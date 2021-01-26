Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E24304644
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393765AbhAZR4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:56:38 -0500
Received: from mail-m971.mail.163.com ([123.126.97.1]:55418 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390611AbhAZI5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NETUb
        YkXW50xbfjAqgKRKzfv0E+zezRS1w8QI/+9u/w=; b=PkjaktfJDPoEV2ckMG4fq
        Fr6KaPNz80ZX5j1p7qbgKRIW6/MCbwayFY1aqHcnWzWUpcIuVTnMZXF5npgSKn+E
        VCz771xO13iEIIi1GP1APui7Fe1PUHUK4Wvg4aH4an74HqRcHskfZTd0Z5cpYpDc
        OliMMTOv/jeyVuUwOOVLtA=
Received: from COOL-20201218BF.ccdomain.com (unknown [218.94.48.178])
        by smtp1 (Coremail) with SMTP id GdxpCgDn7DRToA9gfgFmAg--.66S2;
        Tue, 26 Jan 2021 12:53:53 +0800 (CST)
From:   mateng <ayowoe@163.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, mateng <mateng@yulong.com>
Subject: [PATCH] Change 'addres' to 'address'.
Date:   Tue, 26 Jan 2021 12:53:48 +0800
Message-Id: <20210126045348.1454-1-ayowoe@163.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgDn7DRToA9gfgFmAg--.66S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF18GFyfJF4DCw1kKF1kAFb_yoWxKrc_W3
        48Xr4Iqr48KFnIkw1kCF4fWa4rtFs5ur1fGF1Yg3y3JFWa9r1fJr1qvFy3Wa17ArW3KF17
        Gr1UCa92yw13KjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUercTPUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5d1r40rh6rljoofrz/1tbi6wEmKlXlu3BRCAAAsE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mateng <mateng@yulong.com>

Signed-off-by: mateng <mateng@yulong.com>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.h b/drivers/misc/vmw_vmci/vmci_queue_pair.h
index 00017fc..c4e6e92 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.h
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.h
@@ -104,7 +104,7 @@ struct vmci_qp_dtch_info {
 struct vmci_qp_page_store {
 	/* Reference to pages backing the queue pair. */
 	u64 pages;
-	/* Length of pageList/virtual addres range (in pages). */
+	/* Length of pageList/virtual address range (in pages). */
 	u32 len;
 };
 
-- 
1.9.1

