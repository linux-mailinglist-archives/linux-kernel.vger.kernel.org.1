Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A7E28E5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgJNSFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:05:31 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:46422 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727071AbgJNSFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:05:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id F23C5180A885F;
        Wed, 14 Oct 2020 18:05:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3870:3871:3872:3874:4321:5007:6120:7875:10004:10400:10848:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fowl96_060b2a12720d
X-Filterd-Recvd-Size: 1440
Received: from XPS-9350 (cpe-72-134-80-165.natsow.res.rr.com [72.134.80.165])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 14 Oct 2020 18:05:28 +0000 (UTC)
Message-ID: <fc0c8503257ab6593ea8a1250ee3ac083a4ab5ee.camel@perches.com>
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ujjwal Kumar <ujjwalkumar0501@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Wed, 14 Oct 2020 11:05:27 -0700
In-Reply-To: <CANiq72kogiVbBURCrb74_vCPCLb09LGTudxE-QG8US7pX8LqQw@mail.gmail.com>
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
         <alpine.DEB.2.21.2010140734270.6186@felia>
         <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com>
         <CANiq72kogiVbBURCrb74_vCPCLb09LGTudxE-QG8US7pX8LqQw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-14 at 19:45 +0200, Miguel Ojeda wrote:
>   - Code that should be specially-formatted should be in a
> clang-format-off section to begin with, so it doesn't count.

clang-format is not the end-all tool.
Any 'formatting off/on' marker should be tool agnostic.


