Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FDB2EF0E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbhAHKx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbhAHKxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:53:55 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018D9C0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 02:53:14 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id EAtD2400T4C55Sk06AtDLr; Fri, 08 Jan 2021 11:53:13 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxpOL-00201V-3U; Fri, 08 Jan 2021 11:53:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxpOK-008Vd8-GD; Fri, 08 Jan 2021 11:53:12 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] bitops: Spelling s/synomyn/synonym/
Date:   Fri,  8 Jan 2021 11:53:05 +0100
Message-Id: <20210108105305.2028120-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a misspelling of "synonym".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index a61f192c096b3ac6..a5a48303b0f111ee 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -214,7 +214,7 @@ static inline int get_count_order_long(unsigned long l)
  * __ffs64 - find first set bit in a 64 bit word
  * @word: The 64 bit word
  *
- * On 64 bit arches this is a synomyn for __ffs
+ * On 64 bit arches this is a synonym for __ffs
  * The result is not defined if no bits are set, so check that @word
  * is non-zero before calling this.
  */
-- 
2.25.1

