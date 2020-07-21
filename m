Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A1D228503
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 18:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgGUQLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 12:11:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41466 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgGUQK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:10:59 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595347857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M/KAUo+uAjWl+Ba5IjjGVnrTcFQJlY6tDNdMp29EqOI=;
        b=aRw2ALnFru0qOh3a8FxPYzhVUAakvk1OO+HNFnA9PYXdK6JA3CaajJOmtW4+tXjuk3iy4X
        Ob1SoCTFE4n3cev82ds7Z9hCDVQerrpBXykV3hBlZdqfRd14fspjAUoRMMbvGPiqaEV9B7
        3MxXIRMRPs3HHmT0H4OVc/rwkjX5rkK2Ant7xKXlPMMUHb6HJ3zIqUhWP15po7DFSPobX+
        D9cLp2npVkPd3iY3LRMRO74j+83Mf3oTckeOe9Ap14cbBalb1zhDoWGd+CjdGOizo1WoYZ
        VROeVcHXneLKqhud8o0IOyVoN1Hx8sSKYbJeWv6eMbaZ+ctAyxbfVeP+vHZjnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595347857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M/KAUo+uAjWl+Ba5IjjGVnrTcFQJlY6tDNdMp29EqOI=;
        b=/0DT7ZMf4UKIjWKCIwCWFehA2PV7BKQEZE+O3lbmL9YHliYl7w7vfIHmwXPVqqfzU/lSz7
        ptzsXKXMOxcCYGBA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 2/5] posix-cpu-timers: Convert the flags to a bitmap
In-Reply-To: <20200721123452.GA9290@lenoir>
References: <20200716201923.228696399@linutronix.de> <20200716202044.625081169@linutronix.de> <20200721123452.GA9290@lenoir>
Date:   Tue, 21 Jul 2020 18:10:56 +0200
Message-ID: <874kq04zn3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:
> On Thu, Jul 16, 2020 at 10:19:25PM +0200, Thomas Gleixner wrote:
>> --- a/kernel/time/posix-cpu-timers.c
>> +++ b/kernel/time/posix-cpu-timers.c
>> @@ -25,7 +25,7 @@ void posix_cputimers_group_init(struct p
>>  	posix_cputimers_init(pct);
>>  	if (cpu_limit != RLIM_INFINITY) {
>>  		pct->bases[CPUCLOCK_PROF].nextevt = cpu_limit * NSEC_PER_SEC;
>> -		pct->timers_active = true;
>> +		set_bit(CPUTIMERS_ACTIVE, &pct->flags);
>
> I guess this one could be __set_bit().

True :)
