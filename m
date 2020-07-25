Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D72522D636
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 10:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgGYIwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 04:52:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8825 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726613AbgGYIwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 04:52:44 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BAC998CBAC9638A81EB8;
        Sat, 25 Jul 2020 16:52:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 16:52:35 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Steve French <sfrench@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-cifs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cifs: convert to use be32_add_cpu()
Date:   Sat, 25 Jul 2020 16:56:01 +0800
Message-ID: <20200725085601.98074-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert cpu_to_be32(be32_to_cpu(E1) + E2) to use be32_add_cpu().

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 fs/cifs/connect.c | 3 +--
 fs/cifs/sess.c    | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 889fee586..552975420 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -5114,8 +5114,7 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 	bcc_ptr += strlen("?????");
 	bcc_ptr += 1;
 	count = bcc_ptr - &pSMB->Password[0];
-	pSMB->hdr.smb_buf_length = cpu_to_be32(be32_to_cpu(
-					pSMB->hdr.smb_buf_length) + count);
+	be32_add_cpu(&pSMB->hdr.smb_buf_length, count);
 	pSMB->ByteCount = cpu_to_le16(count);
 
 	rc = SendReceive(xid, ses, smb_buffer, smb_buffer_response, &length,
diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index 6708ab0aa..69cd58566 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -938,8 +938,7 @@ sess_sendreceive(struct sess_data *sess_data)
 	struct kvec rsp_iov = { NULL, 0 };
 
 	count = sess_data->iov[1].iov_len + sess_data->iov[2].iov_len;
-	smb_buf->smb_buf_length =
-		cpu_to_be32(be32_to_cpu(smb_buf->smb_buf_length) + count);
+	be32_add_cpu(&smb_buf->smb_buf_length, count);
 	put_bcc(count, smb_buf);
 
 	rc = SendReceive2(sess_data->xid, sess_data->ses,
-- 
2.25.1

