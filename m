Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1279E2ACF4B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 06:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgKJF4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 00:56:15 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:36662 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgKJF4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 00:56:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604987774; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=FKAuo/Zq2exToLBX9+VpGGEXEAgv5nXZIwk88hvnnlI=;
 b=r/Vf30xnu7k1oEmxatrYkrvLlLv/w63kCnyYIZ8aKNl8Afw24SlP4aiAn50YnKycNtKXkXN0
 a8zJAnQKSNexo2X/3NsKpbCl6IrazSKeyFqSD9kQ8ucw5vaQHDRBw1SNED75yIx3RUytkj1A
 F7NU2wlwyq7Bpz2up3X9SikoZVk=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5faa2b7460d947565289b04a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Nov 2020 05:56:04
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 358E4C433C9; Tue, 10 Nov 2020 05:56:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84F08C433C6;
        Tue, 10 Nov 2020 05:56:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Nov 2020 11:26:02 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Marc Zyngier <maz@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: cpu_errata: Apply Erratum 845719 to KRYO2XX
 Silver
In-Reply-To: <0b09111d-f5cc-226b-bbc5-0277d6b597cd@somainline.org>
References: <20201104232218.198800-1-konrad.dybcio@somainline.org>
 <20201104232218.198800-5-konrad.dybcio@somainline.org>
 <3faa81d537320dfb20bb3f882cfaea1b@kernel.org>
 <8771f66911522ab87fe1b9b16e4e9921@codeaurora.org>
 <0b09111d-f5cc-226b-bbc5-0277d6b597cd@somainline.org>
Message-ID: <17837d78a921161dd73a92ec28437763@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-11-10 00:58, Konrad Dybcio wrote:
>> From what I see from the docs, this is the only version used
>> in MSM8998(silver cores are based on Cortex A53) and it maps
>> to r0p4. @Konrad, can you include (rap4 => r0p4) in comment.
> 
> 
> Hi,
> 
> Thanks for looking into it. Could you perhaps check if it's also the
> case on sdm630/636/660?
> 

Yes I checked with CPU team now and its the same.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
