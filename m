Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FB42345DC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbgGaMbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 08:31:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:61662 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733237AbgGaMbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:31:48 -0400
IronPort-SDR: Rb/jGkqaO8tZsGlCWau+OUVlB1a7K+dh/yoJ0L57CNGlC0cYPlk8YLJNKHqk0pZssfuqMMshk5
 AreWHixNFH+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="169877830"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="169877830"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 05:31:48 -0700
IronPort-SDR: yet9q7DIBj6i3Q2MlG2b1DtVHR+6QpAG9j7n28zcF6yzf8rjuVdxR6elfMjFflLTiqzhAfl7b8
 2HLruYtwK1FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="491469428"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2020 05:31:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 43E99166; Fri, 31 Jul 2020 15:31:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] lib/vsprintf: Replace custom spec to print decimals with generic one
Date:   Fri, 31 Jul 2020 15:31:44 +0300
Message-Id: <20200731123145.22357-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com>
References: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When printing phandle in %pOF the custom spec is used. First of all,
it has SMALL flag which makes no sense for decimal numbers. Second,
we have already default spec for decimal numbers. Use the latter in
%pOF case as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 8a8ac7ce0289..90d818ef03c5 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1979,12 +1979,6 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	char *buf_start = buf;
 	struct property *prop;
 	bool has_mult, pass;
-	static const struct printf_spec num_spec = {
-		.flags = SMALL,
-		.field_width = -1,
-		.precision = -1,
-		.base = 10,
-	};
 
 	struct printf_spec str_spec = spec;
 	str_spec.field_width = -1;
@@ -2024,7 +2018,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 			str_spec.precision = precision;
 			break;
 		case 'p':	/* phandle */
-			buf = number(buf, end, (unsigned int)dn->phandle, num_spec);
+			buf = number(buf, end, (unsigned int)dn->phandle, default_dec_spec);
 			break;
 		case 'P':	/* path-spec */
 			p = fwnode_get_name(of_fwnode_handle(dn));
-- 
2.27.0

