Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC132CFB7A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 14:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgLENvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 08:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgLENBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 08:01:11 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A177C061A53
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 04:05:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cp7Z76T88z9sWK;
        Sat,  5 Dec 2020 23:05:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1607169936;
        bh=qxSWvw0s6lkaoYf5IzmZatZNrCVE9O7Q9inFbS6Phd0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bd4W50rdpjHe8yuJ2FeL4yDpXNEZiTdW8FTwHNr4eOGeuNG6FWcctNoT+8TBqfspi
         JS6KsPy033TlwyzqML3pDHPi9i+26Cid303QItbC06SLfSid1X8ZGqjomzw4iJaBPZ
         BEYNF8hWv7CPAhSlN5YXudIH3VCpdXnHQx4vZj9eEFpDSbFD4gGaIOOOuljWu9hABM
         PNTI0emTnkBdKCuApbZlu0dq/T9X7uGH8ieftYdb65UcvhUWZBLsZb5hr2IkW0Kyrh
         Ud2NjkUUv0fNdgHUPskri/CoU1nqWJ/osVYfRDhNNqjx7TeaFVev9/xNn9CQTlqY2p
         K03/8bmA+LJYQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARN_ON_ONCE
In-Reply-To: <414bc088-9441-70c7-88e2-2c928b97db36@ozlabs.ru>
References: <87f443cf-26c0-6302-edee-556045bca18a@ozlabs.ru> <CACT4Y+ZAyhk6CuddQNix0fAupXhOpv1t3iOdcXbDh4VDEPyOJQ@mail.gmail.com> <CACT4Y+ZHH5DiDj7KvRKtPqkV1CS0TFOkCH-M5bitfCgd5PWotg@mail.gmail.com> <87k0tyuztw.fsf@mpe.ellerman.id.au> <414bc088-9441-70c7-88e2-2c928b97db36@ozlabs.ru>
Date:   Sat, 05 Dec 2020 23:05:31 +1100
Message-ID: <87o8j8tq44.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> On 04/12/2020 12:25, Michael Ellerman wrote:
>> Dmitry Vyukov <dvyukov@google.com> writes:
>>> On Thu, Dec 3, 2020 at 10:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>>> On Thu, Dec 3, 2020 at 10:10 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>
>>>>> Hi!
>>>>>
>>>>> Syzkaller triggered WARN_ON_ONCE at
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/tracepoint.c?h=v5.10-rc6#n266
>>>>>
>>>>>
>>>>> ===
>>>>> static int tracepoint_add_func(struct tracepoint *tp,
>>>>>                                 struct tracepoint_func *func, int prio)
>>>>> {
>>>>>          struct tracepoint_func *old, *tp_funcs;
>>>>>          int ret;
>>>>>
>>>>>          if (tp->regfunc && !static_key_enabled(&tp->key)) {
>>>>>                  ret = tp->regfunc();
>>>>>                  if (ret < 0)
>>>>>                          return ret;
>>>>>          }
>>>>>
>>>>>          tp_funcs = rcu_dereference_protected(tp->funcs,
>>>>>                          lockdep_is_held(&tracepoints_mutex));
>>>>>          old = func_add(&tp_funcs, func, prio);
>>>>>          if (IS_ERR(old)) {
>>>>>                  WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
>>>>>                  return PTR_ERR(old);
>>>>>          }
>>>>>
>>>>> ===
>>>>>
>>>>> What is the common approach here? Syzkaller reacts on this as if it was
>>>>> a bug but WARN_ON_ONCE here seems intentional. Do we still push for
>>>>> removing such warnings?
>> 
>> AFAICS it is a bug if that fires.
>> 
>> See the commit that added it:
>>    d66a270be331 ("tracepoint: Do not warn on ENOMEM")
>> 
>> Which says:
>>    Tracepoint should only warn when a kernel API user does not respect the
>>    required preconditions (e.g. same tracepoint enabled twice,
>
> This says that the userspace can trigger the warning if it does not use 
> the API right.

No I don't think it says that.

It's saying that it should be a WARN if a *kernel* user of the
tracepoint API violates the API. The implication is that this condition
should never happen if the kernel is using the tracepoint API correctly,
and so if we hit this condition it indicates a bug in the kernel that
should be fixed.

>> or called
>>    to remove a tracepoint that does not exist).
>>    
>>    Silence warning in out-of-memory conditions, given that the error is
>>    returned to the caller.
>> 
>> 
>> So if you're seeing it then you've someone caused it to return something
>> other than ENOMEM, and that is a bug.
>
> This is an userspace bug which registers the same thing twice, the 
> kernel returns a correct error. The question is should it warn by 
> WARN_ON or pr_err(). The comment in bug.h suggests pr_err() is the right 
> way, is not it?

Userspace must not be able to trigger a WARN.

What is the path into that code from userspace?

Either something on that path should be checking that it's not violating
the API and triggering the WARN, or if that's not possible/easy then the
WARN should be removed.

cheers
