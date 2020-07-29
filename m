Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BF42316BA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 02:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgG2AZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 20:25:55 -0400
Received: from smtprelay0120.hostedemail.com ([216.40.44.120]:44614 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730449AbgG2AZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:25:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3AA9D2473;
        Wed, 29 Jul 2020 00:25:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:9025:10004:10400:10848:11232:11658:11914:12043:12048:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:14764:21063:21080:21347:21451:21627:30041:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rock34_340ae5326f6e
X-Filterd-Recvd-Size: 1689
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Jul 2020 00:25:52 +0000 (UTC)
Message-ID: <e301110c6aa504be56ec73a355d3aa9215fc9633.camel@perches.com>
Subject: Re: [PATCH][next] greybus: Use fallthrough pseudo-keyword
From:   Joe Perches <joe@perches.com>
To:     Alex Elder <elder@ieee.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Jul 2020 17:25:50 -0700
In-Reply-To: <63871608-e076-26b0-85df-cff11699c3a3@ieee.org>
References: <20200727183258.GA28571@embeddedor>
         <63871608-e076-26b0-85df-cff11699c3a3@ieee.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-28 at 17:37 -0500, Alex Elder wrote:
> On 7/27/20 1:32 PM, Gustavo A. R. Silva wrote:
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1].
> > 
> > [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Thanks for the patch.  It looks good, but it raises
> another question I'd like discussion on.
> 
> It seems that Johan likes default (or final) cases in
> switch statements without a "break" statement.  Viresh
> and Bryan appear to be fond of this too.
> 
> It's pedantic, but I don't like that.  Am I wrong?

No, you are not wrong.


