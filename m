Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8B530313A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 02:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbhAZB2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 20:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732057AbhAYTmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:42:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C6BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mrZHZHbc27vqVUfEuhEyruze5uMUIpOLY2oGHG7fBio=; b=0gasTYezmmRuVGZpBloJjXpYtZ
        F/QWvplkNP8EebFO4SEeW2McKRXNuVhnkZ93z4Vo4x+WWT0v8Rmkm4ShnOqVDjvT8/bEmJLRs9PsD
        j820hmB00uPYjN6bojMNrV3xJcWbCmfaL6/tyNv/xp8moCR3zh2X9XJ7JOesFAzarEMcN4NHJtbjt
        nc/3bNhPxenY1CRQKR79GllGVxu7UI3eI78Z9mS2cyvKIzwfpIFv7dsBwJOLOZGCfJBig28sXBSYl
        rD2ZPKnAKLhQte4+1tdey1YGrBx5iTR5UzmExTo/HESQx9kMQloA6x+DkPTXfE9AIJD7QntsI+Heu
        j09iwTOQ==;
Received: from [2601:1c0:6280:3f0::7650] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l47jz-0005Y8-HV; Mon, 25 Jan 2021 19:41:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RESEND] H8/300: flat.h: fix a duplicated word
Date:   Mon, 25 Jan 2021 11:41:29 -0800
Message-Id: <20210125194129.24392-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the phrase "is is" to "it is".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/h8300/include/asm/flat.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/h8300/include/asm/flat.h
+++ linux-next-20200720/arch/h8300/include/asm/flat.h
@@ -12,7 +12,7 @@
  * on the H8 a couple of the relocations have an instruction in the
  * top byte.  As there can only be 24bits of address space,  we just
  * always preserve that 8bits at the top,  when it isn't an instruction
- * is is 0 (davidm@snapgear.com)
+ * it is 0 (davidm@snapgear.com)
  */
 
 #define	flat_get_relocate_addr(rel)		(rel & ~0x00000001)
