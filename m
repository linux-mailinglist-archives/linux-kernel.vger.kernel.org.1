Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF221F6D45
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 20:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgFKSOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 14:14:09 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:25117 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727010AbgFKSOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:14:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591899247; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=bXMXa2q0kBPywAqymgm7CebcLLhjCuyUceLkBJWseiA=; b=aSrQVU2omO5CSA72+bgiXnI1QP3QItW1nPFwc2Tk5kMU74dQfVpEcA0yJqwd+FgUgg9ob/hZ
 7jWOWOuIHy172LNaAFBKl+sapAQRZdGBO55oxeZD+gsOJLO8ZWnYQexQ+ZFhJJF38aBYKG4O
 W092HCHmroERVNAYJ4w/fVEphl4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ee2745f6bebe35debd5479f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Jun 2020 18:13:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4FDCEC433CB; Thu, 11 Jun 2020 18:13:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D8D8C43387;
        Thu, 11 Jun 2020 18:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D8D8C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=hemantk@codeaurora.org
From:   Hemant Kumar <hemantk@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org,
        Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v3 3/4] docs: Add documentation for user space client interface
Date:   Thu, 11 Jun 2020 11:13:43 -0700
Message-Id: <1591899224-3403-4-git-send-email-hemantk@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591899224-3403-1-git-send-email-hemantk@codeaurora.org>
References: <1591899224-3403-1-git-send-email-hemantk@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MHI user space client driver is creating device file node
for user application to perform file operations. File
operations are handled by MHI core driver. Currently
Loopback MHI channel is supported by this driver.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
---
 Documentation/mhi/index.rst |  1 +
 Documentation/mhi/uci.rst   | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/mhi/uci.rst

diff --git a/Documentation/mhi/index.rst b/Documentation/mhi/index.rst
index 1d8dec3..c75a371 100644
--- a/Documentation/mhi/index.rst
+++ b/Documentation/mhi/index.rst
@@ -9,6 +9,7 @@ MHI
 
    mhi
    topology
+   uci
 
 .. only::  subproject and html
 
diff --git a/Documentation/mhi/uci.rst b/Documentation/mhi/uci.rst
new file mode 100644
index 0000000..a5c5c4f
--- /dev/null
+++ b/Documentation/mhi/uci.rst
@@ -0,0 +1,19 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+User space Client Interface (UCI)
+=================================
+
+UCI driver enables user space clients to communicate to external MHI devices
+like modem and WLAN. It creates standard character device file nodes for user
+space clients to perform open, read, write, pool and close file operations.
+
+Device file node is created with format:-
+
+/dev/mhi_<controller_name>_<mhi_device_name>
+
+controller_name is the name of underlying bus used to transfer data.
+mhi_device_name is the name of the MHI channel being used by MHI client
+to send or receive data using MHI protocol. MHI channels are statically
+defined by MHI specification. Driver currently supports LOOPBACK channel
+index 0 (Host to device) and 1 (Device to Host).
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

