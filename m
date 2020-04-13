Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44BDA1A63ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 09:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgDMH4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 03:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgDMH4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:56:06 -0400
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD19C008609
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 00:56:06 -0700 (PDT)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9EA9480AB927C873579D;
        Mon, 13 Apr 2020 15:56:02 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 15:55:56 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <alexander.shishkin@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] coresight: cti: make some symbols static
Date:   Mon, 13 Apr 2020 16:22:24 +0800
Message-ID: <20200413082224.23090-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/hwtracing/coresight/coresight-cti.c:22:1: warning: symbol
'ect_net' was not declared. Should it be static?
drivers/hwtracing/coresight/coresight-cti.c:625:32: warning: symbol
'cti_ops_ect' was not declared. Should it be static?
drivers/hwtracing/coresight/coresight-cti.c:630:28: warning: symbol
'cti_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/hwtracing/coresight/coresight-cti.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index 9e262f5a85e3..7fc1fc8d7738 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -19,7 +19,7 @@
  */
 
 /* net of CTI devices connected via CTM */
-LIST_HEAD(ect_net);
+static LIST_HEAD(ect_net);
 
 /* protect the list */
 static DEFINE_MUTEX(ect_mutex);
@@ -622,12 +622,12 @@ int cti_disable(struct coresight_device *csdev)
 	return cti_disable_hw(drvdata);
 }
 
-const struct coresight_ops_ect cti_ops_ect = {
+static const struct coresight_ops_ect cti_ops_ect = {
 	.enable = cti_enable,
 	.disable = cti_disable,
 };
 
-const struct coresight_ops cti_ops = {
+static const struct coresight_ops cti_ops = {
 	.ect_ops = &cti_ops_ect,
 };
 
-- 
2.21.1

