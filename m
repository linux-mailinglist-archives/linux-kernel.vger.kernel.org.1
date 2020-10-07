Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B1E285A8A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgJGIcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:32:35 -0400
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:59520 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726463AbgJGIcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:32:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 29989180A7FC7;
        Wed,  7 Oct 2020 08:32:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:569:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3866:3867:3871:3872:4321:5007:10004:10400:10848:11232:11658:11914:12048:12297:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21627:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: nut33_0905109271cd
X-Filterd-Recvd-Size: 1622
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed,  7 Oct 2020 08:32:32 +0000 (UTC)
Message-ID: <0b3f06aca033deb1fe3b1635ff3932e7b3f4127a.camel@perches.com>
Subject: Re: [PATCH RFC] script: add a script for checking doc problems with
 external functions
From:   Joe Perches <joe@perches.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Date:   Wed, 07 Oct 2020 01:32:31 -0700
In-Reply-To: <87tuv6igwg.fsf@intel.com>
References: <20201005125920.27a7768d@coco.lan>
         <e40a32900dba6b8e7a1f41838ee8caeb1ef1c1b3.1601985151.git.mchehab+huawei@kernel.org>
         <87tuv6igwg.fsf@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-07 at 11:23 +0300, Jani Nikula wrote:
> On Tue, 06 Oct 2020, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > While not all EXPORT_SYMBOL*() symbols should be documented,
> > it seems useful to have a tool which would help to check what
> > symbols aren't documented.
> > 
> > This is a first step on this direction. The tool has some
> > limitations. Yet, it could be useful for maintainers to check
> > about missing documents on their subsystems.
> 
> Seems like this should be part of checkpatch.pl somehow.

I don't see how.


