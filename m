Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF62C8A09
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgK3Q4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:56:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbgK3Q4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:56:23 -0500
Received: from kernel.org (unknown [87.71.85.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E982076E;
        Mon, 30 Nov 2020 16:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606755342;
        bh=sMhubw65fYfWbhsLREknMs2fRzNGPSEU7m7l8IbsNoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcnlTPWWFJgwnU2Ro0WvirNKqvBcmoabXOCJ8MZy4TMSa5azPKDua3w5O4hsgWnPu
         6Kshu/TFwrw923A8pBuglb+1LUlyEtdcnJyH447QQAfMZuweoNj350AbvDJQrayjgr
         p/vN0ho8NNKktcmmnojMY9OYCqk3paaLJgaj5nkQ=
Date:   Mon, 30 Nov 2020 18:55:32 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Rahul Gopakumar <gopakumarr@vmware.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Rajender M <manir@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>,
        Peter Jonasson <pjonasson@vmware.com>,
        Venkatesh Rajaram <rajaramv@vmware.com>
Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
Message-ID: <20201130165532.GE557259@kernel.org>
References: <DM6PR05MB529293AC2B077B5170FFE625A41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201022040440.GX25604@MiWiFi-R3L-srv>
 <DM6PR05MB5292D8B85FA9DDE263F6147AA41D0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <DM6PR05MB5292DF14DF1C82FFE001AC24A4100@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201102143035.GA3177@MiWiFi-R3L-srv>
 <DM6PR05MB5292FD196FF6B18DCB47CE25A4110@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201112145149.GN8486@MiWiFi-R3L-srv>
 <DM6PR05MB52920B2D4267AD7D073D3C36A4FF0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201122010844.GR8486@MiWiFi-R3L-srv>
 <DM6PR05MB52927C9962D498F1E49BABAAA4FB0@DM6PR05MB5292.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR05MB52927C9962D498F1E49BABAAA4FB0@DM6PR05MB5292.namprd05.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

On Tue, Nov 24, 2020 at 03:03:40PM +0000, Rahul Gopakumar wrote:
> Hi Baoquan,
> 
> We applied the new patch to 5.10 rc3 and tested it. We are still
> observing the same page corruption issue which we saw with the
> old patch. This is causing 3 secs delay in boot time.
> 
> Attached dmesg log from the new patch and also from vanilla
> 5.10 rc3 kernel.
> 
> There are multiple lines like below in the dmesg log of the
> new patch.
> 
> "BUG: Bad page state in process swapper  pfn:ab08001"

Can you please run your test with the below patch and send output of

	dmesg | grep defer


diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eaa227a479e4..ce7ec660c777 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -455,6 +455,7 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	nr_initialised++;
 	if ((nr_initialised > PAGES_PER_SECTION) &&
 	    (pfn & (PAGES_PER_SECTION - 1)) == 0) {
+		pr_info("=> %s: nid: %d pfn: %lx\n", __func__, nid, pfn);
 		NODE_DATA(nid)->first_deferred_pfn = pfn;
 		return true;
 	}

> ________________________________________
> From: bhe@redhat.com <bhe@redhat.com>
> Sent: 22 November 2020 6:38 AM
> To: Rahul Gopakumar
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; akpm@linux-foundation.org; natechancellor@gmail.com; ndesaulniers@google.com; clang-built-linux@googlegroups.com; rostedt@goodmis.org; Rajender M; Yiu Cho Lau; Peter Jonasson; Venkatesh Rajaram
> Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
> 
> On 11/20/20 at 03:11am, Rahul Gopakumar wrote:
> > Hi Baoquan,
> >
> > To which commit should we apply the draft patch. We tried applying
> > the patch to the commit 3e4fb4346c781068610d03c12b16c0cfb0fd24a3
> > (the one we used for applying the previous patch) but it fails.
> 
> I tested on 5.10-rc3+. You can append below change to the old patch in
> your testing kernel.
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fa6076e1a840..5e5b74e88d69 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -448,6 +448,8 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
>         if (end_pfn < pgdat_end_pfn(NODE_DATA(nid)))
>                 return false;
> 
> +       if (NODE_DATA(nid)->first_deferred_pfn != ULONG_MAX)
> +               return true;
>         /*
>          * We start only with one section of pages, more pages are added as
>          * needed until the rest of deferred pages are initialized.
> 




-- 
Sincerely yours,
Mike.
