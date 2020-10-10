Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694BB289EAB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 08:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgJJGLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 02:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgJJGLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 02:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602310293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IyGrTsuf+XbfRsOlZleQ8COsqo+RgEPBV6+boXBhvfA=;
        b=aco4i24upY52szACRORitb5ZYJflYxEqzQSQBmIpF3x+yzP/5+6wkxmXvS6HQybD/qO/yZ
        7MrfZeQQhjkcpKjK2NcGBumMqWBhu5WBk+zGMc3Q7AAepFqSI+UdxU46KVDknR/S1nvUMb
        XjQ778oWLPpPfTdo76vaNg2kAWTNx8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-pc0cwYiJO-e5uiA-NDu72g-1; Sat, 10 Oct 2020 02:11:30 -0400
X-MC-Unique: pc0cwYiJO-e5uiA-NDu72g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DEFF186DD23;
        Sat, 10 Oct 2020 06:11:28 +0000 (UTC)
Received: from localhost (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19F4D10013C1;
        Sat, 10 Oct 2020 06:11:26 +0000 (UTC)
Date:   Sat, 10 Oct 2020 14:11:24 +0800
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
Message-ID: <20201010061124.GE25604@MiWiFi-R3L-srv>
References: <DM6PR05MB52921FF90FA01CC337DD23A1A4080@DM6PR05MB5292.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR05MB52921FF90FA01CC337DD23A1A4080@DM6PR05MB5292.namprd05.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/20 at 01:15pm, Rahul Gopakumar wrote:
> As part of VMware's performance regression testing for Linux Kernel
> upstream releases, we identified boot time increase when comparing
> Linux 5.8 kernel against Linux 5.7 kernel. Increase in boot time is
> noticeable on VM with a **large amount of memory**.
>  
> In our test cases, it's noticeable with memory 1TB and more, whereas
> there was no major difference noticed in testcases with <1TB.
>  
> On bisecting between 5.7 and 5.8, we found the following commit from 
> “Baoquan He” to be the cause of boot time increase in big VM test cases.
>  
> -------------------------------------
>  
> commit 73a6e474cb376921a311786652782155eac2fdf0
> Author: Baoquan He <bhe@redhat.com>
> Date: Wed Jun 3 15:57:55 2020 -0700
>  
> mm: memmap_init: iterate over memblock regions rather that check each PFN
>  
> When called during boot the memmap_init_zone() function checks if each PFN
> is valid and actually belongs to the node being initialized using
> early_pfn_valid() and early_pfn_in_nid().
>  
> Each such check may cost up to O(log(n)) where n is the number of memory
> banks, so for large amount of memory overall time spent in early_pfn*()
> becomes substantial.
>  
> -------------------------------------
>  
> For boot time test, we used RHEL 8.1 as the guest OS.
> VM config is 84 vcpu and 1TB vRAM.
>  
> Here are the actual performance numbers.
>  
> 5.7 GA - 18.17 secs
> Baoquan's commit - 21.6 secs (-16% increase in time)
>  
> From dmesg logs, we can see significant time delay around memmap.
>  
> Refer below logs.
>  
> Good commit
>  
> [0.033176] Normal zone: 1445888 pages used for memmap
> [0.033176] Normal zone: 89391104 pages, LIFO batch:63
> [0.035851] ACPI: PM-Timer IO Port: 0x448
>  
> Problem commit
>  
> [0.026874] Normal zone: 1445888 pages used for memmap
> [0.026875] Normal zone: 89391104 pages, LIFO batch:63
> [2.028450] ACPI: PM-Timer IO Port: 0x448

Could you add memblock=debug to kernel cmdline and paste the boot logs of
system w and w/o the commit?

>  
> We did some analysis, and it looks like with the problem commit it's
> not deferring the memory initialization to a later stage and it's 
> initializing the huge chunk of memory in serial - during the boot-up
> time.  Whereas with the good commit, it was able to defer the
> initialization of the memory when it could be done in parallel.
> 
> 
> Rahul Gopakumar
> Performance Engineering
> VMware, Inc.
> 

