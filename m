Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504D4292F19
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgJSUEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgJSUEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:04:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B68C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:04:30 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j62so763171qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSfxmMkZMNrPnoT0gljcl/qWl3/OnZ4ITcfP06i5z3Y=;
        b=P+7LV9NU/clppD5XH/mUZOvJ5aRFAhm7pkrqfknV2vOTbGUjhVyGjrroLwd8Kq+Edj
         zzpZd/VtlsnSx8TuuuMg8gGEApuOxh2OOB/ei7qVWZLQuBKYDPocRFM3cRVmnZV/nGLe
         NkT7zqtFUtf1LfzzaqyulqKFtfJF0UxLKsztpY8wsIAA9H8qIA6oVJbdo9AG71va4Rua
         SWy06PTCFJjZynPD+hfobhI8Fv+txnnH052cXnwX9LWtn541xEeBa9CfA3icZjqF467z
         hZTtEGsmcbAdjH6YdvGtoYOFJ83SCU0RYHGB7Tc8UJJzS8qRyZtXIsEaV2rIS145TYpY
         dZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSfxmMkZMNrPnoT0gljcl/qWl3/OnZ4ITcfP06i5z3Y=;
        b=UCVHvEI2AKqQlqVt8a1/Cc/cO0niHXLogai98fLjOQGFwy0Olyd3acoQGh1rv7XL9X
         nKZdari73XK9+7W9JD5xRpoejx3vBMqwMCrvwJep1tewJpdufvCVzla0fieFwSOPuOG8
         sWSpz+urrP1cN5vFwQpummzolRRVBgk/xWflzduGWq5kRHXptsRU0Wc7ptD+wDKub5g8
         BTT3rNVQAneVJPlt0q/Ce0Ql5bvmhqxWlkW5SdJDV77hmU/8ydUeBM+MHC3SkXI0KJPg
         +3TRiFLwaXGvw9njVAHo/FD6wmewTpDGi7f9JN7tNHw+I01xCAoXU5TCWJ/ABdD2VDRC
         lwdQ==
X-Gm-Message-State: AOAM53256e8WFmxftDo4P4UsbOMmKcECQqaK5PRdHNT0fZ/zQzIF5SSC
        lqf4J3lcEkOCnDVmc5/eNUY1C+XflB/BHy+P/GE=
X-Google-Smtp-Source: ABdhPJyVyAM/3YohTjTeJvg3D9kIQTCnDMQ71J0tMGAA0FIzrEbmesrF4wQ1MmGtT1p1awj2aIzrXY7DWM492WXKeG8=
X-Received: by 2002:aed:3e78:: with SMTP id m53mr1188470qtf.170.1603137869631;
 Mon, 19 Oct 2020 13:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201019191631.9604-1-trix@redhat.com>
In-Reply-To: <20201019191631.9604-1-trix@redhat.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 19 Oct 2020 22:04:18 +0200
Message-ID: <CAFLxGvwAVbpUe221N-qS19aFSaJ4hM=J=veHfi+4wAkNTNGAog@mail.gmail.com>
Subject: Re: [PATCH] mtd: remove unneeded break
To:     trix@redhat.com
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 9:23 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A break is not needed if it is preceded by a return
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/mtd/mtdchar.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index b40f46a43fc6..323035d4f2d0 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -881,7 +881,6 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
>                 if (copy_from_user(&offs, argp, sizeof(loff_t)))
>                         return -EFAULT;
>                 return mtd_block_isbad(mtd, offs);
> -               break;
>         }
>
>         case MEMSETBADBLOCK:
> @@ -891,7 +890,6 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
>                 if (copy_from_user(&offs, argp, sizeof(loff_t)))
>                         return -EFAULT;
>                 return mtd_block_markbad(mtd, offs);
> -               break;

Acked-by: Richard Weinberger <richard@nod.at>

Do you want to route this patch through mtd or do you carry it?

-- 
Thanks,
//richard
