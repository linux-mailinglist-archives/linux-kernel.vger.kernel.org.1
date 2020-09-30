Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8AC27F1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgI3Syu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:54:50 -0400
Received: from ale.deltatee.com ([204.191.154.188]:37560 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbgI3Syf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Nm9S1mrD71DL+fV1grCBmg3CM4YNMP/hpGKwYK5ic38=; b=Zhgon41vYRIv7JpaosEyZWpwXU
        BxzPjIpzu+p6hL/FhVvwErAuGEFVQ2yKh/fKXWYSbrBaKGtESDDsK3cPwl9gop8X4E7jllxDUGZnj
        o+qaPxRA/A3e3ZMgC4Sf2lu7Np3ZDrTFCdR8hD8CcaJwsLD6VymloW6cuEg9b68pWvzPnI+Ibopnh
        6Xq/jfPezMMcxPBQ2Tg+bIN+GuwriJSdkIu2f5b7ORnCZRSlVtM8qile23pev+sItcjhK3NFKNtgf
        G1o4uZ0E7AG8HWWqJHNtXU2oXF35wVDCILeHqBrDLU+r5R9xCRkaX9SYe+RKRF+/PrLmog6RsdhGy
        kO5SHbhA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kNhFI-0000uw-B8; Wed, 30 Sep 2020 12:54:32 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kNhFE-00030j-7g; Wed, 30 Sep 2020 12:54:28 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 30 Sep 2020 12:54:20 -0600
Message-Id: <20200930185422.11494-10-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930185422.11494-1-logang@deltatee.com>
References: <20200930185422.11494-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH blktests v2 09/11] nvme/036: Add test for testing reset command on nvme-passthru
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to test 022 but for passthru controllers.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/036     | 37 +++++++++++++++++++++++++++++++++++++
 tests/nvme/036.out |  3 +++
 2 files changed, 40 insertions(+)
 create mode 100755 tests/nvme/036
 create mode 100644 tests/nvme/036.out

diff --git a/tests/nvme/036 b/tests/nvme/036
new file mode 100755
index 000000000000..8218c6538dfd
--- /dev/null
+++ b/tests/nvme/036
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+# Copyright (C) 2019 Eideticom Communications Inc.
+
+. tests/nvme/rc
+
+DESCRIPTION="test NVMe reset command on an NVMeOF target with a passthru controller"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_kernel_option NVME_TARGET_PASSTHRU
+}
+
+test_device() {
+	local subsys="blktests-subsystem-1"
+	local ctrldev
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+	port=$(_nvmet_passthru_target_setup "${subsys}")
+	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
+
+	ctrldev=$(_find_nvme_dev "${subsys}")
+
+	if ! nvme reset "/dev/${ctrldev}" >> "$FULL" 2>&1; then
+		echo "ERROR: reset failed"
+	fi
+
+	_nvme_disconnect_subsys "${subsys}"
+	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/036.out b/tests/nvme/036.out
new file mode 100644
index 000000000000..d294f8646b20
--- /dev/null
+++ b/tests/nvme/036.out
@@ -0,0 +1,3 @@
+Running nvme/036
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.20.1

