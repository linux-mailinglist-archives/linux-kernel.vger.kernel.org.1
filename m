Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DE11BCF42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 23:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgD1V6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 17:58:50 -0400
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:35370 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726286AbgD1V6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:58:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2DC23181D341E;
        Tue, 28 Apr 2020 21:58:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:982:988:989:1042:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3867:3871:3872:3873:4321:5007:7903:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21451:21627:21772:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rose21_1295f4037b114
X-Filterd-Recvd-Size: 1507
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Apr 2020 21:58:47 +0000 (UTC)
Message-ID: <d367cca3297fc07f5fc155f1e0b9b0e93c1b3cdf.camel@perches.com>
Subject: Re: [PATCH -next] perf script: remove unneeded conversion to bool
From:   Joe Perches <joe@perches.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Zou Wei <zou_wei@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Apr 2020 14:58:46 -0700
In-Reply-To: <20200428175046.GD5460@kernel.org>
References: <1587904265-865-1-git-send-email-zou_wei@huawei.com>
         <20200428175046.GD5460@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-28 at 14:50 -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Apr 26, 2020 at 08:31:05PM +0800, Zou Wei escreveu:
> > This issue was detected by using the Coccinelle software:
> > 
> > tools/perf/builtin-script.c:3285:48-53: WARNING: conversion to bool not needed here
> > tools/perf/builtin-script.c:2839:36-41: WARNING: conversion to bool not needed here
> > 
> > The conversion to bool is unneeded, remove it
> 
> Thanks, applied,

Did you read the patch?
It's broken, unless some other patch was applied.

