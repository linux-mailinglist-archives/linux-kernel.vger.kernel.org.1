Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00D72F84F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbhAOS7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:59:30 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:64168 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733299AbhAOS73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:59:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610737150; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=CTWsszJIGit8xUcYKEnIWmsbcjTlkI5zf4lKh3ma3SY=; b=Aj5qVJ+NFy1/HoPDDvIw5QQKDG5ri3abOFUb6E8FoitgZl7i1M7K7TQbTH/vYNRJv5FpWXjo
 tcgKKMrkWvGWFl/9vy10DvIo++wvphg4Z3V8I6HNngygQLZuaLr4UCBK47OWyAyizmWjIS0I
 7ch3EnKQvdWKjkWKr99ZIjaO7xM=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 6001e5d7fd7e724dd362547d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 15 Jan 2021 18:58:31
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3CE93C43462; Fri, 15 Jan 2021 18:58:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.46.162.249] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44829C433ED;
        Fri, 15 Jan 2021 18:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44829C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hemantk@codeaurora.org
Subject: Re: [PATCH v2 2/3] bus: mhi: core: Download AMSS image from
 appropriate function
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, carl.yin@quectel.com,
        naveen.kumar@quectel.com, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org
References: <1610651795-31287-1-git-send-email-bbhatt@codeaurora.org>
 <1610651795-31287-3-git-send-email-bbhatt@codeaurora.org>
From:   Hemant Kumar <hemantk@codeaurora.org>
Message-ID: <69798940-b1fd-1a8e-40ff-945167ca8734@codeaurora.org>
Date:   Fri, 15 Jan 2021 10:58:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610651795-31287-3-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhaumik,

On 1/14/21 11:16 AM, Bhaumik Bhatt wrote:
> During full boot chain firmware download, the PM state worker
> downloads the AMSS image after waiting for the SBL execution
> environment change in PBL mode itself. Since getting rid of the
> firmware load worker thread, this design needs to change and MHI
Can we reword this as current driver does not have firmware load worker 
thread. Basically change is to avoid blocking st worker thread with a 
timeout to get SBL EE before starting AMSS image download. Instead 
trigger AMSS image download directly from the st worker thread when
DEV_ST_TRANSITION_SBL is queued.

> host must download the AMSS image from the SBL mode of PM state
> worker thread instead. Since the full boot chain firmware
> download is associated with a synchronous power up and has MHI
> host waiting for a transition to mission mode with a timeout, we
> can skip creating any devices (or probing any client drivers) in
> SBL mode transition and proceed directly with the AMSS image
> download.
> 
> This means that if MHI host driver is not responsible for the
> AMSS image download or the controller plans to have client
> drivers opening any SBL channels, for example, to download images
> or monitor debug logs for memory allocations or power management,
> the device can be powered up asynchronously.
> 
[..]

Thanks,
Hemant

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
