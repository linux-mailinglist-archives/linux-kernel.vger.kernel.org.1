Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77FED19E7FE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 01:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDDXFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 19:05:54 -0400
Received: from gentwo.org ([3.19.106.255]:48678 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgDDXFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 19:05:53 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 91C4E40CB2; Sat,  4 Apr 2020 23:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 8F7C040CB1;
        Sat,  4 Apr 2020 23:05:52 +0000 (UTC)
Date:   Sat, 4 Apr 2020 23:05:52 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>
Subject: Re: [patch 3/3] isolcpus: undeprecate on documentation
In-Reply-To: <20200331155708.GU20730@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.2004042302080.1722@www.lameter.com>
References: <20200328152117.881555226@redhat.com> <20200328152503.271570281@redhat.com> <20200331152217.GT20730@hirez.programming.kicks-ass.net> <20200331154146.GA28556@fuller.cnet> <20200331155708.GU20730@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020, Peter Zijlstra wrote:

> > Why do you dislike it? What you think would be a decent approach?
>
> Try and reconfigure it after boot.

Not really a problem since this is not the only issue that requires a
reboot.

You have to reboot most of the time if you change applications on a HPC
machine. After all you cannot reliably change the available set of huge
pages after boot. So you have to reboot anyways if you want some cores to
do different things.

And then the machines performance goes down over time due to
memory fragmentation. So you better reboot frequently.

Thus reboot, reboot, reboot. We have become like Windows 95 ...

