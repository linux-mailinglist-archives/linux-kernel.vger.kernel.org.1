Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A027723BE19
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 18:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgHDQYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 12:24:41 -0400
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:54150 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729855AbgHDQYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:24:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0A3BD180A8CB9;
        Tue,  4 Aug 2020 16:23:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3866:3867:3868:3870:3872:4321:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: pear24_610bb7826fa7
X-Filterd-Recvd-Size: 1601
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue,  4 Aug 2020 16:23:55 +0000 (UTC)
Message-ID: <470c32c1a781f3973a87321abf03e2fcd2dfc1eb.camel@perches.com>
Subject: Re: [PATCH] staging: wfx: fixed misspelled word in comment
From:   Joe Perches <joe@perches.com>
To:     Aditya Bansal <adbansal99@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Aug 2020 09:23:54 -0700
In-Reply-To: <CAEY4DyhRxwxqk80WWaPARYf7BxmM0T7AuLYhjcboLG+KP_XHMQ@mail.gmail.com>
References: <20200804145816.GA3823@aditya>
         <bc993561-e494-d6b5-fc73-eb56cb496d75@infradead.org>
         <fc7b8ab86d5a07525e546a23b97c1818331526b3.camel@perches.com>
         <CAEY4DyhRxwxqk80WWaPARYf7BxmM0T7AuLYhjcboLG+KP_XHMQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-04 at 16:07 +0530, Aditya Bansal wrote:
> Should I correct all the instances of the "careful" and submit the
> patch including both "carefull" and "function" word correct? or only
> for the "carefull"? I have already submitted one for the "funcion"
> word.

I suggest submitting a V2 patch with both fixes.

Generally it's better to submit all spelling fixes in a
single file at once, especially when multiple spelling
fixes are on the same line.

Also, it's generally better to submit separate patches
for individual files.


