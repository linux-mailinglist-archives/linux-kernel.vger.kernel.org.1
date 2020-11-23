Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D962C0A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbgKWMm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 07:42:26 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:43184 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732672AbgKWMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:41:33 -0500
Received: by mail-ej1-f66.google.com with SMTP id k27so23019875ejs.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GPrtMY6OwrhTMTFZ3taFyOwaPYmLyv2VpU7rochRReg=;
        b=tgerCVLPHOfUQV3YAj2fSde0sukRBuKXBc4KJpilGrmOGy2gW+QM/M/iydu7SRQnKa
         WvHVExDti7CDRAIsCdTeVKkvC6IFPkyP8qxjyNIBI0H4tl9RCVYRAlC5nM9i76xH/pa3
         1fgQFBBfkkCP+Y7ONVVRrb/xUlm901+Q0pDTu16GZ8eW9v+Gy93Eo03AFpUAKufu7UZG
         NIiuSuA47o7Mtgu9Dq4nUxi92uGhpg4BWrD6uoq1k/fItjKL14Pl+RWNIk3NyPn2SvZ3
         dZsUFomiC7RX9DxQL4NNIHCkJjIo4CkBWhgxLE2CnurJwY/mf9mwP1OR5nAzv1eWvJqf
         uD8A==
X-Gm-Message-State: AOAM533lTWpg8Ozfo2eimpszh3yRy3sFreNirxMQ57ZElBe2rac2GaQB
        bc2KSnlpeyJzaEduQ0PGwr0=
X-Google-Smtp-Source: ABdhPJweTjHhkqFH1VFPyqJ/7+x5kCjNmVPNdbpMvAkswnuUiZsYEq13Ali5w0h7nyDPSgAbrxkeog==
X-Received: by 2002:a17:906:f8c5:: with SMTP id lh5mr46230675ejb.77.1606135291740;
        Mon, 23 Nov 2020 04:41:31 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id y15sm4946855eds.56.2020.11.23.04.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 04:41:30 -0800 (PST)
Date:   Mon, 23 Nov 2020 13:41:29 +0100
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
Message-ID: <20201123124129.GA170000@kozik-lap>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120165202.GG6751@sirena.org.uk>
 <20201120194245.GA2925@kozik-lap>
 <20201120200429.GJ6751@sirena.org.uk>
 <20201122105813.GA3780@kozik-lap>
 <20201123104832.GY4077@smile.fi.intel.com>
 <20201123123731.GA6322@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201123123731.GA6322@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 12:37:31PM +0000, Mark Brown wrote:
> On Mon, Nov 23, 2020 at 12:48:32PM +0200, Andy Shevchenko wrote:
> > On Sun, Nov 22, 2020 at 11:59:20AM +0100, Krzysztof Kozlowski wrote:
> > > On Fri, Nov 20, 2020 at 08:04:29PM +0000, Mark Brown wrote:
> 
> > > > Surely if that's the desired outcome the fix is to change the definition
> > > > of of_match_ptr() such that it leaves the reference with CONFIG_ACPI,
> > > > perhaps hidden behind a config option for PRP0001?  That seems better
> > > > than going through the entire tree like this.
> 
> > > That could be indeed an easier way to achieve this.
> 
> > ...easier and wrong in my opinion. Not all drivers need that.
> > What the point to touch it in the driver which is OF-only?
> > (For IP which will quite unlikely to be present in ACPI world)
> > Or if the device will get the correct ACPI ID?
> 
> That feels like something that should be done with Kconfig dependencies
> like a direct OF dependency (possibly a !PRP0001 dependency?) for the
> driver or possibly with having a variant of_match_ptr() for things that
> really don't want to support PRP0001.  Just removing all the use of
> of_match_ptr() is both noisy and confusing in that it looks like it's
> creating issues to fix, it makes it hard to understand when and why one
> should use the macro.

For the OF-only drivers (without other ID table), there is no point to
use the macro. Driver can bind only with DT, so what is the point of
of_match_ptr? To skip the OF table when building without OF? Driver
won't be usable at all in such case. So maybe for compile testing?
There is no need to remove OF table for simple build tests.

Best regards,
Krzysztof

