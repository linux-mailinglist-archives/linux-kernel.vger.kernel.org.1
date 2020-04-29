Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A9F1BE392
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgD2QRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 12:17:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:41478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2QRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:17:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 75DF6AC8F;
        Wed, 29 Apr 2020 16:17:49 +0000 (UTC)
Date:   Wed, 29 Apr 2020 18:17:47 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before text_poke()
Message-ID: <20200429161747.GS30814@suse.de>
References: <20200429054857.66e8e333@oasis.local.home>
 <20200429105941.GQ30814@suse.de>
 <20200429082854.6e1796b5@oasis.local.home>
 <20200429100731.201312a9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429100731.201312a9@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:07:31AM -0400, Steven Rostedt wrote:
> Talking with Mathieu about this on IRC, he pointed out that my code does
> have a vzalloc() that is called:
> 
> in trace_pid_write()
> 
> 	pid_list->pids = vzalloc((pid_list->pid_max + 7) >> 3);
> 
> This is done when -P1,2 is on the trace-cmd command line.

And that buffer is written to at any function entry?

