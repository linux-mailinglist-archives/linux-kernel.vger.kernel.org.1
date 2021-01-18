Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A732F9CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389906AbhARKRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389372AbhARJ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:56:06 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23C6C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:55:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c124so12981581wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yQySp1I8dFlNRZ6TD27mEdeFa/4xBBrxR4vuqWLafeM=;
        b=EM3w46xMJCikT6pc8p5LzxRmPXG4HmSnVkSjwPfCOJon/tBwwlsZi2ieazcVLmtHlq
         EqRb1Dy6VT33nWYEcocTvZX6ZFAaetOYEbz+owufRCsbbviwwQOMXczFnAgIBd73+Qfw
         3RDX/4VrJ57YGxWS1qq9Ey5DWgPiAwJhzaHGx/86NMIWZJFZwUukekdz7lIFCQQEDHMj
         jhhwAe7SUmBP0X9Fx9EMS1cvexbx5sG9kQQfLfNZK/TYVeOSoB7UyrEqV8vireMTDydW
         ty+nCLNeYmuI3ynzLufT7etS1YG14NT1c24MtRd6bPFD5lLVIeB/eOPmZFrG37r0FBzn
         lBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yQySp1I8dFlNRZ6TD27mEdeFa/4xBBrxR4vuqWLafeM=;
        b=ufrpDVQaBCpYYM3AYwiZpvMPBLlw3cj8+gB0oeC45N9D1nQUAFeqrWCVd17HovZokG
         zkNxybiT+BAVubtBt4ksm98MqMuNbt256/lYsrxZkReuD2MA4pPn7OBDvmg95QzgYHQe
         Voh9UlYRyBNCn0sX8YbwPfslCb27H6yfO8jxGUl99UUCBXtrHo8K0XqvWv8HJ+Yez/jv
         62WEodlhA/G6b6heGUM31wK5LtkDQnMoo2QgW6IVrBF3qbawGl9aQDWL9Uu6aOunXa6F
         0McCxpRjD0KQOjk3RkiWNm3bh2HorHeYXMSj3kouVy1d3PjwkqNqUZYSf8XiYBLDyoTE
         FFsg==
X-Gm-Message-State: AOAM532bSpMmKkKWT5Px6kVHw7xjPjFE5XT74X/lPDV+cfcKKnfDxRBP
        UW2HgxcPpQt4z7BnhFDQKxQiiQ==
X-Google-Smtp-Source: ABdhPJzLhP1CCxFTPbYev6ZBSYyZSUO95R17hQJYKV68+tkak1J7y9dicSOAK6pN4T3m+Clh+pIYng==
X-Received: by 2002:a1c:4e:: with SMTP id 75mr7199354wma.150.1610963712403;
        Mon, 18 Jan 2021 01:55:12 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id c2sm24225161wrt.87.2021.01.18.01.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 01:55:11 -0800 (PST)
Date:   Mon, 18 Jan 2021 09:55:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 00/12] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
Message-ID: <20210118095509.GA4903@dell>
References: <20210117160555.78376-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210117160555.78376-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021, Hans de Goede wrote:

> Hi All,
> 
> This series reworks the arizona codec jack-detect support to use
> the snd_soc_jack helpers instead of direct extcon reporting.
> 
> This is done by reworking the extcon driver into an arizona-jackdet
> library and then modifying the codec drivers to use that directly,
> replacing the old separate extcon child-devices and extcon-driver.
> 
> This brings the arizona-codec jack-detect handling inline with how
> all other ASoC codec driver do this.
> 
> This was developed and tested on a Lenovo Yoga Tablet 1051L with
> a WM5102 codec.
> 
> The MFD, ASoC and extcon parts can be merged independent from each-other
> although that could lead to a case where both the extcon driver and
> the new arizona-jackdet library will try to do jack-detection. If we
> end up with a git tree in that state then one of the 2 will fail to
> load because the other will already have claimed the IRQs, so this
> is not a problem really.
> 
> Or the entire series could be merged through the MFD tree if people
> prefer that.
> 
> Note that this series also paves the way for some further cleanups,
> removing some jackdetect related variables like hp_ena and hp_clamp
> from the arizona data struct shared between all the MFD child devices.
> I've deliberately not done that cleanup as part of this patch-series,
> since IMHO the series is big enough as is. These cleanups can be done
> in a follow-up series once this series has landed.

Would you mind using `git format-patch` to create your cover-letters
in the future please?  This one is missing useful information such as
the diff-stat and patch list.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
