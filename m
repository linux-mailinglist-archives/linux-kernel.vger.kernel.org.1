Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF0B1F4E87
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 09:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgFJHGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 03:06:21 -0400
Received: from smtprelay0093.hostedemail.com ([216.40.44.93]:58456 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726095AbgFJHGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:06:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C2977180A7FF8;
        Wed, 10 Jun 2020 07:06:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:8957:10004:10400:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:21080:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: art91_5d16ec026dc9
X-Filterd-Recvd-Size: 1435
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 07:06:18 +0000 (UTC)
Message-ID: <21c42f96b7f2b105e863a9f4ddf87f4e95a86393.camel@perches.com>
Subject: Re: [PATCH v3 0/2] Recommend blocklist/allowlist instead of
 blacklist/whitelist
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sjpark@amazon.com>, akpm@linux-foundation.org,
        apw@canonical.com
Cc:     colin.king@canonical.com, sj38.park@gmail.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Date:   Wed, 10 Jun 2020 00:06:17 -0700
In-Reply-To: <20200610065223.29894-1-sjpark@amazon.com>
References: <20200610065223.29894-1-sjpark@amazon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 08:52 +0200, SeongJae Park wrote:
> This patchset 1) adds support of deprecated terms in the 'checkpatch.pl'
> and 2) set the 'blacklist' and 'whitelist' as deprecated with
> replacement suggestion of 'blocklist' and 'allowlist', because the
> suggestions are incontrovertible, doesn't make people hurt, and more
> self-explanatory.

I don't care for the politics of the patch myself.

From a technical perspective, it may be better to
have a single routine for both spelling and whatever
this is called.


