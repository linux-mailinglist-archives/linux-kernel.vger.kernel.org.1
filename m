Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68B5284C64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgJFNRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFNRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:17:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025BFC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DfFOW9XRMDdPl0LRUyxH0PJKBdxwNjijafYPV6E4OHM=; b=oybCvYcoaQBFrlUmVpcU4DTKCl
        M5REMqAHfyJRGIgOyeLp26Smj0cOXb08p6YvcZuHaIqYhlyM8AFla5rE5SLFgWsiSh1cW1ucAMPKr
        vG1oK78Jw8KUznYvRq+8Jef22PntpKuSc/fOO5GifTFARCjF/Wb0IXd0SfA/jGUc9p69dzAzpKI4y
        +BGBDkNG4m4JtcEqZ4sH4oKXgDcYe19Kje1uP+ESiDEp1CyRSoIp+VAKV0pexQIpkEw4Hzn9/GxUj
        NJnj5FAGM68oU2dkkn45Fn5GSEq4cqs9s/By4HN6sDNv8XAIw9D8RO4p4Vo12KI9Nq5FlAJgKtvRn
        4gY+gT9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPmqZ-00016j-GM; Tue, 06 Oct 2020 13:17:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1DB423019CE;
        Tue,  6 Oct 2020 15:17:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FB7A2B8462E6; Tue,  6 Oct 2020 15:17:39 +0200 (CEST)
Date:   Tue, 6 Oct 2020 15:17:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/seqlock: Tweak DEFINE_SEQLOCK() kernel doc
Message-ID: <20201006131739.GS2628@hirez.programming.kicks-ass.net>
References: <20200924154851.skmswuyj322yuz4g@linutronix.de>
 <20201006124147.GA25562@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006124147.GA25562@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 01:41:47PM +0100, Will Deacon wrote:
> On Thu, Sep 24, 2020 at 05:48:51PM +0200, Sebastian Andrzej Siewior wrote:
> > ctags creates a warning:
> > |ctags: Warning: include/linux/seqlock.h:738: null expansion of name pattern "\2"
> > 
> > The DEFINE_SEQLOCK() macro is passed to ctags and being told to expect
> > an argument.
> > 
> > Add a dummy argument to keep ctags quiet.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  include/linux/seqlock.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > index 962d9768945f0..4a69e74dc7ce9 100644
> > --- a/include/linux/seqlock.h
> > +++ b/include/linux/seqlock.h
> > @@ -735,7 +735,7 @@ typedef struct {
> >  	} while (0)
> >  
> >  /**
> > - * DEFINE_SEQLOCK() - Define a statically allocated seqlock_t
> > + * DEFINE_SEQLOCK(sl) - Define a statically allocated seqlock_t
> >   * @sl: Name of the seqlock_t instance
> >   */
> >  #define DEFINE_SEQLOCK(sl) \
> 
> Acked-by: Will Deacon <will@kernel.org>


Thanks!
