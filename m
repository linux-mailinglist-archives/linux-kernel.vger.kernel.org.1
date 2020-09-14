Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE44E269594
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgINTWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgINTWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:22:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BD9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:22:04 -0700 (PDT)
Received: from zn.tnic (p200300ec2f09260089ebb5f4b84dd95c.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2600:89eb:b5f4:b84d:d95c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E31E1EC0593;
        Mon, 14 Sep 2020 21:22:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600111322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8jSEFTyJ+w6ij2V9TokmUN4inhCXKie+z9VF4m//R0w=;
        b=aZATmy0G8FAmk4SF5MlHub1oa8Ze29oUuaPascdcShxSfcRpoMNf/N0qFawp6lEmyk8oHE
        ELYTNbQOfMJitZlQLmtttM+/6MErfCq4vwsjmzmqeJhJZKgm9p2yiRi8JjFrtpbLVfPDy4
        XZS/3UHMdUm4nNi7wW37IBIYYJurQ2o=
Date:   Mon, 14 Sep 2020 21:21:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200914192156.GG680@zn.tnic>
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
 <20200914175604.GF680@zn.tnic>
 <CAPcyv4hqxs1zuXb5jkA-6Fm72Vu0ZDCfqeWJKSePM+zFyY9kzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4hqxs1zuXb5jkA-6Fm72Vu0ZDCfqeWJKSePM+zFyY9kzg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 11:48:55AM -0700, Dan Williams wrote:
> > Err, stupid question: can this macro then be folded into access_ok() so
> > that you don't have to touch so many places and the check can happen
> > automatically?
> 
> I think that ends up with more changes because it changes the flow of
> access_ok() from returning a boolean to returning a modified user
> address that can be used in the speculative path.

I mean something like the totally untested, only to show intent hunk
below? (It is late here so I could very well be missing an aspect):

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 2bffba2a1b23..c94e1589682c 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -7,6 +7,7 @@
 #include <linux/compiler.h>
 #include <linux/kasan-checks.h>
 #include <linux/string.h>
+#include <linux/nospec.h>
 #include <asm/asm.h>
 #include <asm/page.h>
 #include <asm/smap.h>
@@ -92,8 +93,15 @@ static inline bool pagefault_disabled(void);
  */
 #define access_ok(addr, size)					\
 ({									\
+	bool range;							\
+	typeof(addr) a = addr, b;					\
+									\
 	WARN_ON_IN_IRQ();						\
-	likely(!__range_not_ok(addr, size, user_addr_max()));		\
+									\
+	range = __range_not_ok(addr, size, user_addr_max());		\
+	b = (typeof(addr)) array_index_nospec((__force unsigned long)addr, TASK_SIZE_MAX); \
+									\
+	likely(!range && a == b);					\
 })
 
 /*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
