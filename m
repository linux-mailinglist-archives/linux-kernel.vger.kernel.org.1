Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507B02EA65B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbhAEIO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbhAEIO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:14:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F2FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 00:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P9TYkqppwZM/jhjV499wBQy9lm5R97nXtaT3K8wh0k4=; b=cV0wyCH5p+SfmkI3UvRYn5WqG8
        41nQmrQkZWPS418IkVIkZAmi1fjqYLhKX1r767cAyN2LAqMeXQKynDTeV4vYUh5q5/1eBwK9AmnM4
        Px2oTUTgyXOGgwrgu4gVOGFCLR7SpBBW100T9/Jv1ORQpxkOKzF/Ld3x37YkbQUlNolb40QsTeVyD
        z3F2H+D5JC+NJDJfMk8RWhY6d8u/vTMFzO6sogjwrEW00kyGgEMEwZWR5dSr2lDNYuTeBWWZtM4za
        n7hxPa+Fhfmd7aMGpNT3x4SxylDRS+OhGujt1Fp2bS5LBOlY0GAaW1Jyac+EFTL6UazY6sF1CZ4BK
        xTMew9vw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwhT7-00070O-2B; Tue, 05 Jan 2021 08:13:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5980C300446;
        Tue,  5 Jan 2021 09:13:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BCBA21213528; Tue,  5 Jan 2021 09:13:25 +0100 (CET)
Date:   Tue, 5 Jan 2021 09:13:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <20210105081325.GD3040@hirez.programming.kicks-ass.net>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/NrdnoDHgFd0Ku1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 02:24:38PM -0500, Andrea Arcangeli wrote:
> The problematic one not pictured is the one of the wrprotect that has
> to be running in another CPU which is also isn't picture above. More
> accurate traces are posted later in the thread.

What thread? I don't seem to have discovered it yet, and the cover
letter from Nadav doesn't seem to have a msgid linking it either.
