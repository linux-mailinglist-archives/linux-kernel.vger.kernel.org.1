Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8184929DB2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbgJ1XoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388114AbgJ1WvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:51:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52972C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:51:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 2so961152ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xht2uNZAIX5U2P4vlg3049+636CJvqI/it3IYYCQ9uQ=;
        b=G+Vy7vW9jYQ4G4gsGIjnfxrI8tXAnoX2ZcNMsN3La8GReilyCGiagAkc6vFnavE4qH
         SaLmg88oUtB8v0TWekXEDfpTabMzkF2kKYvOljmZRg5ogaxaaqHBorI+0MUJBQbFptTo
         VoWyZK6iam2cE5+Xy7kMj0IkVJrivgMYdUb/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xht2uNZAIX5U2P4vlg3049+636CJvqI/it3IYYCQ9uQ=;
        b=h8Mlnu2FjNWrpyQnOXa355xYy5cfMl7/u1/MlI5y0/W3bwwKG7rUS8ZFGskH2jVApi
         8DPMkGJr+vvrjzkcSVigpY3EVEHRoh6Im+v43bcGFD2NhiMYOPmXIYuG806tW+Hodliv
         dyavn2JnXndexWbSgYsdKxKr8AXUKWucbWdeWYvTc2eYq18Jk7/oTvQB/gq0lnD2KzuJ
         FbjzOaQ+xgsJnMEXBkiUAtKSmb8v7t6mW6D7fAwWlklqnXvLU+OJiy/5t4mrgtyrSHCy
         QQyDxgcSy4Qwnp67A76vJhtByEuC8x5Xd/H4OD1HtIYHgASvmZx35dsYLC69FBQC0LiM
         a8pA==
X-Gm-Message-State: AOAM533GVXuf2hF9TUqjg69jchF1650X4vHCCxPq2BattuzsE3CplEFm
        aD8gQq8SeuVbUfRhtsfmvMvgE6BcXslaHTBpwCtYrMMwTe4VVuhIMIg=
X-Google-Smtp-Source: ABdhPJx/XXP2+RVZr9d4sVSYyekwdrWCYrTf38pryUR03VODnNlT+tSmnKvXeHXqafI1rFC/yjZ6PA9TtiQkRYq5iV0=
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr9747522wrk.142.1603897907527;
 Wed, 28 Oct 2020 08:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201022133753.310506-1-ribalda@chromium.org> <20201022133753.310506-7-ribalda@chromium.org>
In-Reply-To: <20201022133753.310506-7-ribalda@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 28 Oct 2020 16:11:36 +0100
Message-ID: <CAMrC3Ht49TtRaGs7RVH0HmzdgHEFUq_QdOyA15XWtDO01J4_EA@mail.gmail.com>
Subject: Re: [PATCH 6/6] media: uvcvideo: Handle IRQs from the privacy_pin
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


On Thu, Oct 22, 2020 at 3:38 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> If the privacy pin produces an IRQ, read the gpio and notify userspace
> via an event.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   |  3 +++
>  drivers/media/usb/uvc/uvc_driver.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 3a49a1326a90..00c41cba0f68 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1346,6 +1346,9 @@ static void uvc_ctrl_status_event_work(struct work_struct *work)
>
>         mutex_unlock(&chain->ctrl_mutex);
>
> +       if (!w->urb)
> +               return;
> +
>         /* Resubmit the URB. */
>         w->urb->interval = dev->int_ep->desc.bInterval;
>         ret = usb_submit_urb(w->urb, GFP_KERNEL);
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 180e503e900f..d1260d131bd8 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1460,6 +1460,25 @@ static int uvc_gpio_get_info(struct uvc_entity *entity, u8 cs, u8 *caps)
>         return 0;
>  }
>
> +static irqreturn_t uvc_privacy_gpio_irq(int irq, void *data)
> +{
> +       struct uvc_device *dev = data;
> +       struct uvc_video_chain *chain;
> +       struct uvc_entity *term;
> +       u8 value;
> +
> +       list_for_each_entry(chain, &dev->chains, list) {
> +               list_for_each_entry(term, &dev->entities, list) {
> +                       if (UVC_ENTITY_TYPE(term) == UVC_GPIO_UNIT) {
> +                               value = gpiod_get_value(term->gpio.gpio_privacy);
> +                               uvc_ctrl_status_event(NULL, chain, term->controls, &value);
> +                       }
> +               }
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
>  static int uvc_parse_gpio(struct uvc_device *dev)
>  {
>         struct uvc_entity *unit;
> @@ -1490,6 +1509,17 @@ static int uvc_parse_gpio(struct uvc_device *dev)
>
>         list_add_tail(&unit->list, &dev->entities);
>
> +       irq = gpiod_to_irq(gpio_privacy);
> +
> +       if (irq == -EPROBE_DEFER)
> +               return -EPROBE_DEFER;
> +
> +       if (irq < 0)
> +               return 0;
> +
> +       ret = devm_request_irq(&dev->udev->dev, irq, uvc_privacy_gpio_irq, IRQF_SHARED,
> +                              "uvc_privacy_gpio", dev);

Here it should say IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING instead
of IRQF_SHARED.

I will fix that on v2,

> +
>         return 0;
>  }
>
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
