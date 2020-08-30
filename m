Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2322256AEA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 02:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgH3A2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 20:28:32 -0400
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:47118 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728187AbgH3A2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 20:28:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 95132181D337B;
        Sun, 30 Aug 2020 00:28:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3872:3873:4321:5007:6120:6691:7875:7901:9040:10004:10400:10848:11026:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:13869:14180:14659:21060:21067:21080:21433:21627:21740:21990:30005:30054:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: match85_5b06fe827082
X-Filterd-Recvd-Size: 1703
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Aug 2020 00:28:28 +0000 (UTC)
Message-ID: <81c3499a5a09a82ddb4f3aa2bd9bfde1c0192b9e.camel@perches.com>
Subject: Re: [PATCH RFC 0/2] simple sysfs wrappers for single values
From:   Joe Perches <joe@perches.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nayna Jain <nayna@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Sat, 29 Aug 2020 17:28:27 -0700
In-Reply-To: <20200829233720.42640-1-alex.dewar90@gmail.com>
References: <20200829233720.42640-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-08-30 at 00:37 +0100, Alex Dewar wrote:
> Hi all,
> 
> I've noticed there seems to have been a fair amount of discussion around
> the subject of possible helper methods for use in the context of sysfs
> show methods (which I haven't had a chance to go through in detail yet
> -- sorry!), so I thought I'd send out a couple of patches I've been
> working on for this, in case it's of any interest to anyone.

If you really want to do this, I suggest you get use
wrappers like sysfs_emit_string, sysfs_emit_int, sysfs_emit_u64
though I don't see _that_ much value.


