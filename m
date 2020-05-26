Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4131D607B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgEPLGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 07:06:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:26451 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgEPLGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 07:06:16 -0400
IronPort-SDR: TKFxObQi7ut6bXsanv3itmymNJ+xrLevOqI+jjAh1WY3akz1tWzzgcQo/A9EI0QJVQrgwWpDoZ
 oXRmgyBVtzIQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 04:06:16 -0700
IronPort-SDR: mr/DOfseHp/z/ixbKiGPnE+x2RyUBperkPFpLoDHnEPwgL4gajXjWNF9I3tD42a/vKzUO5XWCC
 lCzq5PPISTwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="263457885"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by orsmga003.jf.intel.com with ESMTP; 16 May 2020 04:06:14 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 1/2] mfd: constify properties in mfd_cell
Date:   Sat, 16 May 2020 14:06:08 +0300
Message-Id: <20200516110609.22013-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200516110609.22013-1-tomas.winkler@intel.com>
References: <20200516110609.22013-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify 'struct property_entry *properties' in
mfd_cell It is always passed
around as a pointer const struct.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 include/linux/mfd/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index d01d1299e49d..7e5ac3c00891 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -70,7 +70,7 @@ struct mfd_cell {
 	size_t			pdata_size;
 
 	/* device properties passed to the sub devices drivers */
-	struct property_entry *properties;
+	const struct property_entry *properties;
 
 	/*
 	 * Device Tree compatible string
-- 
2.21.3

