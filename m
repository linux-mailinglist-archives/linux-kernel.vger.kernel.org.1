Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECAF1F7451
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 09:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgFLHF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 03:05:59 -0400
Received: from smtprelay0051.hostedemail.com ([216.40.44.51]:47208 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbgFLHF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:05:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8C16C180A7FF5;
        Fri, 12 Jun 2020 07:05:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2110:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3291:3352:3622:3865:3866:3867:3868:3870:3872:3873:3874:4321:5007:6742:7903:8957:10004:10400:10848:10967:11232:11658:11914:12297:12663:12740:12760:12895:13069:13149:13230:13255:13311:13357:13439:14181:14659:14721:21080:21095:21627:21854:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: war82_46171af26dda
X-Filterd-Recvd-Size: 1713
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 12 Jun 2020 07:05:56 +0000 (UTC)
Message-ID: <f3e43aaaafc014fc7564652798b61754d7e437ea.camel@perches.com>
Subject: Re: Re: [PATCH v4 0/2] Recommend denylist/allowlist instead of
 blacklist/whitelist
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, akpm@linux-foundation.org,
        apw@canonical.com, SeongJae Park <sjpark@amazon.de>,
        colin.king@canonical.com, sj38.park@gmail.com,
        linux-kernel@vger.kernel.org, kristen.c.accardi@intel.com,
        mishi@linux.com, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org
Date:   Fri, 12 Jun 2020 00:05:55 -0700
In-Reply-To: <20200612064009.31523-1-sjpark@amazon.com>
References: <20200612064009.31523-1-sjpark@amazon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-12 at 08:40 +0200, SeongJae Park wrote:
> On Thu, 11 Jun 2020 03:43:32 -0700 Joe Perches <joe@perches.com> wrote:
> > On Thu, 2020-06-11 at 10:32 +0200, Jiri Slaby wrote:
> > > On 11. 06. 20, 10:30, SeongJae Park wrote:
> > > > For example, as it seems at least you and I agree on the f-word to hug
> > > > replacement, we could add ``fuck||hug`` in the `deprecated_terms.txt` file to
> > > > avoid future spread of the f-words.
[]
> > $ git grep -i '\bfuck' | wc -l
> > 15
> 
> I'm not understanding what you're meaning with this.  Could I ask your
> explanation, please?

Just that there are 15 instances of that word in the kernel.

cheers, Joe

