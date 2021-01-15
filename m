Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80AE2F7DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbhAOOLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbhAOOLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:11:40 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041CDC061757;
        Fri, 15 Jan 2021 06:11:00 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id md11so5132649pjb.0;
        Fri, 15 Jan 2021 06:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVMDQ0NoHdwzCzsf38XWdiH+uvMyE/EInOhZIyF3pLo=;
        b=L9+njV6fLMgwDoj3nkpi20rCK9v8g/jT8uOnoKDnpbOOLMATTVsSJLEAAYgTZQMQVq
         GlYGESYqvxmLJDkVbBmOumM/88YD05LfW+TRbh1YmKsCSAx546p/BsKf1sOB29cWyOTF
         5j1nayyN5V86P3pT7YcqjxhIFsT/Vo0aIWhKl0R0e/M3NIP4gQYgQdOAK9LP9ftp5e4n
         /plzAuUVVQ1JZtHImRWI4DuhhH/zbHSFkFeffT6bWspn8DolVML8q4b+xxl5vpG0t2KA
         hCFM+rPQiaAS3IYAlvMvPvO02Qv+FcnYp80FnZIASHm4+CqGt9LyOGijf2mIIya9V0Mp
         NA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVMDQ0NoHdwzCzsf38XWdiH+uvMyE/EInOhZIyF3pLo=;
        b=Hb2b2Ow8s2giKB9Azy8jSebK2rjppz7JlF3RjZbymyGGn0F/apLhvKiCX9Qp+654nM
         Biy2qM9YEslYgkUlGqt0trA7LuSRYATkTAocPKBwoyE72VBRQjQQ9mJmbqkbbY4vyfBX
         CJP/MDlDFofC/vE/qGlBE+uAj+E3kja3yhLllUq8p1h1YeKzd5TXt1sdeRDDQhP33DQ0
         m52eBi4WV/yK4wi/zKIlPl23kyooCTyovOGCJq7IfxP9wyxmcYFiWdUbPfzMrEKSMk07
         RRLhybTlRMT+UZTE9OuWZ0g7qhqivltRcoemxn/TY1EYrf4AikPTDwXHGAL1KPkAG8vQ
         Lt9w==
X-Gm-Message-State: AOAM530Or+ZcIXG9dJFf8qRwgk8yqKicgQHP/xE58IN+fwTjqg6rEQgi
        Y+8ow4q5N4Q4cWsUmemi9JoJx028qaEm2KjBEeo=
X-Google-Smtp-Source: ABdhPJye8Onw5+7k1mn9VwwIHJZF7LhD4GwKWMQ6MKPojRrH+4GPTVSOl/9nW+SnAf+X5fkCuryE/1bCQlw6Ox/lAVI=
X-Received: by 2002:a17:90b:17c7:: with SMTP id me7mr10623511pjb.205.1610719859407;
 Fri, 15 Jan 2021 06:10:59 -0800 (PST)
MIME-Version: 1.0
References: <20210115130911.71073-1-colin.king@canonical.com>
In-Reply-To: <20210115130911.71073-1-colin.king@canonical.com>
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
Date:   Fri, 15 Jan 2021 19:40:47 +0530
Message-ID: <CACAkLuqG+4cq9w9=JEjB-5KPcxu==2+Sen6GMknM495vELgEFA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/vkms: Fix missing kmalloc allocation failure check
To:     Colin King <colin.king@canonical.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 6:39 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the kmalloc allocation for config is not being null
> checked and could potentially lead to a null pointer dereference.
> Fix this by adding the missing null check.
>
> Addresses-Coverity: ("Dereference null return value")
> Fixes: 2df7af93fdad ("drm/vkms: Add vkms_config type")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Good catch, thank you!

Reviewed-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 708f7f54001d..2173b82606f6 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -188,7 +188,11 @@ static int vkms_create(struct vkms_config *config)
>
>  static int __init vkms_init(void)
>  {
> -       struct vkms_config *config = kmalloc(sizeof(*config), GFP_KERNEL);
> +       struct vkms_config *config;
> +
> +       config = kmalloc(sizeof(*config), GFP_KERNEL);
> +       if (!config)
> +               return -ENOMEM;
>
>         default_config = config;
>
> --
> 2.29.2
>
regards,
Sumera
