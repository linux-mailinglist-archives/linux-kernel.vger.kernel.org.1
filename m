Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E182F9DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbhARLMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389110AbhARKr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:47:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5146C061786
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:47:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r4so13334587wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nHf20OOCMo8x4Qdkj9BcWGoZ1gfgVypLNOIWfvt4zr0=;
        b=GIDQCTkWdAQcVU5Y65kMWYXGOSSZ6ywq+wJSQGrBn28lZM3s438IHY/LWhXAc3zsPK
         fhYbP0Ev37Ve0xrjNZInpO1RAuuc/ffmthMvZnnVU/2JtZ/vkp6+3SZWAq1oH8e/W+Oh
         oOa7MpT0iKokhtW2+8rVyShUiYTbrI4O5RYahLFt21kK7lbX9KNDojzOSspNyGXTXr9V
         TlHawqeTvr3VRoSEsCPX2xnmlVjTrowr1QkPAube3MF5ahZks6FwjYA7IGT2gSKLQvDb
         kQ9s152UkO1YFgk44pvdQ0ZrHCnB9iFweh1swp8kyj14o5j/kt3PkkB2qHBNnMtJkDXK
         AWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nHf20OOCMo8x4Qdkj9BcWGoZ1gfgVypLNOIWfvt4zr0=;
        b=rhLlYXxJLXsTpiQO2sFVFiGMUDs1b3ssTHf5Lzm0KgwggK2ZMRMJn9RZG8+SrQBpbR
         FkBvJ09tdWMHbMhjjWTpC64B9YKs9LvUTjU5QOst4qsfOsnko77OZ+AVNNdA3gYMfjNH
         n/HUIRNfR8Xp53bLulQYHbwOIVXIoAHbnu0IERQh4rhTT79h1sDOQpHKHO1u+dYemk2Z
         12JeEg9dWcjjv6E/nENbdCGtRH9akDigcRFpzuG3m2rB7q/vwmbNYwvUIzcs9Bo7bL0K
         IF0YO4M3AXnBybIjA5nt6lpaLqIB/lxlxsVPgm87Leq0GKSbqpo8VTd9OLpqO1B8VclD
         z9hQ==
X-Gm-Message-State: AOAM530r4RW25JWXoxSfVbpH3y0A3KAKoW+k0/kYzrK8bgKTcqwWtfBZ
        gR67wt5ZxHsrX9jUHXIRkO+69A==
X-Google-Smtp-Source: ABdhPJx2SuIaE0os9zlqBPDDM6QMp5/GqngUcm6CMXsxuZJeI3DyE+gGaJ44JUHFhPAomftdX+aSow==
X-Received: by 2002:a1c:730f:: with SMTP id d15mr20124727wmb.135.1610966834579;
        Mon, 18 Jan 2021 02:47:14 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id p12sm1868057wmi.3.2021.01.18.02.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 02:47:13 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:47:12 +0000
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
Message-ID: <20210118104712.GD4903@dell>
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210118095509.GA4903@dell>
 <8905f9f2-1c1c-1b64-d70d-374f84568ccb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8905f9f2-1c1c-1b64-d70d-374f84568ccb@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021, Hans de Goede wrote:

> Hi,
> 
> On 1/18/21 10:55 AM, Lee Jones wrote:
> > On Sun, 17 Jan 2021, Hans de Goede wrote:
> > 
> >> Hi All,
> >>
> >> This series reworks the arizona codec jack-detect support to use
> >> the snd_soc_jack helpers instead of direct extcon reporting.
> >>
> >> This is done by reworking the extcon driver into an arizona-jackdet
> >> library and then modifying the codec drivers to use that directly,
> >> replacing the old separate extcon child-devices and extcon-driver.
> >>
> >> This brings the arizona-codec jack-detect handling inline with how
> >> all other ASoC codec driver do this.
> >>
> >> This was developed and tested on a Lenovo Yoga Tablet 1051L with
> >> a WM5102 codec.
> >>
> >> The MFD, ASoC and extcon parts can be merged independent from each-other
> >> although that could lead to a case where both the extcon driver and
> >> the new arizona-jackdet library will try to do jack-detection. If we
> >> end up with a git tree in that state then one of the 2 will fail to
> >> load because the other will already have claimed the IRQs, so this
> >> is not a problem really.
> >>
> >> Or the entire series could be merged through the MFD tree if people
> >> prefer that.
> >>
> >> Note that this series also paves the way for some further cleanups,
> >> removing some jackdetect related variables like hp_ena and hp_clamp
> >> from the arizona data struct shared between all the MFD child devices.
> >> I've deliberately not done that cleanup as part of this patch-series,
> >> since IMHO the series is big enough as is. These cleanups can be done
> >> in a follow-up series once this series has landed.
> > 
> > Would you mind using `git format-patch` to create your cover-letters
> > in the future please?  This one is missing useful information such as
> > the diff-stat and patch list.
> 
> I never heard about that git feature until today, so I learn something
> new every day :)
> 
> I just tested it and it seems useful. I will try to use it next time.

After all these years... That's so funny. :D

Happy to be of service.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
