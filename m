Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE20A2F8049
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbhAOQJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbhAOQJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:09:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE2102388B;
        Fri, 15 Jan 2021 16:09:15 +0000 (UTC)
Date:   Fri, 15 Jan 2021 11:09:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>
Subject: Re: [Intel-gfx] [BUG] on reboot: bisected to: drm/i915: Shut down
 displays gracefully on reboot
Message-ID: <20210115110914.540bf44d@gandalf.local.home>
In-Reply-To: <CAHk-=wgqPnjOUa0aDRHXC0UAePrM6kRUD9gR4g2x0mq91FD4xA@mail.gmail.com>
References: <20210114163206.4a562d82@gandalf.local.home>
        <161066015368.19482.10094410867880595092@build.alporthouse.com>
        <20210114170137.002763b3@gandalf.local.home>
        <CAHk-=wgqPnjOUa0aDRHXC0UAePrM6kRUD9gR4g2x0mq91FD4xA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 20:15:45 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Jan 14, 2021 at 2:01 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Thanks, I take it, it will be going into mainline soon.  
> 
> Just got merged - it might be a good idea to verify that your problem is solved.
> 

Yep, I just tested commit: 5ee88057889bbca5f5bb96031b62b3756b33e164 which
was your master of this morning. The problem appears to be removed.

Thanks!

-- Steve
