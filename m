Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F4A19F501
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 13:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgDFLqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 07:46:11 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:23474 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727481AbgDFLqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:46:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586173570; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=fwS8B2ZENTJa//1JM/Tb3FQEjJEuwZJOlzrKeFY+6hA=; b=FoP7Z2BYzo9e3+b4+ERF7Ax/AcMgqRsFpRvKVKdSSHrekZB7+7yKjsECTnxS8c0MLlzLizIh
 91z4xjykbNgxXutcxM/k+D2C5LRmKgTQym53ahYuW7wNE7Wqw0mWacvohcX/vhfwyedAU1sr
 maRKiXSyxvnitdMcG51sjWOW77M=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b1676.7fa8d21966f8-smtp-out-n04;
 Mon, 06 Apr 2020 11:45:58 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1F0FFC4478F; Mon,  6 Apr 2020 11:45:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [157.44.182.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8662C433D2;
        Mon,  6 Apr 2020 11:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8662C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH 2/3] iio: adc: Add PMIC7 ADC bindings
To:     Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
 <1585064650-16235-3-git-send-email-jprakash@codeaurora.org>
 <CAHLCerO6GY4pNAxZucCOv3wSDweA1MsuPh5bGjSWoEUauv0iFA@mail.gmail.com>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <a8d02f55-ef32-82e5-d261-f644d4c725ed@codeaurora.org>
Date:   Mon, 6 Apr 2020 17:15:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHLCerO6GY4pNAxZucCOv3wSDweA1MsuPh5bGjSWoEUauv0iFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 4/3/2020 5:41 PM, Amit Kucheria wrote:
> Hi Jishnu,
>
> On Tue, Mar 24, 2020 at 9:15 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>> Add documentation for PMIC7 ADC peripheral. For PMIC7 ADC, all SW
>> communication to ADC goes through PMK8350, which communicates with
>> other PMICs through PBS.
> What is PMK8350? What is PBS? Please expand the acronyms and describe
> more verbosely.
PMK8350 is just the name of one of the PMIC7 family of PMICs. I'll 
expand the description in the next post.
>
>> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
>> ---
>>   .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 28 ++++++++++++++++------
>>   1 file changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
>> index 72db14c..20f010c 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
>> @@ -13,7 +13,7 @@ maintainers:
>>   description: |
>>     SPMI PMIC voltage ADC (VADC) provides interface to clients to read
>>     voltage. The VADC is a 15-bit sigma-delta ADC.
>> -  SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
>> +  SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
>>     voltage. The VADC is a 16-bit sigma-delta ADC.
>>
>>
