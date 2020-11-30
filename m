Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAE72C8F25
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgK3U2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:28:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62689 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgK3U2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:28:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C2BE97546;
        Mon, 30 Nov 2020 15:27:22 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=4UF4bH+bC1D+wSV00NU6P7r/a8k=; b=tIYZEf
        ERiRjvhpXPUlN+moKYFNMId1d6FbAO7Ap2U19oN6YpxEGSqBmQzajSv/IGUTvwQo
        A48EQz4XNpf+ZE8RoeFPcJng7TjjUtE6pEnhK2mXwAnjV9oOITyet4jrxKRMUePs
        Z9kn9tT+HvmpkCbEpJdnU9AOY/Y5wLnlaZU/g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F286C97544;
        Mon, 30 Nov 2020 15:27:21 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=WVu9/gmyv9KrvhY427JjOfrA+XHu7RboIqnSgXfUVos=; b=hPR4SYoTMcQfd+mANvYOSLMGe5bTckKACF6SmSmBF96FBcbA0seoHk7NCwO5g82Y1f3Fj70lUBp9NCU7T9CJ2NJwbfUN7uowkOfIbCUrkgwvEFr5MAY0PwhjzeMyapiNKYGJvLxOhTYe8JCRFKDUXIpXB3TKej8W+Q3gw5cbD38=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59FA297543;
        Mon, 30 Nov 2020 15:27:21 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 569602DA09EC;
        Mon, 30 Nov 2020 15:27:20 -0500 (EST)
Date:   Mon, 30 Nov 2020 15:27:20 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     Ard Biesheuvel <ardb@kernel.org>, Antony Yu <swpenim@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] __div64_32(): straighten up inline asm constraints
In-Reply-To: <CAKwvOdn1nCx354hkb15wBDH12aJgbObqPxa_neX5m71axaKRUw@mail.gmail.com>
Message-ID: <44638q0-o866-2o6o-qsp2-q1q528o7o5s9@syhkavp.arg>
References: <pr6q9q72-6n62-236q-s59n-7osq71o285r9@syhkavp.arg> <CAKwvOdn1nCx354hkb15wBDH12aJgbObqPxa_neX5m71axaKRUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 72F09B28-334A-11EB-B458-D152C8D8090B-78420484!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020, Nick Desaulniers wrote:

> On Mon, Nov 30, 2020 at 11:05 AM Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > +       __rem = __n >> 32;
> >         *n = __res;
> >         return __rem;
> 
> The above 3 statement could be:
> 
> ```
> *n = __res;
> return __n >> 32;
> ```

They could. However the compiler doesn't care, and the extra line makes 
it more obvious that the reminder is the high part of __n. So, 
semantically the extra line has value.

Thanks for the review.


Nicolas
