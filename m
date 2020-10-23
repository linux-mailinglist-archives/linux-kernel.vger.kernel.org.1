Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5BF2978A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465898AbgJWVER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:04:17 -0400
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:41532 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S463274AbgJWVER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:04:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3A7C718029123;
        Fri, 23 Oct 2020 21:04:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3870:3871:3872:4321:5007:6120:7901:10004:10400:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:21080:21221:21611:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cause33_34001332725c
X-Filterd-Recvd-Size: 1685
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 23 Oct 2020 21:04:15 +0000 (UTC)
Message-ID: <4317722a8dc93b6de1dc974a8cb51c7f22d86ecf.camel@perches.com>
Subject: Re: [PATCH RFC v2] checkpatch: extend attributes check to handle
 more patterns
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 23 Oct 2020 14:04:13 -0700
In-Reply-To: <CABJPP5AcjAq0kg0MMggd2D6YUwVhq96otm-qQB3Snddt77VxAA@mail.gmail.com>
References: <20201023094307.20820-1-dwaipayanray1@gmail.com>
         <d2b05b45adbcf3f1d16692b054862a7aa7353f6d.camel@perches.com>
         <CABJPP5Dx4qj-_0gOx0bmaWvJj3okB-tNGJg5-8Y3KF2LnCjowQ@mail.gmail.com>
         <2e8279841d604dde8a3335c092db921007f6744e.camel@perches.com>
         <2a3b90ee-b9bd-2586-9d68-45cbf7e499a9@gmail.com>
         <8710630d8c01bf6f3749e3d11d193a805f2d2048.camel@perches.com>
         <CABJPP5AcjAq0kg0MMggd2D6YUwVhq96otm-qQB3Snddt77VxAA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-24 at 02:27 +0530, Dwaipayan Ray wrote:
> Also I tried the pattern  attr =~ s/^_*(.*)_*$/$1/
> for trimming the _ earlier. I think it doesn't trim the
> trailing underscores in the suffix as (.*) captures everything greedily.
>
> Is the iterative one perhaps okay instead?
> while($attr =~ s/(.*)_$/$1/) {}

Then perhaps
 
	$curr_attr =~ s/^_+//; $curr_attr =~ s/_+$//;


