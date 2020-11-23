Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E0C2C0E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgKWO6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:58:38 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33579 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgKWO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:58:36 -0500
Received: by mail-ed1-f65.google.com with SMTP id k4so17419614edl.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8PYxqUct+Q9mNYdM8wqPvnUwdPo92AiSu9RZ/r3u+qk=;
        b=puJ85wHvZF/FWf9t8ZVzkRkvuicst9wtdiRZyviQM9xvujsJuzJ5N5I2OjlQh5Ymwo
         FkWDY+e8w2QLKTrejfmI1vy93hPip3tx0yZxTGBHrllUcvYi1QKZQ4+A2zlkeVXf9lKb
         g+A2CRRSnAFyKimHYVD0Jd2DVbzbzRSGAmI+xvtGtTDA/M3VWZeQrpXTlkCbX+TwfuBe
         kZ+w2VgmF+t/jbmo9hh2InQkqpT15pV9kQmhmwsf2i8c8ZrV7R5od/2aZHOYhBVc6mBO
         /semlGO/yxJ815xOQ6DSA2Vkv98GlBA8Vi5XDZ4470PgLkBICC90Px/7R63ALJd5pEf0
         tDaw==
X-Gm-Message-State: AOAM532oRvxkpKSmwK30KMpps8LYz3R63Zk6Xy2279CnA1Yc02u33wY2
        qrrEIkiZ7BWQjPpAXbrubC4=
X-Google-Smtp-Source: ABdhPJy5lpwJxRHqEXprOoNPlghH8kM6ItxjLvP3djlOBLJEk6uuQ6S56QVwCwPzAi/JZKe2jkr+6g==
X-Received: by 2002:a50:a40f:: with SMTP id u15mr48456599edb.307.1606143514524;
        Mon, 23 Nov 2020 06:58:34 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id g20sm5224076ejk.3.2020.11.23.06.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 06:58:32 -0800 (PST)
Date:   Mon, 23 Nov 2020 15:58:31 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201123145831.GA202597@kozik-lap>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120165202.GG6751@sirena.org.uk>
 <20201120194245.GA2925@kozik-lap>
 <20201120200429.GJ6751@sirena.org.uk>
 <20201122105813.GA3780@kozik-lap>
 <20201123104832.GY4077@smile.fi.intel.com>
 <20201123123731.GA6322@sirena.org.uk>
 <20201123124129.GA170000@kozik-lap>
 <20201123135006.GE6322@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201123135006.GE6322@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 01:50:06PM +0000, Mark Brown wrote:
> On Mon, Nov 23, 2020 at 01:41:29PM +0100, Krzysztof Kozlowski wrote:
> > On Mon, Nov 23, 2020 at 12:37:31PM +0000, Mark Brown wrote:
> 
> > > That feels like something that should be done with Kconfig dependencies
> > > like a direct OF dependency (possibly a !PRP0001 dependency?) for the
> > > driver or possibly with having a variant of_match_ptr() for things that
> > > really don't want to support PRP0001.  Just removing all the use of
> > > of_match_ptr() is both noisy and confusing in that it looks like it's
> > > creating issues to fix, it makes it hard to understand when and why one
> > > should use the macro.
> 
> > For the OF-only drivers (without other ID table), there is no point to
> > use the macro. Driver can bind only with DT, so what is the point of
> > of_match_ptr? To skip the OF table when building without OF? Driver
> > won't be usable at all in such case. So maybe for compile testing?
> > There is no need to remove OF table for simple build tests.
> 
> If nothing else it means you don't have to check if the driver is OF
> only or not.  I can see not bothering to add it but actively going round
> removing some instances of it doesn't seem great, and it seems like
> people will constantly be adding new uses on the basis that it's just
> such an obviously correct thing to do.

If my patch was not changing anything, I would agree that it might be
just a churn. But the patch fixes a real warning.

The other way of fixing warning is the one you proposed at beginning -
adding maybe_unused. Here we go to the second reason:

Having these of_match_ptr() for OF-only drivers is not the correct way
but rather something which is copied from existing drivers into new
ones. This is another reason for removing them - people will stop
copying this code all over again.

Best regards,
Krzysztof

