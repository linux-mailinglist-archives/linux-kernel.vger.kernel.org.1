Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508952E3FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 15:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502863AbgL1OXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502176AbgL1OUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:20:44 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0141C06179C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 06:20:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y8so5689553plp.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 06:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3eeDccvrtLhJ2RlU4cT+GxgHVi8ODX3K/3/cMoQn/k=;
        b=kXj6ALbb7BsUDHxYmTLQCj+IoAVVGAFFcd/GgRVc1henpkMQOd3UkBcPkLLlBdf9FF
         q6M8/srNJmwFr5kf5LhooXTW+6g6Ihfzov1bjX3G0HPc8uSvzXuft7hoORGrGtENY6lC
         +RoQyAkLm2S5THWl+AubvKZ5ueibnu5Lj0mGBkvtF7o23RGpXobbsnFi6OJMjMTwTGhb
         383K9+T1iDrltKQIyGN0Oc7PhcEcIDfc0NQHvd+kJs4/StE2E0E3E2dRCZRQHtbXhSyw
         kWwHZKwSjNJA4QEmE1WAICI7Z2R3lNheiQWhRCM541xMsPxJqjTZgN7C1LYr3nXjwP8i
         HKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3eeDccvrtLhJ2RlU4cT+GxgHVi8ODX3K/3/cMoQn/k=;
        b=lQzUKoP4YK47ghX5tY8SbmgVU8b7O29ZdbRJFVqa4OPXQowUH8aI/Al5hdGQLkaYLl
         8WEOZ/JhDxtCrEnWO8gSloMVqHWo12BnlwUyXAAzJNd0laD4cJN1UqqWfFzvmCLKhgWN
         yknVssP6nO+0dV8Dig7zkKdBSLZWWe7VMBk7uerdbBBb/sbeIFFUTNMCwOhrqYI3Y0Cm
         ZZnojFOyBDEzbomkWVmTowLESmbfapViP5JNK6g5N76uj6HWSenvel1AvJGv4BXtjYBh
         wQN1TssHIbfTn7Vahr/q9SxNXZLjjrExi1a4pZHM1/icxg2Cj/9hnOSM7XlRXg88BkL3
         g/lw==
X-Gm-Message-State: AOAM53170qams4RinWxXIuH5yKcdOsjf+BqDFXbqBkjVK32TJtLasfrI
        5xNBj6lkpT2Gw/fzTA5X06OPAHudEJ6KEOB43+k=
X-Google-Smtp-Source: ABdhPJwNC33nHrVZvkEyUW3jXHOEfzfHJSbX/0d6I5CasyY83H4HtlUyaSLZUVZKRF8RaXC/Ld1qRvjesVFnjc4wom4=
X-Received: by 2002:a17:902:e98c:b029:da:cb88:f11d with SMTP id
 f12-20020a170902e98cb02900dacb88f11dmr24012086plb.17.1609165203427; Mon, 28
 Dec 2020 06:20:03 -0800 (PST)
MIME-Version: 1.0
References: <20201227211232.117801-1-hdegoede@redhat.com>
In-Reply-To: <20201227211232.117801-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Dec 2020 16:19:46 +0200
Message-ID: <CAHp75VcMGjhuNWgVx6Jn6vGCN8pvPO5ePz7oprabhiW=Ffc_rg@mail.gmail.com>
Subject: Re: [PATCH 00/14] MFD/extcon/ASoC: Add support for Intel Bay Trail
 boards with WM5102 codec
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 11:15 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> This patch series adds support for Intel Bay Trail based device which use
> a WM5102 codec for audio output/input. This was developed and tested on a
> Lenovo Yoga Tablet 1051L.
>
> This series consists of 3 parts:
> 1. Arizona MFD drv patches for ACPI bindings, better jack-detect support
>    and misc. fixes
> 2. extcon-arizona driver fixes and improved jack reporting (this depends
>    on the MFD changes)
> 3. ASoC patches in the form of a quirk for BYTCR detecting, a new
>    machine driver for BYT + WM5102 and jack-detect support for the new
>    machine driver (which again depends on the MFD changes).
>
> Given that 2. and 3. depend on the MFD changes I believe that it is best
> if all patches in this series are merged through the MFD tree (once
> reviewed and acked) and then Lee can provide a immutable branch for
> the ASoC and extcon maintainers to merge into their trees.
>
> I have a patch with matching UCM profile changes available here:
> https://github.com/jwrdegoede/alsa-ucm-conf/commit/316109e7814926ba984322c1d9190575fab9021c
>
> This series + the UCM profile has been tested with both the SST and
> SOF ASoC drivers for BYT devices.

Thanks for fixing this!
I found the series pretty much in a good shape (only two patches I
think need a bit of work), FWIW
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
after addressing comments.

> BugLink: https://github.com/thesofproject/linux/issues/2485

Shouldn't this be somewhere in the "main" fix? (Yes, I understand that
it may sound silly and should be copied to almost half of the series,
but if there is a good place it would be nice to have in the Git
history)


-- 
With Best Regards,
Andy Shevchenko
