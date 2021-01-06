Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE33E2EB79B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbhAFB3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:29:47 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:40719 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbhAFB3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:29:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609896566; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=4p4DqJ5urwWJifyBoVvu5TpdqgDgH0bV0rmDfagihD0=; b=TQ/a51do0MsIUXOwfUgYnfD3OlbddBSc4asCVexMXpduobPG+yagguev/oeI3OslblRhw2Zp
 qDrsGkJk3Y7xxF4HQ5MX8Pb41MLVDobGnYZ6njBEsbZECVtPV67Ih0pMEYXwZSfzuXgJDdWQ
 PHYgdWGptv4NgXaIPgXTV+8lr/E=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5ff51258d3eb3c36b4d97031 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 06 Jan 2021 01:28:56
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1C8DC433ED; Wed,  6 Jan 2021 01:28:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30F7FC433CA;
        Wed,  6 Jan 2021 01:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30F7FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Subject: [PATCH 0/1] arm64: make section size configurable for memory hotplug
Date:   Tue,  5 Jan 2021 17:28:45 -0800
Message-Id: <cover.1609895500.git.sudaraja@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The section size defines the granularity of memory hotplug. This is currently
hard coded to 1GB on arm64 linux, which defines that the least size of memblock
that can be hotplugged out is 1GB. Some DDR configurations (especially low RAM
and dual-rank DDRs) may have section sizes that are less than 1GB (ex. 512MB, 256MB etc.).
Having an option to reduce the memblock size to section size or lower gives more
granularity of memory hotplug. For example, a system with DDR section size of 512MB
and kernel memblock size of 1GB, we would have to remove two segments of DDR sections
in order to hotplug out atleast 1 memblock from kernel POV. 

Section sizes of DDRs vary based on specs (number of ranks, channels, regions etc.)
Making this section size configurable helps users to assign based on the DDR being used.
The default is set to 1GB which is the current memblock size.

Sudarshan Rajagopalan (1):
  arm64: Make section size configurable for memory hotplug

 arch/arm64/Kconfig                 | 11 +++++++++++
 arch/arm64/include/asm/sparsemem.h |  4 ++++
 2 files changed, 15 insertions(+)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

