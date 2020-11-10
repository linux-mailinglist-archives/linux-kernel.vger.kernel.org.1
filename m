Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549F92AD034
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgKJHDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:03:03 -0500
Received: from z5.mailgun.us ([104.130.96.5]:39301 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgKJHDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:03:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604991782; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=m04j0QpJO9qcRWC3HxEWNEPuhJSjvuC1ax5Nw9puc4I=;
 b=fkruV/Xbps3aAoB7mhjZM8Bzc9jIj/yPGpHd1aBZeEPhAXsr3SBJ/Bw6HMWRWTxXuHBy4GKC
 jx0pGnVEb6jbpNsTtQcJVs9BiNexMmpfK2VtcjcOSzm6vUVlNYS3a6KjTvsz+Dg7Gck0qDVE
 WxK8Ohh+nykMz2ukpUnLi+A5pyA=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5faa3a7ef8c560b580952186 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Nov 2020 07:00:14
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0C04FC433FE; Tue, 10 Nov 2020 07:00:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8AD4C433C9;
        Tue, 10 Nov 2020 07:00:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Nov 2020 12:30:11 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add KRYO2XX Errata / mitigations data
In-Reply-To: <20201105093349.GA7902@willie-the-truck>
References: <20201104232218.198800-1-konrad.dybcio@somainline.org>
 <20201105093349.GA7902@willie-the-truck>
Message-ID: <f21f5a133f129c7f49ab780e3ef60325@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-05 15:03, Will Deacon wrote:
> Hi Konrad,
> 
> [+Jeffrey]
> 
> On Thu, Nov 05, 2020 at 12:22:09AM +0100, Konrad Dybcio wrote:
>> This series adds Spectre mitigations and errata data for
>> Qualcomm KRYO2XX Gold (big) and Silver (LITTLE) series of
>> CPU cores, used for example in MSM8998 and SDM660-series SoCs.
>> 
>> Konrad Dybcio (4):
>>   arm64: Add MIDR value for KRYO2XX gold/silver CPU cores
>>   arm64: kpti: Add KRYO2XX gold/silver CPU cores to kpti safelist
>>   arm64: proton-pack: Add KRYO2XX silver CPUs to spectre-v2 safe-list
>>   arm64: cpu_errata: Apply Erratum 845719 to KRYO2XX Silver
> 
> This mostly looks fine to me, but I've added Jeffrey to check the MIDRs
> because he's my go-to person for the Qualcomm numbering scheme.
> 
> Jeffrey -- please can you check these patches [1], especially the last 
> patch
> which has some cryptic revision number in there too?

Jeffrey can confirm this, but the MIDR is right and the cryptic revision
maps to cortex r0p4.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
