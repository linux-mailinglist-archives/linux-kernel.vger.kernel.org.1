Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290C71EC105
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgFBRew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 13:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:34:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9C6C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=wZRor1BzB1/H6lezWifVNSHYwmu48K5Pc1GZOtnXb+s=; b=bFaio31lmBvjvk8ROR9ZRifMOA
        vXdmeReEDP8jvcNul3RuRTZUE0FXxJhF132kRjX1QMqB1dqWtevn1Q/un9hHOc284wZp8PUFCmWJk
        JHixC5FHEC8H/Ji0CCJddntFrXek2XUN3HhkDLGhydQGW69/NGQMep0sjOSOG5d3OFcC5TL5riHUx
        3YmVc22fBmAlwO/66IN4XryENkUhkVSMF+sVTo7A2UMhfhNPV1g/GabYkcERNSPZIq46XOFUN0lMX
        PmX9JSDEmLh8E/qvKFJ4N84FBx6IM6OMgKd19nvM/aQSzGCAGijR3hvXAsd7kqqYBCy8JxBGfvBfe
        anhcBphA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgAoC-0007Ar-7V; Tue, 02 Jun 2020 17:34:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 331C03035D4;
        Tue,  2 Jun 2020 19:34:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 07D64201E996A; Tue,  2 Jun 2020 19:34:38 +0200 (CEST)
Message-ID: <20200602173348.401295331@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 02 Jun 2020 19:31:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: [PATCH 2/3] kcsan: Remove __no_kcsan_or_inline
References: <20200602173103.931412766@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more user of this function attribute, also, with us now
actively supporting '__no_kcsan inline' it doesn't make sense to have
in any case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/dev-tools/kcsan.rst |    6 ------
 include/linux/compiler_types.h    |    5 +----
 2 files changed, 1 insertion(+), 10 deletions(-)

--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -114,12 +114,6 @@ functions, compilation units, or entire
   To dynamically limit for which functions to generate reports, see the
   `DebugFS interface`_ blacklist/whitelist feature.
 
-  For ``__always_inline`` functions, replace ``__always_inline`` with
-  ``__no_kcsan_or_inline`` (which implies ``__always_inline``)::
-
-    static __no_kcsan_or_inline void foo(void) {
-        ...
-
 * To disable data race detection for a particular compilation unit, add to the
   ``Makefile``::
 
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -193,10 +193,7 @@ struct ftrace_likely_data {
 
 #define __no_kcsan __no_sanitize_thread
 #ifdef __SANITIZE_THREAD__
-# define __no_kcsan_or_inline __no_kcsan notrace __maybe_unused
-# define __no_sanitize_or_inline __no_kcsan_or_inline
-#else
-# define __no_kcsan_or_inline __always_inline
+# define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
 #endif
 
 #ifndef __no_sanitize_or_inline


