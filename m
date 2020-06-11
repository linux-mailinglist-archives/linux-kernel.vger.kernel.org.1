Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1074C1F61C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 08:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgFKGfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 02:35:30 -0400
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:52340 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725805AbgFKGf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:35:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6CAFA1803106D;
        Thu, 11 Jun 2020 06:35:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3868:3870:3871:4321:5007:7576:8957:10004:10400:10848:11232:11658:11914:12297:12663:12740:12760:12895:13069:13311:13357:13439:14181:14659:21080:21451:21627:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: art98_5a13b2226dd1
X-Filterd-Recvd-Size: 1414
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jun 2020 06:35:25 +0000 (UTC)
Message-ID: <d323a6a114690e4757c777befc997d60d82558f2.camel@perches.com>
Subject: Re: [PATCH v4 0/2] Recommend denylist/allowlist instead of
 blacklist/whitelist
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sjpark@amazon.com>, akpm@linux-foundation.org,
        apw@canonical.com
Cc:     SeongJae Park <sjpark@amazon.de>, colin.king@canonical.com,
        sj38.park@gmail.com, jslaby@suse.cz, linux-kernel@vger.kernel.org
Date:   Wed, 10 Jun 2020 23:35:24 -0700
In-Reply-To: <20200611062550.20113-1-sjpark@amazon.com>
References: <20200611062550.20113-1-sjpark@amazon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-11 at 08:25 +0200, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> This patchset 1) adds support of deprecated terms in the 'checkpatch.pl'
> and 2) set the 'blacklist' and 'whitelist' as deprecated with
> replacement suggestion of 'denylist' and 'allowlist', because the
> suggestions are incontrovertible, doesn't make people hurt, and more
> self-explanatory.

While the checkpatch implementation is better,
I'm still very "meh" about the whole concept.


