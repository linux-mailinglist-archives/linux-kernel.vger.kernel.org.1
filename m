Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871A924EB17
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 06:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgHWEE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 00:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHWEE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 00:04:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3B3C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 21:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=arOcApfWNuK5HC87NZ1RQDuq8GY2apZtFKRCTPcWn1g=; b=H3BXkt4EpiqxehbqLY+GUZsd7H
        RA4hTD4z1+SVAdBg/cHoW9phWO7S4umAHMw9JE1+BNmcaynPp1fUoO6l+pEpd8RtGrRyMWMRnADgT
        K9fRMhQyP+Z0f1IvmOieuZ7s1OOG4nFrWhiFi9yP5nP3+a9KhYz0dbwZ90SVtOFAtef3z4b0UXQZn
        CwsqZDDMzLbszTjcohDm1Iw4WtPKR56busCjHm5kJWkDbkSWDMWnbb1KyegkqRqRZ6/aMFOqyk85f
        ju/W46FxZYdiAykGo2MpJOtzxLID5OJJ7RoGCGcMMmO/73raVeLxJWScP47/2IctgmXEpJxmIxb4Z
        79hhgTWQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9hFV-0004pb-ML; Sun, 23 Aug 2020 04:04:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] lib: dynamic_queue_limits: delete duplicated words + fix typo
Date:   Sat, 22 Aug 2020 21:04:49 -0700
Message-Id: <20200823040449.25946-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the".
Fix spelling of "excess".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 lib/dynamic_queue_limits.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200730.orig/lib/dynamic_queue_limits.c
+++ linux-next-20200730/lib/dynamic_queue_limits.c
@@ -60,8 +60,8 @@ void dql_completed(struct dql *dql, unsi
 		 * A decrease is only considered if the queue has been busy in
 		 * the whole interval (the check above).
 		 *
-		 * If there is slack, the amount of execess data queued above
-		 * the the amount needed to prevent starvation, the queue limit
+		 * If there is slack, the amount of excess data queued above
+		 * the amount needed to prevent starvation, the queue limit
 		 * can be decreased.  To avoid hysteresis we consider the
 		 * minimum amount of slack found over several iterations of the
 		 * completion routine.
