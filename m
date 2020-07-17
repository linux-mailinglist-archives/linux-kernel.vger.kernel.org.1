Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D722240B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 18:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGQQhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 12:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgGQQhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:37:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21CD82065E;
        Fri, 17 Jul 2020 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595003858;
        bh=M25Ak9N76phcop4nhODTZl3XiQ185fxbNFqhkP2BzEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIp4AhYWiZvZ/Qp3qSrnCMw/TkCl8xK5ItR/6BKz679cx4oX7KrYURkHbVfVGh351
         gZ66kZtAVEl+drvVMDwMGmLjsywAp3uDegetLMjbo/6HelDcQQ2tqEwnQeUxjxE81i
         T6A5L4L2sdJ/nquBjEU94ToXDVSVVW8W0/L8/xJQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 79BA640482; Fri, 17 Jul 2020 13:37:35 -0300 (-03)
Date:   Fri, 17 Jul 2020 13:37:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>
Subject: Re: [PATCH v5 02/17] perf ftrace: add option '-F/--funcs' to list
 available functions
Message-ID: <20200717163735.GC712240@kernel.org>
References: <20200711124035.6513-1-changbin.du@gmail.com>
 <20200711124035.6513-3-changbin.du@gmail.com>
 <20200717110504.1650fbdc@oasis.local.home>
 <20200717162116.GB712240@kernel.org>
 <20200717122740.59186df2@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717122740.59186df2@oasis.local.home>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 17, 2020 at 12:27:40PM -0400, Steven Rostedt escreveu:
> On Fri, 17 Jul 2020 13:21:16 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Would you like to start contributing to that, and when we get the
> > > libtracefs.so packed in distributions, we can easily create the
> > > perf ftrace without having to rewrite the wheel 10 times?  

> > Or we can use as soon as it is available, not preventing 'perf ftrace'
> > from having to wait for libtracefs.so?

> > Duplication is normal at some point, Changbin is moving 'perf ftrace'
> > forward, and has been doing this thru several patch series revisions, if
> > we continue putting new requirements, it gets tiresome at some point :-\
 
> We're finally at the point to move libtracefs.so and libtraceevent.so
> into their own repository.
 
> My fear is that the two will become incompatible, and forked forever.

I don't share this fear, and since libtracefs is not generally
available, this will make perf progress to be slowed down, so its better
to merge what he has so far, after some review issues that surfaced are
solved, and when a better way of achieving that is available, consider
using it.

- Arnaldo
