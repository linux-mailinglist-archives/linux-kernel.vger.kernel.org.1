Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6AA27BFC1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgI2IkF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Sep 2020 04:40:05 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:63857 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725468AbgI2IkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:40:04 -0400
X-Greylist: delayed 969 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 04:40:03 EDT
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 22564106-1500050 
        for multiple; Tue, 29 Sep 2020 09:23:37 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <160136751431.9258.5367116987368823201@jlahtine-mobl.ger.corp.intel.com>
References: <CAOMV6SUP1=U3bqO=+f_HrnTYpaLLwvZY4muCdW-ixQU2M10_WQ@mail.gmail.com> <160136751431.9258.5367116987368823201@jlahtine-mobl.ger.corp.intel.com>
Subject: Re: REGRESSION: in intel video driver following introduction of mm_struct.has_pinned
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tony Fischetti <tony.fischetti@gmail.com>, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        rodrigo.vivi@intel.com
Date:   Tue, 29 Sep 2020 09:23:41 +0100
Message-ID: <160136782105.20502.13725312236043545047@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joonas Lahtinen (2020-09-29 09:18:34)
> (+ intel-gfx for being i915 related)
> (+ Chris who has looked into the issue)
> 
> Hi,
> 
> Thanks for reporting!

Fixed in commit a4d63c3732f1a0c91abcf5b7f32b4ef7dcd82025
Author: Jason A. Donenfeld <Jason@zx2c4.com>
Date:   Mon Sep 28 12:35:07 2020 +0200

    mm: do not rely on mm == current->mm in __get_user_pages_locked
-Chris
