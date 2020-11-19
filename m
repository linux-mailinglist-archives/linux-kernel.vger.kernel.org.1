Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A3C2B9726
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgKSPzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:55:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:65089 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbgKSPza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:55:30 -0500
IronPort-SDR: he0+Go827i2Nmdn64GwnUIXRDQrq97W0LnHw4+4m5UX1FAy2XmnEE29gJBWkVcmgsFan5DwINu
 JZjUTYSNp7jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="158342916"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="158342916"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:55:29 -0800
IronPort-SDR: SjRyIXEzIq57x6z7qYadRpAMIW2O4VKSv19lD7gjPWyuaDzA7A3A3IGWIMoX82aDZHnqgXZbTG
 U9/gD9ctzvMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="341725623"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2020 07:55:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E70C449A; Thu, 19 Nov 2020 17:55:23 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 05/12] thunderbolt: Return -ENOTCONN when ERR_CONN is received
Date:   Thu, 19 Nov 2020 18:55:16 +0300
Message-Id: <20201119155523.41332-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
References: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the calling code to distinguish if the error was due to
ERR_CONN (adapter is disconneced or disabled) or something else. Will be
needed in USB4 router NVM update in the following patch.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/ctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 1d86e27a0ef3..bac08b820015 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -962,6 +962,9 @@ static int tb_cfg_get_error(struct tb_ctl *ctl, enum tb_cfg_space space,
 
 	if (res->tb_error == TB_CFG_ERROR_LOCK)
 		return -EACCES;
+	else if (res->tb_error == TB_CFG_ERROR_PORT_NOT_CONNECTED)
+		return -ENOTCONN;
+
 	return -EIO;
 }
 
-- 
2.29.2

