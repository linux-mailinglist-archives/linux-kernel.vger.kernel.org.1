Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E672D8E38
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 16:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgLMPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 10:17:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406508AbgLMPQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607872525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QFK1ZDhIoaUyExjTXZFlOfOZ3dXuJkhzO36EQH+4tPU=;
        b=hK5RUzDbN6lhjIOuGbMSAN9u4H72SOjs5/y7wd6SrX4AK6QEomn2bTeyr40YTit0P74WLn
        zuqhdUQ9R84wAcZInRv5ZB6cyNIG9MMr6KAkkFXGJ+PWcdyxkq86Kh34VT4FUAKTvYd43t
        GKIwgfQQbdouwcrLhiLyTlnGrXvkh0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-P9UtheO6P4CJz-VJ4CrRdw-1; Sun, 13 Dec 2020 10:15:21 -0500
X-MC-Unique: P9UtheO6P4CJz-VJ4CrRdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82AD1107ACF7;
        Sun, 13 Dec 2020 15:15:19 +0000 (UTC)
Received: from localhost (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1BBF19713;
        Sun, 13 Dec 2020 15:15:18 +0000 (UTC)
Date:   Sun, 13 Dec 2020 23:15:16 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     Rahul Gopakumar <gopakumarr@vmware.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
        Venkatesh Rajaram <rajaramv@vmware.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
Message-ID: <20201213151516.GA12368@MiWiFi-R3L-srv>
References: <20201022040440.GX25604@MiWiFi-R3L-srv>
 <DM6PR05MB5292D8B85FA9DDE263F6147AA41D0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <DM6PR05MB5292DF14DF1C82FFE001AC24A4100@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201102143035.GA3177@MiWiFi-R3L-srv>
 <DM6PR05MB5292FD196FF6B18DCB47CE25A4110@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201112145149.GN8486@MiWiFi-R3L-srv>
 <DM6PR05MB52920B2D4267AD7D073D3C36A4FF0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201122010844.GR8486@MiWiFi-R3L-srv>
 <DM6PR05MB52927C9962D498F1E49BABAAA4FB0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <BYAPR05MB5800E8478DF45F39BE06F8ADA4CA0@BYAPR05MB5800.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR05MB5800E8478DF45F39BE06F8ADA4CA0@BYAPR05MB5800.namprd05.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/20 at 04:16pm, Rahul Gopakumar wrote:
> Hi Baoquan,
> 
> We re-evaluated your last patch and it seems to be fixing the
> initial performance bug reported. During our previous testing,
> we did not apply the patch rightly hence it was reporting
> some issues. 
> 
> Here is the dmesg log confirming no delay in the draft patch.
> 
> Vanilla (5.10 rc3)
> ------------------
> 
> [    0.024011] On node 2 totalpages: 89391104
> [    0.024012]   Normal zone: 1445888 pages used for memmap
> [    0.024012]   Normal zone: 89391104 pages, LIFO batch:63
> [    2.054646] ACPI: PM-Timer IO Port: 0x448 --------------> 2 secs delay
> 
> Patch
> ------
> 
> [    0.024166] On node 2 totalpages: 89391104
> [    0.024167]   Normal zone: 1445888 pages used for memmap
> [    0.024167]   Normal zone: 89391104 pages, LIFO batch:63
> [    0.026694] ACPI: PM-Timer IO Port: 0x448 --------------> No delay
> 
> Attached dmesg logs. Let me know if anything is needed from our end.

I posted formal patchset to fix this issue. The patch 1 is doing the
fix, and almost the same as the draft v2 patch I attached in this thread.
Please feel free to help test and add your Tested-by: tag in the patch
thread if possible.

> 
> 
> 
> From: Rahul Gopakumar <gopakumarr@vmware.com>
> Sent: 24 November 2020 8:33 PM
> To: bhe@redhat.com <bhe@redhat.com>
> Cc: linux-mm@kvack.org <linux-mm@kvack.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; akpm@linux-foundation.org <akpm@linux-foundation.org>; natechancellor@gmail.com <natechancellor@gmail.com>; ndesaulniers@google.com <ndesaulniers@google.com>; clang-built-linux@googlegroups.com <clang-built-linux@googlegroups.com>; rostedt@goodmis.org <rostedt@goodmis.org>; Rajender M <manir@vmware.com>; Yiu Cho Lau <lauyiuch@vmware.com>; Peter Jonasson <pjonasson@vmware.com>; Venkatesh Rajaram <rajaramv@vmware.com>
> Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kernel 
>  
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
> "BUG: Bad page state in process swapper  pfn:ab08001"
> 
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
>         if (end_pfn < pgdat_end_pfn(NODE_DATA(nid)))
>                 return false;
> 
> +       if (NODE_DATA(nid)->first_deferred_pfn != ULONG_MAX)
> +               return true;
>         /*
>          * We start only with one section of pages, more pages are added as
>          * needed until the rest of deferred pages are initialized.



