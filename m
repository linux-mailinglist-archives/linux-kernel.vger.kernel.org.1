Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DDA2B5370
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbgKPVH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbgKPVH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:07:58 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1742C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 13:07:57 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CZhVg2kqdz1rvxr;
        Mon, 16 Nov 2020 22:07:55 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CZhVg02dwz1rYF0;
        Mon, 16 Nov 2020 22:07:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id fzVamNsoxLEg; Mon, 16 Nov 2020 22:07:54 +0100 (CET)
X-Auth-Info: bp8e+kdtVtL91h44qqgpo7kA0xjy59gIX7r7DJ3PFXaeWTdW1mGEu1e00FV8Ua+m
Received: from igel.home (ppp-46-244-169-244.dynamic.mnet-online.de [46.244.169.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 16 Nov 2020 22:07:54 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 8F47B2C3398; Mon, 16 Nov 2020 22:07:53 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] compiler.h: Fix barrier_data() on clang
References: <20201014212631.207844-1-nivedita@alum.mit.edu>
        <87sg999ot0.fsf@igel.home>
        <CAKwvOdn8aOr0=22idJ_KetgJ_rhk5-7i29VvxofoLrRo138f_g@mail.gmail.com>
X-Yow:  I smell like a wet reducing clinic on Columbus Day!
Date:   Mon, 16 Nov 2020 22:07:53 +0100
In-Reply-To: <CAKwvOdn8aOr0=22idJ_KetgJ_rhk5-7i29VvxofoLrRo138f_g@mail.gmail.com>
        (Nick Desaulniers's message of "Mon, 16 Nov 2020 11:31:13 -0800")
Message-ID: <87d00d9fiu.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 16 2020, Nick Desaulniers wrote:

> A lot of VDSO's reset KBUILD_CFLAGS or use a new variable for their
> compiler flags.  As such, they're missing `-include` command line flag
> that injects include/linux/compiler_types.h,

It's not missing here.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
