Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F592D7BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392345AbgLKRAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:00:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732728AbgLKRAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:00:09 -0500
Date:   Fri, 11 Dec 2020 08:59:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607705968;
        bh=WZWaJdQGBtU/vASuowwS4F7kXtoWW4OvU9YEYnu4f9g=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CPA7/uoaWjXWUEa7pJJVSimnieYKmIJ48sIQipHja3ZQbthsqk/kZJbPQm/KWbvt/
         YS4e3C1xlsgZnH7NFGNwT9d/1P+R+tRYf5OKIcpQoVfA4aFIJqMyrx8CZwqweqIVIt
         bgvCcmZkwoibpy/0yMQtEU3IKa08HfpgAuFvKSbDEQ+QRc+usVNBWege/mL10gRTgg
         P3BOQdDNDaOn8hFl+bfn4mPxSFsepLUuUQVuiWKL8FUiEd+GQur5B8ar4UtvgLTP/t
         juPnlkVe0fD66LoFiZCHpjLry68w4bTRFRqwGsboZgzoVEqaaOVf9uySzmtgsyIrq9
         XhGdtW/hL64RQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        andrii@kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH v3 sl-b 1/6] mm: Add mem_dump_obj() to print source of
 memory block
Message-ID: <20201211165928.GE2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201211011907.GA16110@paulmck-ThinkPad-P72>
 <20201211012003.16473-1-paulmck@kernel.org>
 <20201211022205.GA11631@js1304-desktop>
 <20201211033359.GD2657@paulmck-ThinkPad-P72>
 <20201211034226.GA2116@paulmck-ThinkPad-P72>
 <20201211065850.GB587@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211065850.GB587@js1304-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 03:58:51PM +0900, Joonsoo Kim wrote:
> On Thu, Dec 10, 2020 at 07:42:27PM -0800, Paul E. McKenney wrote:
> > On Thu, Dec 10, 2020 at 07:33:59PM -0800, Paul E. McKenney wrote:
> > > On Fri, Dec 11, 2020 at 11:22:10AM +0900, Joonsoo Kim wrote:
> > > > On Thu, Dec 10, 2020 at 05:19:58PM -0800, paulmck@kernel.org wrote:
> > > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > [ . . . ]
> > 
> > > > We can get some infos even if CONFIG_SLUB_DEBUG isn't defined.
> > > > Please move them out.
> > > 
> > > I guess since I worry about CONFIG_MMU=n it only makes sense to also
> > > worry about CONFIG_SLUB_DEBUG=n.  Fix update.
> > 
> > Like this?  (Patch on top of the series, to be folded into the first one.)
> 
> Yes!
> 
> Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Applied, and thank you again for the review and feedback!

Suggestions on where to route these?  Left to my own devices, they
go via -rcu in the v5.12 merge window.

							Thanx, Paul
