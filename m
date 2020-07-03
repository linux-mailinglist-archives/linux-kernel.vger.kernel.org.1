Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B22140F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 23:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgGCVhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCVhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:37:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DBFC061794;
        Fri,  3 Jul 2020 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Iua7uSCbVKBTm2R3u3izbGXojizwiadsAU3+yzvMunI=; b=lOELYTPu/zDjeK3ipRsa2IHVyu
        lqOnW6i2stMaCH4xExskSkg6kWJFxmJkmSHqRPucsgZVet+/I1VI0/yMPWiGHVgotB/elDRd7hUu8
        zC8Wd99BViha4uget1kxu2E4inwKQoQhiKYdGlrtSni7dC5h6IbhxNF2HwwrkqQKJI3VCwMpmAGsO
        LjCCAphfIHUfYEfbgCnM2urKflJQH3BLfrvzrotxzofO46amJjSCS2+HMwbIzYMPb+UBQXtvNaJEr
        hQ7XEFJ1sPHmCj80uhqqoi6vY2vnDVi95u7ZUxrvYAEfTP2EqkCf4lvp3+BmFOm9+wqDcbCRzbwIN
        Bd2nuI8A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTMi-0006gs-F1; Fri, 03 Jul 2020 21:37:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 2/2] Documentation: locking: ww-mutex-design: drop duplicated word
Date:   Fri,  3 Jul 2020 14:36:49 -0700
Message-Id: <20200703213649.30948-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703213649.30948-1-rdunlap@infradead.org>
References: <20200703213649.30948-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "up".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
---
 Documentation/locking/ww-mutex-design.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/locking/ww-mutex-design.rst
+++ linux-next-20200701/Documentation/locking/ww-mutex-design.rst
@@ -49,7 +49,7 @@ However, the Wound-Wait algorithm is typ
 compared to Wait-Die, but is, on the other hand, associated with more work than
 Wait-Die when recovering from a backoff. Wound-Wait is also a preemptive
 algorithm in that transactions are wounded by other transactions, and that
-requires a reliable way to pick up up the wounded condition and preempt the
+requires a reliable way to pick up the wounded condition and preempt the
 running transaction. Note that this is not the same as process preemption. A
 Wound-Wait transaction is considered preempted when it dies (returning
 -EDEADLK) following a wound.
