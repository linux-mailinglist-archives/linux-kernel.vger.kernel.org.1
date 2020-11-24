Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409AE2C1A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgKXAmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:42:10 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:22415 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgKXAmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:42:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606178528; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=6gnbiJ4/cY/mVOvvFefpXEYCd0E9z+NaZwEV11kPH+Y=; b=LLNt8YEquOJOvVbrCZvpEm6ZxQLWu+/EEFxrn2vtHLSP6lESUOGLXvEUCiJhF9wYxWCP+BiP
 43UDdyYAAmaIAJkjFKVlJOfww/ySExMtGESXlHaJ6aDwTZ15j2bRXvy3ONrR1SDkFPDaOBfo
 x7nG3yA1m8Z8jt8HxtUKAXjS9BI=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fbc56dde9b708862243b4db (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 00:42:05
 GMT
Sender: tingweiz=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 145EAC43460; Tue, 24 Nov 2020 00:42:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D635C433C6;
        Tue, 24 Nov 2020 00:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D635C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Tue, 24 Nov 2020 08:41:55 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     anshuman.khandual@arm.com, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathan.zhouwen@huawei.com, mike.leach@linaro.org
Subject: Re: [PATCH v4 20/25] coresight: etm4x: Detect system instructions
 support
Message-ID: <20201124004155.GA10220@codeaurora.org>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-21-suzuki.poulose@arm.com>
 <20201123075827.GA18352@codeaurora.org>
 <1c8d4b13-0c80-0bd3-29a6-dd586841377f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c8d4b13-0c80-0bd3-29a6-dd586841377f@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 05:39:43PM +0800, Suzuki K Poulose wrote:
> On 11/23/20 7:58 AM, Tingwei Zhang wrote:
> >Hi Suzuki,
> >
> >On Fri, Nov 20, 2020 at 12:45:42AM +0800, Suzuki K Poulose wrote:
> >>ETM v4.4 onwards adds support for system instruction access
> >>to the ETM. Detect the support on an ETM and switch to using the
> >>mode when available.
> >>
> >>Cc: Mike Leach <mike.leach@linaro.org>
> >>Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>---
> >>  .../coresight/coresight-etm4x-core.c          | 39 +++++++++++++++++++
> >>  1 file changed, 39 insertions(+)
> >>
> >>diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >>b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >>index 7ac0a185c146..5cbea9c27f58 100644
> >>--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >>+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >>@@ -684,6 +684,37 @@ static const struct coresight_ops etm4_cs_ops = {
> >>  	.source_ops	= &etm4_source_ops,
> >>  };
> >>
> >>+static inline bool cpu_supports_sysreg_trace(void)
> >>+{
> >>+	u64 dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> >>+
> >>+	return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) > 0;
> >>+}
> >>+
> >>+static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
> >>+				    struct csdev_access *csa)
> >>+{
> >>+	u32 devarch;
> >>+
> >>+	if (!cpu_supports_sysreg_trace())
> >>+		return false;
> >>+
> >>+	/*
> >>+	 * ETMs implementing sysreg access must implement TRCDEVARCH.
> >>+	 */
> >>+	devarch = read_etm4x_sysreg_const_offset(TRCDEVARCH);
> >>+	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH)
> >
> >Is this driver suppose to work on ETM 5.0/ETE trace unit before ETE driver
> >is ready?
> 
> No, it is not supposed to work on an ETE without the ETE support. That check
> ensures that we only detect ETMv4x for now. The ETE driver support adds the
> ETE_ARCH as one of the supported ETMs. If you hack around it might still
> probe,
> but things could go terribly wrong if we access registers that are not
> available
> on ETE.
> 
> Btw, are you able to test this series on an ETMv4.4+ system ?
> 
I'm trying to test this series on an ETE. Look like it's not correct.
I'll apply ETE patch on top of this and test.

> Kind regards
> Suzuki
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight
