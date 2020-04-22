Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2461B4E45
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 22:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDVUUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 16:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgDVUUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:20:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C97CB20767;
        Wed, 22 Apr 2020 20:20:07 +0000 (UTC)
Date:   Wed, 22 Apr 2020 16:20:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, jthierry@redhat.com, alexandre.chartre@oracle.com
Subject: Re: [PATCH v5 04/17] x86,ftrace: Fix ftrace_regs_caller() unwind
Message-ID: <20200422162006.689881e9@gandalf.local.home>
In-Reply-To: <20200422094446.GY20730@hirez.programming.kicks-ass.net>
References: <20200416114706.625340212@infradead.org>
        <20200416115118.749606694@infradead.org>
        <20200421203345.4e165c4b@oasis.local.home>
        <20200422094446.GY20730@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 11:44:46 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> So can I push out those patches as is? :-) We can do this on top I
> suppose.

My tests just finished. You can add my:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

to the three patches that touch the ftrace code in this series.

I'll continue to tinker with my patches that modify that code as well.

-- Steve
