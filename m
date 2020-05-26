Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767181C4632
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgEDSnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 14:43:55 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:54644 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEDSny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:43:54 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 78402182D3ECD;
        Mon,  4 May 2020 18:34:34 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4C82019B05;
        Mon,  4 May 2020 18:34:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:966:973:981:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2196:2198:2199:2200:2393:2559:2562:2693:2731:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:4250:4321:4362:4385:4605:5007:6119:7903:8957:10004:10400:10848:11026:11232:11473:11658:11914:12295:12297:12438:12555:12740:12895:12986:13095:13870:13894:14093:14096:14097:14181:14659:14721:21080:21220:21433:21451:21627:21740:21741:21990:30012:30034:30054:30070:30075:30089:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: patch84_27b7e2cd6480a
X-Filterd-Recvd-Size: 3549
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 May 2020 18:34:32 +0000 (UTC)
Message-ID: <aaa0a1f9619130293a8d8810fa8de140d5612e45.camel@perches.com>
Subject: Re: [PATCH v6] checkpatch: add support to check 'Fixes:' tag format
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Date:   Mon, 04 May 2020 11:34:31 -0700
In-Reply-To: <20200504082002.GA29972@udknight>
References: <20200504082002.GA29972@udknight>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-04 at 16:20 +0800, Wang YanQing wrote:
> According to submitting-patches.rst, 'Fixes:' tag has a little
> stricter condition about the one line summary than normal git
> commit description:
> “...
> Do not split the tag across multiple lines, tags are exempt from
> the "wrap at 75 columns" rule in order to simplify parsing scripts
> ...”
> 
> And there is no sanity check for 'Fixes:' tag format in checkpatch
> the same as GIT_COMMIT_ID for git commit description, so let's expand
> the GIT_COMMIT_ID to add 'Fixes:' tag format check support.
> 
> The check supports below formats:
> Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
> Fixes: 85f7cd3a2aad ("Revert "media: Kconfig: better support hybrid TV devices"")
> Fixes: 878520ac45f9 ("ext4: save the error code which triggered...")
> Fixes: 878520ac45f9 ("ext4: save the error code which triggered")
> Fixes: 277f27e2f277 ("SUNRPC/cache: Allow garbage collection ... ")
> 
> The check doesn't support below formats and it will emit diagnostics info for them:
> Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface"
> Fixes: 6c73698904aa pinctrl: qcom: Introduce readl/writel accessors
> Fixes: 3fd6e7d9a146 (ASoC: tas571x: New driver for TI TAS571x power amplifiers)
> Fixes: 55697cbb44e4 ("arm64: dts: renesas: r8a779{65,80,90}: Add IPMMU devices nodes)
> Fixes: ba35f8588f47 (“ipvlan: Defer multicast / broadcast processing to a work-queue”)
> Fixes: cd758a9b57ee "KVM: PPC: Book3S HV: Use __gfn_to_pfn_memslot in HPT page fault handler"
> Fixes:      9b1640686470 ("scsi: lpfc: Fix use-after-free mailbox cmd completion")
> Fixes: 03f6fc6de919 ('ASoC: rt5682: Add the soundwire support')
> Fixes: 03404e8ae652("IB/mlx5: Add support to dropless RQ")
> 
> Because after GIT_COMMIT_ID supports 'Fixes:' tag format check, it could do
> the same check as the UNKNOWN_COMMIT_ID, so we don't need UNKNOWN_COMMIT_ID
> anymore and I decide to delete it.
> 
> Note: this patch also fixes double quotation mark issue for normal git
>       commit description, and now it supports double quotation mark in
>       title line, for example:
>       Commit e33e2241e272 ("Revert "cfg80211: Use 5MHz bandwidth by default
>       when checking usable channels"")
> 
> Note: this patch also adds diagnostics info support for normal git commit
>       description format check.

Thanks YanQing.

All of this seems fine, but perhaps checkpatch's output message content
could be a bit shorter.  I'll give it a think for a while.


