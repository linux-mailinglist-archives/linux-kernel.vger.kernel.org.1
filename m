Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814AB2699B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgINXaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgINX36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:29:58 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C6C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:29:58 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cy2so885780qvb.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LMMeKp2XZpRF1V6rdaV2oQtIOtoLTbfrUXrpOurESU=;
        b=fqM0/dnlaOPZfZDvSInehjqLCGv92Do9aryh7PrDqYuQtkMj3euxZkE7wJKpo0cifl
         MQEVan4yDBhZX5g2RWHmv4zkFdJP+knp1Jk+ab2C1zGoxVKQz5D5MbE9W35NirE/GIKT
         4sQBCktG8vHj7E/6k5NAammSu2lDQHkfs3k+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LMMeKp2XZpRF1V6rdaV2oQtIOtoLTbfrUXrpOurESU=;
        b=WpH3wzr2w/1ZOwrXEF45gn06Y63cwmq3T9Dz1dXth23IxYy71RqSA8fTAFXEQiUjh5
         4kqv9ie9SqBqVw1UevbSV+FWLgLMu6q9S9cpI1sW4exizJ/2Z4oowpHYjyT+e87CoFfN
         +oQMJEW8HpYBcjmark2OjC8L6Chk5JsmXTLVjdhjkuZKIw43bL9+mSRZ8tExSpIbit+z
         LqLBfYAkzVB6AGWV91935Ipbpz67fvQC5NjR9lXo2nMQN3HBdvTqpg5zp73c6bhSDMdr
         I7Ritoh4vsoEMEeho8sOQ+oeJIkUOjTwVn3GOo4l1IknJmefwmuzxs2OntgbsIpY342N
         kgrg==
X-Gm-Message-State: AOAM533ZWIsYevqSNLdXugjTg64lb5h7EULQ7jPwNhxt+NL1iVbW/H0i
        NELXf4AwXP5TEIDxwS/YTgY514jl2JyAlPngX+es9w==
X-Google-Smtp-Source: ABdhPJwZEVJlR0rJuUtA5howpx7Kih8SD0nC3OjP9MBPorg1HbQRclaaF6QmZf4lQRTDQo5rKjzq/t4b+OGaGsvr3Jk=
X-Received: by 2002:ad4:56a6:: with SMTP id bd6mr16021039qvb.25.1600126195518;
 Mon, 14 Sep 2020 16:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200903095415.2572049-1-pmalani@chromium.org> <1e2de378-5f5b-939e-39d8-00d6cc5ab6c8@collabora.com>
In-Reply-To: <1e2de378-5f5b-939e-39d8-00d6cc5ab6c8@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 14 Sep 2020 16:29:43 -0700
Message-ID: <CACeCKaeNbhcoxCUkTJ1=jxGff5tNsSm4w7NdPe9=7dhUE7baqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_proto: Update
 cros_ec_cmd_xfer() call-sites
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Enric,

On Mon, Sep 7, 2020 at 3:48 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> Thank you for your patch.
>
> On 3/9/20 11:54, Prashant Malani wrote:
> > Since all the other call-sites of cros_ec_cmd_xfer() have been converted
> > to use cros_ec_cmd_xfer_status() instead, update the remaining
> > call-sites to prepare for the merge of cros_ec_cmd_xfer() into
> > cros_ec_cmd_xfer_status().
> >
> > As part of this update, change the error handling inside
> > cros_ec_get_sensor_count() such that the legacy LPC interface is tried
> > on all error values, not just when msg->result != EC_RESULT_SUCCESS.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
>
> Gwendal, I'd like to hear from you regarding this patch as you're the one that
> know most about the corner cases for the sensors in different hardware. Could
> you take a look and give us your Reviewed tag if all is good?
>
Gwendal, could you kindly take a look? Thanks!

> Thanks,
>
>  Enric
>
> > ---
> >  drivers/platform/chrome/cros_ec_proto.c | 15 ++++-----------
> >  1 file changed, 4 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index dda182132a6a..2cb1defcdd13 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -650,7 +650,7 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
> >       msg->insize = size;
> >       msg->outsize = 0;
> >
> > -     ret = cros_ec_cmd_xfer(ec_dev, msg);
> > +     ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> >       if (ret > 0) {
> >               ec_dev->event_size = ret - 1;
> >               ec_dev->event_data = *event;
> > @@ -694,7 +694,7 @@ static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
> >       msg->insize = sizeof(ec_dev->event_data.data);
> >       msg->outsize = 0;
> >
> > -     ec_dev->event_size = cros_ec_cmd_xfer(ec_dev, msg);
> > +     ec_dev->event_size = cros_ec_cmd_xfer_status(ec_dev, msg);
> >       ec_dev->event_data.event_type = EC_MKBP_EVENT_KEY_MATRIX;
> >       memcpy(&ec_dev->event_data.data, msg->data,
> >              sizeof(ec_dev->event_data.data));
> > @@ -883,11 +883,9 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
> >       params = (struct ec_params_motion_sense *)msg->data;
> >       params->cmd = MOTIONSENSE_CMD_DUMP;
> >
> > -     ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
> > +     ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> >       if (ret < 0) {
> >               sensor_count = ret;
> > -     } else if (msg->result != EC_RES_SUCCESS) {
> > -             sensor_count = -EPROTO;
> >       } else {
> >               resp = (struct ec_response_motion_sense *)msg->data;
> >               sensor_count = resp->dump.sensor_count;
> > @@ -898,9 +896,7 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
> >        * Check legacy mode: Let's find out if sensors are accessible
> >        * via LPC interface.
> >        */
> > -     if (sensor_count == -EPROTO &&
> > -         ec->cmd_offset == 0 &&
> > -         ec_dev->cmd_readmem) {
> > +     if (sensor_count < 0 && ec->cmd_offset == 0 && ec_dev->cmd_readmem) {
> >               ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS,
> >                               1, &status);
> >               if (ret >= 0 &&
> > @@ -915,9 +911,6 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
> >                        */
> >                       sensor_count = 0;
> >               }
> > -     } else if (sensor_count == -EPROTO) {
> > -             /* EC responded, but does not understand DUMP command. */
> > -             sensor_count = 0;
> >       }
> >       return sensor_count;
> >  }
> >
