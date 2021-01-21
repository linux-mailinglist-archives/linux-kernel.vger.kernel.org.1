Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7772FF5AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbhAUUSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:18:36 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49295 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbhAUUSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:18:06 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10LKHEJ2024489;
        Thu, 21 Jan 2021 21:17:14 +0100
Date:   Thu, 21 Jan 2021 21:17:14 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] tools/nolibc: fix build issues on aarch64 after
 unistd cleanup
Message-ID: <20210121201714.GA24484@1wt.eu>
References: <20210121072031.23777-1-w@1wt.eu>
 <20210121111117.GA48431@C02TD0UTHF1T.local>
 <20210121141809.GC24174@1wt.eu>
 <20210121195432.GS2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121195432.GS2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:54:32AM -0800, Paul E. McKenney wrote:
> > > It would be great if this could be applied soon so that it's possible to
> > > use the rcutorture scripts without applying local hacks.
> > 
> > Makes sense. I was wondering, should we mark them for stable ? I don't
> > know if anyone relies on these tests to validate stable kernels in
> > fact.
> 
> I added Fixes tags that should make this happen, and they are now visible
> at -rcu branch "dev".  Could you please check them for me?

I've just rerun all previous tests from my history and all of them are
OK. Please note however that I only did the manual build test, not through
the whole kvm.sh script, but a diff shows that the involved files are byte
for byte identical to those that Valentin and Mark tested, so for me that's
OK as well.

By the way, thank you for having completed the commit messages, I hope you
didn't spend too much time on this.

Cheers,
Willy
