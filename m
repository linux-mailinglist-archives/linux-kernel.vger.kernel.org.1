Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437342CA22A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgLAMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730389AbgLAMJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:09:56 -0500
Received: from mail.kernel.org (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34A572085B;
        Tue,  1 Dec 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824555;
        bh=5j3bZfT+AahvAZyD2bTq7ZbhqOVp8pnzllSmo2XZ6sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UoXWAr058HWX1h5ih5hkHzSgSxCPYXTKyaNyHhZYH4nO/nvYq0XTw9Ipq86OsIV3s
         iz6jiZwxlcsrrmA+tO3+twKUdXF6gLC4zN9JgEh+Cj/3yW+yo9vjTouPkFQ20mDWBQ
         OFlyUXD9FbWYiYyeX6d1AXZZOdLQ2898V/h4HFZ8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T3-00DGdD-49; Tue, 01 Dec 2020 13:09:13 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/16] connector: fix a kernel-doc markup
Date:   Tue,  1 Dec 2020 13:09:02 +0100
Message-Id: <783748cbcb7cc69ee3c79ab6669303c9c0a46295.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A function has a different name between their prototype
and its kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/connector.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/connector.h b/include/linux/connector.h
index cb732643471b..6bdb56662675 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -70,65 +70,65 @@ int cn_add_callback(struct cb_id *id, const char *name,
  * cn_del_callback() - Unregisters new callback with connector core.
  *
  * @id:		unique connector's user identifier.
  */
 void cn_del_callback(struct cb_id *id);
 
 
 /**
  * cn_netlink_send_mult - Sends message to the specified groups.
  *
  * @msg: 	message header(with attached data).
  * @len:	Number of @msg to be sent.
  * @portid:	destination port.
  *		If non-zero the message will be sent to the given port,
  *		which should be set to the original sender.
  * @group:	destination group.
  * 		If @portid and @group is zero, then appropriate group will
  *		be searched through all registered connector users, and
  *		message will be delivered to the group which was created
  *		for user with the same ID as in @msg.
  *		If @group is not zero, then message will be delivered
  *		to the specified group.
  * @gfp_mask:	GFP mask.
  *
  * It can be safely called from softirq context, but may silently
  * fail under strong memory pressure.
  *
  * If there are no listeners for given group %-ESRCH can be returned.
  */
 int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 group, gfp_t gfp_mask);
 
 /**
- * cn_netlink_send_mult - Sends message to the specified groups.
+ * cn_netlink_send - Sends message to the specified groups.
  *
  * @msg:	message header(with attached data).
  * @portid:	destination port.
  *		If non-zero the message will be sent to the given port,
  *		which should be set to the original sender.
  * @group:	destination group.
  * 		If @portid and @group is zero, then appropriate group will
  *		be searched through all registered connector users, and
  *		message will be delivered to the group which was created
  *		for user with the same ID as in @msg.
  *		If @group is not zero, then message will be delivered
  *		to the specified group.
  * @gfp_mask:	GFP mask.
  *
  * It can be safely called from softirq context, but may silently
  * fail under strong memory pressure.
  *
  * If there are no listeners for given group %-ESRCH can be returned.
  */
 int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 group, gfp_t gfp_mask);
 
 int cn_queue_add_callback(struct cn_queue_dev *dev, const char *name,
 			  struct cb_id *id,
 			  void (*callback)(struct cn_msg *, struct netlink_skb_parms *));
 void cn_queue_del_callback(struct cn_queue_dev *dev, struct cb_id *id);
 void cn_queue_release_callback(struct cn_callback_entry *);
 
 struct cn_queue_dev *cn_queue_alloc_dev(const char *name, struct sock *);
 void cn_queue_free_dev(struct cn_queue_dev *dev);
 
 int cn_cb_equal(struct cb_id *, struct cb_id *);
 
-- 
2.28.0

