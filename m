Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B667626CA67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgIPT6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:58:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15054 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgIPT4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:56:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600286184; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/LCfAr6BAH7IdfVVVvfVBFWx6xFSZL9n6uUjXHmeWM8=; b=m6CocVWT62nxRWEHtkxZd5+Fzhy9kJxhQZ220iz6mgyXy2VNvv742YfUFO7ZB78IEJCs+4WB
 n6pBNxcUwigrL2Cih62tE7aescUn0e4LEr0Inf1aHsWDIQxvKZEt7lh3pEaMgN7LbU5SzePy
 jBGCLNk/GuFQYvRn+CqpDEGTfwo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f626ddf6b1937bb657535f7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 19:56:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C91F8C433FE; Wed, 16 Sep 2020 19:56:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE63FC433CA;
        Wed, 16 Sep 2020 19:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE63FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hemantk@codeaurora.org
From:   Hemant Kumar <hemantk@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org,
        Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v6 0/4] user space client interface driver
Date:   Wed, 16 Sep 2020 12:56:03 -0700
Message-Id: <1600286167-4432-1-git-send-email-hemantk@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V6:
- Moved uci.c to mhi directory.
- Updated Kconfig to add module information.
- Updated Makefile to rename uci object file name as mhi_uci
- Removed kref for open count

V5:
- Removed mhi_uci_drv structure.
- Used idr instead of creating global list of uci devices.
- Used kref instead of local ref counting for uci device and
  open count.
- Removed unlikely macro.

V4:
- Fix locking to protect proper struct members.
- Updated documentation describing uci client driver use cases.
- Fixed uci ref counting in mhi_uci_open for error case.
- Addressed style related review comments.

V3: Added documentation for MHI UCI driver.

V2: Added mutex lock to prevent multiple readers to access same
mhi buffer which can result into use after free.

Hemant Kumar (4):
  bus: mhi: core: Add helper API to return number of free TREs
  bus: mhi: core: Move MHI_MAX_MTU to external header file
  docs: Add documentation for userspace client interface
  bus: mhi: Add userspace client interface driver

 Documentation/mhi/index.rst     |   1 +
 Documentation/mhi/uci.rst       |  39 +++
 drivers/bus/mhi/Kconfig         |  13 +
 drivers/bus/mhi/Makefile        |   4 +
 drivers/bus/mhi/core/internal.h |   1 -
 drivers/bus/mhi/core/main.c     |  12 +
 drivers/bus/mhi/uci.c           | 657 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mhi.h             |  12 +
 8 files changed, 738 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/mhi/uci.rst
 create mode 100644 drivers/bus/mhi/uci.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

