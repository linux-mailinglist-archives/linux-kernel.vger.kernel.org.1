Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BCF2F5F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbhANLA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbhANLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:00:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C58C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DIj4I4aRg2hxrhAvA7PTugIJcF97MBBWwvgR9lnTVHU=; b=VaZsinXlRVA1TNv8E5c2IUIldB
        7IEd37sBl7J75xudE3XfnOfE1/XyIEwG9m1+9uYwo7Vj+UfDqztV28dZNdMRPBKHx3h92uzr/36+b
        1+W5Hhca1Q5p5NO+4A5sMgu//NZ5BvaMrWy1mfdcZKdtu7EOhWMZ+4dBWz5TA8NjG9MxVGybM9Y9i
        XXFR40oShM6IWMgTTbJb2JeaY2ovavuFhVwdI89t/fPbQeZtd7zpohKSSz6Jb8vqOPkdZa3bZLVIr
        KDz9SA3TsHMwy3/BAqpvSqEHT2S4Xev0VOLPUbXi3FXwAVrlQqFyRYjgUz/G6CFYb2+tkJfBRVlCX
        Jd4CQYqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l00LI-007TBg-Cd; Thu, 14 Jan 2021 10:59:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BCD7030015A;
        Thu, 14 Jan 2021 11:59:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE2BE200D400D; Thu, 14 Jan 2021 11:59:01 +0100 (CET)
Date:   Thu, 14 Jan 2021 11:59:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        aryabinin@virtuozzo.com, dvyukov@google.com, keescook@chromium.org
Subject: [PATCH] ubsan: Require GCC-8+ or Clang to use UBSAN
Message-ID: <YAAj9aAcPsV9I6UL@hirez.programming.kicks-ass.net>
References: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
 <20210104151317.GR3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104151317.GR3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 04:13:17PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 22, 2020 at 11:04:54PM -0600, Josh Poimboeuf wrote:
> > GCC 7 has a known bug where UBSAN ignores '-fwrapv' and generates false
> > signed-overflow-UB warnings.  The type mismatch between 'i' and
> > 'nr_segs' in copy_compat_iovec_from_user() is causing such a warning,
> > which also happens to violate uaccess rules:
> > 
> >   lib/iov_iter.o: warning: objtool: iovec_from_user()+0x22d: call to __ubsan_handle_add_overflow() with UACCESS enabled
> > 
> > Fix it by making the variable types match.
> > 
> > This is similar to a previous commit:
> > 
> >   29da93fea3ea ("mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions")
> 
> Maybe it's time we make UBSAN builds depend on GCC-8+ ?

---
Subject: ubsan: Require GCC-8+ or Clang to use UBSAN

Just like how we require GCC-8.2 for KASAN due to compiler bugs, require
a sane version of GCC for UBSAN.

Specifically, before GCC-8 UBSAN doesn't respect -fwrapv and thinks
signed arithmetic is buggered.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/Kconfig.ubsan | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 8b635fd75fe4..acc3df62460e 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -2,8 +2,13 @@
 config ARCH_HAS_UBSAN_SANITIZE_ALL
 	bool
 
+# UBSAN prior to GCC-8 gets -fwrapv wrong, we rely on that
+config UBSAN_SANE
+	def_bool !CC_IS_GCC || GCC_VERSION >= 80000
+
 menuconfig UBSAN
 	bool "Undefined behaviour sanity checker"
+	depends on UBSAN_SANE
 	help
 	  This option enables the Undefined Behaviour sanity checker.
 	  Compile-time instrumentation is used to detect various undefined
