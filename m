Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C17224802A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 10:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHRIH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 04:07:26 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:39342 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbgHRIHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:07:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0E7CE1277;
        Tue, 18 Aug 2020 08:07:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2687:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3167:3352:3622:3653:3865:3866:3867:3868:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6691:9025:10004:10400:10848:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:21740:21939:30054:30062:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: talk96_520c0712701d
X-Filterd-Recvd-Size: 1995
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Aug 2020 08:07:18 +0000 (UTC)
Message-ID: <f9803189e589cc719fc9a561003317a81d2da07e.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add --kconfig-prefix
From:   Joe Perches <joe@perches.com>
To:     Jerome Forissier <jerome@forissier.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 18 Aug 2020 01:07:17 -0700
In-Reply-To: <266350d9-c770-6a29-b784-46de2b005e39@forissier.org>
References: <20200817095056.31001-1-jerome@forissier.org>
         <20200818074349.726778-1-jerome@forissier.org>
         <266350d9-c770-6a29-b784-46de2b005e39@forissier.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-18 at 09:50 +0200, Jerome Forissier wrote:
> 
> On 8/18/20 9:43 AM, Jerome Forissier wrote:
> > Kconfig allows to customize the CONFIG_ prefix via the $CONFIG_
> > environment variable. Out-of-tree projects may therefore use Kconfig
> > with a different prefix, or they may use a custom configuration tool
> > which does not use the CONFIG_ prefix at all. Such projects may still
> > want to adhere to the Linux kernel coding style and run checkpatch.pl.
> > 
> > One example is OP-TEE [1] which does not use Kconfig but does have
> > configuration options prefixed with CFG_. It also mostly follows the
> > kernel coding style and therefore being able to use checkpatch is quite
> > valuable.
> > 
> > To make this possible, add the --kconfig-prefix command line option.
> 
> (Oh I forgot to add the link here :-/ sorry about that. Let me know if
> you want me to resend.)
> 
> [1] https://github.com/OP-TEE/optee_os

It's probably not important enough to bother.
A trivial search on "OP-TEE" works.
So I think it's fine, but if you feel like it,
go ahead.

Joe


