Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353C122D8B0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 18:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgGYQg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 12:36:56 -0400
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:58544 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726567AbgGYQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 12:36:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 13F411817BAA6;
        Sat, 25 Jul 2020 16:36:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2689:2693:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6117:9025:10004:10400:10848:11232:11658:11914:12043:12297:12555:12740:12895:13069:13157:13228:13311:13357:13894:14180:14181:14659:14721:14764:21080:21611:21627:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cats52_36037bd26f51
X-Filterd-Recvd-Size: 1668
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 25 Jul 2020 16:36:53 +0000 (UTC)
Message-ID: <58fa2a308db8a27df72f94a880df3224bffab86d.camel@perches.com>
Subject: Re: checkpatch: support deprecated terms checking
From:   Joe Perches <joe@perches.com>
To:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        apw@canonical.com, colin.king@canonical.com, sj38.park@gmail.com,
        jslaby@suse.cz, pavel@ucw.cz
Date:   Sat, 25 Jul 2020 09:36:51 -0700
In-Reply-To: <20200725130248.GC18633@qmqm.qmqm.pl>
References: <20200725130248.GC18633@qmqm.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-07-25 at 15:02 +0200, Michał Mirosław wrote:
> Hello,
> 
> I see that this patch went into next and is already inciting people to
> do wrong things [1]. Can you please fix it to require '--subjective'
> switch or otherwise mark it clearly as suggestion-only?
> 
> The coding-style as in Linus' master says about *NEW* uses of the words
> listed (those introductions I expect to be actually rare) and not about
> existing use in the code or industry. Making a noise about all uses
> found surely will generate a lot more irrelevant patches.
> 
> [1] https://www.spinics.net/lists/linux-tegra/msg51849.html

I was never a big fan of this change.

Andrew, can you revert this please?


