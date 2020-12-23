Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB72E19FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgLWIcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgLWIcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:32:01 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139C9C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:31:21 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id o6so14387617iob.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OnLH8qklo1KODWtLNMYktn2oSuy396x3BfYFHb9R3vw=;
        b=crjxRgjSGLjNBpIhym8OVXA7XJnoXaZX0JydKOi25HaE3iEvOWDn3kgHn+14ct524Q
         BoipiTy/4LyB1psfdHCL3jMQAmxH6sqWktylsH7vAV6gOPx8/cQnQu96W+jrlkPuuhRQ
         EiH10EiJV5t8TuUzBKMx1BHyM3B+0cWcjdDxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OnLH8qklo1KODWtLNMYktn2oSuy396x3BfYFHb9R3vw=;
        b=Szj9AFpF7xHSvIli5hr3QfPbFzVkuYlgY1KSYPWmpzG1aFoGySgR2AI3Nc57mBaykl
         w6WowLo103dl1pwokNDpW2g79MTD6SWrdCxibFC4ywxxg6Hmh+IBxFr7TAZ5C0HyZMye
         wUqEGniEyZKGQLQLwoVsvpMGRyoVT+Ldt86XrRIO0PcLubPq1M4aUGuWlFdTYPH2s810
         ZpPRvJABODwJj0ueTVuN+L01Mr0NDQ0fQS1p93VIgnMN+eVHXajyKjp4Hi4lh3g9Wmb5
         g/q63kA98qcoRs+o8ugyMvz+WlQAo0veXdf9ym45ZXtd/HW7sPiTHumvDtIP5zurcnou
         tWQA==
X-Gm-Message-State: AOAM531ZSgMcdDSBtwx+mwDQt7w4N3bZrxzYg5wv9zFveCvmrG7S6wuA
        zUZnmefXmmSbzcBc8r+qNI4U3MC7CAvqIm9M
X-Google-Smtp-Source: ABdhPJylEDtUajTRc5Kro/tS6GYYl29Yac0AhN8QAQPCIQOOwpdanDlqHKKS7SItArhOmAKByxYPKw==
X-Received: by 2002:a5d:958c:: with SMTP id a12mr20805882ioo.18.1608712280147;
        Wed, 23 Dec 2020 00:31:20 -0800 (PST)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id s12sm6255524ilp.66.2020.12.23.00.31.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 00:31:19 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id 75so14314645ilv.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:31:19 -0800 (PST)
X-Received: by 2002:a92:1b43:: with SMTP id b64mr23399101ilb.71.1608712278624;
 Wed, 23 Dec 2020 00:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20201221164819.792019-1-ribalda@chromium.org> <20201221164819.792019-10-ribalda@chromium.org>
 <X+HKpxzbVC29lNlk@pendragon.ideasonboard.com> <CANiDSCv_+Usx4QkG4ypGWbCKvusiugYGgeNRYP8GZJ_pvuhjEQ@mail.gmail.com>
 <X+L6KSlpKERPAxsm@pendragon.ideasonboard.com>
In-Reply-To: <X+L6KSlpKERPAxsm@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 23 Dec 2020 09:31:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCsvOdB7oAGBwupb_UrV=SND96Pc2AuWu=dPAbTA-boXhQ@mail.gmail.com>
Message-ID: <CANiDSCsvOdB7oAGBwupb_UrV=SND96Pc2AuWu=dPAbTA-boXhQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/12] media: uvcvideo: Implement UVC_QUIRK_PRIVACY_DURING_STREAM
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Wed, Dec 23, 2020 at 9:05 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Dec 22, 2020 at 09:04:19PM +0100, Ricardo Ribalda wrote:
> > On Tue, Dec 22, 2020 at 11:30 AM Laurent Pinchart wrote:
> > > On Mon, Dec 21, 2020 at 05:48:16PM +0100, Ricardo Ribalda wrote:
> > > > Some devices, can only read the privacy_pin if the device is
> > >
> > > s/devices,/devices/
> > >
> > > > streaming.
> > > >
> > > > This patch implement a quirk for such devices, in order to avoid invalid
> > > > reads and/or spurious events.
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_driver.c | 57 ++++++++++++++++++++++++++++--
> > > >  drivers/media/usb/uvc/uvc_queue.c  |  3 ++
> > > >  drivers/media/usb/uvc/uvcvideo.h   |  4 +++
> > > >  3 files changed, 61 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > index 72516101fdd0..7af37d4bd60a 100644
> > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > @@ -7,6 +7,7 @@
> > > >   */
> > > >
> > > >  #include <linux/atomic.h>
> > > > +#include <linux/dmi.h>
> > > >  #include <linux/gpio/consumer.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/list.h>
> > > > @@ -1472,6 +1473,17 @@ static int uvc_parse_control(struct uvc_device *dev)
> > > >  /* -----------------------------------------------------------------------------
> > > >   * Privacy GPIO
> > > >   */
> > >
> > > There should be a blank line here.
> > >
> > > > +static bool uvc_gpio_is_streaming(struct uvc_device *dev)
> > > > +{
> > > > +     struct uvc_streaming *streaming;
> > > > +
> > > > +     list_for_each_entry(streaming, &dev->streams, list) {
> > > > +             if (uvc_queue_streaming(&streaming->queue))
> > > > +                     return true;
> > > > +     }
> > > > +
> > > > +     return false;
> > > > +}
> > > >
> > > >
> > >
> > > But not too blank lines here.
> > >
> > > >  static u8 uvc_gpio_update_value(struct uvc_device *dev,
> > > > @@ -1499,7 +1511,12 @@ static int uvc_gpio_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
> > > >       if (cs != UVC_CT_PRIVACY_CONTROL || size < 1)
> > > >               return -EINVAL;
> > > >
> > > > +     if ((dev->quirks & UVC_QUIRK_PRIVACY_DURING_STREAM) &&
> > > > +         !uvc_gpio_is_streaming(dev))
> > > > +             return -EBUSY;
> > > > +
> > > >       *(uint8_t *)data = uvc_gpio_update_value(dev, entity);
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > > @@ -1528,19 +1545,50 @@ static struct uvc_entity *uvc_gpio_find_entity(struct uvc_device *dev)
> > > >       return NULL;
> > > >  }
> > > >
> > > > -static irqreturn_t uvc_gpio_irq(int irq, void *data)
> > > > +void uvc_privacy_gpio_event(struct uvc_device *dev)
> > > >  {
> > > > -     struct uvc_device *dev = data;
> > > >       struct uvc_entity *unit;
> > > >
> > > > +
> > > >       unit = uvc_gpio_find_entity(dev);
> > > >       if (!unit)
> > > > -             return IRQ_HANDLED;
> > > > +             return;
> > > >
> > > >       uvc_gpio_update_value(dev, unit);
> > > > +}
> > > > +
> > > > +static irqreturn_t uvc_gpio_irq(int irq, void *data)
> > > > +{
> > > > +     struct uvc_device *dev = data;
> > > > +
> > > > +     /* Ignore privacy events during streamoff */
> > > > +     if (dev->quirks & UVC_QUIRK_PRIVACY_DURING_STREAM)
> > > > +             if (!uvc_gpio_is_streaming(dev))
> > > > +                     return IRQ_HANDLED;
> > >
> > > I'm still a bit concerned of race conditions. When stopping the stream,
> > > vb2_queue.streaming is set to 0 after calling the driver's .stop_stream()
> > > handler. This means that the device will cut power before
> > > uvc_gpio_is_streaming() can detect that streaming has stopped, and the
> > > GPIO could thus trigger an IRQ.
> >
> > On the affected devices I have not seen this. I guess it takes some
> > time to discharge. Anyway I am implementing a workaround. Tell me if
> > it is too ugly.
> >
> > > You mentioned that devices have a pull-up or pull-down on the GPIO line.
> > > As there are only two devices affected, do you know if it's a pull-up or
> > > pull-down ? Would it be worse to expose that state to userspace than to
> > > return -EBUSY when reading the control ?
> >
> > The module has a 100K pull up. This is, it will return "Privacy = 0".
> >
> > We cannot return the default value, as it would make the user believe
> > that the privacy is in a different state that currently is.
> > In other words, userspace needs to know at all times if the privacy is
> > in : unknow_state, on, off.
>
> This seems to be the core of the issue: we're trying to shove 3 states
> into a boolean. Would this call for turning the V4L2_CID_PRIVACY control
> into a menu ? Or maybe setting V4L2_CTRL_FLAG_INACTIVE ? Returning
> -EBUSY when the control is read while not streaming, and not generating
> an event that tells the control value becomes unknown, seems like a hack
> designed to work with a single userspace implementation.
>

I think that the V4L2_CTRL_FLAG_INACTIVE seems more correct. I will
see how can I wire that up.


> As the rest of the series is getting ready, I'd propose merging it
> without this patch until we figure out what should be done to support
> these lovely devices. Would that work for you ?

Yes that sounds good to me. Thanks!


>
> > > > +
> > > > +     uvc_privacy_gpio_event(dev);
> > > > +
> > > >       return IRQ_HANDLED;
> > > >  }
> > > >
> > > > +static const struct dmi_system_id privacy_valid_during_streamon[] = {
> > > > +     {
> > > > +             .ident = "HP Elite c1030 Chromebook",
> > > > +             .matches = {
> > > > +                     DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> > > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "Jinlon"),
> > > > +             },
> > > > +     },
> > > > +     {
> > > > +             .ident = "HP Pro c640 Chromebook",
> > > > +             .matches = {
> > > > +                     DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> > > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "Dratini"),
> > > > +             },
> > > > +     },
> > > > +     { } /* terminate list */
> > > > +};
> > > > +
> > > >  static int uvc_gpio_parse(struct uvc_device *dev)
> > > >  {
> > > >       struct uvc_entity *unit;
> > > > @@ -1577,6 +1625,9 @@ static int uvc_gpio_parse(struct uvc_device *dev)
> > > >
> > > >       list_add_tail(&unit->list, &dev->entities);
> > > >
> > > > +     if (dmi_check_system(privacy_valid_during_streamon))
> > > > +             dev->quirks |= UVC_QUIRK_PRIVACY_DURING_STREAM;
> > >
> > > This will also match any external UVC camera plugged to one of the
> > > affected systems, right ? It shouldn't matter in practice as those
> > > devices won't have a GPIO entity.
> >
> > I did think about that but did not make it explicit in the code.
> > Adding a comment.
> >
> > > I suppose we can't match on VID:PID instead because the same VID:PID is
> > > used in both devices affected by this issue, and devices immune to it ?
> >
> > The problem with VID:PID, is that the manufacturer can decide to
> > change the camera module and then the quirk will not work.
> >
> > We cannot rely ONLY in VID:PID as these modules are also used in other
> > models not affected by the quirk.
> >
> > I believe that it is also correct to rely on the dmi, as the quirk is
> > caused for the way the camera module is wired, which is on the
> > motherboard.
>
> I can't comment on the hardware side as I lack details. Using the
> VID:PID only seems a problem indeed. We could combine DMI and VID:PID,
> but that wouldn't make a difference in practice, so I suppose this is
> good enough.
>
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
> > > > index cd60c6c1749e..e800d491303f 100644
> > > > --- a/drivers/media/usb/uvc/uvc_queue.c
> > > > +++ b/drivers/media/usb/uvc/uvc_queue.c
> > > > @@ -337,9 +337,12 @@ int uvc_dequeue_buffer(struct uvc_video_queue *queue, struct v4l2_buffer *buf,
> > > >  int uvc_queue_streamon(struct uvc_video_queue *queue, enum v4l2_buf_type type)
> > > >  {
> > > >       int ret;
> > > > +     struct uvc_streaming *stream = uvc_queue_to_stream(queue);
> > >
> > > Please swap the two lines.
> > >
> > > >
> > > >       mutex_lock(&queue->mutex);
> > > >       ret = vb2_streamon(&queue->queue, type);
> > > > +     if (stream->dev->quirks & UVC_QUIRK_PRIVACY_DURING_STREAM)
> > > > +             uvc_privacy_gpio_event(stream->dev);
> > >
> > > Even when vb2_streamon() failed ?
> > >
> > > >       mutex_unlock(&queue->mutex);
> > > >
> > > >       return ret;
> > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > index 079a407ebba5..32c1ba246d97 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -209,6 +209,7 @@
> > > >  #define UVC_QUIRK_RESTORE_CTRLS_ON_INIT      0x00000400
> > > >  #define UVC_QUIRK_FORCE_Y8           0x00000800
> > > >  #define UVC_QUIRK_FORCE_BPP          0x00001000
> > > > +#define UVC_QUIRK_PRIVACY_DURING_STREAM      0x00002000
> > > >
> > > >  /* Format flags */
> > > >  #define UVC_FMT_FLAG_COMPRESSED              0x00000001
> > > > @@ -826,6 +827,9 @@ extern const struct v4l2_file_operations uvc_fops;
> > > >  int uvc_mc_register_entities(struct uvc_video_chain *chain);
> > > >  void uvc_mc_cleanup_entity(struct uvc_entity *entity);
> > > >
> > > > +/* Privacy gpio */
> > > > +void uvc_privacy_gpio_event(struct uvc_device *dev);
> > > > +
> > > >  /* Video */
> > > >  int uvc_video_init(struct uvc_streaming *stream);
> > > >  int uvc_video_suspend(struct uvc_streaming *stream);
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
