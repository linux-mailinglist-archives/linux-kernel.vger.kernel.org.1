Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6710C1C01D7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 18:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgD3QMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 12:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgD3QMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:12:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B68BE2076D;
        Thu, 30 Apr 2020 16:12:23 +0000 (UTC)
Date:   Thu, 30 Apr 2020 12:12:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
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
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
Message-ID: <20200430121222.3d17cb90@gandalf.local.home>
In-Reply-To: <50145570.77817.1588260209983.JavaMail.zimbra@efficios.com>
References: <20200429054857.66e8e333@oasis.local.home>
        <20200429105941.GQ30814@suse.de>
        <20200429082854.6e1796b5@oasis.local.home>
        <20200429100731.201312a9@gandalf.local.home>
        <20200430141120.GA8135@suse.de>
        <50145570.77817.1588260209983.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 11:23:29 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> I suspect it's called by:
> 
> include/linux/trace_event.h:trace_trigger_soft_disabled():
> 
> static inline bool
> trace_trigger_soft_disabled(struct trace_event_file *file)
> {
>         unsigned long eflags = file->flags;
> 
>         if (!(eflags & EVENT_FILE_FL_TRIGGER_COND)) {
>                 if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
>                         event_triggers_call(file, NULL, NULL);
>                 if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
>                         return true;
>                 if (eflags & EVENT_FILE_FL_PID_FILTER)
>                         return trace_event_ignore_this_pid(file);
>         }
>         return false;
> }

This code is only used for the "enable/disable event" triggers. Which isn't
the case here. So this should never be called.

-- Steve
