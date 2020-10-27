Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426AE29A8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896845AbgJ0KBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896021AbgJ0Jvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:43 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F3F22283;
        Tue, 27 Oct 2020 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792301;
        bh=aVDv8l9vGsqd3srVmIH++RlO1Kd6a8919l1iqcsJX14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MS3vkRAGZvX2RVqGtuMVaWSPlrnBfuowrbubw1J6dLKTJf0glDSnZv9kYvrzf0ofR
         M5+Iirvos67yKMJNzOOf8Zgsu7O+KFrluiOPzhnzKOKy88So80Oiy4dq6xgu4kV7RT
         KcFYEfZn/Pt5GYsVboOb0lxiYAIqBYVCNPfLwNLw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXLdj-003FEk-4v; Tue, 27 Oct 2020 10:51:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/32] docs: hwmon: mp2975.rst: address some html build warnings
Date:   Tue, 27 Oct 2020 10:51:11 +0100
Message-Id: <b02f98d886ab1f5af233f8999c7a15529fc52cdc.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    .../Documentation/hwmon/mp2975.rst:25: WARNING: Unexpected indentation.
    .../Documentation/hwmon/mp2975.rst:27: WARNING: Block quote ends without a blank line; unexpected unindent.
    .../Documentation/hwmon/mp2975.rst:69: WARNING: Unexpected indentation.
    .../Documentation/hwmon/mp2975.rst:70: WARNING: Block quote ends without a blank line; unexpected unindent.
    .../Documentation/hwmon/mp2975.rst:72: WARNING: Bullet list ends without a blank line; unexpected unindent.
    .../Documentation/hwmon/mp2975.rst: WARNING: document isn't included in any toctree

List blocks should have blank lines before and after them,
in order to be properly parsed.

Fixes: 4beb7a028e9f ("hwmon: (pmbus) Add support for MPS Multi-phase mp2975 controller")
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/hwmon/index.rst  |  1 +
 Documentation/hwmon/mp2975.rst | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index e6b91ab12978..b797db738225 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -132,6 +132,7 @@ Hardware Monitoring Kernel Drivers
    mcp3021
    menf21bmc
    mlxreg-fan
+   mp2975
    nct6683
    nct6775
    nct7802
diff --git a/Documentation/hwmon/mp2975.rst b/Documentation/hwmon/mp2975.rst
index 5b0609c62f48..81d816b71490 100644
--- a/Documentation/hwmon/mp2975.rst
+++ b/Documentation/hwmon/mp2975.rst
@@ -20,6 +20,7 @@ This driver implements support for Monolithic Power Systems, Inc. (MPS)
 vendor dual-loop, digital, multi-phase controller MP2975.
 
 This device:
+
 - Supports up to two power rail.
 - Provides 8 pulse-width modulations (PWMs), and can be configured up
   to 8-phase operation for rail 1 and up to 4-phase operation for rail
@@ -32,10 +33,12 @@ This device:
   10-mV DAC, IMVP9 mode with 5-mV DAC.
 
 Device supports:
+
 - SVID interface.
 - AVSBus interface.
 
 Device complaint with:
+
 - PMBus rev 1.3 interface.
 
 Device supports direct format for reading output current, output voltage,
@@ -45,11 +48,14 @@ Device supports VID and direct formats for reading output voltage.
 The below VID modes are supported: VR12, VR13, IMVP9.
 
 The driver provides the next attributes for the current:
+
 - for current in: input, maximum alarm;
 - for current out input, maximum alarm and highest values;
 - for phase current: input and label.
-attributes.
+  attributes.
+
 The driver exports the following attributes via the 'sysfs' files, where
+
 - 'n' is number of telemetry pages (from 1 to 2);
 - 'k' is number of configured phases (from 1 to 8);
 - indexes 1, 1*n for "iin";
@@ -65,11 +71,14 @@ The driver exports the following attributes via the 'sysfs' files, where
 **curr[1-{2n+k}]_label**
 
 The driver provides the next attributes for the voltage:
+
 - for voltage in: input, high critical threshold, high critical alarm, all only
   from page 0;
 - for voltage out: input, low and high critical thresholds, low and high
   critical alarms, from pages 0 and 1;
+
 The driver exports the following attributes via the 'sysfs' files, where
+
 - 'n' is number of telemetry pages (from 1 to 2);
 - indexes 1 for "iin";
 - indexes n+1, n+2 for "vout";
@@ -87,9 +96,12 @@ The driver exports the following attributes via the 'sysfs' files, where
 **in[2-{n+1}1_lcrit_alarm**
 
 The driver provides the next attributes for the power:
+
 - for power in alarm and input.
 - for power out: highest and input.
+
 The driver exports the following attributes via the 'sysfs' files, where
+
 - 'n' is number of telemetry pages (from 1 to 2);
 - indexes 1 for "pin";
 - indexes n+1, n+2 for "pout";
-- 
2.26.2

