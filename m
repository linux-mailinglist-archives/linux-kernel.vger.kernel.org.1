Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326A528BB99
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389623AbgJLPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389225AbgJLPN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:13:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB66620878;
        Mon, 12 Oct 2020 15:13:25 +0000 (UTC)
Date:   Mon, 12 Oct 2020 11:13:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] tracing: Synthetic event dynamic string fixes
Message-ID: <20201012111324.0ea933e0@gandalf.local.home>
In-Reply-To: <cover.1602255803.git.zanussi@kernel.org>
References: <cover.1602255803.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Oct 2020 10:17:06 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> These patches provide fixes for the problems observed by Masami in the
> new synthetic event dynamic string patchset.
> 
> The first patch (tracing: Don't show dynamic string internals in
> synthetic event description) removes the __data_loc from the event
> description but leaves it in the format.
> 
> The patch (tracing: Add synthetic event error logging) addresses the
> lack of error messages when parse errors occur.
> 
> The remaining three patches address the other problems Masami noted
> which result from allowing illegal characters in synthetic event and
> field names when defining an event.  The is_good_name() function is
> used to check that's not possible for the probe events, but should
> also be used for the synthetic events as well.
> 
> (tracing: Move is_good_name() from trace_probe.h to trace.h) makes
> that function available to other trace subsystems by putting it in
> trace.h.  (tracing: Check that the synthetic event and field names are
> legal) applies it to the synthetic events, and (selftests/ftrace:
> Change synthetic event name for inter-event-combined test) changes a
> testcase that now fails because it uses an illegal name.
> 


Hi Tom,

Would you be able to address Masami's concerns on patches 1 and 4?

-- Steve
