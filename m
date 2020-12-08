Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2BA2D2A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgLHMR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:17:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9396 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgLHMR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:17:26 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cqzg075SSz79Sn;
        Tue,  8 Dec 2020 20:16:12 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Dec 2020 20:16:36 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <srinivas.pandruvada@linux.intel.com>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Zou Wei" <zou_wei@huawei.com>
Subject: [PATCH -next] platform/x86: ISST: Mark mmio_range_devid_0 and mmio_range_devid_1 with static keyword
Date:   Tue, 8 Dec 2020 20:28:09 +0800
Message-ID: <1607430489-116200-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings:

drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c:23:24: warning: symbol 'mmio_range_devid_0' was not declared. Should it be static?
drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c:28:24: warning: symbol 'mmio_range_devid_1' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
index 2906cfe..ff49025 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
@@ -20,12 +20,12 @@ struct isst_mmio_range {
 	int end;
 };
 
-struct isst_mmio_range mmio_range_devid_0[] = {
+static struct isst_mmio_range mmio_range_devid_0[] = {
 	{0x04, 0x14},
 	{0x20, 0xD0},
 };
 
-struct isst_mmio_range mmio_range_devid_1[] = {
+static struct isst_mmio_range mmio_range_devid_1[] = {
 	{0x04, 0x14},
 	{0x20, 0x11C},
 };
-- 
2.6.2

