Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CA02C2A37
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389333AbgKXOrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389219AbgKXOrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:47:03 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A1EC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iOUcSzyirFatFhqwtFVdArAYGmABbxA9z4ul7vfBEMk=; b=k6IOH5YvFBCKW1OwwhLzyyPfbu
        q/pwwh+YuwVlEmFxPjGkOaz61zEuqgJiMZfuE53n4y+ZUKneRTl3x87KjDSW+tEq7QdFdRfXDPJNW
        M6gPIT4IOvqS+e2gE8tc1EBU3X2sv1KeGudOMbn8aIZIF9rCUJanCBIm7Ry12jlyGPbGWJJEBNwfY
        ei50Azbp9pqBXTRQZ43Pm7dqwJb+5YBR4RB0kXMJzJSpzwG9JJPcE+IYfqA2Awrgpk+hJ+QWmSq5Z
        VyrR3wpVWQ7z5+qQGrCA9X48DqttyA7BYfhu0vuz5hoGtAMER/SDayI1MtQmivaISw7kndpkIQFtn
        Nl3bTkYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khZap-0005Il-DU; Tue, 24 Nov 2020 14:46:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 091643012DF;
        Tue, 24 Nov 2020 15:46:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA1A9200D4E96; Tue, 24 Nov 2020 15:46:53 +0100 (CET)
Date:   Tue, 24 Nov 2020 15:46:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] mm: proc: Avoid fullmm flush for young/dirty bit
 toggling
Message-ID: <20201124144653.GJ2414@hirez.programming.kicks-ass.net>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-7-will@kernel.org>
 <20201120204005.GC1303870@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120204005.GC1303870@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:40:05PM -0700, Yu Zhao wrote:

> It seems to me ARM's interpretation of tlb->fullmm is a special case,
> not the other way around.

I don't think ARM is special here, IIRC there were more architectures
that did that.

