Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC99B27E741
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgI3Kz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:55:59 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:15058 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgI3Kz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:55:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601463358; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=23IxMnrq2Jp59pR7Ft4ivJfH7caZwKcP3O3ByLp+9OU=; b=bJY+fLZtdkNeE2S84wSJGNZyHn1txx4HWZLn05Ee7y5VKtB4u4gSifZDpbik+Yiv/C8KWgNe
 fFO4OecGjp5iO6xd2ZvJIkZq2jffXpWYCysbw9m47WLqML90ZmyRobM868SKBeFk2c/otUNa
 uR/L8JuaHT7qgBGIT+uo0zXTeQM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f74642919fe605f254d928b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 10:55:37
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2836C433F1; Wed, 30 Sep 2020 10:55:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.118] (unknown [49.207.198.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F36EC433CA;
        Wed, 30 Sep 2020 10:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F36EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/2] docs: Clarify abstract scale usage for power values
 in Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar.Eggemann@arm.com, Quentin Perret <qperret@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20200929121610.16060-1-lukasz.luba@arm.com>
 <CAD=FV=UnNkjMiOc0DZE7+OM3-Kr1ZRynxSerdA=ifbyGiRa2Zw@mail.gmail.com>
 <a1d1fe2a-485f-a21e-2f91-9b609223aa5a@arm.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <62540312-65a2-b6d9-86ce-b4deaaa913c1@codeaurora.org>
Date:   Wed, 30 Sep 2020 16:25:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a1d1fe2a-485f-a21e-2f91-9b609223aa5a@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/30/2020 1:55 PM, Lukasz Luba wrote:
> Hi Douglas,
> 
> On 9/30/20 12:53 AM, Doug Anderson wrote:
>> Hi,
>>
>> On Tue, Sep 29, 2020 at 5:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>> The Energy Model (EM) can store power values in milli-Watts or in abstract
>>> scale. This might cause issues in the subsystems which use the EM for
>>> estimating the device power, such as:
>>> - mixing of different scales in a subsystem which uses multiple
>>>    (cooling) devices (e.g. thermal Intelligent Power Allocation (IPA))
>>> - assuming that energy [milli-Joules] can be derived from the EM power
>>>    values which might not be possible since the power scale doesn't have to
>>>    be in milli-Watts
>>>
>>> To avoid misconfiguration add the needed documentation to the EM and
>>> related subsystems: EAS and IPA.
>>>
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>> ---
>>>   .../driver-api/thermal/power_allocator.rst          |  8 ++++++++
>>>   Documentation/power/energy-model.rst                | 13 +++++++++++++
>>>   Documentation/scheduler/sched-energy.rst            |  5 +++++
>>>   3 files changed, 26 insertions(+)
>>
>> I haven't read through these files in massive detail, but the quick
>> skim makes me believe that your additions seem sane.  In general, I'm
>> happy with documenting reality, thus:
>>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> Thank you for the review.
> 
>>
>> I will note: you haven't actually updated the device tree bindings.
>> Thus, presumably, anyone who is specifying these numbers in the device
>> tree is still supposed to specify them in a way that mW can be
>> recovered, right?  Said another way: nothing about your patches makes
>> it OK to specify numbers in device trees using an "abstract scale",
>> right?
> 
> For completeness, we are talking here about the binding from:
> Documentation/devicetree/bindings/arm/cpus.yaml
> which is 'dynamic-power-coefficient'. Yes, it stays untouched, also the
> unit (uW/MHz/V^2) which then allows to have mW in the power
> values in the EM.

So for platforms where 'dynamic-power-coefficient' is specified in device tree,
its always expected to be derived from 'real' power numbers on these platforms in
'real' mW?

Atleast on Qualcomm platforms we have these numbers scaled, so in essence it
can't be used to derive 'real' mW values. That said we also do not have any of
the 'platform might face potential issue of mixing devices in one thermal zone
of two scales' problem.

So the question is, can such platforms still use 'dynamic-power-coefficient'
in device tree and create an abstract scale? The other way of doing this would
be to *not* specify this value in device tree and have these values stored in the
cpufreq driver and register a custom callback to do the math.

It just feels like jumping through hoops just to deal with the fact that the
device tree bindings say its expected to be in mW and can't be abstract.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
