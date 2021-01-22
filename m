Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29308300FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbhAVWRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:17:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbhAVWRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:17:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0796723B09;
        Fri, 22 Jan 2021 22:16:54 +0000 (UTC)
Date:   Fri, 22 Jan 2021 17:16:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/3] tracing: Remove NULL check from current in
 tracing_generic_entry_update().
Message-ID: <20210122171653.5f53b743@gandalf.local.home>
In-Reply-To: <20210122171211.3d1de176@gandalf.local.home>
References: <20210112230057.2374308-1-bigeasy@linutronix.de>
        <20210112230057.2374308-4-bigeasy@linutronix.de>
        <20210122171211.3d1de176@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 17:12:11 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > I can't imagine when or why `current' would return a NULL pointer. This
> > check was added in commit
> >       72829bc3d63cd ("ftrace: move enums to ftrace.h and make helper function global")
> > 
> > but it doesn't give me hint why it was needed.
> > 
> > Assume `current' never returns a NULL pointer and remove the check.  
> 
> I'm guessing this is unrelated to the patch series, and I can take this now
> separately.
> 

Unrelated, except that it changes the copy not the original :-p

OK, I can wait till v2.

-- Steve
