Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A93228A49
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 23:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbgGUVAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 17:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUVAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:00:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F561C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=WznENdSlJ0jCviF8hzv04QBublYkgavDkLeyRXY7lQI=; b=zearKNpWR0Xq3tVDkeg2cXGTzj
        loUQatCDZorXTKUH51tOlOnc2WOjm9m/Y/VB1cWPCFzPbGIRKk/ag24/8TfWiPJYzGzItlb03xGWM
        SPCtPioBcAPy1k3wILeRbwVkueAvP31fz45/wx2BUosBrbHUR8EphXdpYMduIkk33wXVS//qL06TO
        aBd5wA8knhUYxGRoy2TGfkN0uhzsAlfh+mqRyqYgWJopACEiXdY2FbQc+EjFT7kEKMuhY4d43/hLO
        m4QNQ4pEXmZ3qxoEkQ6+bp3NPOvwz+BxbyR8dGtuomZSyjUzbqdNpr2Op9cyWv3rkLQTQxB5hvDJZ
        D11BMMRw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxzNY-0000es-6q; Tue, 21 Jul 2020 21:00:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH] xtensa: initialize_mmu.h: fix a duplicated word
Date:   Tue, 21 Jul 2020 14:00:44 -0700
Message-Id: <20200721210044.15458-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change "The the" to "For the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/include/asm/initialize_mmu.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/xtensa/include/asm/initialize_mmu.h
+++ linux-next-20200720/arch/xtensa/include/asm/initialize_mmu.h
@@ -6,7 +6,7 @@
  *      For the new V3 MMU we remap the TLB from virtual == physical
  *      to the standard Linux mapping used in earlier MMU's.
  *
- *      The the MMU we also support a new configuration register that
+ *      For the MMU we also support a new configuration register that
  *      specifies how the S32C1I instruction operates with the cache
  *      controller.
  *
