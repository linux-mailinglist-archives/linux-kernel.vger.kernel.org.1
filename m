Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89333275877
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIWNNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWNN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:13:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77E9C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 06:13:26 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so7111806wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6IqVkNIHaeQrr2W7CSnbF5wual+dyS7CT61lBn9svUs=;
        b=AJXtHSRlktbbO2b6KQ6ldIzMmeUtPlde1afiP85l0pc4RgEEZfMEYbe+UC5GEz8gqT
         Fzt6HEaxrR762K+h5Me89di3TQZLNJy1Tm6jQODhQVMlrzVt1n6N/OGlcr7d4MrNcEq9
         7LJrMSUZQ57ZFkWFFATgYP8TDyyxvEtXiqrijifTGJBY6hkKTerm2Zxpc5tuYV8hOBo1
         x59jlRh5Rd/cErcPZp4mq7zvJoe51K9hPGnaC9dEZ0sYGK/NseQn3thj0GDB2IPg5z87
         qheQAZDe9NVk6y41hsoQHQrJPrN90aNxa6Vim9k6+8Yj06F2VeabvrPaa5IfZQWbY4dU
         FwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6IqVkNIHaeQrr2W7CSnbF5wual+dyS7CT61lBn9svUs=;
        b=b1l35Ru5sJiqsFLhby9CXSImMFsRc6RooJs72SYPwCRT2hx4o2t75FGc6uJMnGxOr5
         0/ijClgec0Z0wmhKAC7gEAFr1nO2xftHNDGTrrwBhltNBwQesl2KruWbMWB+PlNUMrIg
         AyLzLzeiTe3dQxQJWEAhS0UJFWX5yRT3ql/5OjQFJ+qFIXz84IPrAepLWW+vpkRQs2ZF
         GdI7bSlbmdpV1VxDCtZSLtVsm2oLoifN/zZ7MhiJFpSCxaNpR8r4HrVn5R5Ek9l/ENWm
         U58VypHWdaWoYzR2rfsWmWery3M4JVcSmC5lX/ZxTxmUrIX1Dk7S7XeM6cplM/GogEsH
         IMvQ==
X-Gm-Message-State: AOAM532ZGMH0BTxMitzcGVJBjRsBo4bSYr396xU9LEmTbNvq60S9PdM/
        Dbfrl2TcTr5tzLaRwO3x+MGN0p1E9acI7gD8N1GT4g==
X-Google-Smtp-Source: ABdhPJyJF0t/rtDU7WOxjawXwvOPvE8EaBqSOUoW4aN3E9Lyo3zvndxSVjWXB6hPgTLtg17jFdU3KkFRL3KMW7jVQ9Y=
X-Received: by 2002:a7b:cd05:: with SMTP id f5mr6394174wmj.116.1600866805441;
 Wed, 23 Sep 2020 06:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <1600774764-50332-1-git-send-email-liheng40@huawei.com>
In-Reply-To: <1600774764-50332-1-git-send-email-liheng40@huawei.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 23 Sep 2020 14:13:07 +0100
Message-ID: <CAPY8ntCnsD=LfqxSG-HrkY1ZjUPSaXbGKC=nc4Xkc7a+a7jF3w@mail.gmail.com>
Subject: Re: [PATCH -next] drm/v3d: Remove set but not used variable
To:     Li Heng <liheng40@huawei.com>
Cc:     Eric Anholt <eric@anholt.net>, airlied@linux.ie, daniel@ffwll.ch,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, 23 Sep 2020 at 08:53, Li Heng <liheng40@huawei.com> wrote:
>
> This addresses the following gcc warning with "make W=3D1":
>
> drivers/gpu/drm/v3d/v3d_drv.c:73:32: warning:
> =E2=80=98v3d_v3d_pm_ops=E2=80=99 defined but not used [-Wunused-const-var=
iable=3D]
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Li Heng <liheng40@huawei.com>
> ---
>  drivers/gpu/drm/v3d/v3d_drv.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.=
c
> index 9f7c261..05140db 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> @@ -70,10 +70,6 @@ static int v3d_runtime_resume(struct device *dev)
>  }
>  #endif
>
> -static const struct dev_pm_ops v3d_v3d_pm_ops =3D {
> -       SET_RUNTIME_PM_OPS(v3d_runtime_suspend, v3d_runtime_resume, NULL)
> -};
> -

This looks to be the wrong approach, and I think a patch has got
dropped somewhere.

On our Raspberry Pi downstream vendor tree we have a patch [1] from
Eric that renames v3d_v3d_pm_ops to v3d_pm_ops (don't need the
duplicated suffix), and adds it to v3d_platform_driver. Why that never
made it through the mainline trees I don't know.

Eric: How good's your memory on this one?

Thanks
  Dave

[1] https://github.com/raspberrypi/linux/commit/fddfb26f6503835a3c6f7ca0175=
ce2260f60f67c

>  static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
>                                struct drm_file *file_priv)
>  {
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
