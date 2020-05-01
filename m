Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E711E1C2121
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 01:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgEAXLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 19:11:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:40199 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAXLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:11:49 -0400
IronPort-SDR: ke7o5OIusED3wg0/5PGE9hsagAcH34owg02GgdHqckjCwTUYVmZyE6CKmQU0OC4QNgP+zlfLVh
 AtIRGBkWsb0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 16:11:49 -0700
IronPort-SDR: k6mJuyJYC1mjBGkqooJ39DygftAnuIU4uOZqpE3rTX+DunwHnyA0W1+uYnBZlvfoouBsJYdtIi
 eYYH9aDeNG/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,341,1583222400"; 
   d="scan'208";a="303660658"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by FMSMGA003.fm.intel.com with ESMTP; 01 May 2020 16:11:48 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH] checkpatch: add NL_SET_ERR_MSG to 80 column exceptions
Date:   Fri,  1 May 2020 16:11:31 -0700
Message-Id: <20200501231131.2389319-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NL_SET_ERR_MSG and NL_SET_ERR_MSG_MOD are used to report extended error
responses about failure of a netlink command. These strings often end up
going over the 80-column limit. Just like logging messages, it is
preferred to leave the message all on a single line.

Add these to the exception list so that checkpatch.pl will no longer
complain about the long lines due to use of these macros.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index eac40f0abd56..5da3b06fbeaa 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -471,7 +471,8 @@ our $logFunctions = qr{(?x:
 	WARN(?:_RATELIMIT|_ONCE|)|
 	panic|
 	MODULE_[A-Z_]+|
-	seq_vprintf|seq_printf|seq_puts
+	seq_vprintf|seq_printf|seq_puts|
+	NL_SET_ERR_MSG(?:_MOD)?
 )};
 
 our $allocFunctions = qr{(?x:
-- 
2.25.2

