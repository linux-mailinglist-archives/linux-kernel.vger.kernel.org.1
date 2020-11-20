Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04C12BA1EF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 06:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgKTFkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 00:40:55 -0500
Received: from z5.mailgun.us ([104.130.96.5]:12057 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgKTFky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 00:40:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605850854; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=rMmSjjnbyOzsRgThkDCdW/lmAgc5QuSLzvPD7FRGp28=;
 b=GjoB2/Uf1kNm/zPrYzoj6rQY5BGyKdO4zW43yTshdLIuc31FvDZF+iFiQB3Gw/vMK5bD846u
 pi8QU4eLaSDl3CxUZxwaTSIYarYO3gXA6Q7BC3BM7s4CJ7BfyO++bzb/ZLtNytwL/Gokeq/s
 s0w/z6VVNSA0vM6y4W/ODbZvpDs=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fb756e522377520ee6c25dd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Nov 2020 05:40:53
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06524C43460; Fri, 20 Nov 2020 05:40:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CF3AC433ED;
        Fri, 20 Nov 2020 05:40:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Nov 2020 11:10:51 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, jonathan.zhouwen@huawei.com,
        coresight@lists.linaro.org, Tingwei Zhang <tingwei@codeaurora.org>
Subject: Re: [PATCH v4 02/25] coresight: etm4x: Skip accessing TRCPDCR in
 save/restore
In-Reply-To: <20201119164547.2982871-3-suzuki.poulose@arm.com>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-3-suzuki.poulose@arm.com>
Message-ID: <f255d5441b2665450231d953b7a3d1b1@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 2020-11-19 22:15, Suzuki K Poulose wrote:
> When the ETM is affected by Qualcomm errata, modifying the
> TRCPDCR could cause the system hang. Even though this is
> taken care of during enable/disable ETM, the ETM state
> save/restore could still access the TRCPDCR. Make sure
> we skip the access during the save/restore.
> 
> Found by code inspection.
> 

Thanks for the patch, I did test at the time if these accesses
in save and restore cause any hang and they do not. But
this patch doesn't leave anything to chances, so its good.

Reviewed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
