Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4812432D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 05:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHMDfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 23:35:05 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:21367 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMDfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:35:04 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id E181A4E1F13;
        Thu, 13 Aug 2020 11:34:57 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] drivers/greybus: Use kobj_to_dev() instead
Date:   Thu, 13 Aug 2020 11:34:48 +0800
Message-Id: <1597289690-22857-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT08fH0MfGUlMGh9OVkpOQkxJQ0JNQkNKQk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OQg6LQw*FD8dOUMODioeVhYc
        EzFPCQ5VSlVKTkJMSUNCTUJDTUxIVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFJSE1INwY+
X-HM-Tid: 0a73e5e293459376kuwse181a4e1f13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/greybus/interface.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
index 67dbe6f..de167f1
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -620,7 +620,7 @@ static struct attribute *interface_common_attrs[] = {
 static umode_t interface_unipro_is_visible(struct kobject *kobj,
 					   struct attribute *attr, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct gb_interface *intf = to_gb_interface(dev);
 
 	switch (intf->type) {
@@ -635,7 +635,7 @@ static umode_t interface_unipro_is_visible(struct kobject *kobj,
 static umode_t interface_greybus_is_visible(struct kobject *kobj,
 					    struct attribute *attr, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct gb_interface *intf = to_gb_interface(dev);
 
 	switch (intf->type) {
@@ -649,7 +649,7 @@ static umode_t interface_greybus_is_visible(struct kobject *kobj,
 static umode_t interface_power_is_visible(struct kobject *kobj,
 					  struct attribute *attr, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct gb_interface *intf = to_gb_interface(dev);
 
 	switch (intf->type) {
-- 
2.7.4

