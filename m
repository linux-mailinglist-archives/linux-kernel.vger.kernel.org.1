Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F579302E40
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbhAYVre convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Jan 2021 16:47:34 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:54733 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732421AbhAYVrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:47:15 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23697720-1500050 
        for multiple; Mon, 25 Jan 2021 21:46:17 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210125213348.GB196782@linux.ibm.com>
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com> <161160687463.28991.354987542182281928@build.alporthouse.com> <CAHk-=wh23BXwBwBgPmt9h2EJztnzKKf=qr5r=B0Hr6BGgZ-QDA@mail.gmail.com> <20210125213348.GB196782@linux.ibm.com>
Subject: Re: Linux 5.11-rc5
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Date:   Mon, 25 Jan 2021 21:46:19 +0000
Message-ID: <161161117911.29150.13853544418926100149@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Rapoport (2021-01-25 21:33:48)
> On Mon, Jan 25, 2021 at 12:49:39PM -0800, Linus Torvalds wrote:
> > On Mon, Jan 25, 2021 at 12:35 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > >
> > > Quoting Linus Torvalds (2021-01-25 01:06:40)
> > > > Mike Rapoport (3):
> > > ...
> > > >       mm: fix initialization of struct page for holes in memory layout
> > >
> > > We have half a dozen or so different machines in CI that are silently
> > > failing to boot, that we believe is bisected to this patch.
> > 
> > That commit reverts cleanly - so if you can verify that reverting it
> > fixes your CI machines, I think that that's the right thing to do for
> > now, unless Mike can figure out some obvious "Duh!" moment from your
> > working dmesg.
> 
> Unfortunately not, at least at 11pm :(
> Maybe tomorrow I'll have something smarter to say.

CI does confirm that the revert of d3921cb8be29 brings the machines back
to life.
  
> > Mike: should we perhaps revert the first patch too (commit
> > bde9cfa3afe4: "x86/setup: don't remove E820_TYPE_RAM for pfn 0")?
> 
> I wonder, maybe actually this one is causing troubles?
> 
> Chris, would it be possible to check what happens if you revert only
> bde9cfa3afe4?

Queued for CI, will be run in about an hour.
-Chris
