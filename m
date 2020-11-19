Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E4E2B972C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgKSP4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:56:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:43268 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbgKSPz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:55:27 -0500
IronPort-SDR: fAxVucEnb0rxvfjSw4j+SCk94xoKDgjZu9LPori9IT9l4fF/jVYkQF32Le7xSzNHN6BxxzsHEr
 slIO5cc9vThQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159081195"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="159081195"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:55:26 -0800
IronPort-SDR: 8E+/vsuHt7lrtM21IIIwMgaj/7zNv/vTtDL2MOB8Igz+uwbpOHQuocgLqcHUKrNlx+eHUq8jEI
 Vgj3BpM/733w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,353,1599548400"; 
   d="scan'208";a="431281581"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 07:55:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D015A3F3; Thu, 19 Nov 2020 17:55:23 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 03/12] thunderbolt: Log adapter numbers in decimal in path activation/deactivation
Date:   Thu, 19 Nov 2020 18:55:14 +0300
Message-Id: <20201119155523.41332-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
References: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it consistent with other debug logs that already are using
decimal number for adapters (ports).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/path.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index 7c2c45d9ba4a..ca7d738d66de 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -454,7 +454,7 @@ void tb_path_deactivate(struct tb_path *path)
 		return;
 	}
 	tb_dbg(path->tb,
-	       "deactivating %s path from %llx:%x to %llx:%x\n",
+	       "deactivating %s path from %llx:%u to %llx:%u\n",
 	       path->name, tb_route(path->hops[0].in_port->sw),
 	       path->hops[0].in_port->port,
 	       tb_route(path->hops[path->path_length - 1].out_port->sw),
@@ -482,7 +482,7 @@ int tb_path_activate(struct tb_path *path)
 	}
 
 	tb_dbg(path->tb,
-	       "activating %s path from %llx:%x to %llx:%x\n",
+	       "activating %s path from %llx:%u to %llx:%u\n",
 	       path->name, tb_route(path->hops[0].in_port->sw),
 	       path->hops[0].in_port->port,
 	       tb_route(path->hops[path->path_length - 1].out_port->sw),
-- 
2.29.2

