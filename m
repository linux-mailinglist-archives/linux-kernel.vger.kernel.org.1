Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C385819CF59
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 06:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbgDCEfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 00:35:33 -0400
Received: from smtprelay0131.hostedemail.com ([216.40.44.131]:33954 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbgDCEfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:35:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DF844182CED5B;
        Fri,  3 Apr 2020 04:35:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3868:3871:4250:4321:5007:7903:10004:10400:10848:11232:11658:11914:12297:12663:12740:12760:12895:13019:13069:13311:13357:13439:14659:14721:21080:21611:21627:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: seed33_4d3b0b285b054
X-Filterd-Recvd-Size: 1327
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Apr 2020 04:35:30 +0000 (UTC)
Message-ID: <d74075e94b39b23d2e3acb24baaaedacfd0cc426.camel@perches.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: emxx_udc: Remove unused code
From:   Joe Perches <joe@perches.com>
To:     "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Apr 2020 21:33:34 -0700
In-Reply-To: <4bd376a6db77ef779972f377cc2c3789d03668e7.camel@gmail.com>
References: <20200402021706.788533-1-jbwyatt4@gmail.com>
         <20200403015057.7a972c79@elisabeth>
         <4bd376a6db77ef779972f377cc2c3789d03668e7.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-02 at 18:42 -0700, John B. Wyatt IV wrote:
> DEBUG is not actually used as far as I can tell (I am still new to
> kernel debugging systems to please correct me).

DEBUG is used by the <foo>_debug and <bar>_dbg macros
(pr_debug, dev_dbg)



