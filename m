Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64830240B16
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 18:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgHJQWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 12:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgHJQWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:22:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D242E2083B;
        Mon, 10 Aug 2020 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597076551;
        bh=TMB+YPg30okjjFLgmu8bD6p0VeNkGsMlsaIVFAzVu38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pgQGCr8VheKcxUlrfeeGOEkt0utWJcaORg7Ddn0uU3m5JhhvK61aEg7qamOMJRFJ9
         aZ0hCdXk42gqATKTayVQkto0uHULpfFYSWqneqbwxB1Hu4uVan0ai4xyyJX/dJqSHw
         qQSeK/HcSsjZZmKvXG2gMLgRLC9QSz88kPQ02BcY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F04F4403C6; Mon, 10 Aug 2020 13:22:28 -0300 (-03)
Date:   Mon, 10 Aug 2020 13:22:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Ahern <dsahern@gmail.com>
Cc:     David Ahern <dsahern@kernel.org>, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH 1/2] perf sched: Prefer sched_waking event when it exists
Message-ID: <20200810162228.GB4527@kernel.org>
References: <20200807164844.44870-1-dsahern@kernel.org>
 <20200807194335.GF2456573@kernel.org>
 <d1e7bc58-122e-5e33-9f7c-d0cdfe4bb9b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1e7bc58-122e-5e33-9f7c-d0cdfe4bb9b2@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 07, 2020 at 01:50:47PM -0600, David Ahern escreveu:
> On 8/7/20 1:43 PM, Arnaldo Carvalho de Melo wrote:
> >> @@ -2958,9 +2967,10 @@ static int timehist_check_attr(struct perf_sched *sched,
> >>  
> >>  static int perf_sched__timehist(struct perf_sched *sched)
> >>  {
> >> -	const struct evsel_str_handler handlers[] = {
> >> +	struct evsel_str_handler handlers[] = {
> >>  		{ "sched:sched_switch",       timehist_sched_switch_event, },
> >>  		{ "sched:sched_wakeup",	      timehist_sched_wakeup_event, },
> >> +		{ "sched:sched_waking",       timehist_sched_wakeup_event, },
> >>  		{ "sched:sched_wakeup_new",   timehist_sched_wakeup_event, },
> >>  	};
> >>  	const struct evsel_str_handler migrate_handlers[] = {
> >> @@ -3018,6 +3028,11 @@ static int perf_sched__timehist(struct perf_sched *sched)
> >>  
> >>  	setup_pager();
> >>  
> >> +	/* prefer sched_waking if it is captured */
> >> +	if (perf_evlist__find_tracepoint_by_name(session->evlist,
> >> +						  "sched:sched_waking"))
> >> +		handlers[1].handler = timehist_sched_wakeup_ignore;
> >> +
> > 
> > 
> > ouch, can't we figure out if its present and then don't ask for the
> > wakeup one to be recorded?
> > 
> 
> This is the analysis side. If someone recorded with sched:* we do not
> want to analyze both sched_wakeup and sched_waking. Rather, it should
> prefer the latter and ignore the former.

Right you are, thans for the explanation, I should've noticed that :)

- Arnaldoi
