Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8243A2B40FC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgKPKUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbgKPKS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:29 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48357222C4;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=Ywa+f+FkweIFP+K0kwh/I3DeYxDcy8UccZZ2WNEDXZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0/sZXJNHPVbr6pwWyRDLr2j6O+smofMJYgfiKr9oaBV5kGhFODgpAT9hQXqHW+tQr
         ijZC6iGbZ6I3wUfkHCdv9w+HCWyJ1OAAwKRjLM4RGTBjJXwHjefuD1E36UKFGxile+
         1elxIKrN0ca3+fZbUJoDlgR7qp5cvLbmdLFDW8gg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwER-Dy; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/27] connector: fix a kernel-doc markup
Date:   Mon, 16 Nov 2020 11:18:12 +0100
Message-Id: <31a93b13510e252ca6268f5730a8d7f443f98b61.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
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
@@ -82,41 +82,41 @@ void cn_del_callback(struct cb_id *id);
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
-- 
2.28.0

