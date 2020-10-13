Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD828D13E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389418AbgJMP1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:27:13 -0400
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:39844 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389400AbgJMP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:27:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id D6F5D12C4;
        Tue, 13 Oct 2020 15:27:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3871:3872:3873:3874:4321:5007:6120:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30041:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: soda43_0a07fbf27204
X-Filterd-Recvd-Size: 1258
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue, 13 Oct 2020 15:27:08 +0000 (UTC)
Message-ID: <099a8b90ba46bf5b518f64936c8092d713e67da8.camel@perches.com>
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
From:   Joe Perches <joe@perches.com>
To:     Ujjwal Kumar <ujjwalkumar0501@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Tue, 13 Oct 2020 08:27:07 -0700
In-Reply-To: <da3053be-f27e-f99c-0a8a-447adb9733d2@gmail.com>
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
         <da3053be-f27e-f99c-0a8a-447adb9733d2@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-13 at 17:43 +0530, Ujjwal Kumar wrote:
> Consider the following case:
> a python script file with '.py' filename extension but without
> a shebang line. Would it be meaningful to allow execute permission
> on such a file?

More the question I think is for a patch to
that file, how do you tell if it has one?


