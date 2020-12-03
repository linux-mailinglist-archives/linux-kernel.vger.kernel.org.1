Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607AD2CD8A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgLCOMK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Dec 2020 09:12:10 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:34795 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgLCOMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:12:09 -0500
Received: by mail-ej1-f67.google.com with SMTP id g20so3707340ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 06:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HvFZiSMhoT0aeyub9btQ17rJWqEcfPqD1vSkkC2bi6U=;
        b=MbwZCyaXiJ7bBnr3Hv0pArt6sYqJvvdnwOzV5eChpugAMEoNeIVAYj84qPJjnMHVJZ
         XWVdpTdMiz5fuLfnBEAVs7+HXAVCVhJlzGmVu62HD4fwHh2tIE7lffCdNzfAmlY0MO1w
         f+OWUdQtjXQ1xcsu3IRIPSDp5FtC/II716jQJugR2omI48aQ8Ioa+Ph85a2yYG33Ou1U
         Jczv/UDn6zfHox/6R7dBnE503D4V+hzjwKu+zww4uxJIW2tMovrzv6y3QBtiyc4v//C0
         /4yfIvzo3o1wcM0C75UmcFmhySwcpx7xZsKjNwriWUY/NEExn/Fj/uxU/2UE9/5FyuYl
         fT2w==
X-Gm-Message-State: AOAM533GaDp5VpGTOMSmKgPqzTFHNITU3ruikIjgRcX7R+z9HYPQr6bu
        bZNL2NDBAmanpMwnnZafqZo=
X-Google-Smtp-Source: ABdhPJwmTL7CqlVMbcxOkKjnuwYYIrLWmt7q2Iqbg4wZ3SjdKguBUGw7iF61U1RnqWFHNlGYLe8sew==
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr2580951ejb.264.1607004686773;
        Thu, 03 Dec 2020 06:11:26 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id t26sm1256930edt.69.2020.12.03.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 06:11:25 -0800 (PST)
Date:   Thu, 3 Dec 2020 16:11:23 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] amba: Make the remove callback return void
Message-ID: <20201203141123.GA7735@kozik-lap>
References: <20201124133139.3072124-1-uwe@kleine-koenig.org>
 <20201124133139.3072124-5-uwe@kleine-koenig.org>
 <20201203130141.ys2s7aaltyzkdena@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201203130141.ys2s7aaltyzkdena@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:01:41PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> [This is a resend because somehow my MUA failed to parse the To: list
> and dropped it without me noticing it. Sorry to those who got it twice
> now.]
> 
> On Tue, Nov 24, 2020 at 02:31:38PM +0100, Uwe Kleine-König wrote:
> > From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > 
> > All amba drivers return 0 in their remove callback. Together with the
> > driver core ignoring the return value anyhow, it doesn't make sense to
> > return a value here.
> > 
> > Change the remove prototype to return void, which makes it explicit that
> > returning an error value doesn't work as expected. This simplifies changing
> > the core remove callback to return void, too.
> > 
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/amba/bus.c                                 | 5 ++---
> >  drivers/char/hw_random/nomadik-rng.c               | 3 +--
> >  drivers/dma/pl330.c                                | 3 +--
> >  drivers/gpu/drm/pl111/pl111_drv.c                  | 4 +---
> >  drivers/hwtracing/coresight/coresight-catu.c       | 3 +--
> >  drivers/hwtracing/coresight/coresight-cpu-debug.c  | 4 +---
> >  drivers/hwtracing/coresight/coresight-cti-core.c   | 4 +---
> >  drivers/hwtracing/coresight/coresight-etb10.c      | 4 +---
> >  drivers/hwtracing/coresight/coresight-etm3x-core.c | 4 +---
> >  drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 +---
> >  drivers/hwtracing/coresight/coresight-funnel.c     | 4 ++--
> >  drivers/hwtracing/coresight/coresight-replicator.c | 4 ++--
> >  drivers/hwtracing/coresight/coresight-stm.c        | 4 +---
> >  drivers/hwtracing/coresight/coresight-tmc-core.c   | 4 +---
> >  drivers/hwtracing/coresight/coresight-tpiu.c       | 4 +---
> >  drivers/i2c/busses/i2c-nomadik.c                   | 4 +---
> >  drivers/input/serio/ambakmi.c                      | 3 +--
> >  drivers/memory/pl172.c                             | 4 +---
> >  drivers/memory/pl353-smc.c                         | 4 +---

For the memory:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
