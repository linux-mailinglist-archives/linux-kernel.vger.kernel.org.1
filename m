Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2562A5B07
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 01:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgKDAbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 19:31:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbgKDAbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 19:31:09 -0500
Received: from X1 (unknown [208.106.6.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42824223EA;
        Wed,  4 Nov 2020 00:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604449867;
        bh=PJ+R6XPlsYAvbfPPVfH/b36l9Qxf3mjjxVF2HSd4mPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ER7zLL0fsJywguzjfs3PdQZTmOgVAwtAz5yE5+b1SdacnLAOa3OQtAGteR5rW7qCD
         Ywc7Z9rUQo9Vi+5FVv3vDhZ6WcR6fNJM16p3Tc2cdLZyMHI3nO70s8Q5UgVBzUwL0U
         RpnJUxRfACjNdutK4tXoVqBpsWdb3+kUMVEy2qI4=
Date:   Tue, 3 Nov 2020 16:31:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     glider@google.com, hpa@zytor.com, paulmck@kernel.org,
        andreyknvl@google.com, aryabinin@virtuozzo.com, luto@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, cl@linux.com,
        dave.hansen@linux.intel.com, rientjes@google.com,
        dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, joern@purestorage.com,
        keescook@chromium.org, mark.rutland@arm.com, penberg@kernel.org,
        peterz@infradead.org, sjpark@amazon.com, tglx@linutronix.de,
        vbabka@suse.cz, will@kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v7 0/9] KFENCE: A low-overhead sampling-based memory
 safety error detector
Message-Id: <20201103163103.109deb9d49a140032d67434f@linux-foundation.org>
In-Reply-To: <20201103175841.3495947-1-elver@google.com>
References: <20201103175841.3495947-1-elver@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Nov 2020 18:58:32 +0100 Marco Elver <elver@google.com> wrote:

> This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> low-overhead sampling-based memory safety error detector of heap
> use-after-free, invalid-free, and out-of-bounds access errors.  This
> series enables KFENCE for the x86 and arm64 architectures, and adds
> KFENCE hooks to the SLAB and SLUB allocators.
> 
> KFENCE is designed to be enabled in production kernels, and has near
> zero performance overhead. Compared to KASAN, KFENCE trades performance
> for precision. The main motivation behind KFENCE's design, is that with
> enough total uptime KFENCE will detect bugs in code paths not typically
> exercised by non-production test workloads. One way to quickly achieve a
> large enough total uptime is when the tool is deployed across a large
> fleet of machines.

Has kfence detected any kernel bugs yet?  What is its track record?

Will a kfence merge permit us to remove some other memory debugging
subsystem?  We seem to have rather a lot of them.

