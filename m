Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1DE2B8A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 03:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgKSCcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 21:32:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgKSCcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 21:32:47 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF684246AD;
        Thu, 19 Nov 2020 02:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605753166;
        bh=ctcnR1MTA2vm/WwcPcb2d8r0ld9UEDbTTC4JtbAd0eU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OptiD9ZsWsGyoNENcHRUe3tMB7g2j2XG1/qH2PSVwq9gA3G1l3QpExfc/z+c2KWbK
         o7YberC50kWc3yCs5ckpC2l7wpR9Fk8eiZ3kB0xjQpaGgEwzv+z6OhUAwzSLVm6CYF
         xQH551Y2g/VQtVA6YlBchHhl0eiuExgxwmCcBxxk=
Date:   Thu, 19 Nov 2020 11:32:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 3/4] tools/bootconfig: Align the bootconfig applied
 initrd image size to 4
Message-Id: <20201119113242.defca2f563b42601aa76d136@kernel.org>
In-Reply-To: <20201118112249.30d20147@gandalf.local.home>
References: <160571371674.277955.11736890010190945946.stgit@devnote2>
        <160571374406.277955.187006985015101129.stgit@devnote2>
        <20201118112249.30d20147@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 11:22:49 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 19 Nov 2020 00:35:44 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > +
> > +	/* To align up the total size to BOOTCONFIG_ALIGN, get padding size */
> > +	total_size = stat.st_size + size + sizeof(u32) * 2 + BOOTCONFIG_MAGIC_LEN;
> > +	pad = BOOTCONFIG_ALIGN - total_size % BOOTCONFIG_ALIGN;
> > +	if (pad == BOOTCONFIG_ALIGN)
> > +		pad = 0;
> 
> If alignment is always a power of two, you could simply do:
> 
> 	pad = (total_size + BOOTCONFIG_ALIGN - 1) &  ~(BOOTCONFIG_ALIGN - 1)) - total_size;
> 
> Which will give you the proper padding, without the if.

Thanks, and in that case, I would like to introduce BOOTCONFIG_ALINE_BITS and
BOOTCONFIG_ALINE_MASK so that we make sure the alignment is power of two.

> > +	size += pad;
> > +
> > +	/* Add a footer */
> > +	*(u32 *)(data + size) = size;
> > +	*(u32 *)(data + size + sizeof(u32)) = csum;
> > +	memcpy(data + size + sizeof(u32) * 2, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
> > +	total_size = size + sizeof(u32) * 2 + BOOTCONFIG_MAGIC_LEN;
> 
> I wonder if it would be cleaner to just have a void pointer index for the above:
> 
> 	void *p;
> 
> 	p = data + size;
> 	*(u32 *)p = size;
> 	p += sizeof(u32);
> 
> 	*(u32 *)p = csum;
> 	p += sizeof(u32);
> 
> 	memcpy(p, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
> 	p += BOOTCONFIG_MAGIC_LEN;
> 
> 	total_size = p - (void *)data;

OK.

> Also, how does this work if we run this on a little endian box for a big
> endian crossbuild?

Hmm, good point. I expected that the bootconfig command will be used
natively. Hmm, there are 2 options.

- Add endian option to the bootconfig (-le/-be) for cross build.
- Update the footer format to use "ascii" size and checksum.

To generalize the format, latter one is better. But it also involves
the kernel side update too.

Thank you,

> 
> -- Steve
> 
> 
> > +
> > +	ret = write(fd, data, total_size);
> > +	if (ret < total_size) {
> >  		if (ret < 0)
> >  			ret = -errno;
> >  		pr_err("Failed to apply a boot config: %d\n", ret);
> > -		if (ret < 0)
> > -			goto out;
> > -		goto out_rollback;
> > -	}
> > -	/* Write a magic word of the bootconfig */
> > -	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
> > -	if (ret < BOOTCONFIG_MAGIC_LEN) {
> > -		if (ret < 0)
> > -			ret = -errno;
> > -		pr_err("Failed to apply a boot config magic: %d\n", ret);
> > -		goto out_rollback;
> > -	}
> > -	ret = 0;
> > +		if (ret > 0)
> > +			goto out_rollback;
> > +	} else
> > +		ret = 0;
> > +
> >  out:
> >  	close(fd);
> >  	free(data);


-- 
Masami Hiramatsu <mhiramat@kernel.org>
