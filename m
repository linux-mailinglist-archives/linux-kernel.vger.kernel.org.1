Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EC12A5930
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 23:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbgKCWFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 17:05:33 -0500
Received: from z5.mailgun.us ([104.130.96.5]:13018 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730549AbgKCWF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 17:05:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604441127; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=4BBm67fUFoo0KkqTgZeFbV6Hq2N7kpn5Ax07w3zlOJs=; b=eC4VOCkbG4zJE3VPgL64A1iqjCasQ2Z/5Q4hrfmJlW9VBVTC4NhdOj3ANWx1j56pyt94uOk/
 /b+UmDfqYMWyT7KVgfsAhW0ESp+m1xHJTdxXCEPBpkW+M7nR+JRkESCGbfeKeOSM+28bGONN
 jbyV7baRM/uwIrZvnm3Rj17DFm8=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fa1d4250ce128468bf6dc23 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Nov 2020 22:05:25
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 173F7C4339C; Tue,  3 Nov 2020 22:05:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.46.162.249] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BDF12C433C6;
        Tue,  3 Nov 2020 22:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDF12C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hemantk@codeaurora.org
Subject: Re: [PATCH v2] bus: mhi: core: Fix null pointer access when parsing
 MHI configuration
To:     carl.yin@quectel.com, manivannan.sadhasivam@linaro.org,
        sfr@canb.auug.org.au
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        naveen.kumar@quectel.com
References: <20201102122710.23406-1-carl.yin@quectel.com>
From:   Hemant Kumar <hemantk@codeaurora.org>
Message-ID: <e3f642a6-66de-163a-3006-79c76d6bf572@codeaurora.org>
Date:   Tue, 3 Nov 2020 14:05:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102122710.23406-1-carl.yin@quectel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/20 4:27 AM, carl.yin@quectel.com wrote:
> From: "carl.yin" <carl.yin@quectel.com>
> 
> Functions parse_ev_cfg() and parse_ch_cfg() access mhi_cntrl->mhi_dev
> before it is set in function mhi_register_controller(),
> use cntrl_dev instead of mhi_dev.
> 
> Fixes: 0cbf260820fa ("bus: mhi: core: Add support for registering MHI controllers")
> Signed-off-by: carl.yin <carl.yin@quectel.com>
> Reviewed-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
