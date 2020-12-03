Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3412CDF19
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgLCThH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgLCThH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:37:07 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B78C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:36:21 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w16so2019437pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6eF0QAIv1/KV66bOz8yibVCv90a/ydrrt73kEf7iSL0=;
        b=XiG4CJIwwDFhuy/CwzksffK4iSUbGJsiF9xFlB3WPBKUSTNqFN1dROzJRaXSk3Mt1I
         maHF7w9nVaKKiDUR87XP+CeoW1cg9mNwuuQuaBSJNBNo61PfYSQHt+wwe1FZylCK4ms3
         WcBdBqbwzFS7xSF4EajV5PryEhg/N1UWJrZlEKHrLcZbK71PsUMYYkYzJI7l+vbSHjvr
         uJ/hFO+v0fZgpH5gvMRg4csxWjUwwluut4EraZz6md3zUAUl0TKAoSUW6I1UHqgJZPyX
         AzxopWChGHk6EouWsVU3rzG9g24DjQGM57/c8kaK1ko1b/ChJ9MDKHmQVqhw/aSYxuWQ
         BSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6eF0QAIv1/KV66bOz8yibVCv90a/ydrrt73kEf7iSL0=;
        b=cmY81ljSqpAdr/IwgTQeihDPtFHtVqTZioL7DsEwl8krAWgy8cv3CNTmJOPLsX4DfP
         YkdhqxOz/xduGMiIgmn80AJ0gFUgUeOrY10PMCGkfDkkVTr993viMiWPnMO7twf9Lyw7
         dpwP2UGMbQNkO7aHdkeyLoE8EXiQd537zSMxoRHA7iB5kCHeUPItN7hrnyHt3GLe4k1X
         bX2OkymoTatIk3dJgRlGgy+m3fbxDvIi0wJLF5Te4OjRqU6FPPV74dua2kFhZ+QAuHxi
         H22UvyYi2kdhSrz/R7KDaMJJ+0jm0UUvHipFxb36ZCCAkkJnZjvAuuOzpfauM/XmpppA
         fLuA==
X-Gm-Message-State: AOAM531/hJ5v1DpNoaNxGVpJO7nAqXcDczVmmlEAkcuecfF82JCey5Mh
        n5cX6gPlXQjthBMoV3ZzEHQ=
X-Google-Smtp-Source: ABdhPJxQ69cqa+vTX02ABVOcpHMNCayrSfyBWmKagfJRt8wTHCp1IiB1wF3KUV3C2WVR1dW1MaAA1A==
X-Received: by 2002:a62:8247:0:b029:19d:b276:96fb with SMTP id w68-20020a6282470000b029019db27696fbmr428918pfd.8.1607024180754;
        Thu, 03 Dec 2020 11:36:20 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id jz7sm185228pjb.14.2020.12.03.11.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:36:19 -0800 (PST)
Date:   Thu, 3 Dec 2020 11:36:16 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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
Message-ID: <X8k+MDeyKZCWxMOw@google.com>
References: <20201124133139.3072124-1-uwe@kleine-koenig.org>
 <20201124133139.3072124-5-uwe@kleine-koenig.org>
 <20201203130141.ys2s7aaltyzkdena@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
