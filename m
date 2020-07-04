Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9456D2148F7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jul 2020 23:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGDVvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 17:51:12 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:57746 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726643AbgGDVvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 17:51:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E202D18224D8E;
        Sat,  4 Jul 2020 21:51:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:582:599:988:989:1152:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1560:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3876:3877:4321:5007:6114:6119:6261:6312:6642:9036:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:14659:14685:21080:21611:21627:21809:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: side00_500090426e9d
X-Filterd-Recvd-Size: 1420
Received: from perches-mx.perches.com (imap-ext [216.40.42.5])
        (Authenticated sender: webmail@joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat,  4 Jul 2020 21:51:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 04 Jul 2020 14:51:09 -0700
From:   Joe Perches <joe@perches.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
In-Reply-To: <1593897917.7058.11.camel@HansenPartnership.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1593897917.7058.11.camel@HansenPartnership.com>
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <7eb36e09e13138d3e349e9657039644f@perches.com>
X-Sender: joe@perches.com
X-Originating-IP: [47.151.133.149]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-04 14:25, James Bottomley wrote:
> On Sat, 2020-07-04 at 13:02 -0700, Dan Williams wrote:
> [...]
>> diff --git a/Documentation/process/inclusive-terminology.rst
[]
> Could we just lose this entire document?

Yes please.
