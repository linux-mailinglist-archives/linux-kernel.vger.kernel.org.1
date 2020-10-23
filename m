Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696D0297473
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750401AbgJWQhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751851AbgJWQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64BCA246BA;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=4cGQZu6GXTOYP+AFlrfRWtgyOlj2+ko5AakCb/DydP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lulq4D7WbTz6Btr9PN4P4SPxFi8Mxd1X26ceXOqcG+JNF84tqxbPROnMQLucLs5ow
         +0YsGO1fBYyMfarzF6uoyPFR1/REnHortZJ+i2NiJ/Ws94zQclVhaEMJe8Nb8zDa3b
         hOxUlFk8SVnu6B8Sxt146lNh0503BIAGEFanzWHM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002AxD-D3; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 41/56] connector: fix a kernel-doc markup
Date:   Fri, 23 Oct 2020 18:33:28 +0200
Message-Id: <12a41727308652cf65e25ec48dd6f86b9f35e715.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
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
@@ -99,7 +99,7 @@ void cn_del_callback(struct cb_id *id);
 int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 group, gfp_t gfp_mask);
 
 /**
- * cn_netlink_send_mult - Sends message to the specified groups.
+ * cn_netlink_send - Sends message to the specified groups.
  *
  * @msg:	message header(with attached data).
  * @portid:	destination port.
-- 
2.26.2

