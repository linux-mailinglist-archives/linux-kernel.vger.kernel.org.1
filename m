Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31E42F8DC2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbhAPRGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:06:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727169AbhAPRDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610816473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qupr++fTHbnNIAJqQF6SX3UmT2+7rap26aUJDYVRflA=;
        b=TTm1AvSq8vlxtxu2iYf0Bc5Eto/KoguNTSxpU2R/1IkoSydK9XWe8M7kN2NfUNorELk8ge
        7s4n9vtKD7Oq7im/k2JwkhR3Y6vEMsEOHzfr2hniPfjq8PGS7WpaSspv3lhp4qiaby5HB3
        4YycXlDzqpuAuyPJ8YfoUv96eZDOeRo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-5VtuKbvSP9GIInXvw3WBGA-1; Sat, 16 Jan 2021 11:49:16 -0500
X-MC-Unique: 5VtuKbvSP9GIInXvw3WBGA-1
Received: by mail-ed1-f70.google.com with SMTP id g25so5506560edu.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 08:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qupr++fTHbnNIAJqQF6SX3UmT2+7rap26aUJDYVRflA=;
        b=OBENBpVclMIGM6F8AdEQn6auXpS0luBgNZticlFIsaDPETYkkDvYFEWjcBk08aTVd/
         1Hv4FYE8zIvyWVw0YdX561/344V60yg3Vvlo2AgCN6Pd/eW3bZZdPiktctKRuowJUAM3
         O9E4RS8r4/bc9XjATcLaycjjMrGTYS+qcNd/iC+jfGHqiq25rrPSnNvwxAUFI3p/d3sL
         MXFunKV1zMk8L3cqTV8vSEJebMpSS5b0+M+BsVHteBkfV2Bh882DMgRUFFRygB0b41KX
         KQZ4vPaAIeNVOpcndoGJi3OHIZkfHvVikqLm03Qruy4lGCcJty77VBXPVBBGHwPdGZ/w
         hD9Q==
X-Gm-Message-State: AOAM533a0qmzAaycziEOD+14rU0DrqKzezGrYBSw9StqaucVy7lYx0m+
        Q35DbT+04I3l0G35v9tDZA/QhNm71kprFxjO3vMQPaRh974QGit+GKKOxsCuis32cApFvtzh6x0
        dTrRdSWk27tPdRbHCnzXYFxe8
X-Received: by 2002:a50:eb44:: with SMTP id z4mr13379023edp.167.1610815754979;
        Sat, 16 Jan 2021 08:49:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzi8DmB+mYK6lnksxQD6SeOrVQ+fX6wIJSvoCcFLD8Pen7ag/50Err0kNpfKGsWZEtuts3rbg==
X-Received: by 2002:a50:eb44:: with SMTP id z4mr13379012edp.167.1610815754745;
        Sat, 16 Jan 2021 08:49:14 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id i13sm7727343edu.22.2021.01.16.08.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 08:49:14 -0800 (PST)
Subject: Re: [PATCH 13/14] ASoC: Intel: bytcr_wm5102: Add machine driver for
 BYT/WM5102
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-14-hdegoede@redhat.com>
 <20201229135836.GO9673@ediswmail.ad.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6d881b08-2511-5dcf-0f88-4f54b937c967@redhat.com>
Date:   Sat, 16 Jan 2021 17:49:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201229135836.GO9673@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the review.

On 12/29/20 2:58 PM, Charles Keepax wrote:
> On Sun, Dec 27, 2020 at 10:12:31PM +0100, Hans de Goede wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> Add a new ASoc Machine driver for Intel Baytrail platforms with a
>> Wolfson Microelectronics WM5102 codec.
>>
>> This is based on a past contributions [1] from Paulo Sergio Travaglia
>> <pstglia@gmail.com> based on the Levono kernel [2] combined with
>> insights in things like the speaker GPIO from the android-x86 android
>> port for the Lenovo Yoga Tablet 2 1051F/L [3].
>>
>> [1] https://patchwork.kernel.org/project/alsa-devel/patch/593313f5.3636c80a.50e05.47e9@mx.google.com/
>> [2] https://github.com/lenovo-yt2-dev/android_kernel_lenovo_baytrail/blob/cm-12.1/sound/soc/intel/board/byt_bl_wm5102.c
>> [3] https://github.com/Kitsune2222/Android_Yoga_Tablet_2-1051F_Kernel
>>
>> The original machine driver from the Android ports was a crude modified
>> copy of bytcr_rt5640.c adjusted to work with the WM5102 codec.
>> This version has been extensively reworked to:
>>
>> 1. Remove all rt5640 related quirk handling. to the best of my knowledge
>> this setup is only used on the Lenovo Yoga Tablet 2 series (8, 10 and 13
>> inch models) which all use the same setup. So there is no need to deal
>> with all the variations with which we need to deal on rt5640 boards.
>>
>> 2. Rework clock handling, properly turn off the FLL and the platform-clock
>> when they are no longer necessary and don't reconfigure the FLL
>> unnecessarily when it is already running. This fixes a number of:
>> "Timed out waiting for lock" warnings being logged.
>>
>> 3. Add the GPIO controlled Speaker-VDD regulator as a DAPM_SUPPLY
>>
>> This only adds the machine driver and ACPI hooks, the BYT-CR detection
>> quirk which these devices need will be added in a separate patch.
>>
>> Co-authored-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
> 
> Just a couple really minor comments.
> 
>> +static int byt_wm5102_prepare_and_enable_pll1(struct snd_soc_dai *codec_dai, int rate)
>> +{
>> +	struct snd_soc_component *codec_component = codec_dai->component;
>> +	int sr_mult = ((rate % 4000) == 0) ?
>> +		(WM5102_MAX_SYSCLK_4K / rate) :
>> +		(WM5102_MAX_SYSCLK_11025 / rate);
>> +	int ret;
>> +
>> +	/* Reset FLL1 */
>> +	snd_soc_dai_set_pll(codec_dai, WM5102_FLL1_REFCLK, ARIZONA_FLL_SRC_NONE, 0, 0);
>> +	snd_soc_dai_set_pll(codec_dai, WM5102_FLL1, ARIZONA_FLL_SRC_NONE, 0, 0);
>> +
>> +	/* Configure the FLL1 PLL before selecting it */
>> +	ret = snd_soc_dai_set_pll(codec_dai, WM5102_FLL1, ARIZONA_CLK_SRC_MCLK1,
>> +				  MCLK_FREQ, rate * sr_mult);
>> +	if (ret) {
>> +		dev_err(codec_component->dev, "Error setting PLL: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = snd_soc_component_set_sysclk(codec_component, ARIZONA_CLK_SYSCLK,
>> +					   ARIZONA_CLK_SRC_FLL1, rate * sr_mult,
>> +					   SND_SOC_CLOCK_IN);
>> +	if (ret) {
>> +		dev_err(codec_component->dev, "Error setting ASYNCCLK: %d\n", ret);
> 
> Error message should say SYSCLK not ASYNCCLK.

Fixed for v2.

> 
>> +		return ret;
>> +	}
>> +
>> +	ret = snd_soc_component_set_sysclk(codec_component, ARIZONA_CLK_OPCLK, 0,
>> +					   rate * sr_mult, SND_SOC_CLOCK_OUT);
>> +	if (ret) {
>> +		dev_err(codec_component->dev, "Error setting OPCLK: %d\n", ret);
>> +		return ret;
>> +	}
> 
> OPCLK is a clock that can be outputted on the CODECs GPIOs. Is
> that being used to clock some external component? If so it should
> be added to the DAPM graph, if not you might as well remove this
> call.

I copy pasted this from the work done for Android X86 to get sound to
work on the Lenovo Tablet 2 series:
https://github.com/Kitsune2222/Android_Yoga_Tablet_2-1051F_Kernel

I believe when you say it is unnecessary, so I will remove it for v2
(and test without this present to make sure it is really unnecessary).

> 
>> +
>> +	ret = snd_soc_dai_set_sysclk(codec_dai, ARIZONA_CLK_SYSCLK,
>> +				     rate * 512, SND_SOC_CLOCK_IN);
>> +	if (ret) {
>> +		dev_err(codec_component->dev, "Error setting clock: %d\n", ret);
>> +		return ret;
>> +	}
>> +
> 
> The rate you set here doesn't actually matter, on wm5102 this
> just links the DAI to a specific clock domain and as they all
> default to SYSCLK you can omit this call if you want. Although no
> harm is caused by leaving it in.

I'm going to leave this in as I prefer to be explicit about things like
this, rather then relying on defaults.

Regards,

Hans

