Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F0B303A10
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391924AbhAZKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:19:11 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:10112 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387445AbhAZBXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:23:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611624195; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=7OsIShq8IRb2YDHJ4/j58ebi3yNhkVmimR5GqE3wAqY=; b=kxK9ABfaS5POFEkIE+gsg72luKKcR7jhH/AuesATUpjKPNwHB4WQ0fpVv/15tOUXWbTzmCA7
 mEbBXxrw4f1D/+8zqGywJDGjYQgRl1QLkGgtGf979m8QAUm1NmqI6LZh/FtPZXZEt5jFTMHe
 XB3J6AGZCNEZZbJOKwqXR42MULQ=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 600f6cfe5677aca7bd490ac0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Jan 2021 01:14:38
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D725AC43463; Tue, 26 Jan 2021 01:14:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.110.78.65] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91F3AC433C6;
        Tue, 26 Jan 2021 01:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91F3AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v6 3/4] usb: dwc3: Resize TX FIFOs to meet EP bursting
 requirements
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter.chen@nxp.com,
        jackp@codeaurora.org
References: <1611288100-31118-1-git-send-email-wcheng@codeaurora.org>
 <1611288100-31118-4-git-send-email-wcheng@codeaurora.org>
 <YAsHbj/mITeiY5Cq@builder.lan>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <724cb274-36ce-fb48-a156-4eaf9e686fdf@codeaurora.org>
Date:   Mon, 25 Jan 2021 17:14:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAsHbj/mITeiY5Cq@builder.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/2021 9:12 AM, Bjorn Andersson wrote:
> On Thu 21 Jan 22:01 CST 2021, Wesley Cheng wrote:
> 

Hi Bjorn,
> 
> Under what circumstances should we specify this? And in particular are
> there scenarios (in the Qualcomm platforms) where this must not be set?
>The TXFIFO dynamic allocation is actually a feature within the DWC3
controller, and isn't specifically for QCOM based platforms.  It won't
do any harm functionally if this flag is not set, as this is meant for
enhancing performance/bandwidth.

> In particular, the composition can be changed in runtime, so should we
> set this for all Qualcomm platforms?
> 
Ideally yes, if we want to increase bandwith for situations where SS
endpoint bursting is set to a higher value.

> And if that's the case, can we not just set it from the qcom driver?
> 
Since this is a common DWC3 core feature, I think it would make more
sense to have it in DWC3 core instead of a vendor's DWC3 glue driver.

Thanks
Wesley Cheng

> Regards,
> Bjorn


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
