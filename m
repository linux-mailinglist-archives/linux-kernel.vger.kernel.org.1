Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB932A0055
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgJ3ItY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgJ3ItX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:49:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF34C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mdVq7rzTsraODx24OzZq2uGF+1g27vjQIcCh6upVV/U=; b=d1DeONvATkDZbjHadQuY9+1zox
        FoWjKBN2l7f5hoRQqt18kU1gEubPYPYlleKuFVUiRm+a7FlU14DnVNK14Epa4bKQjzfhrZT69j71d
        0SWwV7AkejkWS5tSfCkKzHKT6RUQWbTiKHPEvDVNaYjtCPEieps4bY2Q3ZWSesZBeu9Qr9ymJUwUP
        m8cvXWUsGOZc2SPNspRBwi/fSOKwMkSvjp3yAhrDlcgPEah8prWa6J5tN25u/ZCsfKXb+kKJ4V9rs
        UqsnPtcAXbskzFW9v3ZsHdPdrmdoGP10nnHmzCOgQQRRrfsFyr7SHj0Mh9S9MGk5kG3c3OHzeXK5p
        Y90kgg+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYQ5z-0008O1-HI; Fri, 30 Oct 2020 08:49:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97027300446;
        Fri, 30 Oct 2020 09:49:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E98420DCC48D; Fri, 30 Oct 2020 09:49:12 +0100 (CET)
Date:   Fri, 30 Oct 2020 09:49:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     syzbot <syzbot+cebc65195a8639f648b9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: using __this_cpu_read() in preemptible code in
 __bad_area_nosemaphore
Message-ID: <20201030084912.GY2628@hirez.programming.kicks-ass.net>
References: <0000000000000cd2e305b2d9a9db@google.com>
 <20201029225106.0ce492a4@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029225106.0ce492a4@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:51:06PM -0400, Steven Rostedt wrote:
> On Thu, 29 Oct 2020 18:53:17 -0700
> syzbot <syzbot+cebc65195a8639f648b9@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> 
> Didn't Peter already send a fix for this? Is it not upstream yet?

Hurmph, it's been in tip/locking/urgent for 8 days, but does not indeed
seem to have made it into Linus' tee yet.
