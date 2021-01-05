Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC62EAD59
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 15:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbhAEO1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 09:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbhAEO1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:27:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FC5C061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 06:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WPt4GbgvCJj/QsPuZwFr/Sd2QDQgrOU3f9zQkLRLZCE=; b=VshOaC0GH4R/GHWLsOrEaR8b2K
        f1iVB2FdwmZspXhWCtXhYE0GQ+yD/lw0u3Gu3dCbCNz13IM4rb22OcMQwgeEUHxl59jRWfCCWdTLf
        SG8aDNnaltBNlBEXR/znh11f4cffx+/uqrDDigCA60AwXTif2IMu9dTSIxq/oUf1nXwXXoUI5N0zU
        WdXCQt6Z4Bl4Z8tlEQutzgQtBVXUgAUjNEPmQoXV3NO0bmwTyDvSS6l4ynZk1xvwrkVkdKU/bK5mg
        6vqcdVrvcdmg+ulkaE5YZq7M5aACoMBNmaz0qBh27/+cI/0oEu5UOwR8sW0yodinZPb3sqVCFQLcC
        WtDxcDsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwnIR-0000DE-BP; Tue, 05 Jan 2021 14:26:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3A4730377D;
        Tue,  5 Jan 2021 15:26:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EE9621210122; Tue,  5 Jan 2021 15:26:48 +0100 (CET)
Date:   Tue, 5 Jan 2021 15:26:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <20210105142648.GJ3040@hirez.programming.kicks-ass.net>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
 <20210105081325.GD3040@hirez.programming.kicks-ass.net>
 <C255B66E-C418-4B30-B363-76441266A0DC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C255B66E-C418-4B30-B363-76441266A0DC@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 12:52:48AM -0800, Nadav Amit wrote:
> > On Jan 5, 2021, at 12:13 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Mon, Jan 04, 2021 at 02:24:38PM -0500, Andrea Arcangeli wrote:
> >> The problematic one not pictured is the one of the wrprotect that has
> >> to be running in another CPU which is also isn't picture above. More
> >> accurate traces are posted later in the thread.
> > 
> > What thread? I don't seem to have discovered it yet, and the cover
> > letter from Nadav doesn't seem to have a msgid linking it either.
> 
> Sorry for that:
> 
> https://lore.kernel.org/lkml/X+K7JMrTEC9SpVIB@google.com/T/

Much reading later..

OK, go with the write-lock for now.
