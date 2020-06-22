Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73F0203306
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 11:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgFVJNX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Jun 2020 05:13:23 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:57572 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725919AbgFVJNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:13:23 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21574153-1500050 
        for multiple; Mon, 22 Jun 2020 10:13:19 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200622085258.GA22686@duo.ucw.cz>
References: <20200622085258.GA22686@duo.ucw.cz>
To:     Pavel Machek <pavel@ucw.cz>, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        kernel list <linux-kernel@vger.kernel.org>,
        rodrigo.vivi@intel.com
Subject: Re: [Intel-gfx] v5.8-rc1 on thinkpad x220, intel graphics: interface frozen, can still switch to text console
From:   Chris Wilson <chris@chris-wilson.co.uk>
Message-ID: <159281719363.11575.10607533427539631904@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jun 2020 10:13:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pavel Machek (2020-06-22 09:52:59)
> Hi!
> 
> Linux duo 5.8.0-rc1+ #117 SMP PREEMPT Mon Jun 15 16:13:54 CEST 2020 x86_64 GNU/Linux
> 
> [133747.719711] [  17456]     0 17456     4166      271    65536        0             0 sshd
> [133747.719718] [  17466]  1000 17466     4166      289    65536        0             0 sshd
> [133747.719724] [  17468]  1000 17468   433587   303033  2588672        0             0 unison
> [133747.719730] [  18023]  1000 18023     1316       16    40960        0             0 sleep
> [133747.719737] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),task=chromium,pid=27368,uid=1000
> [133747.719795] Out of memory: Killed process 27368 (chromium) total-vm:6686908kB, anon-rss:647056kB, file-rss:0kB, shmem-rss:7452kB, UID:1000 pgtables:5304kB oom_score_adj:300
> [133747.799893] oom_reaper: reaped process 27368 (chromium), now anon-rss:0kB, file-rss:0kB, shmem-rss:6836kB
> [136841.820558] i915 0000:00:02.0: [drm] Resetting chip for stopped heartbeat on rcs0
> [136841.924333] i915 0000:00:02.0: [drm] Xorg[3016] context reset due
> to GPU hang

If that was the first occurrence it would have pointed to the error
state containing more information on the cause of the hang.
Attach /sys/class/drm/card0/error
-Chris
