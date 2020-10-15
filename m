Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB028EFD6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbgJOKFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbgJOKFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:05:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE590C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 03:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dJKybykAdpZHX+hMiVFGUu7Tughqzv0JYMXE+Vz1Rds=; b=B6Y6qc5uYKAMbn3C7uHAt0WtFm
        Iuty8DRyK53iDecWN+XBIsrT40icgPDUTMiS8boZ+HiCxB8ubw+MXpmSOsLCTnuejM+7XzGXIgn0u
        JYSvV7I0KBmKw32KE5HXYJEx0heYWPjH5zCVZysE1FSZfgZMrUt8oK1mmLaik0Q1DaPHKt59ChDdK
        DANj5aGG+/L3Wra2uwqaPpHaX2kNzXrWraA7fyik7AZCVOUhCZvFkSpgPaSpVWJg3te5uFA1Gfoek
        QbMKaW3zWwVM5fXv9D07l2dyEPuZVd3SJWK9naUDmsF0604VnOf3c5ZAdqu3di9Leowiv75/3e0KL
        MSAhi+iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT08S-00078Y-27; Thu, 15 Oct 2020 10:05:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 149B5300DB4;
        Thu, 15 Oct 2020 12:05:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEF8920325EC4; Thu, 15 Oct 2020 12:05:22 +0200 (CEST)
Date:   Thu, 15 Oct 2020 12:05:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Numfor Mbiziwo-Tiapo <nums@google.com>
Subject: Re: [PATCH 1/2] x86/insn: Fix some potential undefined behavior.
Message-ID: <20201015100522.GZ2611@hirez.programming.kicks-ass.net>
References: <20201015062148.1437894-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015062148.1437894-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 11:21:47PM -0700, Ian Rogers wrote:
> From: Numfor Mbiziwo-Tiapo <nums@google.com>
> 
> If insn_init is given a NULL kaddr and 0 buflen then validate_next will
> perform arithmetic on NULL, add a guard to avoid this.

How is this a problem? NULL is (void *)0, you can do arithmetic on that
just fine.

Is UBSAN taking drugs again?

> Don't perform unaligned loads in __get_next and __peek_nbyte_next as
> these are forms of undefined behavior.

Fair enough; that could actually be a problem when we start to
cross-build this stuff. A RISC hosted version of the x86 decoder could
indeed trip this up.


But also, these are two changes in one patch.
