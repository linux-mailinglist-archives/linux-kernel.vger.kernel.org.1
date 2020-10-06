Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C028444A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 05:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgJFDaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 23:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgJFDaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 23:30:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE4EC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 20:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=f/G7DuAt5Vd7J6Q89Y/fdvmp7kSgeSaWs9VcuRmdyDk=; b=oTmFBGviA61qjEiSv4n1ylYMSi
        MGHlo8oH4gkMcTE8HPlOv3eraW2KLUBrsb5rJl4n07hlvkxC+DlU/1SuNvhAGC/++zm9GW1MCD8p1
        o7KmRECGd78UZRMgWNekq5zCS4k7ZFYJHXZF/khJa1zTZUtuvmEzwDVZLkrAHWmrhOP5r4Ei+Nm1W
        od+t0VoL68uep0MF5OPp3nyTtCpbi3CPTf0cWw9/eWc6pxm4l+lN0hHdxdLKKFXHJUU3lxZH8Hm7w
        TIn73CzMU1YfRsy/oWvSsL3On/BIl1VJtHz+6dFzRj2nbxs9jB9rEhwx/uOQq+HiwyEFd+LYKL4J6
        pLJpXQXQ==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPdfv-0002uG-Fs; Tue, 06 Oct 2020 03:30:03 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arc: include/asm: fix typos of "themselves"
Message-ID: <610cc0df-deac-e2f6-e9ce-b19b3cba9501@infradead.org>
Date:   Mon, 5 Oct 2020 20:30:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix copy/paste spello of "themselves" in 3 places.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/include/asm/atomic.h  |    4 ++--
 arch/arc/include/asm/cmpxchg.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- lnx-59-rc7.orig/arch/arc/include/asm/atomic.h
+++ lnx-59-rc7/arch/arc/include/asm/atomic.h
@@ -45,7 +45,7 @@ static inline int atomic_##op##_return(i
 									\
 	/*								\
 	 * Explicit full memory barrier needed before/after as		\
-	 * LLOCK/SCOND thmeselves don't provide any such semantics	\
+	 * LLOCK/SCOND themselves don't provide any such semantics	\
 	 */								\
 	smp_mb();							\
 									\
@@ -71,7 +71,7 @@ static inline int atomic_fetch_##op(int
 									\
 	/*								\
 	 * Explicit full memory barrier needed before/after as		\
-	 * LLOCK/SCOND thmeselves don't provide any such semantics	\
+	 * LLOCK/SCOND themselves don't provide any such semantics	\
 	 */								\
 	smp_mb();							\
 									\
--- lnx-59-rc7.orig/arch/arc/include/asm/cmpxchg.h
+++ lnx-59-rc7/arch/arc/include/asm/cmpxchg.h
@@ -20,7 +20,7 @@ __cmpxchg(volatile void *ptr, unsigned l
 
 	/*
 	 * Explicit full memory barrier needed before/after as
-	 * LLOCK/SCOND thmeselves don't provide any such semantics
+	 * LLOCK/SCOND themselves don't provide any such semantics
 	 */
 	smp_mb();
 

