Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4B219BE3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 11:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGIJSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGIJSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:18:11 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75735C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 02:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dwNXifkJGavjYX5M4CtOaAfXz8jVFrFMDhngfF3KgTg=; b=AwDFVC9zVTGcR8FIoUzWtpcwls
        mVK6/Y8mJQ1wsN/aE2GlL0e/nlSnlglKDCfKjBjcsmK1OzTIE4dWMxf19rWJmhroHouuCpAOsvUGK
        V5sbzvPwJAzi95wmcgaI5ZxZ/521Cvs9sRgwVVpmzV9YUsK94umLIVGcqj97XT9xrjUenfqu89Bto
        E6XHMFPajeP8jBTJy66mEYfJ301RzR3uXmNUg5hlRa8eUVlmMXn/Bp/ukZADohYAYGEa+KBGeWHuS
        yrUoSYNpepSVwtqFiNsocQ05O0I+xaWqkLAFbG344Mdb3jkKJQqHFhgSWTQTPYWv0mfp9VFdyO504
        NJDRRZFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtSgy-0004e4-Qa; Thu, 09 Jul 2020 09:18:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 99C17300739;
        Thu,  9 Jul 2020 11:09:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8673C285718F2; Thu,  9 Jul 2020 11:09:01 +0200 (CEST)
Date:   Thu, 9 Jul 2020 11:09:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [patch 0/3] x86/entry: A couple of small fixes
Message-ID: <20200709090901.GM597537@hirez.programming.kicks-ass.net>
References: <20200708192804.911958542@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708192804.911958542@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 09:28:04PM +0200, Thomas Gleixner wrote:
>  - Syzbot reported a missing local_irq_disable() in exc_alignment_check()
>  - A missing noinstr annotation
>  - Make a function static which is not longer used from ASM code

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
