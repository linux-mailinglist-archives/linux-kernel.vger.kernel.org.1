Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A991DDD6E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 04:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgEVCvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 22:51:41 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:10900 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728142AbgEVCvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:51:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590115898; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=NYcDgZyyahLLE5f9Z+PU8f3BZ+2lpwR0G4U8MadhPdY=; b=XUXZQA/osFnGtsTTwFBzr0USxQgnqzPGkJB2s17pvYQO0ek4wl6RIVKcPL+yas6GmyoymZE0
 4q6kmPwYqBleLij6loKA4jiafQBlo8RMu1FI2EcgmxhQd54qC3f+doOzRlEwgfqRvBq7+6DP
 vKTqLxkopnQK0bGSVscdzSwsK9g=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ec73e3982c96b5d3b12526b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 02:51:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1CDBFC433A0; Fri, 22 May 2020 02:51:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3FF93C43387;
        Fri, 22 May 2020 02:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FF93C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=hemantk@codeaurora.org
From:   Hemant Kumar <hemantk@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org,
        Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v2 0/3] user space client interface driver
Date:   Thu, 21 May 2020 19:51:27 -0700
Message-Id: <1590115890-12278-1-git-send-email-hemantk@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2: Added mutex lock to prevent multiple readers to access same
mhi buffer which can result into use after free.

Hemant Kumar (3):
  bus: mhi: core: Add helper API to return number of free TREs
  bus: mhi: core: Move MHI_MAX_MTU to external header file
  bus: mhi: clients: Add user space client interface driver

 drivers/bus/mhi/Kconfig          |   2 +
 drivers/bus/mhi/Makefile         |   1 +
 drivers/bus/mhi/clients/Kconfig  |  16 +
 drivers/bus/mhi/clients/Makefile |   3 +
 drivers/bus/mhi/clients/uci.c    | 652 +++++++++++++++++++++++++++++++++++++++
 drivers/bus/mhi/core/main.c      |  12 +
 include/linux/mhi.h              |  12 +
 7 files changed, 698 insertions(+)
 create mode 100644 drivers/bus/mhi/clients/Kconfig
 create mode 100644 drivers/bus/mhi/clients/Makefile
 create mode 100644 drivers/bus/mhi/clients/uci.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

