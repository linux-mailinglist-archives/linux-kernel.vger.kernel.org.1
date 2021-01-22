Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45C03009DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbhAVRbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbhAVPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:49:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DEBC06121F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:47:56 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id a20so964182pjs.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PdDUQpTTa/vebneMqETLs1lh6NBTqik+/UKGsjcfFuA=;
        b=G2h3gZ1xMzLQcLHaMMKuEtrk5L0QFUsRVk6hsENZlqp97AS6CpCWM0Y5q2S675Mdeb
         +jt/VBO+dPr1gkg5n7Qw64zZm+VmHJO31JetwJAti5wt6edbArj6PXxsjBEvk4xsHEjK
         Rl4gwlFI/R7FOH1BptElZxodhJrWGklgTs8XwJcEFZ7eYS5ONzaNZGvIrrPHWnAdO47z
         kK9wy86MQb0zUOV/wpw7VeeQIgmnBpRSUPHKQCnfzerbYbvWZ8MlKY+aGGqBYKKw0XUq
         eV0/P4/x3Sh0sDaMCk3xdhRBDad9NoHBoZzoKMe9Ff6Bn93KHAnt0gC50TriOZjo+RLN
         AdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdDUQpTTa/vebneMqETLs1lh6NBTqik+/UKGsjcfFuA=;
        b=GERA8In307/8wgrz1HnoxsooU/Hd5eFxNc+Z1XXmikyjp1h4DsV+Qt0k2yjgmoZi3g
         ED9fkm33gEhhmzrNePNBqmWFZBySXAifs+sKp8zsKwxkhABQ7Cg/N7v10g/j6suVbxZc
         eheAGsayZF/zsp9z7WThL895SkTga4NfpawGkm7vl7RSHgpaHxJzmRo9vUhDokgkkViq
         w6w1rzTZNVtGh54a919dEdPMMiUfhs/IgdyPJUJKQL6ZPlpitylejWAZTtP1m6SQ4nip
         iCf1r6+Ch+wsfAdzptVuDlsMUhudpeVVcapyxw4VHhLIlHi/5IkGfYvothn9qJOMfzoV
         b/ZQ==
X-Gm-Message-State: AOAM5335IaRty94ETcoYXFYIkeOq3n3Gmn6qjt9WVRh0qkuNYq6sESBX
        9j7EZ8yMWC0f6RTDOPIr9dJPxR5C/VFaUHqyVXY8wz0QpN0=
X-Google-Smtp-Source: ABdhPJyKaM6heiVs45DHGJ5aMpMXwPplfaambFQiceQ90sJC2VZv0DYdU3XWcYdf5upOXpJA9LsjJJudVgruxTUwmRw=
X-Received: by 2002:a17:90a:d913:: with SMTP id c19mr6215690pjv.19.1611330476335;
 Fri, 22 Jan 2021 07:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20210120102057.21143-1-tiwai@suse.de> <20210120102057.21143-3-tiwai@suse.de>
In-Reply-To: <20210120102057.21143-3-tiwai@suse.de>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 22 Jan 2021 16:47:44 +0100
Message-ID: <CAG3jFyuTJ5sj_YYYfFO0LAFN-RM4QdmLV7w4ng9pb9eJkO4FiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: dvb-usb: Fix use-after-free access
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Seyfried <seife+kernel@b1-systems.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Takashi,

This patch is generating a checkpatch warning, but I think it is
spurious and can be ignored.

Other than that, this looks good to me.
Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Wed, 20 Jan 2021 at 12:51, Takashi Iwai <tiwai@suse.de> wrote:
>
> dvb_usb_device_init() copies the properties to the own data, so that
> the callers can release the original properties later (as done in the
> commit 299c7007e936 "media: dw2102: Fix memleak on sequence of
> probes").  However, it also stores dev->desc pointer that is a
> reference to the original properties data.  Since dev->desc is
> referred later, it may result in use-after-free, in the worst case,
> leading to a kernel Oops as reported.
>
> This patch addresses the problem by allocating and copying the
> properties at first, then get the desc from the copied properties.
>
> Reported-and-tested-by: Stefan Seyfried <seife+kernel@b1-systems.com>
> BugLink: http://bugzilla.opensuse.org/show_bug.cgi?id=1181104
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/media/usb/dvb-usb/dvb-usb-init.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> index 5befec87f26a..07ff9b4d2f34 100644
> --- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
> +++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> @@ -255,27 +255,30 @@ int dvb_usb_device_init(struct usb_interface *intf,
>         if (du != NULL)
>                 *du = NULL;
>
> -       if ((desc = dvb_usb_find_device(udev, props, &cold)) == NULL) {
> +       d = kzalloc(sizeof(struct dvb_usb_device), GFP_KERNEL);
> +       if (!d) {
> +               err("no memory for 'struct dvb_usb_device'");
> +               return -ENOMEM;
> +       }
> +
> +       memcpy(&d->props, props, sizeof(struct dvb_usb_device_properties));
> +
> +       desc = dvb_usb_find_device(udev, &d->props, &cold);
> +       if (!desc) {
>                 deb_err("something went very wrong, device was not found in current device list - let's see what comes next.\n");
> -               return -ENODEV;
> +               ret = -ENODEV;
> +               goto error;
>         }
>
>         if (cold) {
>                 info("found a '%s' in cold state, will try to load a firmware", desc->name);
>                 ret = dvb_usb_download_firmware(udev, props);
>                 if (!props->no_reconnect || ret != 0)
> -                       return ret;
> +                       goto error;
>         }
>
>         info("found a '%s' in warm state.", desc->name);
> -       d = kzalloc(sizeof(struct dvb_usb_device), GFP_KERNEL);
> -       if (d == NULL) {
> -               err("no memory for 'struct dvb_usb_device'");
> -               return -ENOMEM;
> -       }
> -
>         d->udev = udev;
> -       memcpy(&d->props, props, sizeof(struct dvb_usb_device_properties));
>         d->desc = desc;
>         d->owner = owner;
>
> --
> 2.26.2
>
