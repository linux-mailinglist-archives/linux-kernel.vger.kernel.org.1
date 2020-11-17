Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895D82B6951
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgKQQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:04:30 -0500
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:34252 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725767AbgKQQEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:04:30 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4C9FE18225DF8;
        Tue, 17 Nov 2020 16:04:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3870:3872:3873:3874:4321:5007:7775:10004:10400:10848:11026:11232:11658:11914:12048:12297:12740:12760:12895:13069:13149:13230:13311:13357:13439:14659:21080:21627:21987:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: earth94_2c0ee1027332
X-Filterd-Recvd-Size: 1447
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Nov 2020 16:04:28 +0000 (UTC)
Message-ID: <6ba830d2a07b93e5c6602fcc1b329d74dcb7e2d8.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Fix unescaped left brace
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 17 Nov 2020 08:04:26 -0800
In-Reply-To: <CABJPP5CBccqvLVpzahMXhkuTt5Z+Gz-HaEGWgJdc4aMi4JsMEA@mail.gmail.com>
References: <20201115202928.81955-1-dwaipayanray1@gmail.com>
         <d3d6b68178b4193f04c35863163ce811a1571c0a.camel@perches.com>
         <67332536788cefbc39c7f87129adca462bb42fa5.camel@perches.com>
         <CABJPP5CBccqvLVpzahMXhkuTt5Z+Gz-HaEGWgJdc4aMi4JsMEA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-17 at 14:37 +0530, Dwaipayan Ray wrote:
> I have seen that
> the perl_version_ok check mandates perl 5.10 which was
> released more than 10 years back.
> 
> Do you think that check could be removed completely?
> Maybe sometime in the future or just have it lay around
> for backward compatibility?

I think having the check in the code isn't burdensome.


