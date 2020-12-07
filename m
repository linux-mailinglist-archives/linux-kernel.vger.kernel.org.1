Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72ACB2D1B94
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgLGVBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:01:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:59824 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgLGVBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:01:22 -0500
IronPort-SDR: E2OydwAfb5DkA76vyYJyhFqTtqhVWEEWyUk67VvbjAODlEcrW7zn9Rseg5w70n4wzy0HbSQ4xI
 /QRy/vPpsqWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="237880400"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="237880400"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 13:00:40 -0800
IronPort-SDR: F3bzpdIxvMvLyAAEUqHSDTH19i25/wicm7KFY2x+jLJ4+bklGhRLvwf2cUqo6AJKpURL0jGlqm
 EPU+OUsoxKqA==
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="363307816"
Received: from sutgikar-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.135.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 13:00:39 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH] kernel-doc: Fix example in Nested structs/unions
Date:   Mon,  7 Dec 2020 13:00:27 -0800
Message-Id: <20201207210027.1049346-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing ';' as well as fixes the indent for the first struct.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/doc-guide/kernel-doc.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 52a87ab4c99f..79aaa55d6bcf 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -247,12 +247,12 @@ It is possible to document nested structs and unions, like::
           struct {
             int memb1;
             int memb2;
-        }
+          };
           struct {
             void *memb3;
             int memb4;
-          }
-        }
+          };
+        };
         union {
           struct {
             int memb1;
-- 
2.29.2

