Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680F02CFB7E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 15:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgLEN5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 08:57:50 -0500
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:33810 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726042AbgLEM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 07:59:48 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 1B3DB183531D3
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 12:05:07 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4F88A100E7B42;
        Sat,  5 Dec 2020 12:03:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3873:3874:4321:5007:7903:10004:10400:11026:11232:11473:11658:11914:12109:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:14721:21067:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wash17_2807e12273cc
X-Filterd-Recvd-Size: 1809
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat,  5 Dec 2020 12:03:24 +0000 (UTC)
Message-ID: <7b8289150f47b1fe32fc85f2082a4b727f2b1664.camel@perches.com>
Subject: Re: [PATCH v6] checkpatch: add fix for non-standard signature -
 co-authored-by
From:   Joe Perches <joe@perches.com>
To:     Aditya <yashsri421@gmail.com>, linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, daniel@iogearbox.net,
        peterz@infradead.org, gregkh@linuxfoundation.org
Date:   Sat, 05 Dec 2020 04:03:23 -0800
In-Reply-To: <b9048b9c-22cb-fc47-8e87-1c091a9cc822@gmail.com>
References: <a2c74693-93ae-cd5a-7836-4ffff643fc09@gmail.com>
         <20201204144000.21734-1-yashsri421@gmail.com>
         <b9048b9c-22cb-fc47-8e87-1c091a9cc822@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-12-05 at 15:52 +0530, Aditya wrote:
> On 4/12/20 8:10 pm, Aditya Srivastava wrote:
> > Currently, checkpatch.pl warns us for BAD_SIGN_OFF on the usage of
> > non-standard signatures.
[]
> > The standard signature equivalent for 'Co-authored-by' is
> > 'Co-developed-by'.
> > 
> > Provide a fix by suggesting users with this signature alternative and
> > replacing.

> we were planning to introduce a fix for
> suggesting users to use "Co-developed-by" tag over "Co-authored-by"
> and I noticed that you have earlier used "Co-authored-by" tag.
> 
> We feel that users perhaps use this tag as they are unaware of its
> standard equivalent tag, "Co-developed-by"

As I do not particularly approve of this patch,
"we" does not include "me", nor is it I presume
the royal usage.

Please specify who the "we" is here.

