Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E342C82C0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgK3LBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:01:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8217 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgK3LBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:01:10 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cl2Lg3wcxzkjd4;
        Mon, 30 Nov 2020 18:59:55 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 30 Nov 2020 19:00:18 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <justin.ernst@hpe.com>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Zou Wei" <zou_wei@huawei.com>
Subject: [PATCH -next] x86/platform/uv: Mark some symbols with static keyword
Date:   Mon, 30 Nov 2020 19:11:53 +0800
Message-ID: <1606734713-43919-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings:

drivers/platform/x86/uv_sysfs.c:22:13: warning: symbol 'uv_pcibus_kset' was not declared. Should it be static?
drivers/platform/x86/uv_sysfs.c:23:13: warning: symbol 'uv_hubs_kset' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/platform/x86/uv_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index 54c3425..c780a4b 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -19,8 +19,8 @@
 #define INVALID_CNODE -1
 
 struct kobject *sgi_uv_kobj;
-struct kset *uv_pcibus_kset;
-struct kset *uv_hubs_kset;
+static struct kset *uv_pcibus_kset;
+static struct kset *uv_hubs_kset;
 static struct uv_bios_hub_info *hub_buf;
 static struct uv_bios_port_info **port_buf;
 static struct uv_hub **uv_hubs;
-- 
2.6.2

