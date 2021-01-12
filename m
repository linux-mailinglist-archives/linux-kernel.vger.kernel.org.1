Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE752F2B49
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390787AbhALJbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:31:02 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:31733 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389713AbhALJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:31:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610443838; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=074WLx/sNBYbNlq20eslBXSyFVzU/VE2fXP/4Hp+4Bw=;
 b=eBdT//6n3nsBIVfMPBn7ixxCJtOShqzn5PYBiroYAP7pfEgpQSEZpjzW/muKjmRlsT52uZHh
 d+WxSIB2sv4KnkQDG3utxJjXngGFoH4z2uLLnQ/5UOJ6Ys9bDkIGP0w+Y4yjt+LQI9DAeVqq
 JKd2C0rlnrhgtf7ouwTF2BdjPjw=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5ffd6c1c8fb3cda82fd38cc2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 12 Jan 2021 09:30:04
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3EAD2C433ED; Tue, 12 Jan 2021 09:30:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 78B9AC433CA;
        Tue, 12 Jan 2021 09:30:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Jan 2021 15:00:02 +0530
From:   mdalam@codeaurora.org
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     vkoul@kernel.org, corbet@lwn.net, agross@kernel.org,
        bjorn.andersson@linaro.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sricharan@codeaurora.org, mdalam=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Add LOCK and UNLOCK flag bit
 support
In-Reply-To: <11f538a697de934551bcec5036d7fb17@codeaurora.org>
References: <1608215842-15381-1-git-send-email-mdalam@codeaurora.org>
 <6c85436d-e064-367e-736b-951af82256c8@linaro.org>
 <9769c54acf54617a17346fea60ee38b6@codeaurora.org>
 <8c86f4db-9956-10d1-b380-a207137b50ef@linaro.org>
 <11f538a697de934551bcec5036d7fb17@codeaurora.org>
Message-ID: <ec3f90470eca80256d3c335c7fb23e4e@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-22 17:48, mdalam@codeaurora.org wrote:
> On 2020-12-21 23:39, Thara Gopinath wrote:
>> On 12/21/20 2:35 AM, mdalam@codeaurora.org wrote:
>>> On 2020-12-19 09:05, Thara Gopinath wrote:
>>>> On 12/17/20 9:37 AM, Md Sadre Alam wrote:
>>>>> This change will add support for LOCK & UNLOCK flag bit support
>>>>> on CMD descriptor.
>>>>> 
>>>>> If DMA_PREP_LOCK flag passed in prep_slave_sg then requester of 
>>>>> this
>>>>> transaction wanted to lock the DMA controller for this transaction 
>>>>> so
>>>>> BAM driver should set LOCK bit for the HW descriptor.
>>>>> 
>>>>> If DMA_PREP_UNLOCK flag passed in prep_slave_sg then requester of 
>>>>> this
>>>>> transaction wanted to unlock the DMA controller.so BAM driver 
>>>>> should set
>>>>> UNLOCK bit for the HW descriptor.
>>>> Hi,
>>>> 
>>>> This is a generic question. What is the point of LOCK/UNLOCK with
>>>> allocating LOCK groups to the individual dma channels? By default
>>>> doesn't all channels fall in the same group. This would mean that
>>>> a lock does not prevent the dma controller from not executing a
>>>> transaction on the other channels.
>>>> 
>>> 
>>> The Pipe Locking/Unlocking will be only on command-descriptor.
>>> Upon encountering a command descriptor with LOCK bit set, the BAM
>>> will lock all other pipes not related to the current pipe group, and 
>>> keep
>>> handling the current pipe only until it sees the UNLOCK set then it 
>>> will
>>> release all locked pipes.
>> 
>> So unless you assign pipe groups, this will not work as intended
>> right? So this patch is only half of the solution. There should also
>> be a patch allowing pipe groups to be assigned. Without that extra bit
>> this patch does nothing , right ?
> 
> Yes you are right.
> We are having some register which will configure the pipe lock group.
> But these registers are not exposed to non-secure world. These 
> registers
> only accessible through secure world. Currently in IPQ5018 SoC we are
> configuring
> these register in secure world to configure pipe lock group.

ping! Is there any update on this ? Do you need any further info ?
