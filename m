Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4CC234A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 20:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbgGaSFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 14:05:30 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:48034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733310AbgGaSFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:05:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 044C4182251B0;
        Fri, 31 Jul 2020 18:05:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3868:3872:4321:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:21080:21324:21627:21740:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: prose87_2707e7626f85
X-Filterd-Recvd-Size: 1202
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 Jul 2020 18:05:28 +0000 (UTC)
Message-ID: <83fc36d8c87408298a4cd6d66b140b330f2c45b0.camel@perches.com>
Subject: Re: [PATCH] checkpatch: skip macros when finding missing
 switch/case break
From:   Joe Perches <joe@perches.com>
To:     Cambda Zhu <cambda@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 31 Jul 2020 11:05:27 -0700
In-Reply-To: <20200729125911.47318-1-cambda@linux.alibaba.com>
References: <20200729125911.47318-1-cambda@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-29 at 20:59 +0800, Cambda Zhu wrote:
> The checkpatch.pl only searches 3 previous lines when finding missing
> switch/case break, and macros are treated as normal statements. If the
> cases are surrounded with CONFIG, checkpatch.pl may report false
> warnings. For example:

Likely this test should be removed altogether as
it's never really worked well and now compilers
find this and emit warnings.


