Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130942A0583
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgJ3Me2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgJ3MeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:34:03 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E7D6221FF;
        Fri, 30 Oct 2020 12:34:00 +0000 (UTC)
Date:   Fri, 30 Oct 2020 08:33:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, kan.liang@linux.intel.com,
        like.xu@linux.intel.com, Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] perf/arch: Remove perf_sample_data::regs_user_copy
Message-ID: <20201030083358.4c771278@oasis.local.home>
In-Reply-To: <20201030105917.GI2611@hirez.programming.kicks-ass.net>
References: <20201030002722.766a22df@oasis.local.home>
        <20201030090037.GZ2628@hirez.programming.kicks-ass.net>
        <877dr8nh6u.fsf@nanos.tec.linutronix.de>
        <20201030105917.GI2611@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 11:59:17 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Oct 30, 2020 at 11:26:01AM +0100, Thomas Gleixner wrote:
> > What's worse is perf_sample_data which is 384 bytes and is 64 bytes aligned.  
> 
> Here; this shrinks it to 192 bytes. Combined with the static dummy this
> should reduce stack usage by 360 bytes.
> 
> ---
> Subject: perf/arch: Remove perf_sample_data::regs_user_copy
> 
> struct perf_sample_data lives on-stack, we should be careful about it's
> size. Furthermore, the pt_regs copy in there is only because x86_64 is a
> trainwreck, solve it differently.
> 
> Halves sizeof(perf_sample_data).
> 
> 


I tested with just this patch and it doesn't crash when running
function tracing and perf simultaneously.

-- Steve
