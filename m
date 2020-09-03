Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C09425C411
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 17:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgICPDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 11:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgICPCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:02:54 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F49BC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 08:02:54 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i22so4330161eja.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEZULZGUnrJd5MA6uBgxW8EAcWqrbiDc+CTyDki6MEk=;
        b=NT8UDCqL1GZXqiJGvRF6IDS1DP0g+AYdwg+RDanVz+rq5KIg51wcdy3qDEQjr6tplJ
         CT+RKKs2ucwpAY90xooram4d0h6xZleCf4HROeppkHL1u2cDUfGTNsa1rVP0fSAdhNSx
         XdhJwv3iA0DlkNZBTfR59JoHeMkFecuvnus7ihbs3t2C3OpdUxWk4JN/FfpuMnOTuByB
         TGzcEN82k2KxvFXWE9Si/I1fsq5+0uRIW5kajA3SJdO232CPeLaXXJZtqQ+5zQwIM1PU
         HXW/zn/dK46dlU5StP8CD/TmlXL5MEOv7qRbJMxlqBfeo0HQJ6dQnRx0fIib9dLJyy0j
         0bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEZULZGUnrJd5MA6uBgxW8EAcWqrbiDc+CTyDki6MEk=;
        b=ung41FT0VBL868leBAuN/bG5zrKBL8xTL7lNb6StNRKYUA7I/GeMey8qcMlWnwRHSY
         w4orMJ0ROf/b0A/pPPBTzmQBu17XCP1YzM0mF9EjR7fk7eXyi4jwMD34kS6cd+e5vDGS
         qlogKll63aPFeTUb7yQ3g9zGZTI7b+wyGHiPcbiUaZOkTyPuhFRVvILVAXnnE+GIaVfZ
         nAIULp0WCJiE0UH2YpSMjVGonkArGWAAD7EJfGjZpljMWHmBGHx6HOx1HjveKZhFiQ18
         umT+hMLL4oAZhbRZGv9IIXbnhxVzgbgEsxWHdsALvsCfG3GPRMLRJKnZcvzLHhxxC9HP
         VO9Q==
X-Gm-Message-State: AOAM530R0vqcWkwj+um0duE9VYy7PidV4+EkB4uI3bBcs5Bqh4eu0caZ
        fsK25F+/GvK8838xrbzTyVhA5bqzqVWY/2noUoyyVQ==
X-Google-Smtp-Source: ABdhPJyPS/HR9MNGYvLkqlJ+L/rJ9ZPBwb3yDUrFpkR3P7YeKQO0QT//nQv8xIL7sNSS2YePXN0JUKxCBy5MvCzJBX4=
X-Received: by 2002:a17:906:1e11:: with SMTP id g17mr2447258ejj.298.1599145372527;
 Thu, 03 Sep 2020 08:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200903141746.996974-1-enric.balletbo@collabora.com>
In-Reply-To: <20200903141746.996974-1-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 3 Sep 2020 08:02:41 -0700
Message-ID: <CABXOdTeHZ52HzghkS85rRs92gG-mPe6JEfUx9uz3vMrxXYjpaQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Kconfig: Remove the transitional
 MFD_CROS_EC config
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 7:17 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The MFD_CROS_EC config was a transitional Kconfig option to not break
> current defconfigs in the kernel. Now, this is not required anymore
> because all the defconfigs have been removed this option and migrated to
> enable the CrOS EC parts individually.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/platform/chrome/Kconfig | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index a056031dee81..ccc23d8686e8 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -3,16 +3,6 @@
>  # Platform support for Chrome OS hardware (Chromebooks and Chromeboxes)
>  #
>
> -config MFD_CROS_EC
> -       tristate "Platform support for Chrome hardware (transitional)"
> -       select CHROME_PLATFORMS
> -       select CROS_EC
> -       select MFD_CROS_EC_DEV
> -       depends on X86 || ARM || ARM64 || COMPILE_TEST
> -       help
> -         This is a transitional Kconfig option and will be removed after
> -         everyone enables the parts individually.
> -
>  menuconfig CHROME_PLATFORMS
>         bool "Platform support for Chrome hardware"
>         depends on X86 || ARM || ARM64 || COMPILE_TEST
> --
> 2.28.0
>
