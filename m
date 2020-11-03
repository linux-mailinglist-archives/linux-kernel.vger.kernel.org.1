Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEFA2A4739
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgKCOEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:04:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729440AbgKCOEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604412243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IsejNI8EYSmowoiAvOvFY33zKF4jozyNUSQ9LBHEIew=;
        b=G+BmjeiHfQkXjo4My/zO9tdhf0PVaW6LzA6xieVKsT5aLa3SQ+ShQaVSrO9xBSVu7t3APa
        uBxUBvfLqOmYlO6YTGOT195Iev6lE3DfIyJx5UZxqf+SxQ+wHN+ULxm3QVPctVECVC2ubb
        ePwmjgOqrpCbmh3SGWKBKM2gK7J2ZpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-cvTYnFueNbGheckDPJMuxw-1; Tue, 03 Nov 2020 09:03:58 -0500
X-MC-Unique: cvTYnFueNbGheckDPJMuxw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A2E3107465A;
        Tue,  3 Nov 2020 14:03:56 +0000 (UTC)
Received: from localhost (ovpn-12-165.pek2.redhat.com [10.72.12.165])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5383F5C230;
        Tue,  3 Nov 2020 14:03:55 +0000 (UTC)
Date:   Tue, 3 Nov 2020 22:03:52 +0800
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
Message-ID: <20201103140352.GB3177@MiWiFi-R3L-srv>
References: <DM6PR05MB529281F914953691E0F52D1CA4070@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201013131735.GL25604@MiWiFi-R3L-srv>
 <DM6PR05MB52926FDAB0E58F5CFA2E892DA41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201020151814.GU25604@MiWiFi-R3L-srv>
 <DM6PR05MB529293AC2B077B5170FFE625A41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201022040440.GX25604@MiWiFi-R3L-srv>
 <DM6PR05MB5292D8B85FA9DDE263F6147AA41D0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <DM6PR05MB5292DF14DF1C82FFE001AC24A4100@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201102143035.GA3177@MiWiFi-R3L-srv>
 <DM6PR05MB5292FD196FF6B18DCB47CE25A4110@DM6PR05MB5292.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR05MB5292FD196FF6B18DCB47CE25A4110@DM6PR05MB5292.namprd05.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/20 at 12:34pm, Rahul Gopakumar wrote:
> >> So, you mean with the draft patch applied, the initial performance
> regression goes away, just many page corruption errors with call trace
> are seen, right?
> 
> Yes, that's right.
> 
> >> And the performance regression is about 2sec delay in
> your system?
> 
> The delay due to this new page corruption issue is about
> 3 secs.
> 
> Here is the summary
> 
> * Initial problem - 2 secs
> * Draft patch - Fixes initial problem (recovers 2 secs) but
> brings in new page corruption issue (3 secs)
> 
> >> Could you tell how you setup vmware VM so that I can ask our QA for
> help to create a vmware VM for me to test?
> 
> * Use vSphere ESXi 6.7 or 7.0 GA.
> * Create VM using vSphere Web Client and specify 1TB VM Memory.
> * Install RHEL 8.1, that's the guest used in this test.

OK, I see. The draft patch fix the original issue, seems some boundary
of memory region is not handled correctly. Thanks for confirmation.

The memory layout is important in this case. Not sure if making a VM gesut
as you suggested can also create a system with below memory layout.

[    0.008842] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.008842] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
[    0.008843] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x55ffffffff]
[    0.008844] ACPI: SRAT: Node 1 PXM 1 [mem 0x5600000000-0xaaffffffff]
[    0.008844] ACPI: SRAT: Node 2 PXM 2 [mem 0xab00000000-0xfcffffffff]
[    0.008845] ACPI: SRAT: Node 2 PXM 2 [mem 0x10000000000-0x1033fffffff]


> 
> With draft patch, you should be able to reproduce the issue.
> Let me know if you need more details.

