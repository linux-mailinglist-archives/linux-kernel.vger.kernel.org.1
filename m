Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C31B2C3964
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 07:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgKYG6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 01:58:34 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:11559 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgKYG6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:58:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606287514; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=LrICIdDLfpZKH7ljsAEC0wOYB0ntNG1+5ilRwexAuoU=;
 b=YgQ8bQz7+khyQbS0+LahEtuMsgrElUQeL3RW57h9SWd3ScqNgFHNEqVhyxtTBHSa5yZsXmsd
 9BA+Ry7/t8DtCUqK8SxIjJXlGKTq5YU7LQPaE2sduCoHWIwUvnrLajy89btyrMkwUn2eUevC
 9XIMhohhz5WLhuT2wwUBRZSgATg=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fbe008c22377520eeda0295 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Nov 2020 06:58:20
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E679AC43468; Wed, 25 Nov 2020 06:58:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03716C433C6;
        Wed, 25 Nov 2020 06:58:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Nov 2020 12:28:18 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno@lists.freedesktop.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCHv9 2/8] iommu/arm-smmu: Add domain attribute for pagetable
 configuration
In-Reply-To: <20201124214134.GB14252@willie-the-truck>
References: <cover.1606150259.git.saiprakash.ranjan@codeaurora.org>
 <122e7b3050c51ee2e3637fca0b3967b4c3dc2bac.1606150259.git.saiprakash.ranjan@codeaurora.org>
 <20201124214134.GB14252@willie-the-truck>
Message-ID: <b56ec844e2c059d0c6d8de3424a0cce7@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-25 03:11, Will Deacon wrote:
> On Mon, Nov 23, 2020 at 10:35:55PM +0530, Sai Prakash Ranjan wrote:
>> Add iommu domain attribute for pagetable configuration which
>> initially will be used to set quirks like for system cache aka
>> last level cache to be used by client drivers like GPU to set
>> right attributes for caching the hardware pagetables into the
>> system cache and later can be extended to include other page
>> table configuration data.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 20 ++++++++++++++++++++
>>  drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
>>  include/linux/io-pgtable.h            |  4 ++++
>>  include/linux/iommu.h                 |  1 +
>>  4 files changed, 26 insertions(+)
> 
> Given that we're heading for a v10 to address my comments on patch 3,
> then I guess you may as well split this into two patches so that I can
> share just the atttibute with Rob rather than the driver parts.
> 
> Please keep it all as one series though, with the common parts at the
> beginning, and I'll figure it out.
> 

Ok I will split up and send v10.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
