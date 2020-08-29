Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EA5256ACF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 01:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgH2Xt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 19:49:59 -0400
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:56316 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728095AbgH2Xt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 19:49:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3E5A7837F24A;
        Sat, 29 Aug 2020 23:49:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3622:3866:3867:3868:3870:3871:3872:3874:4321:5007:10004:10400:11026:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:21080:21451:21627:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shock04_2e0f26127082
X-Filterd-Recvd-Size: 1596
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 29 Aug 2020 23:49:56 +0000 (UTC)
Message-ID: <461dfa640ae8e98b92ad82b6a5fbef843351d129.camel@perches.com>
Subject: Re: [PATCH] sysfs: Add sysfs_emit to replace sprintf to PAGE_SIZE
 buffers.
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 29 Aug 2020 16:49:55 -0700
In-Reply-To: <31462501-a1fc-7470-ce7c-70e7bd9c0d96@linux.com>
References: <a96cdf07cd136d06c3cc1e10eb884caa7498ba72.1598654887.git.joe@perches.com>
         <c77e83a0-7587-3e07-81cb-6b185d1ce6aa@linux.com>
         <fe4de2e9f0a492e66b870cddbadb820e3459cc7a.camel@perches.com>
         <31462501-a1fc-7470-ce7c-70e7bd9c0d96@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-08-30 at 00:53 +0300, Denis Efremov wrote:
> > Anyway, this will need updating, likely with better examples.
[]
> I think it's good to reflect in docs that sysfs_emit_at/sysfs_emit_pos is
> only for "legacy" code and should not be used in new code (checkpatch.pl warning?)
> because of sysfs design principles.

sysfs_emit_at is also used for arrays.


