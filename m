Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F0430263D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 15:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbhAYOVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 09:21:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbhAYOOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:14:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 422612145D;
        Mon, 25 Jan 2021 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611584032;
        bh=aIUrp6lPa0cxDQK/ZAf5EpmucIVm0vBQmL73AHPDKPU=;
        h=From:To:Cc:Subject:Date:From;
        b=Eh2ujyYUqnzOJ4I/jJCXRqE+1JnBfD5VOoMqZcJxl442a2MK8hIbd3x8cwSsiUJQW
         nd84VcfOtpfwLHpZphnEL3KrwoFCxaoVtvif0Zf17hP05b3xqSUY5VpqzLrdLo+BM4
         a6290yP70K8ADVsGB3Jq+kO/TCbfoRMBrp02lMLfVA7zWVRm9/FjcI2ngK3XpMZT89
         rkVYW5Q7jp77ihrQsl5Ojn+421gn/6QkKVQuYaLTea4VyLYBtHE3OiAq/hEpsavL0i
         9Qeg2oXsRitFiKz2ZPEg5lRpux/gJQs2PevC2EjLlnFzbAgCv1W95zgxiioFtXDm3X
         G8HIytwRFZL2Q==
Received: by pali.im (Postfix)
        id EB23E768; Mon, 25 Jan 2021 15:13:49 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: arm: marvell: Fix dead link to Armada 37xx Product Brief
Date:   Mon, 25 Jan 2021 15:13:41 +0100
Message-Id: <20210125141341.32200-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/arm/marvell.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
index b16e6f7e8dbe..fa22a72d4391 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -183,7 +183,7 @@ EBU Armada family ARMv8
 	http://www.marvell.com/embedded-processors/armada-3700/
 
   Product Brief:
-	http://www.marvell.com/embedded-processors/assets/PB-88F3700-FNL.pdf
+	http://www.marvell.com/content/dam/marvell/en/public-collateral/embedded-processors/marvell-embedded-processors-armada-37xx-product-brief-2016-01.pdf
 
   Hardware Spec:
 	http://www.marvell.com/content/dam/marvell/en/public-collateral/embedded-processors/marvell-embedded-processors-armada-37xx-hardware-specifications-2019-09.pdf
-- 
2.20.1

