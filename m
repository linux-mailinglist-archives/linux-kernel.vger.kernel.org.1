Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7002B29B2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 01:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgKNAPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 19:15:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56080 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgKNAPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:15:22 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605312920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vvG8CPWDFDqmJouW/M6yHgJapIxayz7eh5nBkFkA8c4=;
        b=ebNgHyUYFUywCVBAfdi++u8Ip16c7TQ9MSsfGTD4OlyGab5Wp8TcHffNuRvLBKpQnCEbVu
        ENaN6kWv0mCxTmczlC+pE0T0CO+X1omwqcg3DLK30fmk68Udkcn6obYiB1L4DS6JZFDe5I
        Kqu8dKySdovmHKIhc1ZR3gVU3Cxrf/tjm++RLRW++cCQ0AeEa39U45PbPBFwQ77RyNYwOO
        44MZsiJdYycw8F6xrw0jlVu+vD30hymv8lEs/VqktLA3qN2o/Rt70FHMI8wSATqzsNHdE2
        h7yPvNRwV3Jh1CopYfCSJhq4FFPVzp6WUJ46c8e9/MM6TPn9hL/MQZQCbmtNkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605312920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vvG8CPWDFDqmJouW/M6yHgJapIxayz7eh5nBkFkA8c4=;
        b=KkzSDYyz98uOLLLLOjGhIEocYgIkFVPnE9Dq9uFXryq+tUkoINGEmiTW5c9q3YpCuPzhym
        24Az12AKesLJT8DQ==
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Darren Hart <dvhart@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] futex: remove unused empty compat_exit_robust_list()
In-Reply-To: <20201113172012.27221-1-lukas.bulwahn@gmail.com>
References: <20201113172012.27221-1-lukas.bulwahn@gmail.com>
Date:   Sat, 14 Nov 2020 01:15:20 +0100
Message-ID: <87ima8bxpj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas,

On Fri, Nov 13 2020 at 18:20, Lukas Bulwahn wrote:
> Commit ba31c1a48538 ("futex: Move futex exit handling into futex code")
> introduced compat_exit_robust_list() with a full-fledged implementation for
> CONFIG_COMPAT, and an empty-body function for !CONFIG_COMPAT.
> However, compat_exit_robust_list() is only used in futex_mm_release() under
> ifdef CONFIG_COMPAT.
>
> Hence for !CONFIG_COMPAT, make CC=clang W=1 warns:
>
>   kernel/futex.c:314:20:
>     warning: unused function 'compat_exit_robust_list' [-Wunused-function]
>
> There is no need to declare the unused empty function for !CONFIG_COMPAT.
> Simply, remove it to address the -Wunused-function warning.

While I agree with the removal, I disagree with the reasoning.

The real argument is that the stub function is useless. Addressing the
warning is a side effect of the removal, nothing else.

Thanks,

        tglx
