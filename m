Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238282B9721
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgKSPz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:55:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:65086 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbgKSPz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:55:27 -0500
IronPort-SDR: axWZiOEQf/tE43TwkiEkO4kszBxOFQmV8EVVfJ07bist2Bk0ZCgoyuau48/zzMff4z/crZc+LK
 gSHqsrhWadpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="158342910"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="158342910"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:55:26 -0800
IronPort-SDR: Q82mFm7xUdRgbcDem1dwzfbC2ieic47Ru3liZRIDLhOFtm1A+QQ5HZTu59QJ/6L72L1NFJOzaZ
 JO46YtJeCHfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="341725611"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2020 07:55:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B6AF014A; Thu, 19 Nov 2020 17:55:23 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 01/12] thunderbolt: Move max_boot_acl field to correct place in struct icm
Date:   Thu, 19 Nov 2020 18:55:12 +0300
Message-Id: <20201119155523.41332-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
References: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the kernel-doc to match the ordering and also this is better
place for it, not between upstream_port and vnd_cap that are used
together.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index b51fc3f62b1f..03e86817afc7 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -79,9 +79,9 @@ struct icm {
 	struct mutex request_lock;
 	struct delayed_work rescan_work;
 	struct pci_dev *upstream_port;
-	size_t max_boot_acl;
 	int vnd_cap;
 	bool safe_mode;
+	size_t max_boot_acl;
 	bool rpm;
 	bool can_upgrade_nvm;
 	bool veto;
-- 
2.29.2

