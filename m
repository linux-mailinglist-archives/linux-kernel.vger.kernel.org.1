Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 580BE1A26D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 18:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgDHQJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 12:09:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:19689 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730173AbgDHQJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:09:29 -0400
IronPort-SDR: dJ3xPsXzDR82PngxWtS+NFFzioBE3RkGfgye31aXSGLPoVfGw4G15W7VWNY8fsKKw2WRLhuOXg
 MVeH9uIlG7HQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 09:09:28 -0700
IronPort-SDR: EqSvKDZuddnWMvMttuT5dob9LoypSLUWZWrk+ov+oKKzAj+if1cjBjPYhwCC9UMCFNt/tQ0skI
 65/8rfRbTjRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="275491704"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2020 09:09:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 75DC2D2; Wed,  8 Apr 2020 19:09:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/6] device property: export set_secondary_fwnode() to modules
Date:   Wed,  8 Apr 2020 19:09:01 +0300
Message-Id: <20200408160905.12101-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
References: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers when compiled as modules may need to set secondary firmware node.
Export set_secondary_fwnode() to make it possible without code duplication.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index dbb0f9130f42..11ab8fa7bd00 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3738,6 +3738,7 @@ void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
 	else
 		dev->fwnode = fwnode;
 }
+EXPORT_SYMBOL_GPL(set_secondary_fwnode);
 
 /**
  * device_set_of_node_from_dev - reuse device-tree node of another device
-- 
2.25.1

