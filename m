Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E6B254F41
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 21:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgH0Tts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 15:49:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15150 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbgH0Ttl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:49:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598557780; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=NaYKWRYtlz24wBCiVhLhyrMbm0vV1UjfOtA7OUUm/ko=; b=Vpqo6HPVOFodN4cOMubXTybuZxj4kCvqjgHJaSwgzgqoDRW2M5EeY8PPbdRhv8jldbDtDMnu
 eaWTz01yooE1OFqGlDRgu42nHYlomASp2JPplyhYboxsJ8x4j+aGnskq/ssSXOE7tRs1Nvcz
 UArTeNRCkE/ZsdXz7bch52zG1qg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f480e43d6f74c6f9cb2da68 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 19:49:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E1ACEC43395; Thu, 27 Aug 2020 19:49:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 31103C433CA;
        Thu, 27 Aug 2020 19:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31103C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v2 1/3] remoteproc: Expose remoteproc configuration through sysfs
Date:   Thu, 27 Aug 2020 12:48:49 -0700
Message-Id: <1598557731-1566-2-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
References: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a feature flag to expose some of the remoteproc configuration
through sysfs. This feature is helpful in systems where debugfs is
not available/mounted. Currently the recovery and coredump
configuration is exposed through sysfs rather than debugfs when
this feature is selected.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index c6659dfe..8aecf70 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -275,6 +275,18 @@ config TI_K3_DSP_REMOTEPROC
 	  It's safe to say N here if you're not interested in utilizing
 	  the DSP slave processors.
 
+config RPROC_SYSFS_CONFIGURATION_SUPPORT
+	bool "Expose remoteproc configuration sysfs entries"
+	default n
+	help
+	  Say y here to expose recovery and coredump configuration sysfs
+	  entries. This will remove the corresponding entries from debugfs
+	  and expose it through sysfs. This is helpful in operating systems
+	  where debugfs is not available.
+
+	  It's safe to say N here if you are not interested in accessing
+	  recovery and coredump configuration through sysfs.
+
 endif # REMOTEPROC
 
 endmenu
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

