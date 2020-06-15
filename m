Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03CD1F8EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 09:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgFOHBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 03:01:08 -0400
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:58888 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728251AbgFOHBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:01:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 51DF9181D3025;
        Mon, 15 Jun 2020 07:00:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2919:3138:3139:3140:3141:3142:3622:3865:3867:3871:3873:4321:5007:8957:10004:10400:11232:11658:11914:12297:12740:12760:12895:13069:13255:13311:13357:13439:14659:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sand89_221708e26df4
X-Filterd-Recvd-Size: 1330
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Jun 2020 07:00:57 +0000 (UTC)
Message-ID: <404b3a391bd73acfc29f65d14b1586905ee5103c.camel@perches.com>
Subject: Re: Re: [PATCH v4 0/2] Recommend denylist/allowlist instead of
 blacklist/whitelist
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sjpark@amazon.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Jiri Slaby <jslaby@suse.cz>, Michael Ellerman <mpe@ellerman.id.au>,
        akpm@linux-foundation.org, apw@canonical.com,
        SeongJae Park <sjpark@amazon.de>, colin.king@canonical.com,
        sj38.park@gmail.com, linux-kernel@vger.kernel.org
Date:   Mon, 15 Jun 2020 00:00:56 -0700
In-Reply-To: <20200615064631.18910-1-sjpark@amazon.com>
References: <20200615064631.18910-1-sjpark@amazon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-15 at 08:46 +0200, SeongJae Park wrote:
> So, I agree this patch is imperfect for many cases, but better than nothing.

Not necessarily.

Having people strain for unusual equivalents
to generally well known terms is not good.

blacklist/whitelist is well understood.

Would you do the same for red/black?


