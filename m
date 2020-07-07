Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1292167F3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgGGIDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 04:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgGGIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:03:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E6EC08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 01:03:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so44163100wrv.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 01:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vi8QIB3allPIgtc+g0TQIDBLQpQq3t8N/dpOokskUIo=;
        b=TqS6r/FOFqwjyy0ZYLrNgewmD/GW5FRT6IK4DchWcSREKSGX/AnlKCZxH+MbHoVEY8
         FpT6X4Wjt2Z510SzVrsKwyLl6iwreWo8yAXQR/YQNKVP++DJ9b6viH/ajhIqp2lCC/vM
         PaabZ1UTLZ0w/upJq0sj3FeLdn0huKm8VIgG/6FmhUoX8Qo3CWtEcM0JKbLkJu9PgJ5d
         Bo+hH0tHtIZ6jLcotPdMZ8mK0qS/CqHLHO2sXQS02vuhcsjThc6j0LEdSKRIvcLCKUDl
         vgjItvckjEDVh6Z0OM+f+lKIXT4YV4grEn/HzhS5dXvuMR38OlhVGl0y5l7A4FWu+kvl
         VhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vi8QIB3allPIgtc+g0TQIDBLQpQq3t8N/dpOokskUIo=;
        b=daFz+a+0atqlQmvs4FNFyg3867waypq4W3Uur/sVAIl8jJ257GZKiPxkm/8RnLiTlO
         0p1YJ5mh5l6JVqZgoZMy1bNsfEmzbg9WBAqac7ckikHljEwewA4M7O+z7gX4uZxwvgOh
         qjnwFUhexwoqwsxpnwdeGQ9w89RVvUwM9zPSYSpDsMu7nfKB6iBxYICf0sIMEP61LkSB
         IPW/pLSFZbfbJBfQl3kErU+qBnNcEm/+6hNgFE3+WHBKl1PLZjV0RuQzbdFm+iIk/OBY
         6bhnNJECmGQSF22CVHhdjTpjcrJadLnSPPVPAvT5SlH0mwlkYdsLZcYr+Nf9oah7CEhM
         U2RQ==
X-Gm-Message-State: AOAM530RkK1+UxO1dX4FiEq28IBc6vx5wj96HRuSdRlvj07Cf521wp16
        J6KedQyVWwc/vSHtLVfaC231b1nbJU0kzsIZN65XMA==
X-Google-Smtp-Source: ABdhPJyl4Q71vOqumcQz4YfC1YAuHs6zh2eiNBQQqOIQUkflwCRnOimvIwqwTX7hst2UVshvN1suVKbkXvoRi7qE8O4=
X-Received: by 2002:adf:b6a4:: with SMTP id j36mr53365270wre.260.1594109026427;
 Tue, 07 Jul 2020 01:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200706085240.1979622-1-darekm@google.com> <20200706090056.GI6538@piout.net>
In-Reply-To: <20200706090056.GI6538@piout.net>
From:   Dariusz Marcinkiewicz <darekm@google.com>
Date:   Tue, 7 Jul 2020 10:03:34 +0200
Message-ID: <CALFZZQH3NaMVuaxt8noWcpWToxwYWdWO_jUOQPvwdtFBPaNLRw@mail.gmail.com>
Subject: Re: [PATCH] media: cros-ec-cec: disable the device wakeup on remove
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dariusz Marcinkiewicz <darekm@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 11:00 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 06/07/2020 10:52:38+0200, Dariusz Marcinkiewicz wrote:
> > The device is enabled for wake up while the driver is loaded.
> > For symmetry, disable wakeup when it is removed.
> >
>
> This is not necessary as it is handled by the core properly. There are
> currently 73 calls to device_init_wakeup that are not necessary, this
> would add one more.
>
Thank you.

To make sure - your comment applies even if the device node in
question is not actually removed, as it is the case here? This is a
platform dev, which won't be freed when the driver is unloaded.

Regards.



> > Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
> > ---
> >  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> > index 2d95e16cd248..3881ed7bc3d9 100644
> > --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> > +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> > @@ -277,8 +277,6 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
> >       platform_set_drvdata(pdev, cros_ec_cec);
> >       cros_ec_cec->cros_ec = cros_ec;
> >
> > -     device_init_wakeup(&pdev->dev, 1);
> > -
> >       cros_ec_cec->adap = cec_allocate_adapter(&cros_ec_cec_ops, cros_ec_cec,
> >                                                DRV_NAME,
> >                                                CEC_CAP_DEFAULTS |
> > @@ -306,6 +304,8 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
> >       if (ret < 0)
> >               goto out_probe_notify;
> >
> > +     device_init_wakeup(&pdev->dev, 1);
> > +
> >       return 0;
> >
> >  out_probe_notify:
> > @@ -335,6 +335,8 @@ static int cros_ec_cec_remove(struct platform_device *pdev)
> >                                        cros_ec_cec->adap);
> >       cec_unregister_adapter(cros_ec_cec->adap);
> >
> > +     device_init_wakeup(&pdev->dev, 0);
> > +
> >       return 0;
> >  }
> >
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
