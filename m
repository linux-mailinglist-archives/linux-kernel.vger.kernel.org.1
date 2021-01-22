Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3167B300DED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbhAVUl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbhAVUko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:40:44 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EBBC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:40:04 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n7so4618060pgg.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPBpTtNISftNMnwOVfv0OcRq7P7OLC0DLakDCVVKP/U=;
        b=fgcWBQDdJ0m1A8KrLvi9mOIAG0c1vqbz725WE9Yq4aZM0AIG7DSAN/OBvxu4pA1rLe
         70+Vd6TWFk5J9wwuTdVdrvtHub1/AKBCruwfJP4f3uU62PQP2N3kli+mzQC6hIMvrJ6e
         qx8/BcLGdhZ/Yw5YwbTWVkw+084MCcieaDEnTsfAeq9HWUWiZJufrT1vpa9+cMGfP5C5
         4KtWEd98cP1RnNSyLytLlO5lYqj0xPsB752MOxKxeZ8JWnlwEUU4dmuoubzE01n3xeUH
         /MW59zP4bMvLIfmXoT1h1fJKuaRS2M21yebh0cwC8JsybV7mXg4BS0iF5tYkaRK5vU0z
         J6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPBpTtNISftNMnwOVfv0OcRq7P7OLC0DLakDCVVKP/U=;
        b=Fs8IRUhDab+Uu1Rlk5G8txY3hQqaqNEVf04HOv2L9jYSdZdUXlv5oGQQ9ECU86a54F
         OWg5XlAuytSPXSwenPSq9yVBBe28Rq1y60kAhTK64OwfAoEW2/5eEL1Jcva4lH+P14NF
         QU6MofBuk2IJxJI3krGgppKiuKfGSodB29EUcBiP5d5nM1peLV0iKjqOR2krfCJN1twA
         oDt+ToYSddpqx0CV6dmQQPSmheZVBI6WVhSuKi+yyr+rLEAEKeB07bnw3bp1vFhWFlNR
         Bt0TSN87HVadS5jrECW0Yy0FAtutttF/eA/NczdnoPArxtamWRqohbshy1HRmu4WwPJ+
         PyhQ==
X-Gm-Message-State: AOAM533VFx1Tzih0EBv/zpUIoMPFZuStvx9l5S6BVnrGiB3WFXm6boDG
        LI/NF6tqGrzyIEv8qC0iynpZ4Sj58z8NvxSMl0Liybau+qHhPw==
X-Google-Smtp-Source: ABdhPJwnbZ+jAOGuV98zPaY7ANvVMlLzk73pb/52V5+0ncXlHDi/+mOtDdqNqaD4GwHheMMKR5Kg8GQRrKXfDvMNFGU=
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id
 q20-20020a056a000854b02901b762330c5fmr6578225pfk.73.1611348004138; Fri, 22
 Jan 2021 12:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20210122164107.361939-1-hdegoede@redhat.com> <20210122164107.361939-7-hdegoede@redhat.com>
In-Reply-To: <20210122164107.361939-7-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 Jan 2021 22:40:53 +0200
Message-ID: <CAHp75VedGzihYi1Ndjj4K4326pMrLtk3V7gi_rxteu5HaqWfEA@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] ASoC/extcon: arizona: Move arizona jack code to sound/soc/codecs/arizona-jack.c
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 6:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The jack handling for arizona codecs is being refactored so that it is
> done directly by the codec drivers, instead of having an extcon-driver
> bind to a separate "arizona-extcon" child-device for this.
>
> drivers/mfd/arizona-core.c has already been updated to no longer
> instantiate an "arizona-extcon" child-device for the arizona codecs.
>
> This means that the "arizona-extcon" driver is no longer useful
> (there are no longer any devices for it to bind to).
>
> This commit drops the extcon Kconfig / Makefile bits and moves
> drivers/extcon/extcon-arizona.c to sound/soc/codecs/arizona-jack.c .
>
> This is a preparation patch for converting the arizona extcon-driver into
> a helper library for letting the arizona codec-drivers directly report jack
> state through the standard sound/soc/soc-jack.c functions.

...

>  MAINTAINERS                                               | 1 -

> -F:     drivers/extcon/extcon-arizona.c

Commit message doesn't shed a light if we need to move this actually
to another record in MAINTAINERS database.

-- 
With Best Regards,
Andy Shevchenko
