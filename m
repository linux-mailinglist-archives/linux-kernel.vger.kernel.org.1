Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05C61C35AF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 11:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgEDJ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 05:29:16 -0400
Received: from foss.arm.com ([217.140.110.172]:40536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgEDJ3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:29:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DBFB1045;
        Mon,  4 May 2020 02:29:14 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2C0E3F305;
        Mon,  4 May 2020 02:29:12 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com
Subject: [PATCH v2 1/5] arm/arm64: smccc: Update link to latest SMCCC specification
Date:   Mon,  4 May 2020 10:29:01 +0100
Message-Id: <20200504092905.10580-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504092905.10580-1-sudeep.holla@arm.com>
References: <20200504092905.10580-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current link gets redirected to the revision B published in November
2016 though it actually points to the original revision A published in
June 2013.

Let us update the link to point to the latest version, so that it
doesn't get stale anytime soon. Currently it points to v1.2 published in
March 2020.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/arm-smccc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 59494df0f55b..6c1d1eda3be4 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -10,7 +10,7 @@
 /*
  * This file provides common defines for ARM SMC Calling Convention as
  * specified in
- * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
+ * https://developer.arm.com/docs/den0028/latest
  */
 
 #define ARM_SMCCC_STD_CALL	        _AC(0,U)
-- 
2.17.1

