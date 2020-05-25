Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297221E140B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 20:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbgEYSYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 14:24:32 -0400
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:57382 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387644AbgEYSYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 14:24:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D8289837F24A;
        Mon, 25 May 2020 18:24:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2908:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3872:3873:3874:4321:5007:6119:7901:8531:10004:10400:10848:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:14777:21080:21324:21433:21451:21627:21819:30030:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: boy42_4301fb626d43
X-Filterd-Recvd-Size: 1665
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 May 2020 18:24:29 +0000 (UTC)
Message-ID: <7b93effe211b5439b6b8697e8ed3a2b070bfbb31.camel@perches.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
From:   Joe Perches <joe@perches.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 May 2020 11:24:28 -0700
In-Reply-To: <0b3b5ae5-457a-b550-63a8-08a77bb862d7@al2klimov.de>
References: <20200520200037.88705-1-grandmaster@al2klimov.de>
         <20200525102825.63d72ed2@lwn.net>
         <0b3b5ae5-457a-b550-63a8-08a77bb862d7@al2klimov.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-25 at 20:01 +0200, Alexander A. Klimov wrote:
> Does it matter whether I just feed the output of ...
> 
> perl scripts/get_maintainer.pl --separator , --norolestats 
> 0001-Replace-HTTP-links-with-HTTPS-ones-documentation.patch
> 
> ... into Git send-email To: prompt or actually CC: (not To:) mailing lists?

Yes.  vger mailing lists drop emails with large to:/cc:
headers (It was >1024 chars, it may be different now)

It's generally better to add --nogit --nogit-fallback to
get_maintainer to avoid the git lookup addition of people
that have modified files that aren't listed in MAINTAINERS.

You could add a --bcc with those dropped names if you
really want to have those people receive the emails.

