Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A08228A46
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 23:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgGUVA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 17:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUVA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:00:28 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859BFC061794;
        Tue, 21 Jul 2020 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=delRZux0mLS0jQqWSa4cDSDXHbHgMN/MHMG8w/uxu8c=; b=29p9nJvrs6X3lwKd5pPKY+xqGi
        eyOAAKyqwhilFECaRrWdAPVa2mkabSqX2bffVqMvESVAEa0j6F7zloG3zHxACmuaYuK7q48dNrw7D
        Ab1uW3hK2Z+vHmRbF1+zpxrp3/7Uf5148tvJKGoqzZjTizaqLSFK4lwfSohNtG5B/WEorZdEgjE32
        ru2zR6KPC46eHwKpRTfi+gS17+45uddawhXZJt4JFOuhCPZX5ehGX4usOj9P8aGWPg6FhkAOLrhg0
        CXYQVoAMXdg/wH39qYhUeYs3dPwqPbaVZ4a7CIV52RNDRbj5sC3LjiVQnoIJqUXcOBgdJgWnFJcE+
        5g+XEcfg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxzNC-0000bK-6B; Tue, 21 Jul 2020 21:00:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH] PARISC: elf.h: delete a duplicated word
Date:   Tue, 21 Jul 2020 14:00:22 -0700
Message-Id: <20200721210022.15354-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
---
 arch/parisc/include/asm/elf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/parisc/include/asm/elf.h
+++ linux-next-20200720/arch/parisc/include/asm/elf.h
@@ -152,7 +152,7 @@
 /* The following are PA function descriptors 
  *
  * addr:	the absolute address of the function
- * gp:		either the data pointer (r27) for non-PIC code or the
+ * gp:		either the data pointer (r27) for non-PIC code or
  *		the PLT pointer (r19) for PIC code */
 
 /* Format for the Elf32 Function descriptor */
