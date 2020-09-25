Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E427278E61
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgIYQ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgIYQ0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:26:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6F50206E5;
        Fri, 25 Sep 2020 16:26:49 +0000 (UTC)
Date:   Fri, 25 Sep 2020 12:26:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck <paulmck@kernel.org>,
        Michael Jeanson <mjeanson@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        linux-mm <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 1/2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
Message-ID: <20200925122647.230decde@oasis.local.home>
In-Reply-To: <965650354.69699.1601047806662.JavaMail.zimbra@efficios.com>
References: <20200924170928.466191266@goodmis.org>
        <20200924153517.73f5f257@oasis.local.home>
        <221547373.69067.1600977935633.JavaMail.zimbra@efficios.com>
        <20200924161328.760f5e79@oasis.local.home>
        <1430794518.69084.1600979254425.JavaMail.zimbra@efficios.com>
        <20200924163331.0080b943@oasis.local.home>
        <176393901.69671.1601044916547.JavaMail.zimbra@efficios.com>
        <20200925111415.60f5334c@oasis.local.home>
        <965650354.69699.1601047806662.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 11:30:06 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > Anyway, I don't see any issues with the current patch set as is
> > (besides the documentation fix, which I already updated locally). And
> > will add this to my queue for linux-next.  
> 
> The only thing I would change in the documentation is to word this as
> "here is a trampoline trick which can be used to work-around rare cases
> of tracepoint header circular dependency issues" rather than "always use
> this when instrumenting a header".
> 

I rather not have tracepoints in headers. Period!

It's not just about circular dependencies, it also bloats the code.

-- Steve

