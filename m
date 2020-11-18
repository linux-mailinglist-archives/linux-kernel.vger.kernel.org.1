Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873442B81B6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgKRQWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:22:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgKRQWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:22:52 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 210AD247E0;
        Wed, 18 Nov 2020 16:22:51 +0000 (UTC)
Date:   Wed, 18 Nov 2020 11:22:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 3/4] tools/bootconfig: Align the bootconfig applied
 initrd image size to 4
Message-ID: <20201118112249.30d20147@gandalf.local.home>
In-Reply-To: <160571374406.277955.187006985015101129.stgit@devnote2>
References: <160571371674.277955.11736890010190945946.stgit@devnote2>
        <160571374406.277955.187006985015101129.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 00:35:44 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> +
> +	/* To align up the total size to BOOTCONFIG_ALIGN, get padding size */
> +	total_size = stat.st_size + size + sizeof(u32) * 2 + BOOTCONFIG_MAGIC_LEN;
> +	pad = BOOTCONFIG_ALIGN - total_size % BOOTCONFIG_ALIGN;
> +	if (pad == BOOTCONFIG_ALIGN)
> +		pad = 0;

If alignment is always a power of two, you could simply do:

	pad = (total_size + BOOTCONFIG_ALIGN - 1) &  ~(BOOTCONFIG_ALIGN - 1)) - total_size;

Which will give you the proper padding, without the if.

> +	size += pad;
> +
> +	/* Add a footer */
> +	*(u32 *)(data + size) = size;
> +	*(u32 *)(data + size + sizeof(u32)) = csum;
> +	memcpy(data + size + sizeof(u32) * 2, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
> +	total_size = size + sizeof(u32) * 2 + BOOTCONFIG_MAGIC_LEN;

I wonder if it would be cleaner to just have a void pointer index for the above:

	void *p;

	p = data + size;
	*(u32 *)p = size;
	p += sizeof(u32);

	*(u32 *)p = csum;
	p += sizeof(u32);

	memcpy(p, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
	p += BOOTCONFIG_MAGIC_LEN;

	total_size = p - (void *)data;

Also, how does this work if we run this on a little endian box for a big
endian crossbuild?

-- Steve


> +
> +	ret = write(fd, data, total_size);
> +	if (ret < total_size) {
>  		if (ret < 0)
>  			ret = -errno;
>  		pr_err("Failed to apply a boot config: %d\n", ret);
> -		if (ret < 0)
> -			goto out;
> -		goto out_rollback;
> -	}
> -	/* Write a magic word of the bootconfig */
> -	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
> -	if (ret < BOOTCONFIG_MAGIC_LEN) {
> -		if (ret < 0)
> -			ret = -errno;
> -		pr_err("Failed to apply a boot config magic: %d\n", ret);
> -		goto out_rollback;
> -	}
> -	ret = 0;
> +		if (ret > 0)
> +			goto out_rollback;
> +	} else
> +		ret = 0;
> +
>  out:
>  	close(fd);
>  	free(data);
