Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653DA2B8A90
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 05:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKSEAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 23:00:35 -0500
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:37344 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725964AbgKSEAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 23:00:35 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A073812F5;
        Thu, 19 Nov 2020 04:00:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3622:3865:3867:3868:3874:4321:5007:6117:7903:7975:9010:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13095:13311:13357:13439:14659:14695:21067:21080:21433:21627:21939:30054:30070:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: light29_1b10e552733f
X-Filterd-Recvd-Size: 1070
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 19 Nov 2020 04:00:33 +0000 (UTC)
Message-ID: <95a1e8f15358bbc6e11f88880cc7927f6b0f83ea.camel@perches.com>
Subject: Re: [RFC] checkpatch.pl Is "does MAINTAINERS need updating" check
 broken?
From:   Joe Perches <joe@perches.com>
To:     "Andersen, John" <john.s.andersen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 18 Nov 2020 20:00:32 -0800
In-Reply-To: <20201119040123.GA629660@johnsa1-desk.jf.intel.com>
References: <20201119040123.GA629660@johnsa1-desk.jf.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-11-18 at 20:01 -0800, Andersen, John wrote:
> I just noticed that patches which have "added, moved or deleted file(s)" and
> updated MAINTAINERS still trigger the following warning:

Please to not directly message me.
Send any questions to the lkml list and cc me.


