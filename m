Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74D21EE9D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 19:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgFDRxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 13:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbgFDRxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:53:44 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B49BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 10:53:44 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id d13so3379211ybk.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oneSfIFxgHFfo5g1F989n4rjZs8A8jIs4lA0TFra9aw=;
        b=T9VZSqewMDKVtEwi4Akffs+9EN2iWLjmPMioRDR4Iych9IQn7qEDlGsy5WYkua7sTL
         asmNkJHYwcgMbjAC7WCTInFXhCnQv/Y7nYXsxNyUzpkusVNmJV6TPvqDTbS8iHkg5wXm
         WNtsxsnuyP7pjcOUrZDBkLm4xafb7O1nO+nkAC5zZBnkVtgzQfOsnJ8T2avTjxmu1g+M
         zc0Tril5ZxWmbDFCYyAb5EsCt5+d0QNkKMe+VQ14pv4gVuau274W4fRrKo69hbMzT7Bl
         N/w20llcKhqqiIkl8/kcBuj4tDfDPr9B6FWSlbXrEqQqHHuJnX3tFxh0w2RS4K4N/7Ue
         d7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oneSfIFxgHFfo5g1F989n4rjZs8A8jIs4lA0TFra9aw=;
        b=eco4xhnq/5ALHTxHa7CZkVjwUOFire+fYpYfTNEKolcmL6D3t1Z+c77Wr+mUgjQsOM
         ZT6FKsDgkg6kGZcgOhzwPBEdF7I2rG1ygqTgXX62gkBksIYmG4kKuuiWCw8j7AK98h7h
         09bElvF7L54Rv20wd8t3H1qbohCcwV5ldyceyToGiP53nbEEIFEMrSLAosUKZK0KUnOq
         1OzwpbdN6JCjpm5jTmPc8n1qefC9H6Q/0D7nph9zf+JF+FuDA1hO/j65/rN3OEBTBxvj
         G6CTaoih1VsuXfunA0ZS+iwI4iFJuoSNmmiYMwiR/nJKOh5QZi6Qh6Dd+VGL3wn1z/9A
         w7hg==
X-Gm-Message-State: AOAM531ABaDhyhGlparty2qeZqPtYqPLZ2PQvYoSTpounxYTtSl5kzkc
        QjRXAzl034bQlMAe37oGB0HnJPMLgB+wkrUUwACTvlpF
X-Google-Smtp-Source: ABdhPJwnblvovO8nxRhYEpS/B8m9q/QarsNo1cOT/d58VIsQypozOLUbONsn023HdR+rrTdDGxe15pnZ8Pf42CVBUgw=
X-Received: by 2002:a25:4f08:: with SMTP id d8mr10541974ybb.125.1591293223284;
 Thu, 04 Jun 2020 10:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200604150348.27996-1-maxim.uvarov@linaro.org> <20200604150348.27996-2-maxim.uvarov@linaro.org>
In-Reply-To: <20200604150348.27996-2-maxim.uvarov@linaro.org>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Thu, 4 Jun 2020 20:53:32 +0300
Message-ID: <CAD8XO3bUSgGX9YLDQ+6zgDAjfNo8ZL1mVtzmZG3yXuw2QyJ5CQ@mail.gmail.com>
Subject: Re: [PATCHv7 1/3] optee: use uuid for sysfs driver entry
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Cc:     peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 18:03, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> With the evolving use-cases for TEE bus, now it's required to support
> multi-stage enumeration process. But using a simple index doesn't
> suffice this requirement and instead leads to duplicate sysfs entries.
> So instead switch to use more informative device UUID for sysfs entry
> like:
> /sys/bus/tee/devices/optee-ta-<uuid>
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
>  MAINTAINERS                                       | 1 +
>  drivers/tee/optee/device.c                        | 9 ++++++---
>  3 files changed, 15 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> new file mode 100644
> index 000000000000..0ae04ae5374a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> @@ -0,0 +1,8 @@
> +What:          /sys/bus/tee/devices/optee-ta-<uuid>/
> +Date:           May 2020
> +KernelVersion   5.7
> +Contact:        tee-dev@lists.linaro.org
> +Description:
> +               OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
> +               matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
> +               are free to create needed API under optee-ta-<uuid> directory.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecc0749810b0..6717afef2de3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
>  M:     Jens Wiklander <jens.wiklander@linaro.org>
>  L:     tee-dev@lists.linaro.org
>  S:     Maintained
> +F:     Documentation/ABI/testing/sysfs-bus-optee-devices
>  F:     drivers/tee/optee/
>
>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index e3a148521ec1..14d335cf8d34 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
>         return 0;
>  }
>
> -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> +static int optee_register_device(const uuid_t *device_uuid)
>  {
>         struct tee_client_device *optee_device = NULL;
>         int rc;
> @@ -75,7 +75,10 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
>                 return -ENOMEM;
>
>         optee_device->dev.bus = &tee_bus_type;
> -       dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
> +       if (!dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid)) {

Please do not merge. Will send v8.

> +               kfree(optee_device);
> +               return -ENOMEM;
> +       }
>         uuid_copy(&optee_device->id.uuid, device_uuid);
>
>         rc = device_register(&optee_device->dev);
> @@ -144,7 +147,7 @@ int optee_enumerate_devices(void)
>         num_devices = shm_size / sizeof(uuid_t);
>
>         for (idx = 0; idx < num_devices; idx++) {
> -               rc = optee_register_device(&device_uuid[idx], idx);
> +               rc = optee_register_device(&device_uuid[idx]);
>                 if (rc)
>                         goto out_shm;
>         }
> --
> 2.17.1
>
