Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6B52B972A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgKSPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:55:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:65086 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbgKSPz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:55:27 -0500
IronPort-SDR: /8TozwsBvNP998Gzjd87qd+zs+cF0gmqgCT+hOmznoFQmHdAPxVRWmjK+09Su5OimeGPHvyfFH
 oZlb6u5RGfMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="158342908"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="158342908"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:55:26 -0800
IronPort-SDR: bpX01BTcxnMEjeZ/NfLZ7nPfdrbENaJ2DhV4+GsYtiO28uaPMsGKgM30X79p3i956KnJ7KNKdu
 Rbo1vv1ANjJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="341725609"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2020 07:55:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C54EB3DB; Thu, 19 Nov 2020 17:55:23 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 02/12] thunderbolt: Log which connection manager implementation is used
Date:   Thu, 19 Nov 2020 18:55:13 +0300
Message-Id: <20201119155523.41332-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
References: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it easier to figure out whether the driver is using firmware
or software based connection manager implementation.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c | 2 ++
 drivers/thunderbolt/tb.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 03e86817afc7..beee6e6b8b6e 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -2302,5 +2302,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 		return NULL;
 	}
 
+	tb_dbg(tb, "using firmware connection manager\n");
+
 	return tb;
 }
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 214fbc92c1b7..51d5b031cada 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1534,5 +1534,7 @@ struct tb *tb_probe(struct tb_nhi *nhi)
 	INIT_LIST_HEAD(&tcm->dp_resources);
 	INIT_DELAYED_WORK(&tcm->remove_work, tb_remove_work);
 
+	tb_dbg(tb, "using software connection manager\n");
+
 	return tb;
 }
-- 
2.29.2

