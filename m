Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F99C294CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440910AbgJUMrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:47:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:59176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407717AbgJUMrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:47:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E7F1AC1F;
        Wed, 21 Oct 2020 12:47:03 +0000 (UTC)
Date:   Wed, 21 Oct 2020 13:47:00 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles.Muller@inria.fr
Subject: Re: [PATCH] sched/fair: check for idle core
Message-ID: <20201021124700.GE32041@suse.de>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021112038.GC32041@suse.de>
 <20201021122532.GA30733@vingu-book>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201021122532.GA30733@vingu-book>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:25:32PM +0200, Vincent Guittot wrote:
> > I see Vincent already agreed with the patch so I could be wrong.  Vincent,
> > did I miss something stupid?
> 
> This patch fixes the problem that we don't favor anymore the prev_cpu when it is idle since
> commit 11f10e5420f6ce because load is not null when cpu is idle whereas runnable_load was
> And this is important because this will then decide in which LLC we will looks for a cpu
> 

Ok, that is understandable but I'm still concerned that the fix simply
trades one problem for another by leaving related tasks remote to each
other and increasing cache misses and remote data accesses.

wake_affine_weight is a giant pain because really we don't care about the
load on the waker CPU or its available, we care about whether it has idle
siblings that can be found quickly. As tempting as ripping it out is,
it never happened because sometimes it makes the right decision.

-- 
Mel Gorman
SUSE Labs
