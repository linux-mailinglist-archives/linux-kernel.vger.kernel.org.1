Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D284C2CA4E2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391484AbgLAODr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388491AbgLAODr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:03:47 -0500
Received: from coco.lan (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34329206A5;
        Tue,  1 Dec 2020 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831386;
        bh=fN4NSS/2Z3e5ZDp6dT8LOOMaJ+kpvmyC/239xA9Oq1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kePb5KVkqAS71FlmuATQK/WwMBod77n2IDiESe9VYDlwQ+Kk93lNPKZQz2HE8e8c6
         FR0RJ4TJ0O2+VouNrgju7q5qrgPW4wnqZRDRKoO82YMXWwVi0kBAsfooq4x1lSTJPV
         dSik+VGazyEbU0EjntWoaFbiK45G1/El4qfxOn9I=
Date:   Tue, 1 Dec 2020 15:03:01 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/16] completion: drop init_completion define
Message-ID: <20201201150249.56132775@coco.lan>
In-Reply-To: <20201201125445.GW2414@hirez.programming.kicks-ass.net>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
        <e657bfc533545c185b1c3c55926a449ead56a88b.1606823973.git.mchehab+huawei@kernel.org>
        <20201201125445.GW2414@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 1 Dec 2020 13:54:45 +0100
Peter Zijlstra <peterz@infradead.org> escreveu:

> On Tue, Dec 01, 2020 at 01:09:00PM +0100, Mauro Carvalho Chehab wrote:
> > Changeset cd8084f91c02 ("locking/lockdep: Apply crossrelease to completions")
> > added a CONFIG_LOCKDEP_COMPLETE (that was later renamed to
> > CONFIG_LOCKDEP_COMPLETIONS).
> > 
> > Such changeset renamed the init_completion, and add a macro
> > that would either run a modified version or the original code.
> > 
> > However, such code reported too many false positives. So, it
> > ended being dropped later on by
> > changeset e966eaeeb623 ("locking/lockdep: Remove the cross-release locking checks").
> > 
> > Yet, the define remained there as just:
> > 
> > 	 #define init_completion(x) __init_completion(x)
> > 
> > Get rid of the define, and return __init_completion() function
> > to its original name.
> > 
> > Fixes: e966eaeeb623 ("locking/lockdep: Remove the cross-release locking checks")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---  
> 
> Your patch is weird, did you add -C 1000 or something?

Per a past review request, I used -U32 on this particular series, in order
to be able to display the function name and the kernel-doc markup at
the same time.

I'm enclosing the patch with -U3.

Thanks,
Mauro

[PATCH] completion: drop init_completion define

Changeset cd8084f91c02 ("locking/lockdep: Apply crossrelease to completions")
added a CONFIG_LOCKDEP_COMPLETE (that was later renamed to
CONFIG_LOCKDEP_COMPLETIONS).

Such changeset renamed the init_completion, and add a macro
that would either run a modified version or the original code.

However, such code reported too many false positives. So, it
ended being dropped later on by
changeset e966eaeeb623 ("locking/lockdep: Remove the cross-release locking checks").

Yet, the define remained there as just:

	 #define init_completion(x) __init_completion(x)

Get rid of the define, and return __init_completion() function
to its original name.

Fixes: e966eaeeb623 ("locking/lockdep: Remove the cross-release locking checks")

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bf8e77001f18..51d9ab079629 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -28,8 +28,7 @@ struct completion {
 	struct swait_queue_head wait;
 };
 
-#define init_completion_map(x, m) __init_completion(x)
-#define init_completion(x) __init_completion(x)
+#define init_completion_map(x, m) init_completion(x)
 static inline void complete_acquire(struct completion *x) {}
 static inline void complete_release(struct completion *x) {}
 
@@ -82,7 +81,7 @@ static inline void complete_release(struct completion *x) {}
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void __init_completion(struct completion *x)
+static inline void init_completion(struct completion *x)
 {
 	x->done = 0;
 	init_swait_queue_head(&x->wait);

