Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59546269716
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgINUwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgINUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:51:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F2EC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:51:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600116716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aDiPSzZTn9VZOgWHTza0B6Xq/ARyn+pdBM1nVtKC6oU=;
        b=32A5zbE18lOTSAlbzsrHu7jkmGQbH0a/kGsnBli5tZQ9xlnz9kvE5EjBkd0SNa9M1Ke6Lk
        c/ZGk2IK8T+Pnl7tLnOP4zCtjiOAlRiEL6mBO9ixx7fm5VjafED9vAZnjITWxxrjD5ONLP
        +3aryQVETV9Dph2wXKa88xhaF9/zBVkz8n41CxiSVQKMQ3bX1ByFL09l7hYOIR/T79IqQF
        a6uNJ7UC7rjtLjtpzXyCb+6rHxyMa1UkO01G8iuIJ9qhH+TzXzW9HNUSDVoNTrqViPWcNf
        zb6KspRL1eXMYCJdyxecIkbskkhb0U/q7Ad4RwG6b/57ZF963yWh7vGraiYs/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600116716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aDiPSzZTn9VZOgWHTza0B6Xq/ARyn+pdBM1nVtKC6oU=;
        b=lS+dygw7Bu6tTKSgjeG33hsJOu7VPkl8naz4rp9u58R8+gDAWipqZH7fXcv3wuW3UOS9Hf
        UiWeuPAIFCadLlAQ==
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess speculation
In-Reply-To: <20200914195354.yghlqlwtqz7mqteb@treble>
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com> <20200914195354.yghlqlwtqz7mqteb@treble>
Date:   Mon, 14 Sep 2020 22:51:56 +0200
Message-ID: <877dswozdf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14 2020 at 14:53, Josh Poimboeuf wrote:
> Al,
>
> This depends on Christoph's set_fs() removal patches.  Would you be
> willing to take this in your tree?

Ack.

> On Thu, Sep 10, 2020 at 12:22:53PM -0500, Josh Poimboeuf wrote:
>> The x86 uaccess code uses barrier_nospec() in various places to prevent
>> speculative dereferencing of user-controlled pointers (which might be
>> combined with further gadgets or CPU bugs to leak data).
>> 
>> There are some issues with the current implementation:
>> 
>> - The barrier_nospec() in copy_from_user() was inadvertently removed
>>   with: 4b842e4e25b1 ("x86: get rid of small constant size cases in
>>   raw_copy_{to,from}_user()")
>> 
>> - copy_to_user() and friends should also have a speculation barrier,
>>   because a speculative write to a user-controlled address can still
>>   populate the cache line with the original data.
>> 
>> - The LFENCE in barrier_nospec() is overkill, when more lightweight user
>>   pointer masking can be used instead.
>> 
>> Remove all existing barrier_nospec() usage, and instead do user pointer
>> masking, throughout the x86 uaccess code.  This is similar to what arm64
>> is already doing with uaccess_mask_ptr().
>> 
>> barrier_nospec() is now unused, and can be removed.
>> 
>> Fixes: 4b842e4e25b1 ("x86: get rid of small constant size cases in raw_copy_{to,from}_user()")
>> Suggested-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
