Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF5B22DAE7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 02:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgGZAih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 20:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgGZAic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:38:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF24C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sH3Q5iTjYfBvYZxROArpXeVz46XzFFrdUeQmFmyUWrU=; b=fQo6zQkS2cVLXjK+Ueg+9onuVe
        ZcohwyfF+STjTR/8y6CdOYR62bE3i0m4qwLg0SrIYbr66/ypRSKhHs+BBn4EpJ7a7i7Bz5yIn/+Zu
        T+Jui9Vg+XEjGkeJm+yx/5R15RjsoR2lxbzvewFB/+EAhcy9gjTiZHODwxi/LgtXAwyIzBlMhHYy0
        71mi/QgiYnZ0MK997QCKGbKJD6k8201rVYub7n1zcpRalCAunFdfUs5Z/LjH3BURSL0Q4JtDCj721
        Y/v1szVasSz2e71f28XKeQXepsGlOPJOsejKpt0iLG7qX9htIazsHhd/YrBr6rpLLGYm4tP6CdnhO
        bx87hjjw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUgQ-0003Cq-07; Sun, 26 Jul 2020 00:38:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 9/9] powerpc: powernv: pci.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:38:09 -0700
Message-Id: <20200726003809.20454-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003809.20454-1-rdunlap@infradead.org>
References: <20200726003809.20454-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "for".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/powernv/pci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/powerpc/platforms/powernv/pci.h
+++ linux-next-20200720/arch/powerpc/platforms/powernv/pci.h
@@ -87,7 +87,7 @@ struct pnv_ioda_pe {
 	bool			tce_bypass_enabled;
 	uint64_t		tce_bypass_base;
 
-	/* MSIs. MVE index is identical for for 32 and 64 bit MSI
+	/* MSIs. MVE index is identical for 32 and 64 bit MSI
 	 * and -1 if not supported. (It's actually identical to the
 	 * PE number)
 	 */
