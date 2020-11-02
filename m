Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48E42A2BB3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgKBNko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:40:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:47320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKBNko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:40:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604324442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5taM+xYm/roqABSXKkx0AaxQ/mE9w6z11tF73TDYO34=;
        b=JwyFhGWnOj6rr9Fro8QmODOHDgJOMbxn6yIXAsMWqDTcuesi6SbZAjEn7eF2VcAPsNbe7x
        0IECPDduSukxbA9TbUaoqewrUTyTTu0SmE5pU18LUYzdhtzX5X7yKv//X/bwX3mDD3jpj9
        EOchAN8zcDJtMpMjFLMvpil4kE8sDjk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC9F4ACB5;
        Mon,  2 Nov 2020 13:40:42 +0000 (UTC)
Date:   Mon, 2 Nov 2020 14:40:42 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] init/Kconfig: Fix CPU number in
 LOG_CPU_MAX_BUF_SHIFT description
Message-ID: <20201102134042.GH20201@alley>
References: <20200811092924.6256-1-pmenzel@molgen.mpg.de>
 <d7cad0f8-5831-7730-42d5-fa6d8c46edbb@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7cad0f8-5831-7730-42d5-fa6d8c46edbb@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-10-30 17:00:18, Paul Menzel wrote:
> Dear Petr,
> 
> 
> Am 11.08.20 um 11:29 schrieb Paul Menzel:
> > Currently, LOG_BUF_SHIFT defaults to 17, which is 2 ^ 17 bytes = 128 KB,
> > and LOG_CPU_MAX_BUF_SHIFT defaults to 12, which is 2 ^ 12 bytes = 4 KB.
> > 
> > Half of 128 KB is 64 KB, so more than 16 CPUs are required for the value
> > to be used, as then the sum of contributions is greater than 64 KB for
> > the first time. My guess is, that the description was written with the
> > configuration values used in the SUSE in mind.
> > 
> > Fixes: 23b2899f7f ("printk: allow increasing the ring buffer depending on the number of CPUs")
> > Cc: Luis R. Rodriguez <mcgrof@suse.com>
> > Cc: linux-kernel@vger.kernel.org
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > ---
> > v2: Add Reviewed-by tag
> > 
> >   init/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/init/Kconfig b/init/Kconfig
> > index d6a0b31b13dc..9dc607e3806f 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -718,7 +718,7 @@ config LOG_CPU_MAX_BUF_SHIFT
> >   	  with more CPUs. Therefore this value is used only when the sum of
> >   	  contributions is greater than the half of the default kernel ring
> >   	  buffer as defined by LOG_BUF_SHIFT. The default values are set
> > -	  so that more than 64 CPUs are needed to trigger the allocation.
> > +	  so that more than 16 CPUs are needed to trigger the allocation.
> >   	  Also this option is ignored when "log_buf_len" kernel parameter is
> >   	  used as it forces an exact (power of two) size of the ring buffer.
> 
> Could you please apply this trivial patch from the two patches already, so I
> do not have to resend it?

The patch is committed in printk/linux.git, branch for-5.10-trivial.

I am not going to create pull request just for this trivial fix.
I will push it for-5.10 only together with eventual more urgent fix.
It is very likely that it will have to wait for 5.11.

Best Regards,
Petr
