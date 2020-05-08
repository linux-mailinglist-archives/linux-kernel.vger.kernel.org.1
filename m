Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9D21CB2D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEHPan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 11:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEHPan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:30:43 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AFAC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XJCvgGP3AdVSMVnuFTuPZXemiWrl38A2OA1chjGxEpw=; b=SyNDZ5a3FzbWUr39nrs1d8q8C7
        KzOwwx4Lh4Kl5tPRaYfdxAWGbkmhjUkzkhUE1Qb97MKWMeLKmSJ+ofMm2LNfemza6JJLz1FNV7Dd5
        nd7+VUKYRKniafzZmCXNME9UubTA8sf5DmnJiUWbI9A3ovjlKau8MEzAeS2DnBIbTFWteNkYVABZi
        q+KfgoZ028S8yC3TiR7apAeDOL7ZycUSW/qaDCenAENhIyH1o5xBhj9/EM8yYWvekikYB36jW9Ic6
        tOEA4C+EutZR/m7GhqBplEoYPW1aE5+KbzIUKXG8t0l2ZBjG1hGzV65YoWfgxtrON1BCLvMeK6Yte
        jNmeBc5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX4x5-0007CQ-Ef; Fri, 08 May 2020 15:30:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5D993012DC;
        Fri,  8 May 2020 17:30:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EFCD286E9005; Fri,  8 May 2020 17:30:13 +0200 (CEST)
Date:   Fri, 8 May 2020 17:30:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 16/18] static_call: Allow early init
Message-ID: <20200508153013.GC3344@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.706674211@infradead.org>
 <20200506211547.2vnuhkfzhgbi27dm@treble>
 <20200508133156.GC3762@hirez.programming.kicks-ass.net>
 <20200508142703.44ggcccdunchamro@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508142703.44ggcccdunchamro@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 09:27:03AM -0500, Josh Poimboeuf wrote:

> Looks good, I'll try to do some more testing today-ish.

I'll try and push out a new version after I get dinner sorted.
