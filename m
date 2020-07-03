Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912C4213E91
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 19:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgGCRbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 13:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGCRbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:31:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8DAC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6d9P+hb+xlPa7ojX++IyULHHkW8FXRW9tXtmJKpRZGY=; b=iYV+wZpjCaKtxx1PmPbJ96H75h
        9EILTcJ7LpFyy7fwqoNAjSyVLyANFnuYv1L7opuNLeQGz5DhPKhZQpetsYeiGpZe/nF3tluUUi21U
        NITj9EOAvOCs0ZI5HBO7dZ/pbpg9+DAp6l4h50+fWqoNhUjyU0NER+pY02p7KpwE2k/n8XY0tUsWI
        jiQMrHIPa9xLX+XSOBrqbFvMZF8hDxpxEWDdLoeNmtNz5Bo64kuqtEt+Ca3EnEq+jacGraEgJp9h3
        KDYieW91HOpZ0vUZyWPaUVBtjiGs+fUeafxlgND06xtMAR0Fm4NFaCNpOiheb8IsfSj/0b45iD1CJ
        uNivJu0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrPWv-0000A5-Lu; Fri, 03 Jul 2020 17:31:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F40F30411F;
        Fri,  3 Jul 2020 19:31:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D29220A9E7A7; Fri,  3 Jul 2020 19:31:13 +0200 (CEST)
Date:   Fri, 3 Jul 2020 19:31:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH entry v2 0/6] x86/entry: Fixes and cleanups
Message-ID: <20200703173113.GY4800@hirez.programming.kicks-ass.net>
References: <cover.1593795633.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593795633.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 10:02:52AM -0700, Andy Lutomirski wrote:
> These are in priority order.  Patch 1 could be folded into the patch
> it fixes.  The selftests improve my confidence in the correctness of
> the whole pile.  The next two patches fix IDTENTRY miswiring.  The
> last two are optional and could easily wait until the next merge
> window.
> 
> Andy Lutomirski (6):
>   x86/entry/compat: Clear RAX high bits on Xen PV SYSENTER
>   x86/entry, selftests: Further improve user entry sanity checks
>   x86/entry/xen: Route #DB correctly on Xen PV
>   x86/entry/32: Fix #MC and #DB wiring on x86_32
>   x86/ldt: Disable 16-bit segments on Xen PV
>   x86/entry: Rename idtentry_enter/exit_cond_rcu() to
>     idtentry_enter/exit()

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
