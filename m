Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B700B22DAC3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 02:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGZAVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 20:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGZAVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:21:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9F5C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iT5qrCLArCszES5racsHcDNOM4jlffe8YL9XVjHGO6Y=; b=aSasYrZPg2rMlaw+r3CKwj389V
        ZHvH11r9CPDkoLJdI9KPliGVcQWUb3F4CBCXuaUxTNZZe7Q81pgsZvc0MOIwheI/chNJ6nfWQFT5M
        c/IMzB8nLZlmRj4LHI+hxN63Syy4Nxb59bdK78vtCn145S8wgErF9FsK0VDRfus1K8g9h2Th5gyVR
        PABtqTuBYGdJZxKqkYmwhh3tl1+VUZNtLnD07Fe39IRA6DxJCkxHcD6Sz71nA4B2VLYq4FtFNPZCA
        uhWJGZkI19Y3GQfAg5klp8ZxKEqQ+ozT5W1PwKJzR6bAfyI3r4xrbeFDr/IXTrX21rnqbPaSUrb/O
        ftZ5id5Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUQJ-0002XX-F6; Sun, 26 Jul 2020 00:21:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm: dts: imx1-pinfunc.h: delete duplicate word
Date:   Sat, 25 Jul 2020 17:21:48 -0700
Message-Id: <20200726002148.19796-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "configurable".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx1-pinfunc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/arm/boot/dts/imx1-pinfunc.h
+++ linux-next-20200720/arch/arm/boot/dts/imx1-pinfunc.h
@@ -26,7 +26,7 @@
  *                2 - 0
  *                3 - 1
  *
- * 'pin' is an integer between 0 and 0xbf. i.MX1 has 4 ports with 32 configurable
+ * 'pin' is an integer between 0 and 0xbf. i.MX1 has 4 ports with 32
  * configurable pins each. 'pin' is PORT * 32 + PORT_PIN, PORT_PIN is the pin
  * number on the specific port (between 0 and 31).
  */
