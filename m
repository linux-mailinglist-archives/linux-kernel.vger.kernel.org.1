Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6443045D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393783AbhAZR4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:56:40 -0500
Received: from m12-14.163.com ([220.181.12.14]:35218 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390435AbhAZI6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OZJSc
        d3nHQP6Nw7DZOfFY+swFW54pECiOh30Eg8HCkc=; b=gvWVW+K+gIrNMU57KKzmr
        /V1WSV9/haqnvYwSwAg1R8duVIZ9xRaB+1CzrVdXLnDlO9tCrrCmPp9kCf+aaeCY
        Im9ZNIYEkhxwUFVpJ1QIZnJY7rfBmiMA4PfTNfN4pE/0zIE6IYkAr1+gY9KokEvv
        YbITSkQNieGW7Pl4V5dPgM=
Received: from COOL-20201218BF.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowABHDNhh1Q9gP9Sqhw--.18850S2;
        Tue, 26 Jan 2021 16:40:14 +0800 (CST)
From:   mateng <ayowoe@163.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, mateng <mateng@yulong.com>
Subject: [PATCH] misc/vmw_vmci: fix typo
Date:   Tue, 26 Jan 2021 16:40:10 +0800
Message-Id: <20210126084010.1941-1-ayowoe@163.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABHDNhh1Q9gP9Sqhw--.18850S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF45ZFW8GFW7GF45uFyDJrb_yoW3GFg_W3
        48Xr4Iqr48KFnFkw18CF1fWa4rtFs5ur13GF1ag3y3JFya9r1fJr1qvFy3Wa1jyrW7KF17
        Gr1UCFWIyw13KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUebtxDUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5d1r40rh6rljoofrz/1tbiWw4mKlSIo28N5wAAsj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mateng <mateng@yulong.com>

change 'addres' to 'address'

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


