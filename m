Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071B22F6D56
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbhANVhQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Jan 2021 16:37:16 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:50534 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726614AbhANVhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:37:08 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23600604-1500050 
        for multiple; Thu, 14 Jan 2021 21:35:55 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210114163206.4a562d82@gandalf.local.home>
References: <20210114163206.4a562d82@gandalf.local.home>
Subject: Re: [Intel-gfx] [BUG] on reboot: bisected to: drm/i915: Shut down displays gracefully on reboot
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Date:   Thu, 14 Jan 2021 21:35:53 +0000
Message-ID: <161066015368.19482.10094410867880595092@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steven Rostedt (2021-01-14 21:32:06)
> On reboot, one of my test boxes now triggers the following warning:

057fe3535eb3 ("drm/i915: Disable RPM wakeref assertions during driver shutdown")
is included with the drm-intel-fixes PR.
-Chris
