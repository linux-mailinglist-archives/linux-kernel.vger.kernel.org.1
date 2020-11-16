Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FFB2B40B1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgKPKSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgKPKSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:31 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E70C22409;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=C7aylmvczZOzdAQYeQYP3G44CrEN39sjqPEW7hB9Y3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5ZxYonH2NTctESSLb2l1Cl9ITDzxS/3UInT0StM9qHczwGLKRsahc+jCu+1zihhh
         yR58UgTYUV412+mL0Aa4w0ZXLsJqm1HtwWVZ2JLUOmN8BHPWVPMFIDcnmTsZZ2auA6
         9zFryZyaTXzPd7yMgYnPxOSpXvDheYvycEtcZ0FM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwEU-Er; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/27] lib/crc7: fix a kernel-doc markup
Date:   Mon, 16 Nov 2020 11:18:13 +0100
Message-Id: <27b4c10189681f62858e3871704a893ca9c38d38.1605521731.git.mchehab+huawei@kernel.org>
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
 lib/crc7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/crc7.c b/lib/crc7.c
index 6a848d73e804..3848e313b722 100644
--- a/lib/crc7.c
+++ b/lib/crc7.c
@@ -34,41 +34,41 @@ const u8 crc7_be_syndrome_table[256] = {
 	0x82, 0x90, 0xa6, 0xb4, 0xca, 0xd8, 0xee, 0xfc,
 	0x12, 0x00, 0x36, 0x24, 0x5a, 0x48, 0x7e, 0x6c,
 	0xb0, 0xa2, 0x94, 0x86, 0xf8, 0xea, 0xdc, 0xce,
 	0x20, 0x32, 0x04, 0x16, 0x68, 0x7a, 0x4c, 0x5e,
 	0xe6, 0xf4, 0xc2, 0xd0, 0xae, 0xbc, 0x8a, 0x98,
 	0x76, 0x64, 0x52, 0x40, 0x3e, 0x2c, 0x1a, 0x08,
 	0xd4, 0xc6, 0xf0, 0xe2, 0x9c, 0x8e, 0xb8, 0xaa,
 	0x44, 0x56, 0x60, 0x72, 0x0c, 0x1e, 0x28, 0x3a,
 	0x4a, 0x58, 0x6e, 0x7c, 0x02, 0x10, 0x26, 0x34,
 	0xda, 0xc8, 0xfe, 0xec, 0x92, 0x80, 0xb6, 0xa4,
 	0x78, 0x6a, 0x5c, 0x4e, 0x30, 0x22, 0x14, 0x06,
 	0xe8, 0xfa, 0xcc, 0xde, 0xa0, 0xb2, 0x84, 0x96,
 	0x2e, 0x3c, 0x0a, 0x18, 0x66, 0x74, 0x42, 0x50,
 	0xbe, 0xac, 0x9a, 0x88, 0xf6, 0xe4, 0xd2, 0xc0,
 	0x1c, 0x0e, 0x38, 0x2a, 0x54, 0x46, 0x70, 0x62,
 	0x8c, 0x9e, 0xa8, 0xba, 0xc4, 0xd6, 0xe0, 0xf2
 };
 EXPORT_SYMBOL(crc7_be_syndrome_table);
 
 /**
- * crc7 - update the CRC7 for the data buffer
+ * crc7_be - update the CRC7 for the data buffer
  * @crc:     previous CRC7 value
  * @buffer:  data pointer
  * @len:     number of bytes in the buffer
  * Context: any
  *
  * Returns the updated CRC7 value.
  * The CRC7 is left-aligned in the byte (the lsbit is always 0), as that
  * makes the computation easier, and all callers want it in that form.
  *
  */
 u8 crc7_be(u8 crc, const u8 *buffer, size_t len)
 {
 	while (len--)
 		crc = crc7_be_byte(crc, *buffer++);
 	return crc;
 }
 EXPORT_SYMBOL(crc7_be);
 
 MODULE_DESCRIPTION("CRC7 calculations");
 MODULE_LICENSE("GPL");
-- 
2.28.0

