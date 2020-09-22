Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB6B2741ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 14:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIVMSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 08:18:31 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:39915 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgIVMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 08:18:29 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id ACD7B4E114D;
        Tue, 22 Sep 2020 20:18:25 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] thunderbolt: use kobj_to_dev()
Date:   Tue, 22 Sep 2020 20:18:13 +0800
Message-Id: <1600777096-25725-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGE0dHx1CGUgfSU5LVkpNS0tMTExKS01LTkJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRA6Tzo6Pj8oCg4uMA8hPho8
        HTMKCjhVSlVKTUtLTExMSktNT0xLVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFJSUxINwY+
X-HM-Tid: 0a74b5c032139376kuwsacd7b4e114d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/thunderbolt/domain.c | 2 +-
 drivers/thunderbolt/switch.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index bba4cbf..7a192b7
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -275,7 +275,7 @@ static struct attribute *domain_attrs[] = {
 static umode_t domain_attr_is_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct tb *tb = container_of(dev, struct tb, dev);
 
 	if (attr == &dev_attr_boot_acl.attr) {
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 3845db5..99effd6
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1648,7 +1648,7 @@ static struct attribute *switch_attrs[] = {
 static umode_t switch_attr_is_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct tb_switch *sw = tb_to_switch(dev);
 
 	if (attr == &dev_attr_device.attr) {
-- 
2.7.4

