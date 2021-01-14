Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924C52F5C00
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbhANIFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:05:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbhANIFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:05:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15F91239EC;
        Thu, 14 Jan 2021 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610611500;
        bh=O5ypsP3hRuPrE324x5q9RBIy7mNUHSv41zXsG+phmqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clLzLYXf1FMt2x+S8RAA356oK+uAl8qu/FJlqajxjP9VDMHR8/8h8GLly9fO87fSx
         1wmNxbzfEhcoiJOsTzdjJvj/lG/yN30rXssW+xiNXmSNCUGYCGknEfFp6PGL/Iw795
         UDDMlzmUaCBppNOvWiKR4F93bHMc1Uh1/WzwEwszThBpzjV5fmBor/QDo5KHFB4PjD
         GsF29J3Q5QjiJQq/b2Ozplf0DKJH22Rj3dnP1ApCOM8lB93kPXI3C4RAdKuV1nOQJk
         EfMKGYp7L908qRjd+cHP362+d1t24ZmavDA1yWD13Nv5yk2teL8KRxMN3Zb8dnkeIY
         JU540NaPANvSQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxcn-00EQ6a-UY; Thu, 14 Jan 2021 09:04:57 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Geoff Levand <geoff@infradead.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/16] connector: fix a kernel-doc markup
Date:   Thu, 14 Jan 2021 09:04:42 +0100
Message-Id: <889cfb141a98ae06d5bc79b744786ec2e8f92d93.1610610937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
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
index 8ea860efea37..487350bb19c3 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -99,7 +99,7 @@ void cn_del_callback(const struct cb_id *id);
 int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 group, gfp_t gfp_mask);
 
 /**
- * cn_netlink_send_mult - Sends message to the specified groups.
+ * cn_netlink_send - Sends message to the specified groups.
  *
  * @msg:	message header(with attached data).
  * @portid:	destination port.
-- 
2.29.2

