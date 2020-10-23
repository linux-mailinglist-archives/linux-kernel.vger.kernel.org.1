Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38AC297460
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbgJWQg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751853AbgJWQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CDBB246BC;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=ik6XN/F9Yil/xxoz9W54cw08G8P+2xMgKORme/cmGbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kCRWEuzHM6GkSZ1YvcZDl2Wletm6F+MvgN8ayvb3mjkVpHEM4BcByqkPa+uJ8O69E
         l1DvvtayM6aC40idBS6fnyZshtpsIMqYay6TK3FtPAejKfT46t82VeMsusJ5bjLD4+
         g6n4VqbwA6INoTLs8l/xkwZ2BSDmPp8tRMpKWYlA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002AxH-Dm; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 42/56] lib/crc7: fix a kernel-doc markup
Date:   Fri, 23 Oct 2020 18:33:29 +0200
Message-Id: <a8da359243b9b76f53e545682f1897e1c2b81963.1603469755.git.mchehab+huawei@kernel.org>
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
 lib/crc7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/crc7.c b/lib/crc7.c
index 6a848d73e804..3848e313b722 100644
--- a/lib/crc7.c
+++ b/lib/crc7.c
@@ -51,7 +51,7 @@ const u8 crc7_be_syndrome_table[256] = {
 EXPORT_SYMBOL(crc7_be_syndrome_table);
 
 /**
- * crc7 - update the CRC7 for the data buffer
+ * crc7_be - update the CRC7 for the data buffer
  * @crc:     previous CRC7 value
  * @buffer:  data pointer
  * @len:     number of bytes in the buffer
-- 
2.26.2

