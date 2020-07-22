Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0322A2D4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgGVXIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 19:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVXIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:08:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8538DC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:08:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595459322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WyEi4r6pHlCnjds15Evf4SyPGIdz2gkscTmxlZ56a7c=;
        b=0VIdlQaYmuU15xJKR2Vpu8IZRz4nGtHhg8vfaQlvdhVSw+gcedvuz9juuJ2Mfcgx7trj4X
        kbQwll7FYVjPNFGijxlpSc2RiWrM4y6VSLSVMhdp7sD1aW1N3q6cRap0AaNBEEkj3N9WCs
        tl34aWpmmKv7kaVT5q7SpQdjRRbDvKOxMQt8TC2TYTbwo8v+GLGu3FhGn23e+oJEPUeFb4
        atu/+nq4gdgQ3zkiR+l+HVGP/Gd4rLOVZNbFZ+EhSkW6xWMuda+VVKryw/PVrEyn06hHhN
        zORjEhukzQw/gufdOpxK5k9zEad0IWjYw83raD4ZyNd4HGDhfLtpGPeg9oISjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595459322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WyEi4r6pHlCnjds15Evf4SyPGIdz2gkscTmxlZ56a7c=;
        b=2PJLzQX5a1QOkaKYxq4l13cl5Zpw5jHy6laMnbmQ2JW1XUOLxYwXKK1aNkm9iQpfwwWxzB
        fIy/OIU1EhYvkkBw==
To:     Dennis Zhou <dennis@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 00/11] i386 Clang support
In-Reply-To: <20200721222754.GA820494@google.com>
References: <20200720204925.3654302-1-ndesaulniers@google.com> <20200721222754.GA820494@google.com>
Date:   Thu, 23 Jul 2020 01:08:42 +0200
Message-ID: <87blk7ywp1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dennis Zhou <dennis@kernel.org> writes:
> On Mon, Jul 20, 2020 at 01:49:14PM -0700, Nick Desaulniers wrote:
>> Resend of Brian's v2 with Acks from Peter and Linus collected, as well
>> as the final patch (mine) added. The commit of the final patch discusses
>> some of the architectural differences between GCC and Clang, and the
>> kernels tickling of this difference for i386, which necessitated these
>> patches.
>> 
>> Brian Gerst (10):
>>   x86/percpu: Introduce size abstraction macros
>>   x86/percpu: Clean up percpu_to_op()
>>   x86/percpu: Clean up percpu_from_op()
>>   x86/percpu: Clean up percpu_add_op()
>>   x86/percpu: Remove "e" constraint from XADD
>>   x86/percpu: Clean up percpu_add_return_op()
>>   x86/percpu: Clean up percpu_xchg_op()
>>   x86/percpu: Clean up percpu_cmpxchg_op()
>>   x86/percpu: Clean up percpu_stable_op()
>>   x86/percpu: Remove unused PER_CPU() macro
>> 
>> Nick Desaulniers (1):
>>   x86: support i386 with Clang
>> 
>>  arch/x86/include/asm/percpu.h  | 510 +++++++++++----------------------
>>  arch/x86/include/asm/uaccess.h |   4 +-
>>  2 files changed, 175 insertions(+), 339 deletions(-)
>> 
>> -- 
>> 2.28.0.rc0.105.gf9edc3c819-goog
>> 
>
> This looks great to me! I applied it to for-5.9.

You applied it? I'm not aware that you're maintaining x86 nowadays.

Thanks,

        tglx
