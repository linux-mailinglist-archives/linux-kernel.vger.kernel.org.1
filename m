Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EBE1EE7B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 17:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgFDPZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbgFDPZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:25:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD13C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7nUdXGk9WUnPOP8CYGbU/r6c+Zp3RIzDzbNwRPB+ALQ=; b=jB26+r1FRQkXtmmAPM7QDg16Tm
        cl2BkyaI4Uq5YWCZFF7gwLE7+sG/RxCCIGXfcBtiUteR6DDpVon6/n9oCXBwWplkn+GvUXnl9FjdS
        vPIJHV6kW/eiAdZbWVzETOdnAi9VrPB6APSX6mQWSrCb7LNIRHqvuQJnXQN53UY0gQadjBm8OmsrU
        vDVrxZnjKJSCDk43BCgsmYKK3gaw1SIymAYGpCWFEU/Zj1VRjk7NaDzplAHme8HuLQOoverLHA3yv
        N5972lZQTXhkCZUP4WquHfYVVZc/wSfmZ/90JW3rQkvmO/PTupnlre92zYH9hfWyMLs8K5zJMuQHo
        VIeX47/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgrkR-0004vl-76; Thu, 04 Jun 2020 15:25:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 549D4301DFD;
        Thu,  4 Jun 2020 17:25:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4045A20E061B2; Thu,  4 Jun 2020 17:25:37 +0200 (CEST)
Date:   Thu, 4 Jun 2020 17:25:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@kernel.org,
        clang-built-linux@googlegroups.com, paulmck@kernel.org,
        dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 1/2] kcov, objtool: Make runtime functions
 noinstr-compatible
Message-ID: <20200604152537.GD3976@hirez.programming.kicks-ass.net>
References: <20200604145635.21565-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604145635.21565-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 04:56:34PM +0200, Marco Elver wrote:
> While we lack a compiler attribute to add to noinstr that would disable
> KCOV, make the KCOV runtime functions return if the caller is in a
> noinstr section. We then whitelist __sanitizer_cov_*() functions in
> objtool.

> __sanitizer_cov_*() cannot safely become safe noinstr functions
> as-is, as they may fault due to accesses to vmalloc's memory.

I would feel very much better with those actually in noinstr, because
without it, there is nothing stopping us from adding a kprobe/hw-
breakpoint or other funny to the function.

Even if they almost instra-return, having a kprobe on the function entry
or condition check is enough to utterly wreck things.

So something like:

void noinstr __sanitizer_cov_trace_*(...)
{
	if (within_noinstr_section(ip))
		return;

	instrumentation_begin();
	write_comp_data(...);
	instrumentation_end();
}

Would make me feel a whole lot better.

> +static __always_inline bool in_noinstr_section(unsigned long ip)
> +{
> +	return (unsigned long)__noinstr_text_start <= ip &&
> +	       ip < (unsigned long)__noinstr_text_end;
> +}

.entry.text is also considered noinstr, although I suppose that all
being in .S files avoids it having annotations inserted, but perhaps a
comment?

