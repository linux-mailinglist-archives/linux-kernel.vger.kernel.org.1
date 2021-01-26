Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265A4303AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404259AbhAZKs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:48:29 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:63671 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730850AbhAZCOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:14:25 -0500
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="103827318"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Jan 2021 10:13:37 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id CFBDA48990D2;
        Tue, 26 Jan 2021 10:13:35 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 26 Jan 2021 10:13:34 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 26 Jan 2021 10:13:34 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-nvdimm@lists.01.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] dax: fix default return code of range_parse()
Date:   Tue, 26 Jan 2021 10:13:31 +0800
Message-ID: <20210126021331.1059933-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: CFBDA48990D2.AACFD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of range_parse() indicates the size when it is
positive.  The error code should be negative.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 drivers/dax/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 737b207c9e30..3003558c1a8b 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1038,7 +1038,7 @@ static ssize_t range_parse(const char *opt, size_t len, struct range *range)
 {
 	unsigned long long addr = 0;
 	char *start, *end, *str;
-	ssize_t rc = EINVAL;
+	ssize_t rc = -EINVAL;
 
 	str = kstrdup(opt, GFP_KERNEL);
 	if (!str)
-- 
2.30.0



