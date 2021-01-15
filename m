Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB432F804F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbhAOQLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:11:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbhAOQLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:11:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8331238A0;
        Fri, 15 Jan 2021 16:10:29 +0000 (UTC)
Date:   Fri, 15 Jan 2021 11:10:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ville.syrjala@linux.intel.com, lukas@wunner.de,
        chris@chris-wilson.co.uk
Subject: Re: [BUG] on reboot: bisected to: drm/i915: Shut down displays
 gracefully on reboot
Message-ID: <20210115111028.76aec4ac@gandalf.local.home>
In-Reply-To: <87mtxaprjy.fsf@intel.com>
References: <20210114163206.4a562d82@gandalf.local.home>
        <20210114163435.767ccbb0@gandalf.local.home>
        <87mtxaprjy.fsf@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 09:50:25 +0200
Jani Nikula <jani.nikula@intel.com> wrote:

> >>   fe0f1e3bfdfeb53e18f1206aea4f40b9bd1f291c
> >>   ("drm/i915: Shut down displays gracefully on reboot")
> >> 
> >> Which makes sense, as it happens on shutdown.  
> 
> Please try this pull, heading to -rc4, which cointains "drm/i915:
> Disable RPM wakeref assertions during driver shutdown":
> 
> http://lore.kernel.org/r/87sg73pz42.fsf@intel.com


Yep, Linus pulled in 057fe3535eb3 last night and it appears to fix the
issue in mainline.

Thanks!

-- Steve
