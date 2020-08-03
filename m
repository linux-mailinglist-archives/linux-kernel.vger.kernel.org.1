Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC2C23A100
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 10:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgHCI1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 04:27:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:63452 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgHCI1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:27:10 -0400
IronPort-SDR: SATrK+f+aqQczKjrXx43vHFHoMWael5mZpRbuh3T0nxTPNNbBwSI3rb3cVKvoXTl6XLy8jjYP6
 o4Ku3GtJ3Gvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="170166624"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="170166624"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 01:27:09 -0700
IronPort-SDR: 8+bUHXn2S5GBUnIYcgAzabJaDshi2Df9aXOOBl4rS8SroGk+W9D13jd5jsB5VK0UtKasj9sQi5
 JDikYO7oaT8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="331819023"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2020 01:27:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 46EC9130; Mon,  3 Aug 2020 11:27:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2] kobject: Restore old behaviour of kobject_del(NULL)
Date:   Mon,  3 Aug 2020 11:27:06 +0300
Message-Id: <20200803082706.65347-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in
kobject_cleanup()") inadvertently dropped a possibility to call kobject_del()
with NULL pointer. Restore the old behaviour.

Fixes: 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in kobject_cleanup()")
Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: replaced ?: with plain conditional (Greg)
 lib/kobject.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 3afb939f2a1c..9dce68c378e6 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -637,8 +637,12 @@ static void __kobject_del(struct kobject *kobj)
  */
 void kobject_del(struct kobject *kobj)
 {
-	struct kobject *parent = kobj->parent;
+	struct kobject *parent;
+
+	if (!kobj)
+		return;
 
+	parent = kobj->parent;
 	__kobject_del(kobj);
 	kobject_put(parent);
 }
-- 
2.27.0

