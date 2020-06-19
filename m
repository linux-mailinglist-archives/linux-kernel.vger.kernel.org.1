Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9F201B60
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbgFSThR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 15:37:17 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:58610 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387688AbgFSThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:37:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 928371801E0BD;
        Fri, 19 Jun 2020 19:37:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 94,12.5,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:4321:5007:6119:9389:10013:10400:10848:10967:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21627:21740:21741:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: hot07_310c0a226e1b
X-Filterd-Recvd-Size: 1975
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Jun 2020 19:37:14 +0000 (UTC)
Message-ID: <369b8060416ad9507ba1cd1160e20bc2f0ea7e5d.camel@perches.com>
Subject: Re: [PATCH] Documentation: Fix most typos
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 19 Jun 2020 12:37:13 -0700
In-Reply-To: <20200619132045.6120f4eb@lwn.net>
References: <9587fe318ac88299131e751a07bdd1f4b69ae0de.camel@perches.com>
         <20200619132045.6120f4eb@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-19 at 13:20 -0600, Jonathan Corbet wrote:
> On Wed, 10 Jun 2020 16:07:32 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > These are the typos found in scripts/spelling.txt for
> > most of the Documentation/ tree.
> > 
> > Scripted with:
> > 
> > $ cat scripts/spelling.txt | \
> >   grep -v -P "^\s*\#" | \
> >   while read line ; do \
> >     from=$(echo $line | cut -f1 -d'|'); \
> >     to=$(echo $line | cut -f3 -d'|'); \
> >     echo "from: $from to: $to" ; \
> >     git grep -w --name-only $from | \
> >     xargs sed -i "s/\b$from\b/$to/" ; \
> >     git checkout scripts/spelling.txt ; \
> >   done
> > 
> > And some removal of inappropriate conversions
> > in Documentation/translations and a few files
> > where the conversions were incorrect.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> So this fails badly against current docs-next...any chance of a redo?

This patch still works against current -next.

Maybe your tree should be added to -next so
people don't have to search out specific trees.

git git://git.lwn.net/linux.git docs-next

