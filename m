Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA76F293E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408005AbgJTOTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:19:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47760 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407988AbgJTOTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:19:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kUsUD-0007vc-5C; Tue, 20 Oct 2020 14:19:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: make const array static, makes object smaller
Date:   Tue, 20 Oct 2020 15:19:36 +0100
Message-Id: <20201020141936.52272-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate const array smb3_create_tag_posix on the stack but
instead make it static. Makes the object code smaller by 50 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
 150184	  47167	      0	 197351	  302e7	fs/cifs/smb2pdu.o

After:
    text	   data	    bss	    dec	    hex	filename
 150070	  47231	      0	 197301	  302b5	fs/cifs/smb2pdu.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cifs/smb2pdu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index d504bc296349..be8696abd871 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1971,9 +1971,11 @@ smb2_parse_contexts(struct TCP_Server_Info *server,
 	unsigned int next;
 	unsigned int remaining;
 	char *name;
-	const char smb3_create_tag_posix[] = {0x93, 0xAD, 0x25, 0x50, 0x9C,
-					0xB4, 0x11, 0xE7, 0xB4, 0x23, 0x83,
-					0xDE, 0x96, 0x8B, 0xCD, 0x7C};
+	static const char smb3_create_tag_posix[] = {
+		0x93, 0xAD, 0x25, 0x50, 0x9C,
+		0xB4, 0x11, 0xE7, 0xB4, 0x23, 0x83,
+		0xDE, 0x96, 0x8B, 0xCD, 0x7C
+	};
 
 	*oplock = 0;
 	data_offset = (char *)rsp + le32_to_cpu(rsp->CreateContextsOffset);
-- 
2.27.0

