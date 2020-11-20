Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803082BAF17
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgKTPgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbgKTPgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:36:14 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1814C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:36:13 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id n11so9085926ota.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W3MInVIKjWz9dTqN1xgW7SjRxytR3xOKiE8bAyltq5E=;
        b=J7NjtKdRCHvHTwfirbE9SRtnDzo1dy9iGTYkZoW9AVGCpiGYq0q64HAHuOowt0Ilzp
         sC9dYGbLl2rc1ajfmhHOHR3GrhDhpdADQtxq0t4PiwSQX2XJc6f9HFxufn10cdJeV9og
         dcjmCFsmEJ3pweYsk35jx+SFlfENDP4ee/XodCZTG1B+pH3mqw11eQ3C2r/Df8EVz1Jk
         jcOxD0QJ16lx0W5duSn2i+PPx9lrbUu2LCVAXuNzpEOj67w6YFQKaItarAbnqotnpzL4
         11YX38IiHib3ma2qVqsTfmeYcNX1TZSBaU6Ke9bDEvPKDGFk7YRKHzH8UkrtaPylhSY7
         tDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W3MInVIKjWz9dTqN1xgW7SjRxytR3xOKiE8bAyltq5E=;
        b=Agt192mRmJ/AiKjt+ny0JOPeBlnsyIC539+YqIoD80vKlkntERVRkc1BR50rHtI1p0
         9Mb7nZppoh9l2k7eMSThqnoXWFtFg/9J8z84QGSQpmhhmuA3s3ceaCEcqHJhCHfiU4y3
         Y1+CYP53weN1raeTae+Du4Vi32Wnn/Cszv5I+eviDeCQfAFLuKHGdzAvBuZaRJZC0pTI
         Si/zdOjlH0dXc6l+2YgMzbY5bt7retP2ZenOC4mCxu4PjDkxIZudjeBOFan41E8lImMj
         kxYyyg7NZbzoaOgJLBsqPrIMaiCM/zTc6H+iTFnEkzrS2TopQRQRjZDSR/khI29C1+aY
         c/fQ==
X-Gm-Message-State: AOAM530mvta9LkBDRm11QcoA8vsx2zziG1pU7F5Vc/yGzZqhT8irfv9s
        TppqN6DU/LirudhZuXojpzMcRw==
X-Google-Smtp-Source: ABdhPJwYLyVPxmwaoKP6Kgl+t25DK17pv2lFelWU4fOaV59/QK4oWVo7v8aVdTX6m5QZwpO383FGjw==
X-Received: by 2002:a9d:7d14:: with SMTP id v20mr13389184otn.106.1605886573387;
        Fri, 20 Nov 2020 07:36:13 -0800 (PST)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id t199sm1833383oif.25.2020.11.20.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:36:12 -0800 (PST)
Date:   Fri, 20 Nov 2020 09:35:59 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Remove bogus __user annotations
Message-ID: <20201120153559.GA4119@sequoia>
References: <20201120015913.1375667-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120015913.1375667-1-jannh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jann - Thanks for cleaning this up!

On 2020-11-20 02:59:13, Jann Horn wrote:
> Buffers that are passed to read_actions_logged() and write_actions_logged()
> are in kernel memory; the sysctl core takes care of copying from/to
> userspace.
> 
> Fixes: 0ddec0fc8900 ("seccomp: Sysctl to configure actions that are allowed to be logged")

After tracing back through the code, I was struggling to understand why
I thought the __user annotation was needed back then. It turns out that
__user was correct when I wrote 0ddec0fc8900 and that the Fixes tag
should be changed to this:

 Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")

If you agree, please adjust and resubmit with:

 Reviewed-by: Tyler Hicks <code@tyhicks.com>

Thank you!

Tyler

> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  kernel/seccomp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 8ad7a293255a..c2bff3561846 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1968,7 +1968,7 @@ static bool seccomp_actions_logged_from_names(u32 *actions_logged, char *names)
>  	return true;
>  }
>  
> -static int read_actions_logged(struct ctl_table *ro_table, void __user *buffer,
> +static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
>  			       size_t *lenp, loff_t *ppos)
>  {
>  	char names[sizeof(seccomp_actions_avail)];
> @@ -1986,7 +1986,7 @@ static int read_actions_logged(struct ctl_table *ro_table, void __user *buffer,
>  	return proc_dostring(&table, 0, buffer, lenp, ppos);
>  }
>  
> -static int write_actions_logged(struct ctl_table *ro_table, void __user *buffer,
> +static int write_actions_logged(struct ctl_table *ro_table, void *buffer,
>  				size_t *lenp, loff_t *ppos, u32 *actions_logged)
>  {
>  	char names[sizeof(seccomp_actions_avail)];
> 
> base-commit: 4d02da974ea85a62074efedf354e82778f910d82
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
