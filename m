Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74058254F52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 21:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgH0TuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 15:50:17 -0400
Received: from ale.deltatee.com ([204.191.154.188]:54882 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgH0TtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c143+GTEX7zyD/AulBS9Iu+zOY5FLCUer2NvCoDsSeI=; b=SZObRZlrY2eN4y+pUAiPO1SXTU
        Dx3AaFVhqM903maM+RjjDXpaIqCMPF3u5XQlnL/09MGb/3WX9T/+e1QSuCBrVPoqBs+fa/4XYuEyW
        XMYP9Fm+1qF0z/XghXrUWNBIgo7OoOMqMfqP5dl63s56/KolW/bpFAunH8z/kUpreKD4EHWe0RqLh
        YTyWPvT2decsz5mxb+OhypgpiLv3CSQ1aCf6IvndkisC5tykzNwwAkYxOmybsLseeXi6DsB4LYSig
        EQK4oPVWLztSi6JWwHXJVDUKge+ZcN6H4+WbdUxhECCME7mRmu8Ix/9ZeGxMtfq7R5J9ov9EdC8te
        ou0ktxeQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNtg-0000Cf-J2; Thu, 27 Aug 2020 13:49:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNta-0001c8-92; Thu, 27 Aug 2020 13:49:14 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 27 Aug 2020 13:49:07 -0600
Message-Id: <20200827194912.6135-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827194912.6135-1-logang@deltatee.com>
References: <20200827194912.6135-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH blktests 06/11] nvme/033: Simple test to create and connect to a passthru target
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This tests creates and connects to a passthru controller backed
by a test NVMe namespace. It then verifies that some common fields
in id-ctrl and id-ns are the same in the target and the orginial
device.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/033     | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  6 ++++
 2 files changed, 75 insertions(+)
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out

diff --git a/tests/nvme/033 b/tests/nvme/033
new file mode 100755
index 000000000000..e45c5e9758ba
--- /dev/null
+++ b/tests/nvme/033
@@ -0,0 +1,69 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+# Copyright (C) 2019 Eideticom Communications Inc.
+
+. tests/nvme/rc
+
+DESCRIPTION="create and connect to an NVMeOF target with a passthru controller"
+QUICK=1
+
+requires() {
+	_have_program nvme &&
+	_have_modules nvme-loop nvmet &&
+	_have_configfs &&
+	_have_kernel_option NVME_TARGET_PASSTHRU
+}
+
+nvme_info() {
+	local ns=$1
+
+	nvme id-ctrl "$ns" | grep -E '^(vid|sn|mn|fr) '
+	nvme id-ns "$ns" | grep -E '^(nsze|ncap) '
+}
+
+compare_dev_info() {
+	local passthru_dev=$1
+	local testdev_info
+	local passthru_info
+
+	testdev_info=$(nvme_info "$TEST_DEV")
+	passthru_info=$(nvme_info "$passthru_dev")
+
+	cat >> "${FULL}" <<- EOF
+
+	Test Device ${TEST_DEV} Info:
+	$testdev_info
+
+	Passthru Device ${passthru_dev} Info:
+	$passthru_info
+
+	EOF
+
+	diff -u <(echo "$testdev_info") <(echo "$passthru_info")
+	if [[ "$testdev_info" != "$passthru_info" ]]; then
+		echo "ERROR: Device information does not match! (See ${FULL})"
+	fi
+}
+
+test_device() {
+	local subsys="blktests-subsystem-1"
+	local nsdev
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+	port=$(_nvmet_passthru_target_setup "$subsys")
+
+	nvme discover -t loop | _filter_discovery
+
+	nsdev=$(_nvmet_passthru_target_connect "$subsys")
+
+	compare_dev_info "${nsdev}"
+
+	_nvmet_passthru_target_disconnect "$subsys"
+	_nvmet_passthru_target_cleanup "$port" "$subsys"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/033.out b/tests/nvme/033.out
new file mode 100644
index 000000000000..88787848654f
--- /dev/null
+++ b/tests/nvme/033.out
@@ -0,0 +1,6 @@
+Running nvme/033
+Discovery Log Number of Records 1, Generation counter X
+=====Discovery Log Entry 0======
+trtype:  loop
+subnqn:  blktests-subsystem-1
+Test complete
-- 
2.20.1

