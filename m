Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9419E27092F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 01:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIRXjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 19:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRXjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 19:39:06 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DACC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 16:39:06 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z13so8869968iom.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 16:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uE/cayLTRj4o6VbdtS1FiP9bUXCTNIrB9/N0MCrOtfo=;
        b=im4xm9S+CB1bk+rTchpPTBu234oDgOXS0c6CizqgqQSILhVrGvpR2NrL6FsCo8urns
         p+h+lTo3ZeERwuDd/OQ3olVB4P3xQruG1OxeD1KmG4RxXly6GNL9N4JMnmm13f5Jet/M
         d1Nz+DkEY44BwXgGnUIrOQMk3ERMThORhA5PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uE/cayLTRj4o6VbdtS1FiP9bUXCTNIrB9/N0MCrOtfo=;
        b=IQX0IcheeM+YAnFhFzBgvlyHg5YwnP/VQoNm+TmYLPL2p7BtqF0iiNfjDFvv97XoMj
         3qQT4GQHyVwe1GjNLcUn/0cpMrZ43KHtVybRn1fubcSGdYVoNEcJfskrRlSm85wB0WqJ
         k1Zu3am4WokDZMnebEVDjboGN2vpvtc88l6DkIwj7ga90rfTL/4qMzyPy43MMhJD344z
         /Mzk6c2t6+4/2AP3YY741TltwLcR84lQ4bB6gz7aYwqw2E5qrdWIgJhs6DyV4rDxXYLq
         0mNCXOdscQ1dxBTgB2inw7GQHZpguV9b3Mm2IUd+Uay4XIosi/U7zstvu8lLrX3n03Gq
         orlQ==
X-Gm-Message-State: AOAM532hWzSRY8S+uLfY6ioQUc1TWie+HJpfd/71KVEWmPD4VSH7H0k0
        ybrPTSkLmfMYX32tB7q59soDEokl5zm8SIR8rHJZ7Q==
X-Google-Smtp-Source: ABdhPJx8gLoUjR0Ap8mewfR2t8s4cOhUrrYbG0HDoOWOITfbtbz2bGM93p5sQM9HOx3L6yoALSoU6Ynr1vifO4D+b9U=
X-Received: by 2002:a02:8805:: with SMTP id r5mr33544712jai.52.1600472345877;
 Fri, 18 Sep 2020 16:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200903095415.2572049-1-pmalani@chromium.org>
 <1e2de378-5f5b-939e-39d8-00d6cc5ab6c8@collabora.com> <CACeCKaeNbhcoxCUkTJ1=jxGff5tNsSm4w7NdPe9=7dhUE7baqA@mail.gmail.com>
In-Reply-To: <CACeCKaeNbhcoxCUkTJ1=jxGff5tNsSm4w7NdPe9=7dhUE7baqA@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 18 Sep 2020 16:38:53 -0700
Message-ID: <CAPUE2usvG43vTNGipQp8Q5DsvJqXKLggZ-TH4m+vkMi249v_nA@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_proto: Update
 cros_ec_cmd_xfer() call-sites
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 4:29 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Thanks Enric,
>
> On Mon, Sep 7, 2020 at 3:48 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Hi Prashant,
> >
> > Thank you for your patch.
> >
> > On 3/9/20 11:54, Prashant Malani wrote:
> > > Since all the other call-sites of cros_ec_cmd_xfer() have been converted
> > > to use cros_ec_cmd_xfer_status() instead, update the remaining
> > > call-sites to prepare for the merge of cros_ec_cmd_xfer() into
> > > cros_ec_cmd_xfer_status().
> > >
> > > As part of this update, change the error handling inside
> > > cros_ec_get_sensor_count() such that the legacy LPC interface is tried
> > > on all error values, not just when msg->result != EC_RESULT_SUCCESS.
> > >
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>

There is a slight change in API in cros_ec_get_sensor_count(): it will
return a negative number of sensors when there
are no sensors on arm platform when MOTIONSENSE_CMD_DUMP is not
supported (typical for sensorless chromebook) instead of 0.
However, this is not a problem when probing the EC as we ignore errors
only looking for cros_ec_get_sensor_count() returning a positive
number of sensors.

> >
> > Gwendal, I'd like to hear from you regarding this patch as you're the one that
> > know most about the corner cases for the sensors in different hardware. Could
> > you take a look and give us your Reviewed tag if all is good?
> >
> Gwendal, could you kindly take a look? Thanks!
>
> > Thanks,
> >
> >  Enric
> >
> > > ---
> > >  drivers/platform/chrome/cros_ec_proto.c | 15 ++++-----------
> > >  1 file changed, 4 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > > index dda182132a6a..2cb1defcdd13 100644
> > > --- a/drivers/platform/chrome/cros_ec_proto.c
> > > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > > @@ -650,7 +650,7 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
> > >       msg->insize = size;
> > >       msg->outsize = 0;
> > >
> > > -     ret = cros_ec_cmd_xfer(ec_dev, msg);
> > > +     ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> > >       if (ret > 0) {
> > >               ec_dev->event_size = ret - 1;
> > >               ec_dev->event_data = *event;
> > > @@ -694,7 +694,7 @@ static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
> > >       msg->insize = sizeof(ec_dev->event_data.data);
> > >       msg->outsize = 0;
> > >
> > > -     ec_dev->event_size = cros_ec_cmd_xfer(ec_dev, msg);
> > > +     ec_dev->event_size = cros_ec_cmd_xfer_status(ec_dev, msg);
> > >       ec_dev->event_data.event_type = EC_MKBP_EVENT_KEY_MATRIX;
> > >       memcpy(&ec_dev->event_data.data, msg->data,
> > >              sizeof(ec_dev->event_data.data));
> > > @@ -883,11 +883,9 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
> > >       params = (struct ec_params_motion_sense *)msg->data;
> > >       params->cmd = MOTIONSENSE_CMD_DUMP;
> > >
> > > -     ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
> > > +     ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> > >       if (ret < 0) {
> > >               sensor_count = ret;
> > > -     } else if (msg->result != EC_RES_SUCCESS) {
> > > -             sensor_count = -EPROTO;
> > >       } else {
> > >               resp = (struct ec_response_motion_sense *)msg->data;
> > >               sensor_count = resp->dump.sensor_count;
> > > @@ -898,9 +896,7 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
> > >        * Check legacy mode: Let's find out if sensors are accessible
> > >        * via LPC interface.
> > >        */
> > > -     if (sensor_count == -EPROTO &&
> > > -         ec->cmd_offset == 0 &&
> > > -         ec_dev->cmd_readmem) {
> > > +     if (sensor_count < 0 && ec->cmd_offset == 0 && ec_dev->cmd_readmem) {
> > >               ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS,
> > >                               1, &status);
> > >               if (ret >= 0 &&
> > > @@ -915,9 +911,6 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
> > >                        */
> > >                       sensor_count = 0;
> > >               }
> > > -     } else if (sensor_count == -EPROTO) {
> > > -             /* EC responded, but does not understand DUMP command. */
> > > -             sensor_count = 0;
> > >       }
> > >       return sensor_count;
> > >  }
> > >
