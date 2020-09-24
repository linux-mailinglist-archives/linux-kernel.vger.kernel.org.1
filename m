Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE682779FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgIXUNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIXUNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:13:33 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 375BD23899;
        Thu, 24 Sep 2020 20:13:31 +0000 (UTC)
Date:   Thu, 24 Sep 2020 16:13:28 -0400
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
Message-ID: <20200924161328.760f5e79@oasis.local.home>
In-Reply-To: <221547373.69067.1600977935633.JavaMail.zimbra@efficios.com>
References: <20200924170928.466191266@goodmis.org>
        <20200924171846.993048030@goodmis.org>
        <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com>
        <20200924143025.58dc3c1f@gandalf.local.home>
        <166273261.68446.1600974510284.JavaMail.zimbra@efficios.com>
        <20200924153517.73f5f257@oasis.local.home>
        <221547373.69067.1600977935633.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 16:05:35 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> If headers which happens to be included by include/trace/events/ headers are
> the issue, and they happen to only be needed by CREATE_TRACE_PROBES, then we
> should consider wrapping those #include with #ifdef CREATE_TRACE_PROBES guards.

Well, we are at a point you can't even use preempt_disable().

Whatever wants to use this tracepoint_enabled() macro, is going to have
to include something that doesn't include tracepoint.h.

-- Steve
