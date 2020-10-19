Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02763292E60
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbgJSTXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgJSTXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:23:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C05C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:23:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e17so932484wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CqLz2GES8nS6ZiyqNo1k1fKZexjy+aj8oQk7nWn8E5s=;
        b=LTHX5TvhwUCP+kBT+3IPrRVx0FpamCx+pK5VIQDhc2CHXNatdKgWdVgqoYzpWWxkfS
         VtI8U5zTofukggSNrirkeJgBs+jxx6SBhzxITJ1Jca1Argu/gOaXOS+3N+1lMfKNaZHa
         hmKfYhMgLQHIbWxstGXJKW9C1t+ix+3l1kKgpKzar9Yg3JpuNEaWwDXRMkNtEQwU+ewX
         WP0QbjANR9lqiCF82sVUMrUfuGf0m9AOIE8eELcnYxFA5iIxH7KuutRBLmWfVONEHKvg
         ClcK1UnJMo47tgmPHzJPYNE7J4+KdzNhY3hNx1GKahmepJd9wcvGzs0MByhmNvseAjFk
         PAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CqLz2GES8nS6ZiyqNo1k1fKZexjy+aj8oQk7nWn8E5s=;
        b=KlAPnKC2ejvYxObFw326F3coWm53jueqyfcgd9j3dv/a/FPeS+YXhekZbVzfib1nLS
         LhVXOKI3INYpZLtyok4k7PPAxSJQlARTIZtBTQ0KDVtK37OUXXd6c4TLyeu6aNtpkcwd
         NydubORt6ej8ZQqABclcdoaQtqTixEtY3TG9FDQ8UNZ76fJsg1lSJX9qqXKWIpRUzcIY
         RvsRhlRMV1kx4eGtV8eeVNB5a9P3ubFMfPkSXs22+ajgxWLyilrD1zpO5jbOPaV+fEnn
         J0i8PaXEdN2mHhybNARw4OSi8dZs0PeoBLPcNYScXUXrigtqN1DmDXiU8mPAYN0AGghi
         tCLw==
X-Gm-Message-State: AOAM530fpoevMCM+K6HDqdIEiHFPZ4fe6CS3M4twEILDzpzqPq09B4eY
        KsVHXOKilanrgHkc/vnpVdc+wQ==
X-Google-Smtp-Source: ABdhPJwvDOb2U0x3L8Lupi6+YluOA0LVBNFpAxYZG+9+aEqeubTUjGjKi/MxpNQClQi+Djx91W/rLw==
X-Received: by 2002:adf:f792:: with SMTP id q18mr744862wrp.333.1603135383177;
        Mon, 19 Oct 2020 12:23:03 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cd19:90dc:c92f:a1c1? ([2a01:e34:ed2f:f020:cd19:90dc:c92f:a1c1])
        by smtp.googlemail.com with ESMTPSA id x15sm978219wrr.36.2020.10.19.12.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 12:23:02 -0700 (PDT)
Subject: Re: [PATCH RFC 0/8] Introduce warming in thermal framework
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lukasz.luba@arm.com, amitk@kernel.org
References: <20200917032226.820371-1-thara.gopinath@linaro.org>
 <CALD-y_wQeuUq=0+_TGWYwOAcM4zdmGbtCMYZ+Oa587HtzHHqVQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <12160a98-bf04-939c-0149-018db8affe08@linaro.org>
Date:   Mon, 19 Oct 2020 21:22:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALD-y_wQeuUq=0+_TGWYwOAcM4zdmGbtCMYZ+Oa587HtzHHqVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2020 20:42, Thara Gopinath wrote:
> On Wed, 16 Sep 2020 at 23:22, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> Thermal framework today supports monitoring for rising temperatures and
>> subsequently initiating cooling action in case of a thermal trip point
>> being crossed. There are scenarios where a SoC need warming mitigating
>> action to be activated if the temperature falls below a cetain permissible
>> limit.  Since warming action can be considered mirror opposite of cooling
>> action, most of the thermal framework can be re-used to achieve this. The
>> key assumption in this patch series is that a device can act either as a
>> warming device or a cooling device and not as both.
>>
>> In order to support warming three extensions are needed in the thermal
>> framework.
>>
>> 1. Indication that a trip point is being monitored for falling temperature
>> and not rising temperature. We discussed two different ways to achieve this
>> during LPC. First option is to introduce a new trip type to indicate that a
>> trip is a cold trip(THERMAL_TRIP_COLD). The second option is to introduce a
>> new property for trip point that will indicate whether a trip point is
>> being monitored for rising temperature or falling temperature. The patch
>> series(patches 1-4) chooses the second approach since it allows trip points
>> of any type to be monitored for rising or falling temperature.Also this was
>> the preferred approach when discussed during LPC. The approach that
>> introduces a new cold trip type was posted on the list earlier as a RFC and
>> can be found at [1].
>>
>> 2. Extend the exisitng governors to handle monitoring of falling
>> temperature. The patch series(patches 5 & 6) extends the step wise governor
>> to monitor the falling temperature.Other governors return doing nothing if
>> the trip point they are being called for is being monitored for falling
>> temperature. The governors' mitigate function is called "throttle" in the
>> thermal framework and with this patch series it is a misnomer as the
>> function is called for both throttling and warming up. Ideally
>> "throttle" should be renamed to "mitigate" to improve readability of code.
>> The renaming is not part of this series.
>>
>> 3. Finally, the cooling device framework itself can be reused for a warming
>> device. As stated before a device can act either as a warming device or a
>> cooling device and not as both.  With this the cooling state in the
>> framework can be considered as mitigating state with 0 as the state with no
>> thermal mitigation and higher the number higher the thermal mitigation.
>> Again what affects the code readability and comprehension is the term
>> "cooling" which is a misnomer here. Ideally the term "cooling" should be
>> renamed to "mitigating" and hence thermal_cooling_device will become
>> thermal_mitgating_device. The renaming is not part of the patch series as
>> even though the renaming is a simple search-replace, it will change a lot
>> of files.  The patch series(patches 7 & 8) instead introduces a minimal set
>> of _warming_device_ apis to register and unregister warming devices which
>> internally is identical to the _cooling_device_ counterpart.
> 
> Gentle ping for review..

Pong, review before the end of this week.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
