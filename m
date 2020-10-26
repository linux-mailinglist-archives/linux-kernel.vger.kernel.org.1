Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDAB298DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780066AbgJZNah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:30:37 -0400
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:42034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1780052AbgJZNac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:30:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B3ED1182CF668;
        Mon, 26 Oct 2020 13:30:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3350:3622:3865:3866:3867:3868:3873:4321:5007:6691:7576:10004:10400:10848:11232:11658:11914:12114:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:30054:30064:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: arch63_1d0ef5f27273
X-Filterd-Recvd-Size: 1713
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 26 Oct 2020 13:30:24 +0000 (UTC)
Message-ID: <6e36c8cf2c9cdcf7e6d8fd607b52c5e3621d9925.camel@perches.com>
Subject: Re: [PATCH] um: include compiler_attributes.h where used
From:   Joe Perches <joe@perches.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christopher Obbard <chris.obbard@collabora.com>
Date:   Mon, 26 Oct 2020 06:30:22 -0700
In-Reply-To: <20201026124702.874c23068ecc.I4c3cbf992dc2c038117a01c2cd9a4c406b89ec94@changeid>
References: <20201026124702.874c23068ecc.I4c3cbf992dc2c038117a01c2cd9a4c406b89ec94@changeid>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-26 at 12:47 +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Joe's commit didn't only convert uses of __section(...) to add
> the quotes, but _also_ converted 'raw' uses of __attribute__(())
> for setting the section to use __section, but didn't update the
> includes where necessary. Add them now.

Apologies and thank you.
I believed the robot had done these compilation tests.
 
> Fixes: 33def8498fdd ("treewide: Convert macro and uses of __section(foo) to __section("foo")")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cause-identified-by: Christopher Obbard <chris.obbard@collabora.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>


