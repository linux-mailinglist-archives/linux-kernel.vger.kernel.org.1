Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F9E2F35E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405094AbhALQgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:36:15 -0500
Received: from gentwo.org ([3.19.106.255]:50638 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbhALQgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:36:14 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id D69533F5AA; Tue, 12 Jan 2021 16:35:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id D41703E9B5;
        Tue, 12 Jan 2021 16:35:28 +0000 (UTC)
Date:   Tue, 12 Jan 2021 16:35:28 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Jann Horn <jannh@google.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: SLUB: percpu partial object count is highly inaccurate, causing
 some memory wastage and maybe also worse tail latencies?
In-Reply-To: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2101121627490.20570@www.lameter.com>
References: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021, Jann Horn wrote:

> [This is not something I intend to work on myself. But since I
> stumbled over this issue, I figured I should at least document/report
> it, in case anyone is willing to pick it up.]

Well yeah all true. There is however a slabinfo tool that has an -s option
to shrink all slabs.

	slabinfo -s

So you could put that somewhere that executes if the system is
idle or put it into cron or so.

This is a heavy handed operation through. You could switch off partial cpu
slabs completely to avoid the issue. Nothing came to mind in the past on
how to solve this without sacrificing significant performance or cause
some system processing at random times while the shrinking runs. No one
wants any of that.

Being able to do it from userspace cleanly shifts the burden to userspace  ;-)
You can even do random heavy system processing from user space if you put
a sleep there for random seconds between the shrinking runs.

