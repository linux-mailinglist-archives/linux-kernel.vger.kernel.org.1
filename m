Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB41F5D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 22:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgFJUY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 16:24:57 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:42002 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726982AbgFJUY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:24:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 647F918028E68;
        Wed, 10 Jun 2020 20:24:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:1978:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3867:3868:3872:3873:3874:4321:5007:7514:7903:10004:10400:10848:10946:11026:11473:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wing27_440e66526dce
X-Filterd-Recvd-Size: 1668
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 20:24:55 +0000 (UTC)
Message-ID: <2024b2594378686f24279488f0d80ad8f13a9181.camel@perches.com>
Subject: Re: WIP generic module->debug_flags and dynamic_debug
From:   Joe Perches <joe@perches.com>
To:     jim.cromie@gmail.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Randy Dunlap <rdunlap@infradead.org>
Date:   Wed, 10 Jun 2020 13:24:54 -0700
In-Reply-To: <CAJfuBxzxwoyXbDrgQzb=BZJ8ZQ5hHo32Zr1uo6Od=7+q13+GXQ@mail.gmail.com>
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
         <20200609104604.1594-7-stanimir.varbanov@linaro.org>
         <CAJfuBxzxwoyXbDrgQzb=BZJ8ZQ5hHo32Zr1uo6Od=7+q13+GXQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 12:32 -0600, jim.cromie@gmail.com wrote:
> so Ive got a WIP / broken / partial approach to giving all modules a
> u32 flagset,
> and enabling pr_debug based upon it.  I leave out the "pr_debug_typed(
> bitpos )" for now.  For Stanimir, bits 1,2,3 could be high, middle,
> low.

Can you change this please to be a pointer to an unsigned long/int?

That way, existing non-dynamic debug uses like

MODULE_PARM_DESC(debug, "module specific debug control");

maybe could use the same mechanism to enable/disable by class.


