Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78CE2E0002
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgLUSia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgLUSi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:38:29 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5F2C0611CA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:37:48 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m25so25960353lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OvIy+je2Kd/cJewHk0Cl2/RLAuIPuaVK5CnveLEJtgI=;
        b=eHh3zez2PVNKgy+jqoJDRazYYbYiy5Pa9+iHkqYOTiIOZPapU4B70l4sk5o0iMubws
         lSCJ7rc9lKMVelN7k1EHtCPunP59l7VDgEaU8rJy5u94JZkoK1VhuxeM/Jjgt+w8vrG8
         A/vqHZX9yN8Y3eGG8ssBiMg232/dISo0WnUEnkA66p0OR+bBfw2LGXIQvAeXPDtMQ6j1
         Kybj2VXzL3XPkbgnl1NzE0g70mQj8iFROyiarp1Hs0JugMsG6L+ogj8myrKaoMe2JM1O
         vz/fOQAd9taWQ1IwBCC65MB8mkH55qoZ2r1td2LZSI2fJQURFZTWYSoPD9G38iXLqqth
         jg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OvIy+je2Kd/cJewHk0Cl2/RLAuIPuaVK5CnveLEJtgI=;
        b=ZawMJE6A4lU6DSl3eFw9i/MpmFGwaiI8QXESYznlpKIjViShpRte4v5rW3oGK7o5SL
         +EQaOi3up8AHczipGY+4IA2HoZ0gUtRTbDlPdIbNcGNnUtwzyVD4H2qFlusGpmjAvkPJ
         FJqYHd7F/ERKD+RVAAG1f87ic93IYpjac2Y75FxIv9tqnquAJ7/KOaQ89EN8qK4ViCwL
         bWXgmwYk0POVIIGntBiN7tDgyk2CJYat9Gysh7zMd0M9FvfuEudh0Am9ExjSRyt6CNfH
         rA31cMtRnd7ZEXdXIKZsYmLfWlQuhVw+CewTO+nxDQ+2+kROkTVU49S/3MUyFr5QRV1q
         dJDQ==
X-Gm-Message-State: AOAM530auZCOdK/modr9Yrwn0NyUQBGvNmD2o0gDt+deAZhlYvpGgzih
        g13qH+sYibuZ0BMfU2vsIIO9KaRZOWwv3A==
X-Google-Smtp-Source: ABdhPJyo3Azp+6BoCc6hfTxxuk687uLFXzXvFwFxUrKnlCzmKZ2/y/o7AR8tHJsBbBVXw11VTjH1lg==
X-Received: by 2002:a17:907:971c:: with SMTP id jg28mr15987408ejc.85.1608566620722;
        Mon, 21 Dec 2020 08:03:40 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-148-164.adsl.proxad.net. [82.252.148.164])
        by smtp.googlemail.com with ESMTPSA id b7sm9146492ejp.5.2020.12.21.08.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:03:40 -0800 (PST)
Subject: Re: [PATCH 1/2] thermal: int340x: Add critical callback to override
 default shutdown behavior
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>, amitk@kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Matthew Garrett <mjg59@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Kaestle <peter@piie.net>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201221135206.17671-1-kai.heng.feng@canonical.com>
 <20e74dc1-1f1d-6dee-19a7-e9a975b66606@linaro.org>
 <CAAd53p5WRVMgSquOC69Yq3DO+itSR44273bLWiF7wXUxFZMDhg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9e4dc22e-e912-8410-945c-f802f3959028@linaro.org>
Date:   Mon, 21 Dec 2020 17:03:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAd53p5WRVMgSquOC69Yq3DO+itSR44273bLWiF7wXUxFZMDhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2020 16:00, Kai-Heng Feng wrote:
> On Mon, Dec 21, 2020 at 9:59 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 21/12/2020 14:52, Kai-Heng Feng wrote:
>>> We are seeing thermal shutdown on Intel based mobile workstations, the
>>> shutdown happens during the first trip handle in
>>> thermal_zone_device_register():
>>> kernel: thermal thermal_zone15: critical temperature reached (101 C), shutting down
>>>
>>> However, we shouldn't do a thermal shutdown here, since
>>> 1) We may want to use a dedicated daemon, Intel's thermald in this case,
>>> to handle thermal shutdown.
>>>
>>> 2) For ACPI based system, _CRT doesn't mean shutdown unless it's inside
>>> ThermalZone namespace. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
>>> "... If this object it present under a device, the device’s driver
>>> evaluates this object to determine the device’s critical cooling
>>> temperature trip point. This value may then be used by the device’s
>>> driver to program an internal device temperature sensor trip point."
>>>
>>> So a "critical trip" here merely means we should take a more aggressive
>>> cooling method.
>>>
>>> As int340x device isn't present under ACPI ThermalZone, override the
>>> default .critical callback to prevent surprising thermal shutdown.
>>>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>
>> I'll submit those changes for v5.11-rc1 and change the subject by:
>>
>> thermal: int340x: Fix unexpected shutdown at critical temperature
>> thermal: pch: Fix unexpected shutdown at critical temperature
>>
>> Sounds good ?
> 
> Sounds good to me. Thanks!
> 
> Kai-Heng

Rui, Srinivas? Are you ok with the changes ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
