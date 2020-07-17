Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F0F22408F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 18:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgGQQ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 12:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgGQQ1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:27:43 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48F0B2065F;
        Fri, 17 Jul 2020 16:27:42 +0000 (UTC)
Date:   Fri, 17 Jul 2020 12:27:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>
Subject: Re: [PATCH v5 02/17] perf ftrace: add option '-F/--funcs' to list
 available functions
Message-ID: <20200717122740.59186df2@oasis.local.home>
In-Reply-To: <20200717162116.GB712240@kernel.org>
References: <20200711124035.6513-1-changbin.du@gmail.com>
        <20200711124035.6513-3-changbin.du@gmail.com>
        <20200717110504.1650fbdc@oasis.local.home>
        <20200717162116.GB712240@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 13:21:16 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

>  
> > Would you like to start contributing to that, and when we get the
> > libtracefs.so packed in distributions, we can easily create the
> > perf ftrace without having to rewrite the wheel 10 times?  
> 
> Or we can use as soon as it is available, not preventing 'perf ftrace'
> from having to wait for libtracefs.so?
> 
> Duplication is normal at some point, Changbin is moving 'perf ftrace'
> forward, and has been doing this thru several patch series revisions, if
> we continue putting new requirements, it gets tiresome at some point :-\

We're finally at the point to move libtracefs.so and libtraceevent.so
into their own repository.

My fear is that the two will become incompatible, and forked forever.

-- Steve
