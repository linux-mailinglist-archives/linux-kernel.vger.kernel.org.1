Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4E0224E6A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 02:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgGSAb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 20:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSAb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:31:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2264C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=eVuh87c7MJk7qhJ+f7vdZv1qfj1xgmO2BO8izKfmC/I=; b=pfElcevWOHn00748+l8gXwlDxi
        uGortHXOMpI9BzYy064FGVCrGmiR8ZwIRONgqp7KNzw3HTzwxiYcDg7P5KQuIUPpeQhmLhjUB8KaI
        uuYF+1+2NGZRDSsn7+0hZJsVp2CUs/roP/5mMGiLHdZm5kUM+SzSdRMZHvijlaTAxv6AEETg9pbR1
        FKL4kbvM5igJXO9zonRadiWb4Gq4fR8//9mVSjZimQVb7GOPvWaWbuudYOiLfhgk+SkKkdnalhS5h
        K5dMXJuhBZzF2mGlW44p7Rxu2RZQRacP2BcHaLP7wCNEKKq3QmS8ZLnPDkhNUspiZX9ALetyqY0IJ
        KVBhOhWA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxEh-0002u0-BE; Sun, 19 Jul 2020 00:31:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Irina Tirdea <irina.tirdea@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] platform_data: x86/pmc_atom.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:31:19 -0700
Message-Id: <20200719003119.21000-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "of" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Irina Tirdea <irina.tirdea@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
 include/linux/platform_data/x86/pmc_atom.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/platform_data/x86/pmc_atom.h
+++ linux-next-20200717/include/linux/platform_data/x86/pmc_atom.h
@@ -47,7 +47,7 @@
 #define	PMC_S0I2_TMR		0x88
 #define	PMC_S0I3_TMR		0x8C
 #define	PMC_S0_TMR		0x90
-/* Sleep state counter is in units of of 32us */
+/* Sleep state counter is in units of 32us */
 #define	PMC_TMR_SHIFT		5
 
 /* Power status of power islands */
