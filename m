Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6164822FE16
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 01:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgG0Xg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 19:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgG0Xg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:36:56 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 649F22070B;
        Mon, 27 Jul 2020 23:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595893016;
        bh=jD76YQM8f/TUsUl8oDjD/7d0es35o7kkPw5jloOAyFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TrKJV2Cjw/I6yAzthI+7FxywCGioynOQReVA9DNc80OGtrbAAI2Hj3UKigr4m+JS+
         zu/Q9zsLGfb1fegaNxdjZHRmggIIfRCdiosXyES49FPbVXUquIuod2lGUX6BMmaSWC
         umC2RwRccGES3T/Q+1c6X/MjiWLMs1givxkbcRl8=
Date:   Mon, 27 Jul 2020 16:36:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joerg Vehlow <lkml@jv-coder.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in
 interrupt context
Message-Id: <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
In-Reply-To: <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
        <20200528084614.0c949e8d@gandalf.local.home>
        <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 06:30:53 +0200 Joerg Vehlow <lkml@jv-coder.de> wrote:

> >> About 12 years ago this was not implemented using a mutex, but using xchg.
> >> See: 8c5a1cf0ad3ac5fcdf51314a63b16a440870f6a2
> > Yes, that commit is wrong, because mutex_trylock() is not to be taken in
> > interrupt context, where crash_kexec() looks like it can be called.

Yup, mutex_trylock() from interrupt is improper.  Well dang, that's a
bit silly.  Presumably the 2006 spin_lock_mutex() wasn't taken with
irqs-off.

Ho hum, did you look at switching the kexec code back to the xchg
approach?

