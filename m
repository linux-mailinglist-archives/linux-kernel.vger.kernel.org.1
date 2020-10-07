Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393BE2866C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgJGSSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:18:49 -0400
Received: from smtprelay0181.hostedemail.com ([216.40.44.181]:58482 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgJGSSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:18:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D4D2718029128;
        Wed,  7 Oct 2020 18:18:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:4321:5007:7514:10004:10400:10848:11026:11232:11473:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21627:30003:30029:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: train85_06054c8271d1
X-Filterd-Recvd-Size: 1373
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed,  7 Oct 2020 18:18:46 +0000 (UTC)
Message-ID: <a2db6d34e964bd5ca65f59d1a536a61df71fc955.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: add new warnings to author signoff
 checks.
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 07 Oct 2020 11:18:45 -0700
In-Reply-To: <CABJPP5AEELQz0t2+34xYQOJ5e5nQzTUUU6UT8ZH0fqm-tacOmg@mail.gmail.com>
References: <20201007063315.41585-1-dwaipayanray1@gmail.com>
         <CABJPP5AEELQz0t2+34xYQOJ5e5nQzTUUU6UT8ZH0fqm-tacOmg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-07 at 12:08 +0530, Dwaipayan Ray wrote:
> On Wed, Oct 7, 2020 at 12:03 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> > The author signed-off-by checks are currently very vague.
> > Cases like same name or same address are not handled separately.

Likely now, the type should be changed from NO_AUTHOR_SIGN_OFF
to a single something else for all the other types of messages.


