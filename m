Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640532D416D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgLILwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:52:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:8605 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbgLILwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:52:05 -0500
IronPort-SDR: 76a+vcFfNjGAW3EHGES7j7kbXGZbOMI7K0v2KCpiKhh1i4hFZdXKiwjg+Cjpvz4PlwJ4NHaJ/z
 RgZykXbUA2YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174208961"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="174208961"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 03:50:19 -0800
IronPort-SDR: obIrY2NUvqXsAYi8bUzuxVzVXftr90FhSqbiet16T5q1gU3V2CEBVSEyHvlX8riHxNk2oRYkc9
 PHipgnjLiyZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="337962365"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2020 03:50:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EC0881C8; Wed,  9 Dec 2020 13:50:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] scripts: switch explicitly to Python 3
Date:   Wed,  9 Dec 2020 13:50:17 +0200
Message-Id: <20201209115017.64452-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some distributions are about to switch to Python 3 support only.
This means that /usr/bin/python, which is Python 2, is not available
anymore. Hence, switch scripts to use Python 3 explicitly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 scripts/bloat-o-meter | 2 +-
 scripts/diffconfig    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
index 652e9542043f..dcd8d8750b8b 100755
--- a/scripts/bloat-o-meter
+++ b/scripts/bloat-o-meter
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Copyright 2004 Matt Mackall <mpm@selenic.com>
 #
diff --git a/scripts/diffconfig b/scripts/diffconfig
index 627eba5849b5..d5da5fa05d1d 100755
--- a/scripts/diffconfig
+++ b/scripts/diffconfig
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 #
 # diffconfig - a tool to compare .config files.
-- 
2.29.2

