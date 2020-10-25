Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393F62980DB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 09:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414591AbgJYIsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 04:48:10 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:40036 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1414581AbgJYIsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 04:48:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6A7A818224D77;
        Sun, 25 Oct 2020 08:48:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3870:4321:5007:10004:10400:10848:11026:11232:11658:11914:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:21063:21080:21433:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: back55_03039e727269
X-Filterd-Recvd-Size: 1522
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sun, 25 Oct 2020 08:48:06 +0000 (UTC)
Message-ID: <5789da1346a215e7c351c14562101ff07bc3de2a.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: extend attributes check to handle more
 patterns
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 25 Oct 2020 01:48:05 -0700
In-Reply-To: <CABJPP5AY7Vm4CBhhnqYo_LWFYY6PB2fgtk6CLR3tUEV1ZJNQpg@mail.gmail.com>
References: <20201025065134.21737-1-dwaipayanray1@gmail.com>
         <e96f8306d57e9a2ce7118b545db197e819e97b19.camel@perches.com>
         <CABJPP5D9ziuyPpPPyPM+n101vT1LGEjHj+JQjOhdN533t8Ud7w@mail.gmail.com>
         <80280a389782858c72fcd56a54da1a1f4153216c.camel@perches.com>
         <CABJPP5AY7Vm4CBhhnqYo_LWFYY6PB2fgtk6CLR3tUEV1ZJNQpg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-10-25 at 14:12 +0530, Dwaipayan Ray wrote:
> Suppose we have non handled attributes in one such
> multi attribute macro. (not present in our hash)
> 
> Like __attribute__((__packed, __something_not_handled))
> 
> For this case, do I skip the warning totally? Or something else?

Emit the warning, skip the fix unless all converted.


