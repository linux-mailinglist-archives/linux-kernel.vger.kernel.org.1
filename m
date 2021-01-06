Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274B32EC0A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbhAFPun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:50:43 -0500
Received: from foss.arm.com ([217.140.110.172]:43026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbhAFPun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:50:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A215D6E;
        Wed,  6 Jan 2021 07:49:57 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33193F719;
        Wed,  6 Jan 2021 07:49:56 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bristot@redhat.com, frederic@kernel.org
Subject: Re: lockdep splat in v5.11-rc1 involving console_sem and rq locks
In-Reply-To: <X/Xa1fwplnZIOm+U@hirez.programming.kicks-ass.net>
References: <20210105220115.GA27357@paulmck-ThinkPad-P72> <X/WITr5JuNvuMH+p@hirez.programming.kicks-ass.net> <20210106144621.GJ17086@paulmck-ThinkPad-P72> <X/Xa1fwplnZIOm+U@hirez.programming.kicks-ass.net>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 06 Jan 2021 15:49:46 +0000
Message-ID: <jhj1reyawv9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/21 16:44, Peter Zijlstra wrote:
> On Wed, Jan 06, 2021 at 06:46:21AM -0800, Paul E. McKenney wrote:
>> What would break if I made the code dump out a few entries in the
>> runqueue if the warning triggered?
>
> There was a patch around that did that, Valentin might remember where
> that was.

There is http://lore.kernel.org/r/jhjpn4bwznx.mognet@arm.com which is a
dumb inline of print_rq() / print_task().
