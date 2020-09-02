Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4602625A517
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 07:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIBFg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 01:36:26 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:34102 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbgIBFgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 01:36:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599024984; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Ji73SYobjua5kOTQythFn0xAJRkAQsD505nfnZi/Ywk=; b=EiaDVic3f40znoT9uB4LuFaRlfR/VcPpaiP5VRPS6LwmwYZ9cnUnJQyH3X555Ut2Y9vrWVDs
 Iu6Wsh/Q6MZXnzaWEybkLk37vP9WQTBm+f15BTKpKm1fyXPwLvTJ/y+qPAf1CSmC4zWvF3j7
 OoGCIimJ0+jfm2PyLp4Hm2L1azc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f4f2f4cd7b4e26913b82f53 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 05:36:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83463C43391; Wed,  2 Sep 2020 05:36:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.16] (unknown [61.1.229.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EFBFBC433C6;
        Wed,  2 Sep 2020 05:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFBFBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add 'sustainable_power' for CPU
 thermal zones
To:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
References: <20200813113030.1.I89c33c4119eaffb986b1e8c1bc6f0e30267089cd@changeid>
 <20200901170745.GA3419728@google.com>
 <CAD=FV=Xv0FLtWWcQcRy7p2LPNdDtSjdarsvNHRHaLkWwABnwJw@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <8ad0589e-102d-7523-899f-0ebe85b7d2b8@codeaurora.org>
Date:   Wed, 2 Sep 2020 11:06:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Xv0FLtWWcQcRy7p2LPNdDtSjdarsvNHRHaLkWwABnwJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> * In terms of the numbers here, I believe that you're claiming that we
> can dissipate 768 mW * 6 + 1202 mW * 2 = ~7 Watts of power.  My memory
> of how much power we could dissipate in previous laptops I worked on
> is a little fuzzy, but that doesn't seem insane for a passively-cooled
> laptop.  However, I think someone could conceivably put this chip in a
> smaller form factor.  In such a case, it seems like we'd want these
> things to sum up to ~2000 (if it would ever make sense for someone to
> put this chip in a phone) or ~4000 (if it would ever make sense for
> someone to put this chip in a small tablet).  It seems possible that,
> to achieve this, we might have to tweak the
> "dynamic-power-coefficient".

DPC values are calculated (at a SoC) by actually measuring max power at various
frequency/voltage combinations by running things like dhrystone.
How would the max power a SoC can generate depend on form factors?
How much it can dissipate sure is, but then I am not super familiar how
thermal frameworks end up using DPC for calculating power dissipated,
I am guessing they don't.
  
> I don't know how much thought was put
> into those numbers, but the fact that the little cores have a super
> round 100 for their dynamic-power-coefficient makes me feel like they
> might have been more schwags than anything.  Rajendra maybe knows?

FWIK, the values are always scaled and normalized to 100 for silver and
then used to derive the relative DPC number for gold. If you see the DPC
for silver cores even on sdm845 is a 100.
Again these are not estimations but based on actual power measurements.


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
