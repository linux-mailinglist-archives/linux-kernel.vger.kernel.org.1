Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B86224E66
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 02:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGSAae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 20:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSAae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:30:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169E1C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XNsAC5CGSK2EfiNfkev/gW722QSz1f0snJkwXcwd4oI=; b=ETIP6xmH9/GxYTlQ/KOJy/6g+x
        Sp6D+OLPCNSiX9Bocwz5wF/o5CU8RVXePt6mgLIuPZY+Lv9QKMtALIV0JI/B4SdWSvobMot/G/DIX
        5OXzXZmf1v+37+M+Hr2S5o9bf2EG2+/vDTGaSCQlmYHitWeoDMtMQ6gGyO215lpb3+WQaZZTnEhQf
        0FiXLFgxGy5kDgKKYYksL+MCGbV6piwpXkVFCZ0q4DoFx7daVxk17izOOjXHb5MQnhpjXDaLLbzc8
        z+9E+U/WuwfPd9WCN3EUmysenMrJ5VUwniBudh+zbuDfi0XH8cDEhVBP85D0/PV/bWMfPFpea06TE
        QUeycwpg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxDr-0002ol-6G; Sun, 19 Jul 2020 00:30:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH] perf: <linux/perf_event.h>: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:30:27 -0700
Message-Id: <20200719003027.20798-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 include/linux/perf_event.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/perf_event.h
+++ linux-next-20200717/include/linux/perf_event.h
@@ -366,7 +366,7 @@ struct pmu {
 	 * ->stop() with PERF_EF_UPDATE will read the counter and update
 	 *  period/count values like ->read() would.
 	 *
-	 * ->start() with PERF_EF_RELOAD will reprogram the the counter
+	 * ->start() with PERF_EF_RELOAD will reprogram the counter
 	 *  value, must be preceded by a ->stop() with PERF_EF_UPDATE.
 	 */
 	void (*start)			(struct perf_event *event, int flags);
