Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39B1CB21B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 16:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgEHOmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 10:42:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:53840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgEHOmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:42:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 829C1AE2E;
        Fri,  8 May 2020 14:42:36 +0000 (UTC)
Date:   Fri, 8 May 2020 16:42:29 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH] tracing: Call vmalloc_sync_mappings() after
 alloc_percpu()
Message-ID: <20200508144229.GO8135@suse.de>
References: <20200430191434.GC8135@suse.de>
 <20200430211308.74a994dc@oasis.local.home>
 <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
 <20200430223919.50861011@gandalf.local.home>
 <20200504151236.GI8135@suse.de>
 <20200504134042.178409c3@gandalf.local.home>
 <20200504183832.GL8135@suse.de>
 <20200504151006.69d2a16c@gandalf.local.home>
 <20200505123144.GM8135@suse.de>
 <20200506111704.5a97a3e2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506111704.5a97a3e2@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 11:17:04AM -0400, Steven Rostedt wrote:
> OK, I did take authorship. At least it will be me who gets the blame ;-)

Okay, I meanwhile worked on the removal of vmalloc_sync_(un)mappings.
Let's see what people think about it.

Regards,

	Joerg
