Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2B81C3E83
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgEDPbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 11:31:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:38134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgEDPbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:31:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F12A2AF5C;
        Mon,  4 May 2020 15:31:39 +0000 (UTC)
Date:   Mon, 4 May 2020 17:31:35 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
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
Subject: Re: [PATCH] percpu: Sync vmalloc mappings in pcpu_alloc() and
 free_percpu()
Message-ID: <20200504153135.GJ8135@suse.de>
References: <20200429054857.66e8e333@oasis.local.home>
 <20200430141120.GA8135@suse.de>
 <20200430121136.6d7aeb22@gandalf.local.home>
 <20200430191434.GC8135@suse.de>
 <20200430211308.74a994dc@oasis.local.home>
 <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
 <20200430223919.50861011@gandalf.local.home>
 <20200504151236.GI8135@suse.de>
 <99290786.82178.1588606126392.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99290786.82178.1588606126392.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 11:28:46AM -0400, Mathieu Desnoyers wrote:
> ----- On May 4, 2020, at 11:12 AM, Joerg Roedel jroedel@suse.de wrote:
> Placing this here is inefficient. It syncs mappings for each percpu allocation.
> I would recommend moving it right after __vmalloc() is called to allocate the
> underlying memory chunk instead:
> 
> static void *pcpu_mem_zalloc(size_t size, gfp_t gfp)
> {

Tried this before, actually I put it into the caller of
pcpu_mem_zalloc(), but that didn't fix the problem for me. Stevens
test-case still hangs the machine.


Regards,

	Joerg
