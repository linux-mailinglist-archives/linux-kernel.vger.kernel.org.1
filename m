Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72901304231
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389816AbhAZPUP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Jan 2021 10:20:15 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:54868 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390639AbhAZJe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:34:28 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23700597-1500050 
        for multiple; Tue, 26 Jan 2021 09:33:38 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <161161117911.29150.13853544418926100149@build.alporthouse.com>
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com> <161160687463.28991.354987542182281928@build.alporthouse.com> <CAHk-=wh23BXwBwBgPmt9h2EJztnzKKf=qr5r=B0Hr6BGgZ-QDA@mail.gmail.com> <20210125213348.GB196782@linux.ibm.com> <161161117911.29150.13853544418926100149@build.alporthouse.com>
Subject: Re: Linux 5.11-rc5
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Date:   Tue, 26 Jan 2021 09:33:39 +0000
Message-ID: <161165361960.29150.15515544628767131483@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wilson (2021-01-25 21:46:19)
> Quoting Mike Rapoport (2021-01-25 21:33:48)
> > On Mon, Jan 25, 2021 at 12:49:39PM -0800, Linus Torvalds wrote:
> > > Mike: should we perhaps revert the first patch too (commit
> > > bde9cfa3afe4: "x86/setup: don't remove E820_TYPE_RAM for pfn 0")?
> > 
> > I wonder, maybe actually this one is causing troubles?
> > 
> > Chris, would it be possible to check what happens if you revert only
> > bde9cfa3afe4?
> 
> Queued for CI, will be run in about an hour.

I ran just the revert of bde9cfa3afe4 through CI twice, on both occasions
all machines failed to boot. 
-Chris
