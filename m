Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A809A28F2F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgJONMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:12:09 -0400
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:46922 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728639AbgJONMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:12:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 28B93181D302B;
        Thu, 15 Oct 2020 13:12:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1560:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3870:3876:4321:5007:6119:10004:10400:10848:11658:11914:12048:12297:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21092:21627:21972:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: crack74_231335c27214
X-Filterd-Recvd-Size: 1287
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 15 Oct 2020 13:12:04 +0000 (UTC)
Message-ID: <0efd61190d00eec9c76e0ca949f3488fab1ab7c7.camel@perches.com>
Subject: Re: [PATCH] scripts: Spelling:  Fix spelling memry to memory in
 /tools/nolibc/include/nolibc.h
From:   Joe Perches <joe@perches.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        akpm@linux-foundation.org, colin.king@canonical.com,
        sfr@canb.auug.org.au, wangqing@vivo.com, david@redhat.com,
        xndchn@gmail.com, luca@lucaceresoli.net, ebiggers@google.com
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 15 Oct 2020 06:12:02 -0700
In-Reply-To: <20201015130525.381818-1-unixbhaskar@gmail.com>
References: <20201015130525.381818-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-15 at 18:35 +0530, Bhaskar Chowdhury wrote:
> s/memry/memory/p
[]
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
[]
> @@ -885,6 +885,7 @@ meetign||meeting
>  memeory||memory
>  memmber||member
>  memoery||memory
> +memry ||memory

Spaces are not used in these entries.


