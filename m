Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F372CE51C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgLDB0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbgLDB0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:26:35 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCAFC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 17:25:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CnFQQ5Mx0z9ryj;
        Fri,  4 Dec 2020 12:25:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1607045152;
        bh=4HSAD6xXrbFZYCa+s18rvCcwKjmHfdu4XDPdOyGqFaA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GhmVr/vSuHBo5JxGky6+aVTtxV0w9ifWUBzgvvZcO5or6uHnvAPyZBClp9NRWZNX0
         yYP8kLvJUJdm6HBCY+1yoVkgRLFIlk2df/yzxo75defNqGrLcQN/Q2mrHRRZN0W9FC
         o+z1Bi+ANIdMhAfu/mtlRGrAFVV8sYFFVxjf7GGbmbBGq/9fm63zDfsLhvD5xZyz2x
         50ZoSSraKIBzSxlt5/RUP3TV1Lltgqka67h+LNnoOLVjgMv8oEz2MnHs0GRYU7Corf
         bWV6MKEY3kmbpndKfcpUrffggudl+oyX5LvGONmGw/sBOawXd8d7oYLZkg9wd5BHcC
         ncE3qicoVA22w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARN_ON_ONCE
In-Reply-To: <CACT4Y+ZHH5DiDj7KvRKtPqkV1CS0TFOkCH-M5bitfCgd5PWotg@mail.gmail.com>
References: <87f443cf-26c0-6302-edee-556045bca18a@ozlabs.ru> <CACT4Y+ZAyhk6CuddQNix0fAupXhOpv1t3iOdcXbDh4VDEPyOJQ@mail.gmail.com> <CACT4Y+ZHH5DiDj7KvRKtPqkV1CS0TFOkCH-M5bitfCgd5PWotg@mail.gmail.com>
Date:   Fri, 04 Dec 2020 12:25:47 +1100
Message-ID: <87k0tyuztw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:
> On Thu, Dec 3, 2020 at 10:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Thu, Dec 3, 2020 at 10:10 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>> >
>> > Hi!
>> >
>> > Syzkaller triggered WARN_ON_ONCE at
>> >
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/tracepoint.c?h=v5.10-rc6#n266
>> >
>> >
>> > ===
>> > static int tracepoint_add_func(struct tracepoint *tp,
>> >                                struct tracepoint_func *func, int prio)
>> > {
>> >         struct tracepoint_func *old, *tp_funcs;
>> >         int ret;
>> >
>> >         if (tp->regfunc && !static_key_enabled(&tp->key)) {
>> >                 ret = tp->regfunc();
>> >                 if (ret < 0)
>> >                         return ret;
>> >         }
>> >
>> >         tp_funcs = rcu_dereference_protected(tp->funcs,
>> >                         lockdep_is_held(&tracepoints_mutex));
>> >         old = func_add(&tp_funcs, func, prio);
>> >         if (IS_ERR(old)) {
>> >                 WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
>> >                 return PTR_ERR(old);
>> >         }
>> >
>> > ===
>> >
>> > What is the common approach here? Syzkaller reacts on this as if it was
>> > a bug but WARN_ON_ONCE here seems intentional. Do we still push for
>> > removing such warnings?

AFAICS it is a bug if that fires.

See the commit that added it:
  d66a270be331 ("tracepoint: Do not warn on ENOMEM")

Which says:
  Tracepoint should only warn when a kernel API user does not respect the
  required preconditions (e.g. same tracepoint enabled twice, or called
  to remove a tracepoint that does not exist).
  
  Silence warning in out-of-memory conditions, given that the error is
  returned to the caller.


So if you're seeing it then you've someone caused it to return something
other than ENOMEM, and that is a bug.

cheers
