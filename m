Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C27328BC1B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390095AbgJLPi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388881AbgJLPi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:38:27 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 728BB20575;
        Mon, 12 Oct 2020 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602517106;
        bh=5ilsmtgrr7sa13By8mYzL3sh1WhWQr5N6nl5iXe8aao=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TbgNgzJxo+0FX0UeaezbxCOm1ZqmUmL61RODQXvkh321n/JfvBt8uO5k6J69K6tVD
         M1JEcgN5KkfhUl1kAfJ16FTb++Q/5KHVtBxK1YvcGGKTLP2b4YVabH4Kc8u3x7SB2G
         ZxrlBktINi+RnZSYMSNMjFFCj4XCyldsummIjK7Y=
Message-ID: <68753123860c684af182bba48e12d7091be44d35.camel@kernel.org>
Subject: Re: [PATCH 0/5] tracing: Synthetic event dynamic string fixes
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Oct 2020 10:38:25 -0500
In-Reply-To: <20201012111324.0ea933e0@gandalf.local.home>
References: <cover.1602255803.git.zanussi@kernel.org>
         <20201012111324.0ea933e0@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 2020-10-12 at 11:13 -0400, Steven Rostedt wrote:
> On Fri,  9 Oct 2020 10:17:06 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > These patches provide fixes for the problems observed by Masami in
> > the
> > new synthetic event dynamic string patchset.
> > 
> > The first patch (tracing: Don't show dynamic string internals in
> > synthetic event description) removes the __data_loc from the event
> > description but leaves it in the format.
> > 
> > The patch (tracing: Add synthetic event error logging) addresses
> > the
> > lack of error messages when parse errors occur.
> > 
> > The remaining three patches address the other problems Masami noted
> > which result from allowing illegal characters in synthetic event
> > and
> > field names when defining an event.  The is_good_name() function is
> > used to check that's not possible for the probe events, but should
> > also be used for the synthetic events as well.
> > 
> > (tracing: Move is_good_name() from trace_probe.h to trace.h) makes
> > that function available to other trace subsystems by putting it in
> > trace.h.  (tracing: Check that the synthetic event and field names
> > are
> > legal) applies it to the synthetic events, and (selftests/ftrace:
> > Change synthetic event name for inter-event-combined test) changes
> > a
> > testcase that now fails because it uses an illegal name.
> > 
> 
> 
> Hi Tom,
> 
> Would you be able to address Masami's concerns on patches 1 and 4?

Yes, I'll submit a v2 fixing those soon (today).

Thanks,

Tom

> 
> -- Steve

