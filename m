Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DFE2DAFAA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgLOPDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgLOPDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:03:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B426C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i9KHdr0gWbDVcyczmnpwIu1qTcM2k7ELJkhC17pIbYI=; b=nztQpRm/TEk0vHpz/vHwvmYB1Y
        AeK5Hy5kWuawLIh7Kam6qJatL2hgggRak7vOeS4t/rGKt5c4e8pVLTVsvnLiqugDz1VXsV2zqZwkC
        CRu+/5B88jL60LY2qatz1ysGiHZ1ELG4HkbDduCp1zXH9efXPRlYDAbgfz87Bc6l9j0hrdlZJhFOo
        n5BnE6A+K8N54Qhydf/A2+0LkydsJofoUoQBR/lDYNoI7A4pLocUOPF2pkeO5MHuqjv64vJY75ghd
        9zAdczMbYrxvhssw8dBTgTbtiAJHUXhyFtFoHb6pwuQMI8Uxvs2FJt+gNgbVncmKHyzHGCDAwe07j
        srYxu3kQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpBqV-0005Xm-Im; Tue, 15 Dec 2020 15:02:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A4DD302753;
        Tue, 15 Dec 2020 16:02:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E833B201DED68; Tue, 15 Dec 2020 16:02:34 +0100 (CET)
Date:   Tue, 15 Dec 2020 16:02:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     trix@redhat.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove h from printk format specifier
Message-ID: <20201215150234.GH3040@hirez.programming.kicks-ass.net>
References: <20201215141931.1842379-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215141931.1842379-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 06:19:31AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> See Documentation/core-api/printk-formats.rst.
> h should no longer be used in the format specifier for printk.

I'm not going to be reading any RST gunk. If there's a sane reason,
replicate it here, in plain text.
