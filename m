Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635EB2D6B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404318AbgLJWb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 17:31:28 -0500
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:39302 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405080AbgLJWU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:20:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D8DAB180374C4;
        Thu, 10 Dec 2020 22:20:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2691:2692:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6120:7903:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13095:13141:13230:13311:13357:13439:14096:14097:14659:21063:21080:21433:21627:21740:21741:21939:30034:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: pipe78_48138e9273fb
X-Filterd-Recvd-Size: 1865
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Dec 2020 22:20:13 +0000 (UTC)
Message-ID: <91b4b2f3591e6e8ce2d61daae31f2218d1a12b9e.camel@perches.com>
Subject: Re: [RFC PATCH v2] checkpatch: rewrite Kconfig parsing
From:   Joe Perches <joe@perches.com>
To:     Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Date:   Thu, 10 Dec 2020 14:20:12 -0800
In-Reply-To: <d97d491e-10fe-5c2e-ebdd-45f437afd257@fau.de>
References: <a07d684c-37ea-b589-c4b1-489e88b5caa5@fau.de>
         <97fb4ba0-68b3-8faf-1d98-e4990b2e63e3@fau.de>
         <776550b7fac3870e65e903f0d8cb917dec58f7c2.camel@perches.com>
         <d97d491e-10fe-5c2e-ebdd-45f437afd257@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-09 at 15:24 +0100, Nicolai Fischer wrote: 
> We understand that checkpatch may not be the ideal place for all of these checks.

So please work on an ideal thing.

> However the current implementation has some problems we would like to fix.
> Would you be interested in a patch series addressing just the check for the number of lines?
> Specifically:
> 1)
> > 
> > > 
> > > I believe all the '---help---' lines have been converted to just 'help'
> > > so the '(?:---)?' bits here could be removed.
> > 
> > Yes.
> > 
> 2) add string, hex and int types to the $is_start regex

sure

> 3) improve the help message to include the number of present and expected lines

no.  The concept of a required paragraph is still dubious.

> 4) Warn if help text is not followed by a blank line or endif

How often is it now not followed by a blank line or endif?


