Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A612A911C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgKFISo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgKFISn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:18:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C507C0613CF;
        Fri,  6 Nov 2020 00:18:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604650719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QGCORwOg18faQgRDXRDoAOZ5EtYvujQ10ImekmNwcQs=;
        b=yhXy6gcGmWFYE01h4/TKk+zrZMwg42xeYL5EUEXrb/RFZqSPqPEU3d8FmcRj2+pfwXGvFj
        z8y+me8VUStg/owSsrgKg8p8UcnFt5DyjSWcw9GevRo3g1tS23PSqYYVqrzsGEOZEbqBpd
        RrlWTfFz/pZA60DTh4d4NGZ6t3P5v8b6cISt3xSTj4/YFU3aBd8QwCAwBQvpSneS5nKp4A
        bvZCmb6ZS/Rbynvd9f2zQ7RmG6J5Ni2Uf+LN08BM6J0OQ2RZWA3TfcjmQdD1PE+q2QJNcl
        BNfBbe5e04PD3Eso/jQay04n7Lz/8HzluPHNAVJBQE7samIBwTHasHdvKEq0pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604650719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QGCORwOg18faQgRDXRDoAOZ5EtYvujQ10ImekmNwcQs=;
        b=U8exzy41HYahMJICgu/66bCwCM/tiCv6nQvZZF+FdfyNJz3NGeeThwe7sRCmcxB07M0B4y
        jR82KoHtmLvI1EDA==
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] printk: remove unneeded dead-store assignment
In-Reply-To: <20201106034005.18822-1-lukas.bulwahn@gmail.com>
References: <20201106034005.18822-1-lukas.bulwahn@gmail.com>
Date:   Fri, 06 Nov 2020 09:24:38 +0106
Message-ID: <87h7q2j3tt.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-06, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> make clang-analyzer on x86_64 defconfig caught my attention with:
>
>   kernel/printk/printk_ringbuffer.c:885:3: warning:
>   Value stored to 'desc' is never read [clang-analyzer-deadcode.DeadStores]
>                 desc = to_desc(desc_ring, head_id);
>                 ^
>
> Commit b6cf8b3f3312 ("printk: add lockless ringbuffer") introduced
> desc_reserve() with this unneeded dead-store assignment.
>
> As discussed with John Ogness privately, this is probably just some minor
> left-over from previous iterations of the ringbuffer implementation. So,
> simply remove this unneeded dead assignment to make clang-analyzer happy.
>
> As compilers will detect this unneeded assignment and optimize this anyway,
> the resulting object code is identical before and after this change.
>
> No functional change. No change to object code.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
