Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E9B28E687
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgJNSiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:38:03 -0400
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:39460 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727897AbgJNSiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:38:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3AC5418029124;
        Wed, 14 Oct 2020 18:38:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3872:3874:4321:5007:6119:6120:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21627:30029:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: stamp19_48036d92720e
X-Filterd-Recvd-Size: 1728
Received: from XPS-9350 (cpe-72-134-80-165.natsow.res.rr.com [72.134.80.165])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 14 Oct 2020 18:38:01 +0000 (UTC)
Message-ID: <b1469df9f90d5d4025c4ce7b189a4a3a31c9dbd7.camel@perches.com>
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ujjwal Kumar <ujjwalkumar0501@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Wed, 14 Oct 2020 11:37:59 -0700
In-Reply-To: <CANiq72nNkqu2a0KoDoj7Y0K2Ud37Ode5U9ju7JyPTtv58QJ3cw@mail.gmail.com>
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
         <alpine.DEB.2.21.2010140734270.6186@felia>
         <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com>
         <CANiq72kogiVbBURCrb74_vCPCLb09LGTudxE-QG8US7pX8LqQw@mail.gmail.com>
         <fc0c8503257ab6593ea8a1250ee3ac083a4ab5ee.camel@perches.com>
         <CANiq72nNkqu2a0KoDoj7Y0K2Ud37Ode5U9ju7JyPTtv58QJ3cw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-14 at 20:32 +0200, Miguel Ojeda wrote:
> On Wed, Oct 14, 2020 at 8:05 PM Joe Perches <joe@perches.com> wrote:
> > Any 'formatting off/on' marker should be tool agnostic.
> 
> Agreed, they should have used a compiler-agnostic name for the marker.

It means to me that linux has to invent one and any
clang-format use has to use an equivalent of the sphinx
.rst macro conversion scripts pre and post format.


