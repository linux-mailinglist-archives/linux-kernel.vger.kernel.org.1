Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680DC1F74F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 10:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgFLIAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 04:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgFLIAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:00:04 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D73AC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 01:00:03 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id er17so3977015qvb.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zAch9IlDTp6iEr5w238b0yuLmT7aOF6imYemNYoLEcM=;
        b=Dupr1m37CTGw4+ohb5QSfamEzZj2PxJPeG5irXL+9QuTzFHpCgE8yPpn5blX9p3G4N
         KkjCYbpH56ulQEGwMu4HVjdpUpzbibqcRaIC/BcmW5X02t5/gmDSiZAK3IbQetQhKl2J
         J5fZG/dZ7lk7FdAZ0zXuoRxcXte73Vr7+RSypUkKfYeJOI8H9aMVf0nFEv0iLD94Wil4
         xRWvs1k++ma1V/PiVoijg0pVmcL3y5AuWrQT3GS/kmsj8dTndoosa90F3FAX5BT6NEk5
         sXDCvnf3L4vJy+n3Fsek9Yy7vsAxX21X4W9DEE+Zkllq3EGDQD7ItZXleP5iUQGn2vCQ
         tkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zAch9IlDTp6iEr5w238b0yuLmT7aOF6imYemNYoLEcM=;
        b=pviUPDuPCpjHIAM9IMdepkynwbnmJaz4Bn3bJCLsZseOdy3o4R3Q40wqZkJ4r6droE
         HG5IyHui6+XJPBeMscLDj4IHzU1ERcuaQi4J1T+lfJx2WnDmJeV9j4gDwBlTwp3DlxII
         I/vNCQsF7gAtEfiiWNTcLe8xr1pBeVHymi7wn1L4fmvwZzPhKJeyNwqO8UwyU20cPWvG
         pGJFJ07csyLr9fy11zl+oKVasMiCwJla2Z4jpwIVJ1haS386ieUMkJH5TOTiVUChEO7Z
         fCmnyTEZa8E0IFZxZD3+gKEUnhZKD+0wJl1VVR7qvil2IEhgTXbY6ZvL5OHYVa2lxryl
         rAJw==
X-Gm-Message-State: AOAM530L7lZuMbG7UMLz1aPW8042jFFpAJYulX8iUBxRyP2A9+/ti3GT
        C2JQCSm4osp2HUtRGkzLBZDIu2hgpsdnSBmWzlwg8A==
X-Google-Smtp-Source: ABdhPJzu+ikYeKslS04C6iqRdh+KuS10EdJ8EzagLxWO+G6bPpS74j9WkEF9YzTpHGGWSiZXeAW9AVmnAHKn5Rn+vKA=
X-Received: by 2002:a0c:f652:: with SMTP id s18mr10954998qvm.96.1591948802450;
 Fri, 12 Jun 2020 01:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200612045034.27425-1-warthog618@gmail.com> <20200612045034.27425-2-warthog618@gmail.com>
In-Reply-To: <20200612045034.27425-2-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 12 Jun 2020 09:59:51 +0200
Message-ID: <CAMpxmJWUmiEADN44DeZ8tRwOSZGr_eYnutQy5zGsxhDTM7PSFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpiolib: cdev: fix -Wmissing-prototypes warnings
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 12 cze 2020 o 06:51 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a)=
:
>
> Fix -Wmissing-prototypes warnings by including module's header.
>
> Fixes: f6d984418ffd (gpiolib: split character device into gpiolib-cdev)
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 971470bdc9c9..58011ba88a1d 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -23,6 +23,7 @@
>
>
>  #include "gpiolib.h"
> +#include "gpiolib-cdev.h"
>
>  /* Implementation infrastructure for GPIO interfaces.
>   *
> --
> 2.27.0
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
