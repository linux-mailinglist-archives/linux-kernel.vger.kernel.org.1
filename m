Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9229277A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIXUdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIXUdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:33:35 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 658892399A;
        Thu, 24 Sep 2020 20:33:33 +0000 (UTC)
Date:   Thu, 24 Sep 2020 16:33:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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
Message-ID: <20200924163331.0080b943@oasis.local.home>
In-Reply-To: <1430794518.69084.1600979254425.JavaMail.zimbra@efficios.com>
References: <20200924170928.466191266@goodmis.org>
        <20200924171846.993048030@goodmis.org>
        <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com>
        <20200924143025.58dc3c1f@gandalf.local.home>
        <166273261.68446.1600974510284.JavaMail.zimbra@efficios.com>
        <20200924153517.73f5f257@oasis.local.home>
        <221547373.69067.1600977935633.JavaMail.zimbra@efficios.com>
        <20200924161328.760f5e79@oasis.local.home>
        <1430794518.69084.1600979254425.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 16:27:34 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> I'd be a bit more specific: so far, the msr.h use-case requires to include
> directly tracepoint-defs.h and use a tracepoint_enabled() macro defined there.
> 
> Other less "core" header use-cases could still include tracepoint.h, as long as
> there is no circular dependency.

Well, I'll keep tracepoint-defs.h for the msr.h case, and I could see
if tracepoint.h is good enough for the other cases.

But does it really matter, if we only need what is in
tracepoint-defs.h?  Why add something that may cause issues in the
future?

-- Steve
