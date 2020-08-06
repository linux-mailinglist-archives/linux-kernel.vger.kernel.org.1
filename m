Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763E823D5DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 05:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgHFDrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 23:47:51 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:38497 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbgHFDrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:47:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596685670; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=t1wyWqVtkXEHbE514TF0VHElBeW1/dYqN2kCbkvgXv4=;
 b=ppYBrnfhenHGP81f17v/Ufxr0U52hQU752usT9PbeB+SE3EQ0B3NkbLmavoeDZg2M67yHcRp
 cfJ7KGsF0ewY18sonZjaDXgmLdMbWoOK2xnr0cp4eF3KBniGrvTCYvPe3UzT5aJnaDoo0m6f
 WolXefM4KCEM+ej8qmGk/gcJszA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-west-2.postgun.com with SMTP id
 5f2b7d5303528d4024d144d6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 Aug 2020 03:47:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 85407C433CB; Thu,  6 Aug 2020 03:47:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mansur)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 001FAC433C9;
        Thu,  6 Aug 2020 03:47:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Aug 2020 09:17:30 +0530
From:   mansur@codeaurora.org
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     stanimir.varbanov@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] venus: core: add shutdown callback for venus
In-Reply-To: <7223de0f80de73835238abe13a79d1bc@codeaurora.org>
References: <1592044386-15654-1-git-send-email-mansur@codeaurora.org>
 <7223de0f80de73835238abe13a79d1bc@codeaurora.org>
Message-ID: <eb92618f22fd5350ab7e4565d54e86a5@codeaurora.org>
X-Sender: mansur@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

> On 2020-06-24 12:17, Sai Prakash Ranjan wrote:
>> Hi Mansur,
>> 
>> On 2020-06-13 16:03, Mansur Alisha Shaik wrote:
>>> After the SMMU translation is disabled in the
>>> arm-smmu shutdown callback during reboot, if
>>> any subsystem are still alive then IOVAs they
>>> are using will become PAs on bus, which may
>>> lead to crash.
>>> 
>>> Below are the consumers of smmu from venus
>>> arm-smmu: consumer: aa00000.video-codec supplier=15000000.iommu
>>> arm-smmu: consumer: video-firmware.0 supplier=15000000.iommu
>>> 
>>> So implemented shutdown callback, which detach iommu maps.
>>> 
>>> Change-Id: I0f0f331056e0b84b92f1d86f66618d4b1caaa24a
>>> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
>>> ---
>>>  drivers/media/platform/qcom/venus/core.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>> 
>>> diff --git a/drivers/media/platform/qcom/venus/core.c
>>> b/drivers/media/platform/qcom/venus/core.c
>>> index 30d4b9e..acf798c 100644
>>> --- a/drivers/media/platform/qcom/venus/core.c
>>> +++ b/drivers/media/platform/qcom/venus/core.c
>>> @@ -371,6 +371,14 @@ static int venus_remove(struct platform_device 
>>> *pdev)
>>>  	return ret;
>>>  }
>>> 
>>> +static void venus_core_shutdown(struct platform_device *pdev)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = venus_remove(pdev);
>>> +	WARN_ON(ret < 0);
>> 
>> I don't think you should warn here, its shutdown path and you can't
>> do anything with this WARN unlike remove callback where you have
>> to be sure to cleanup properly so that you are able to reload module.
>> But if you still want a hint about this failure, then just add a 
>> dev_err()
>> to indicate the failure instead of a big stack trace spamming kernel 
>> log.
>> 

posted V2 version by adding dev_warn during shutdown failure instead of 
WARN_ON.
V2 version : https://lore.kernel.org/patchwork/patch/1284693/

>> Thanks,
>> Sai

---
Thanks,
Mansur
