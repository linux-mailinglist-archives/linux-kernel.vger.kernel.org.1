Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694AB30369F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbhAZGev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:34:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbhAYORd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:17:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3CDC2145D;
        Mon, 25 Jan 2021 14:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611584135;
        bh=op5xHV1OhugM04UhmRRpoD5rSX9S94ZPnVmezEUehNk=;
        h=From:To:Cc:Subject:Date:From;
        b=Yrc/SaCgnKPdYJdPUOa0AdkIRA/584kvxde/CbqMAUrorztdFFSfnwpvC6biOrvTh
         /OtuGYn9cNjwsni2eCCU+lgzZi3lq8TJ7lHxTSVH7fxPxF/HIz7EmjVX3UcBp3QTqJ
         nYZ0d2YqtqNwKW2h4Oca9MhmNxVfJOQ2qymT6Q9rrl44UBXz5J0E7cN5vWl4UpTs+P
         t6ot1mzRdApu+YyNBSPPJx3OavA0AfUgBw7e+vAzCVyv1xT90MWihpUEOvxCQlsfTP
         nogUKPWw1S/ynfx0TcmPNyFoZ2Lhuo2I05XKRQfGXPdgI1jN/hf/Z7z2uFfIXEoYPf
         pRWfTIoQLyMRw==
Received: by pali.im (Postfix)
        id B791B768; Mon, 25 Jan 2021 15:15:32 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: arm: marvell: Update link to unrestricted Armada 38x Functional Spec
Date:   Mon, 25 Jan 2021 15:15:29 +0100
Message-Id: <20210125141529.32357-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Marvell website is documentation accessible without need to register or
fill any other forms.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/arm/marvell.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
index fa22a72d4391..94cd73383594 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -127,7 +127,7 @@ EBU Armada family
 	- 88F6828 Armada 388
 
     - Product infos:   http://www.marvell.com/embedded-processors/armada-38x/
-    - Functional Spec: https://marvellcorp.wufoo.com/forms/marvell-armada-38x-functional-specifications/
+    - Functional Spec: http://www.marvell.com/content/dam/marvell/en/public-collateral/embedded-processors/marvell-embedded-processors-armada-38x-functional-specifications-2015-11.pdf
 
   Core:
 	ARM Cortex-A9
-- 
2.20.1

