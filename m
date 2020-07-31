Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D641D234070
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 09:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbgGaHri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 03:47:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41698 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727851AbgGaHri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596181657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ixNb2EBybLzWSoNGo2fASCaOj4fWf5R3chGaBD35os=;
        b=f5S1EOnyn3bNWpbd6J2jdtEOib6n3fSoG6LLKQR0LAxDrHPHfDQ/H3IrGeS37LRrJkApTs
        WBP8RQvO8BJXPXE+E3GMOdGIp48cAU1Kuox4PUz1+y9xWTax7XRqP45gkb2Kuq+rmxvXXQ
        qN0pUJZSvLvUkNV/Ez0/wremNAbNAoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-WL5PGebtPXuGD9vBIZq2qQ-1; Fri, 31 Jul 2020 03:47:34 -0400
X-MC-Unique: WL5PGebtPXuGD9vBIZq2qQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D89191005504;
        Fri, 31 Jul 2020 07:47:31 +0000 (UTC)
Received: from krava (unknown [10.40.194.13])
        by smtp.corp.redhat.com (Postfix) with SMTP id D3A2F7C0E0;
        Fri, 31 Jul 2020 07:47:27 +0000 (UTC)
Date:   Fri, 31 Jul 2020 09:47:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     peterz@infradead.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH 0/6] perf tools: Add wallclock time conversion support
Message-ID: <20200731074726.GA1485940@krava>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730221423.GH2638@hirez.programming.kicks-ass.net>
 <a59b833f-bcb7-3d1b-6e0c-8758b47b93a3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59b833f-bcb7-3d1b-6e0c-8758b47b93a3@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 07:21:54PM -0600, David Ahern wrote:
> On 7/30/20 4:14 PM, peterz@infradead.org wrote:
> > On Thu, Jul 30, 2020 at 11:39:44PM +0200, Jiri Olsa wrote:
> > 
> >> The patchset is adding the ability to display TOD/wallclock timestamp
> >> in 'perf script' output and in 'perf data convert --to-ctf' subcommand,
> >> so the converted CTF data contain TOD/wallclock timestamps.
> > 
> > But why? Wallclock is a horrible piece of crap. Why would you want to do
> > this?
> > 
> 
> Same reason I brought this up 9+ years ago: userspace lives on
> time-of-day, and troubleshooting is based on correlating timestamps from
> multiple sources. To correlate a perf event to syslog or an application
> log, we need time-of-day.

yep, we have a customer that needs to compare data from multiple servers

jirka

