Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF682F6DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbhANWCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbhANWCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:02:20 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5983123A5E;
        Thu, 14 Jan 2021 22:01:39 +0000 (UTC)
Date:   Thu, 14 Jan 2021 17:01:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Intel-gfx] [BUG] on reboot: bisected to: drm/i915: Shut down
 displays gracefully on reboot
Message-ID: <20210114170137.002763b3@gandalf.local.home>
In-Reply-To: <161066015368.19482.10094410867880595092@build.alporthouse.com>
References: <20210114163206.4a562d82@gandalf.local.home>
        <161066015368.19482.10094410867880595092@build.alporthouse.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 21:35:53 +0000
Chris Wilson <chris@chris-wilson.co.uk> wrote:

> Quoting Steven Rostedt (2021-01-14 21:32:06)
> > On reboot, one of my test boxes now triggers the following warning:  
> 
> 057fe3535eb3 ("drm/i915: Disable RPM wakeref assertions during driver shutdown")
> is included with the drm-intel-fixes PR.

Thanks, I take it, it will be going into mainline soon.

-- Steve
