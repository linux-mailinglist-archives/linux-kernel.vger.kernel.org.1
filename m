Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995F223F6F7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Aug 2020 10:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHHIe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Aug 2020 04:34:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9356 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbgHHIeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 04:34:25 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B62D12A7F7EEF3E9890F;
        Sat,  8 Aug 2020 16:34:19 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Sat, 8 Aug 2020
 16:34:09 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <sfrench@samba.org>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] cifs: Convert to use the fallthrough macro
Date:   Sat, 8 Aug 2020 16:36:37 +0800
Message-ID: <1596875797-22710-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/cifs/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 24c2ac360591..667d70aa335f 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3913,7 +3913,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	case MID_RESPONSE_MALFORMED:
 		credits.value = le16_to_cpu(shdr->CreditRequest);
 		credits.instance = server->reconnect_instance;
-		/* fall through */
+		fallthrough;
 	default:
 		rdata->result = -EIO;
 	}
@@ -4146,7 +4146,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
 	case MID_RESPONSE_MALFORMED:
 		credits.value = le16_to_cpu(rsp->sync_hdr.CreditRequest);
 		credits.instance = server->reconnect_instance;
-		/* fall through */
+		fallthrough;
 	default:
 		wdata->result = -EIO;
 		break;
-- 
2.19.1

