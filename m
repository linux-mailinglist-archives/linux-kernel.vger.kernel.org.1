Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924EE280EFF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbgJBIcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:32:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJBIcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:32:35 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601627553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HsKbNhW6JyOvMMjFKexiqV08EYNocTJhCoLVMa7DgIE=;
        b=KCmB2Loiww0GOii8DG3gVpmEbZxkBaZOQ02wfIOW6A1jwM9e9rQbFiA2yQyuXVE0GyIxkR
        Q8jz/AhOnUEHFn73X885O9pwKXCyy9gsEUY6z2WdFQaf2SfM39N7KgIB7M6TYxAPLVlE+K
        9KAhyaSu9bBHEqBKUDWfQyZHONVqRO0mxtDFR82jTaV8E1vz/f1H0GoibZdGfoVh+Lzz1i
        DV16j1QC+8Aa4dWJ7BpAT/3o5y1DIcSlsQoSBbK8pv0khmNTcccYFu7UHD6xjnlN3cL4dR
        1YMUqaENl1gHfxcuSsZoZJLUzPusDtYXhtzavYRu9HsDwShAWuBRN4/XjIZcpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601627553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HsKbNhW6JyOvMMjFKexiqV08EYNocTJhCoLVMa7DgIE=;
        b=JGKS+1g+uj2Yxl07TKYt8CCkuIJjovYPDzqG1I8oSy2opzXLr6TwMk5/O8vrAS+TEu/dqm
        6bsqbF/+pMJAgjBg==
To:     Hillf Danton <hdanton@sina.com>
Cc:     Hillf Danton <hdanton@sina.com>, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        akpm@linux-foundation.org, Peter Zijlstra <peterz@infradead.org>,
        Zqiang <qiang.zhang@windriver.com>
Subject: Re: [RFC PATCH] kthread: do not modify running work
In-Reply-To: <20201002023412.2276-1-hdanton@sina.com>
References: <20200926040426.11936-1-hdanton@sina.com> <20201001095151.5640-1-hdanton@sina.com> <20201002023412.2276-1-hdanton@sina.com>
Date:   Fri, 02 Oct 2020 10:32:32 +0200
Message-ID: <877ds9do4f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02 2020 at 10:34, Hillf Danton wrote:
> On Thu, 01 Oct 2020 15:59:38 +0200 Thomas Gleixner wrote:
>> On Thu, Oct 01 2020 at 17:51, Hillf Danton wrote:
>> Aside of that it's pretty irrelevant whether there is a user at the
>> moment which reschedules work from the callback or not.
>> 
>> It's something which needs to work because its possible from regular
>> work queues as well and makes a lot of sense.
>
> https://lore.kernel.org/lkml/87eemheay8.fsf@nanos.tec.linutronix.de/

That's a completely different thing, really. This adds new functionality
without users and exports it.

kthread work is modeled after workqueue to address specific
needs. delayed work can be rescheduled from the callback and all
variants of timers support rearming the timer from the callback as well.

So having a consistent behaviour accross all these facilities makes
absolutely sense and I don't agree with your sentiment in the changelog
at all.

Just because it does not make sense to you is not a justification for
making stuff inconsistent. You still have not provided a technical
reason why this change is needed.

Thanks,

        tglx

