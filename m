Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875D02A2D00
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgKBOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:30:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgKBOas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604327445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgoHjvHTKD+aahDSfC3sk1RkQjJwPPtUoTUfQVXKlxE=;
        b=Ko+AhYUEsYS5Zd0T1kvLHq/F4bl1VPx3Jqf05206zXpt6TbYmVKkZzkWudR/S58Uhg9Oq5
        6F0xlZVO6jHv0UQv4UcU4n9IwJg2W/r5cHQERed3aHQfcbDUqQZ+rciGAnrAwkY3lL33Ru
        ak1BilSCwz9EpSQBuNbCZhEsPnnMpS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-1eFeWNgsO9erQluVajwL9A-1; Mon, 02 Nov 2020 09:30:41 -0500
X-MC-Unique: 1eFeWNgsO9erQluVajwL9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77319801F99;
        Mon,  2 Nov 2020 14:30:39 +0000 (UTC)
Received: from localhost (ovpn-13-83.pek2.redhat.com [10.72.13.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 497FF10013BD;
        Mon,  2 Nov 2020 14:30:38 +0000 (UTC)
Date:   Mon, 2 Nov 2020 22:30:35 +0800
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
        Venkatesh Rajaram <rajaramv@vmware.com>
Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
Message-ID: <20201102143035.GA3177@MiWiFi-R3L-srv>
References: <DM6PR05MB52921FF90FA01CC337DD23A1A4080@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201010061124.GE25604@MiWiFi-R3L-srv>
 <DM6PR05MB529281F914953691E0F52D1CA4070@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201013131735.GL25604@MiWiFi-R3L-srv>
 <DM6PR05MB52926FDAB0E58F5CFA2E892DA41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201020151814.GU25604@MiWiFi-R3L-srv>
 <DM6PR05MB529293AC2B077B5170FFE625A41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201022040440.GX25604@MiWiFi-R3L-srv>
 <DM6PR05MB5292D8B85FA9DDE263F6147AA41D0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <DM6PR05MB5292DF14DF1C82FFE001AC24A4100@DM6PR05MB5292.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR05MB5292DF14DF1C82FFE001AC24A4100@DM6PR05MB5292.namprd05.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/20 at 02:15pm, Rahul Gopakumar wrote:
> Hi Baoquan,
> 
> There could still be some memory initialization problem with
> the draft patch. I see a lot of page corruption errors.
> 
> BUG: Bad page state in process swapper  pfn:ab0803c
> 
> Here is the call trace
> 
> [    0.262826]  dump_stack+0x57/0x6a
> [    0.262827]  bad_page.cold.119+0x63/0x93
> [    0.262828]  __free_pages_ok+0x31f/0x330
> [    0.262829]  memblock_free_all+0x153/0x1bf
> [    0.262830]  mem_init+0x23/0x1f2
> [    0.262831]  start_kernel+0x299/0x57a
> [    0.262832]  secondary_startup_64_no_verify+0xb8/0xbb
> 
> I don't see this in dmesg log with vanilla kernel.
> 
> It looks like the overhead due to this initialization problem
> is around 3 secs.
> 
> [    0.262831]  start_kernel+0x299/0x57a
> [    0.262832]  secondary_startup_64_no_verify+0xb8/0xbb
> [    3.758185] Memory: 3374072K/1073740756K available (12297K kernel code, 5778Krwdata, 4376K rodata, 2352K init, 6480K bss, 16999716K reserved, 0K cma-reserved)
> 
> But the draft patch is fixing the initial problem
> reported around 2 secs (log snippet below) hence the total
> delay of 1 sec.
> 
> [    0.024752]   Normal zone: 1445888 pages used for memmap
> [    0.024753]   Normal zone: 89391104 pages, LIFO batch:63
> [    0.027379] ACPI: PM-Timer IO Port: 0x448

So, you mean with the draft patch applied, the initial performance
regression goes away, just many page corruption errors with call trace
are seen, right? And the performance regression is about 2sec delay in
your system?

Could you tell how you setup vmware VM so that I can ask our QA for
help to create a vmware VM for me to test? I tested the draft patch on
bare metal system with more than 1T memory, didn't see the page
corruption call trace, need reproduce and have a look.

> 
> 
> ________________________________________
> From: Rahul Gopakumar <gopakumarr@vmware.com>
> Sent: 22 October 2020 10:51 PM
> To: bhe@redhat.com
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; akpm@linux-foundation.org; natechancellor@gmail.com; ndesaulniers@google.com; clang-built-linux@googlegroups.com; rostedt@goodmis.org; Rajender M; Yiu Cho Lau; Peter Jonasson; Venkatesh Rajaram
> Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
> 
> Hi Baoquan,
> 
> >> Can you tell how you measure the boot time?
> 
> Our test is actually boothalt, time reported by this test
> includes both boot-up and shutdown time.
> 
> >> At above, you said "Patch on latest commit - 20.161 secs",
> >> could you tell where this 20.161 secs comes from,
> 
> So this time is boot-up time + shutdown time.
> 
> From the dmesg.log it looks like during the memmap_init
> it's taking less time in the patch. Let me take a closer look to
> confirm this and also to find where the 1-sec delay in the patch
> run is coming from.
> 
> 
> From: bhe@redhat.com <bhe@redhat.com>
> Sent: 22 October 2020 9:34 AM
> To: Rahul Gopakumar <gopakumarr@vmware.com>
> Cc: linux-mm@kvack.org <linux-mm@kvack.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; akpm@linux-foundation.org <akpm@linux-foundation.org>; natechancellor@gmail.com <natechancellor@gmail.com>; ndesaulniers@google.com <ndesaulniers@google.com>; clang-built-linux@googlegroups.com <clang-built-linux@googlegroups.com>; rostedt@goodmis.org <rostedt@goodmis.org>; Rajender M <manir@vmware.com>; Yiu Cho Lau <lauyiuch@vmware.com>; Peter Jonasson <pjonasson@vmware.com>; Venkatesh Rajaram <rajaramv@vmware.com>
> Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
> 
> Hi Rahul,
> 
> On 10/20/20 at 03:26pm, Rahul Gopakumar wrote:
> > >> Here, do you mean it even cost more time with the patch applied?
> >
> > Yes, we ran it multiple times and it looks like there is a
> > very minor increase with the patch.
> >
> ......
> > On 10/20/20 at 01:45pm, Rahul Gopakumar wrote:
> > > Hi Baoquan,
> > >
> > > We had some trouble applying the patch to problem commit and the latest upstream commit. Steven (CC'ed) helped us by providing the updated draft patch. We applied it on the latest commit (3e4fb4346c781068610d03c12b16c0cfb0fd24a3), and it doesn't look like improving the performance numbers.
> >
> > Thanks for your feedback. From the code, I am sure what the problem is,
> > but I didn't test it on system with huge memory. Forget mentioning my
> > draft patch is based on akpm/master branch since it's a mm issue, it
> > might be a little different with linus's mainline kernel, sorry for the
> > inconvenience.
> >
> > I will test and debug this on a server with 4T memory in our lab, and
> > update if any progress.
> >
> > >
> > > Patch on latest commit - 20.161 secs
> > > Vanilla latest commit - 19.50 secs
> >
> 
> Can you tell how you measure the boot time? I checked the boot logs you
> attached, E.g in below two logs, I saw patch_dmesg.log even has less
> time during memmap init. Now I have got a machine with 1T memory for
> testing, but didn't see obvious time cost increase. At above, you said
> "Patch on latest commit - 20.161 secs", could you tell where this 20.161
> secs comes from, so that I can investigate and reproduce on my system?
> 
> patch_dmesg.log:
> [    0.023126] Initmem setup node 1 [mem 0x0000005600000000-0x000000aaffffffff]
> [    0.023128] On node 1 totalpages: 89128960
> [    0.023129]   Normal zone: 1392640 pages used for memmap
> [    0.023130]   Normal zone: 89128960 pages, LIFO batch:63
> [    0.023893] Initmem setup node 2 [mem 0x000000ab00000000-0x000001033fffffff]
> [    0.023895] On node 2 totalpages: 89391104
> [    0.023896]   Normal zone: 1445888 pages used for memmap
> [    0.023897]   Normal zone: 89391104 pages, LIFO batch:63
> [    0.026744] ACPI: PM-Timer IO Port: 0x448
> [    0.026747] ACPI: Local APIC address 0xfee00000
> 
> vanilla_dmesg.log:
> [    0.024295] Initmem setup node 1 [mem 0x0000005600000000-0x000000aaffffffff]
> [    0.024298] On node 1 totalpages: 89128960
> [    0.024299]   Normal zone: 1392640 pages used for memmap
> [    0.024299]   Normal zone: 89128960 pages, LIFO batch:63
> [    0.025289] Initmem setup node 2 [mem 0x000000ab00000000-0x000001033fffffff]
> [    0.025291] On node 2 totalpages: 89391104
> [    0.025292]   Normal zone: 1445888 pages used for memmap
> [    0.025293]   Normal zone: 89391104 pages, LIFO batch:63
> [    2.096982] ACPI: PM-Timer IO Port: 0x448
> [    2.096987] ACPI: Local APIC address 0xfee00000
> 

