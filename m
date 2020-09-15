Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC9269AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgIOBTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgIOBTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:19:18 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30DEC06174A;
        Mon, 14 Sep 2020 18:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:Cc:From:References:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=v9FWm4hfn+Gl7QRXgXNxLaYsXltVQy8MIpwN6KsfkPU=; b=APwmWzHow9lj1CoVKgq9lWkz3L
        z9nA9PnAK5TNUuzh8Q1nmMyi/UFC6SABsKF2E/vx8KGzRhMlrpf4qVpcUMcOd1OSB6A1ArPj0D6hm
        LPy8MurFW8NUL36E7pPIWZRuATJhJJjakeE9JdwRWHQbP8rSdPZ0UDOI9xfjom/+3diDYuPxhvfiZ
        rxjZWzJCu1FBt4cNgg6QXNRh7aE75dmJgv1mLOQc5C9+gkHiAKzE59RH63BnHgRDeAPoxorOlsQtO
        lqzVIpL2w4FasBymgzaxO05jqJjbE3zzzVgPxeElT66cfvdGZL36wYZ/AGGyrgtfSbHB/77L9H+ul
        HcMKMEuA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHzcW-0002kl-V7; Tue, 15 Sep 2020 01:18:57 +0000
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <git-mailbomb-linux-master-50145474f6ef4a9c19205b173da6264a644c7489@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yuan Ming <yuanmingbuaa@gmail.com>, Willy Tarreau <w@1wt.eu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        NopNop Nop <nopitydays@gmail.com>,
        =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        Andy Lutomirski <luto@amacapital.net>
Message-ID: <c9cd22ec-60dc-d761-b488-d3a1392708c0@infradead.org>
Date:   Mon, 14 Sep 2020 18:18:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <git-mailbomb-linux-master-50145474f6ef4a9c19205b173da6264a644c7489@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI--

On 9/14/20 3:48 PM, Linux Kernel Mailing List wrote:
> Commit:     50145474f6ef4a9c19205b173da6264a644c7489
> Parent:     856deb866d16e29bd65952e0289066f6078af773
> Refname:    refs/heads/master
> Web:        https://git.kernel.org/torvalds/c/50145474f6ef4a9c19205b173da6264a644c7489
> Author:     Linus Torvalds <torvalds@linux-foundation.org>
> AuthorDate: Mon Sep 7 11:45:27 2020 -0700
> Committer:  Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Mon Sep 14 10:06:15 2020 -0700
> 
>     fbcon: remove soft scrollback code
>     
>     This (and the VGA soft scrollback) turns out to have various nasty small
>     special cases that nobody really is willing to fight.  The soft
>     scrollback code was really useful a few decades ago when you typically
>     used the console interactively as the main way to interact with the
>     machine, but that just isn't the case any more.

and:

> Commit:     973c096f6a85e5b5f2a295126ba6928d9a6afd45
> Parent:     06a0df4d1b8b13b551668e47b11fd7629033b7df
> Refname:    refs/heads/master
> Web:        https://git.kernel.org/torvalds/c/973c096f6a85e5b5f2a295126ba6928d9a6afd45
> Author:     Linus Torvalds <torvalds@linux-foundation.org>
> AuthorDate: Wed Sep 9 14:53:50 2020 -0700
> Committer:  Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Mon Sep 14 10:06:15 2020 -0700
> 
>     vgacon: remove software scrollback support



diffstats:

> ---
>  drivers/video/fbdev/core/fbcon.c | 334 +--------------------------------------
>  1 file changed, 4 insertions(+), 330 deletions(-)

>  arch/powerpc/configs/pasemi_defconfig |   1 -
>  arch/powerpc/configs/ppc6xx_defconfig |   1 -
>  arch/x86/configs/i386_defconfig       |   1 -
>  arch/x86/configs/x86_64_defconfig     |   1 -
>  drivers/video/console/Kconfig         |  46 -------
>  drivers/video/console/vgacon.c        | 221 +---------------------------------
>  6 files changed, 1 insertion(+), 270 deletions(-)




Now someone can remove the documentation for scrollback (and "no-scroll")...


-- 
~Randy

