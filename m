Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A89F2B8DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKSIqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:46:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:54326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgKSIqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:46:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 398D9AD2B;
        Thu, 19 Nov 2020 08:46:04 +0000 (UTC)
Date:   Thu, 19 Nov 2020 08:46:01 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch V4 2/8] mm/highmem: Provide
 CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
Message-ID: <20201119084601.GG3306@suse.de>
References: <20201118194838.753436396@linutronix.de>
 <20201118204007.028261233@linutronix.de>
 <CAHk-=wh6+VXQASpG+X_v8E25X9mARyHULeOfHk1RsNFMMWHafQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAHk-=wh6+VXQASpG+X_v8E25X9mARyHULeOfHk1RsNFMMWHafQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 01:13:57PM -0800, Linus Torvalds wrote:
> On Wed, Nov 18, 2020 at 12:58 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP which forces the temporary
> > mapping even for lowmem pages. This needs to be a seperate config switch
> > because this only works on architectures which do not have cache aliasing
> > problems.
> 
> Very good. And you made sure to have a comment to not enable it for
> production systems.
> 
> Hopefully people will even read it ;)
> 

And not start thinking it as a security hardening option.

-- 
Mel Gorman
SUSE Labs
