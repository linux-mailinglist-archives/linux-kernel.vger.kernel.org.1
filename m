Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1DB2FD75A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391843AbhATRlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730545AbhATRiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:38:08 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B54FC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:37:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v15so20247537wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=h4o1dqV1saA7hYOJlBVLQsq7Q1SofZIleeHLa1n/egM=;
        b=r4LRj2ZHTeb9ADlUTM5kszCh7XMbCx74c2Av/bphqgjiLl3oZYyI19iTJuSK9Epvo6
         cgo1dopcJS6lomWcqFMHUtcyK3rXHcYsQTZGV8BQRvwSueJZniYjBa0bSaxFCOErmJdi
         4nMYnCp4SNT46fC+1HKiK+JgZBjicGdta8LOkPR8jRUNI2fj0i2EW/4qVqOUynfHq57d
         cjQkCvTo9GpmFNfqY0ZrZPQMRCKDN7MFVWXwx2R0MBC1KzmvvstzduuXOS6EMOKMCvf3
         edh/KDjDNebV6vfG0BQfaiKaqjKOQ7TTu6+A3TRKjbHcFAFNWxKOkKy2lJp8X2Ajt7lT
         567Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h4o1dqV1saA7hYOJlBVLQsq7Q1SofZIleeHLa1n/egM=;
        b=U43Rvi0Yf7Une+1OKZc1O9xHFv/cZm0AXee1al3BHgBNuJF5CMtxnbV3YqWj/jjgj0
         Dz2P2wDt+4X2b3P0uGrj97j6OOC+SEhlfHlUhPvd33KKRMgvQ363tjNea/Prr125ELMI
         F3VbZsAKQp+lZv2DEhuL+iweM9XNFKqYtgxvhykc2qm3htPaaG8cg7nK3joJiE1caowm
         2MehjBd3Yn3SRljb7qw0B/2ctue37lQeLKuE9cOXsxvqNjlKcZrqY/ELB9euXjbX+xA5
         KrBufB+RENwBIQ3nn4srAq8gaj2e/LXM7oJzlrhS1JUlwSIJaRRUrTdqnDaft6p4ZN9S
         /1NQ==
X-Gm-Message-State: AOAM533SX58MHGh/CNjJfA076jXw/LdK2UujtgErGN0ZoUW0yNAegCeS
        rsSE2sx1xD3ngoOL4JUb1tlkdw==
X-Google-Smtp-Source: ABdhPJzkezaLXgq5uH78Cp6GjxLgHk7vFHYkmiYrokCm4/BtfZHexDrRbjL04HUFOyb8tTclJDb35w==
X-Received: by 2002:a05:6000:254:: with SMTP id m20mr2062106wrz.300.1611164237903;
        Wed, 20 Jan 2021 09:37:17 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id w8sm5480791wrl.91.2021.01.20.09.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 09:37:16 -0800 (PST)
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        okukatla@codeaurora.org
References: <20210120080627.20784-1-manivannan.sadhasivam@linaro.org>
 <20210120080627.20784-3-manivannan.sadhasivam@linaro.org>
 <cb0f56b6-a75c-51a8-d640-08896d459a68@linaro.org>
 <20210120163735.GC54606@thinkpad>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SDX55 interconnect provider
 driver
Message-ID: <2a5d4de5-1e92-3b58-0ad1-9dd472ed7a0b@linaro.org>
Date:   Wed, 20 Jan 2021 19:37:20 +0200
MIME-Version: 1.0
In-Reply-To: <20210120163735.GC54606@thinkpad>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 1/20/21 18:37, Manivannan Sadhasivam wrote:
> Hi Georgi,
> 
> On Wed, Jan 20, 2021 at 04:59:31PM +0200, Georgi Djakov wrote:
>> Hi Mani,
>>
>> Thanks for the patch!
>>
>> On 1/20/21 10:06, Manivannan Sadhasivam wrote:
>>> Add driver for the Qualcomm interconnect buses found in SDX55 based
>>> platforms. The topology consists of several NoCs that are controlled by
>>> a remote processor that collects the aggregated bandwidth for each
>>> master-slave pairs.
>>>
>>> Based on SM8250 driver and generated from downstream dts.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>    drivers/interconnect/qcom/Kconfig  |  10 +
>>>    drivers/interconnect/qcom/Makefile |   2 +
>>>    drivers/interconnect/qcom/sdx55.c  | 356 +++++++++++++++++++++++++++++
>>>    drivers/interconnect/qcom/sdx55.h  |  70 ++++++
>>>    4 files changed, 438 insertions(+)
>>>    create mode 100644 drivers/interconnect/qcom/sdx55.c
>>>    create mode 100644 drivers/interconnect/qcom/sdx55.h
>>>
>>> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
>>> index a8f93ba265f8..6df7e2161a0a 100644
>>> --- a/drivers/interconnect/qcom/Kconfig
>>> +++ b/drivers/interconnect/qcom/Kconfig
>>> @@ -65,6 +65,16 @@ config INTERCONNECT_QCOM_SDM845
>>>    	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
>>>    	  platforms.
>>> +config INTERCONNECT_QCOM_SDX55
>>> +	tristate "Qualcomm SDX55 interconnect driver"
>>> +	depends on INTERCONNECT_QCOM
>>> +	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
>>
>> Why not use depends on INTERCONNECT_QCOM_RPMH_POSSIBLE?
>>
> 
> I just followed the same pattern as other RPMh based drivers. And I don't get
> what you are suggesting here! Can you please explain?

There are some recent changes here. Please check linux-next or v5.11-rc3+.

Thanks,
Georgi
