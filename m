Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B10329164C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 09:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgJRHLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 03:11:25 -0400
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:50734 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgJRHLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 03:11:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7FDA4181D341E;
        Sun, 18 Oct 2020 07:11:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2110:2198:2199:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3350:3622:3865:3867:3868:3870:3871:3872:4321:5007:7903:10004:10400:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:21740,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sand51_3b152dd2722c
X-Filterd-Recvd-Size: 1625
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 18 Oct 2020 07:11:21 +0000 (UTC)
Message-ID: <e417e506c23ad56b2618204071c86e8a6ec2cb85.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: add new exception to repeated word check
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 18 Oct 2020 00:11:20 -0700
In-Reply-To: <CABJPP5Cr3giDJkJvBDd62iwx6y6r1dFhaVXp9jYXS8Y6k9b09A@mail.gmail.com>
References: <20201017162732.152351-1-dwaipayanray1@gmail.com>
         <1ad9c5f49e10a192f0c6efb1116f3f0d31adce74.camel@perches.com>
         <CABJPP5DuQ_Y0LLS5BzNXUWyxjzp9ts5kgEH-3+7Pn7PPjq0Ljg@mail.gmail.com>
         <eda7a64b4af42ba1fb66a5b3704780cf3f761951.camel@perches.com>
         <CABJPP5Cr3giDJkJvBDd62iwx6y6r1dFhaVXp9jYXS8Y6k9b09A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-10-18 at 12:10 +0530, Dwaipayan Ray wrote:
> print index(" \t.,;?!", '');
> 
> It output 0 in my case. So last words on a line seems to work.
> I don't know if this changes with the perl version though.
> 
> So given this, will it be necessary to change end_char to ' ' ?
> or perhaps change both start_char and end_char to a ' ' to maintain
> uniformity?

It seems it's fine even back to perl 5.6, so it's fine as is.

cheers, Joe


