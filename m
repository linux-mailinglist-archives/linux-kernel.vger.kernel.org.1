Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D34A1DB861
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgETPgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 11:36:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55332 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgETPgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hr/v7CrPKy0D3t/BD3ZD7T4JRwoyIeHJHkahUfGLsTE=; b=iCZKQEyfjeyEyEvKf6sXVvInlW
        YEQFgm52Z0H11/d9q+J+OUt3bq7IKdzgofPfBQYA5A2qTLlntw2/Yy5z9tDf/TfeZo879QmLATTKp
        /itZqG+daVaWOTC4pcSKW8p4VhrfqMfViqNnXEy4XgMpUCjodaM/Nd+ugCleWNPN7ipFNiRDEnfc+
        EuzR97LCJwBXmY3ZX78orsDxWelkxZzA/CRE/q28ATmsWyD2QqhgUBsHNaazpMs7HxfK/NygU2Ftc
        mwe866Err3VsETUjK5p22cNSFnwRAmurojciN+t7oJWiI7M2sY3FSehbT0VXSP2rcU+pk6mJTNMD7
        Vw7FL1hw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbQlQ-0004LN-0Y; Wed, 20 May 2020 15:36:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD303301A80;
        Wed, 20 May 2020 17:36:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FE5B29DB513D; Wed, 20 May 2020 17:36:03 +0200 (CEST)
Date:   Wed, 20 May 2020 17:36:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] sched/cputime: make scale_stime() more precise
Message-ID: <20200520153603.GP317569@hirez.programming.kicks-ass.net>
References: <20190718131834.GA22211@redhat.com>
 <20200127122817.GA10957@redhat.com>
 <20200519172506.GA317395@hirez.programming.kicks-ass.net>
 <20200520152439.GC26470@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520152439.GC26470@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 05:24:40PM +0200, Oleg Nesterov wrote:
> Nevermind, I agree with your version. Will you send this patch or do you
> want me to make V3 ?

I got stuck at writing a Changelog, am more scatter brained than usual,
due to lack of sleep. If you have Changelog that includes information
rather than links to it, feel free to send it along and I'll frob the
thing together, or just send a v3 with everything on.

Otherwise, I'll try again tomorrow :-)
