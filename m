Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C31270FA6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 18:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgISQv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 12:51:29 -0400
Received: from smtprelay0151.hostedemail.com ([216.40.44.151]:44478 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726449AbgISQv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 12:51:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C70A5180A7FD7;
        Sat, 19 Sep 2020 16:51:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2551:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3871:3872:4321:5007:10004:10400:10848:11232:11658:11914:12050:12114:12296:12297:12740:12760:12895:13069:13161:13229:13255:13311:13357:13439:14659:14721:21080:21627:21939:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: swing28_07170e027135
X-Filterd-Recvd-Size: 1463
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 19 Sep 2020 16:51:26 +0000 (UTC)
Message-ID: <b390217b2db2cd44c53effbdec198f191df7c7ac.camel@perches.com>
Subject: Re: [PATCH V3 6/8] mm: and drivers core: Convert
 hugetlb_report_node_meminfo to sysfs_emit
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Sat, 19 Sep 2020 09:51:25 -0700
In-Reply-To: <20200919062228.GA438957@kroah.com>
References: <cover.1600285923.git.joe@perches.com>
         <894b351b82da6013cde7f36ff4b5493cd0ec30d0.1600285923.git.joe@perches.com>
         <20200919062228.GA438957@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-09-19 at 08:22 +0200, Greg Kroah-Hartman wrote:
> I'll take a look at it on Monday...

It's decidedly not urgent/critical.

There are several logical defects all over the kernel
for these unbounded sprintfs, but I don't know of an
actual instance where the PAGE_SIZE buf is overfilled.


