Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EC1295708
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgJVEEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725927AbgJVEEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603339489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ae2OaQqqHV4++U7pFL5husft7G1mWnlpANfXuyKi6ic=;
        b=PdX+ADNBc0avWVAEtwwbP/2sMEPaBLJ2y1KQdQXEuAUB3Hd0T30RstkTQ/y/TJRuTpxxar
        ZHME/B+Y82GmkghrY659gzP9zEIJJ3ysw15tfCbwKQ7JWHrT/2wqHnyRoLdys7oV94tALY
        uLbjbQqg+XTawEryU7Lwq9EkctFXe3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-OMoJQYF3OS2l9Fx0Kh6lrw-1; Thu, 22 Oct 2020 00:04:45 -0400
X-MC-Unique: OMoJQYF3OS2l9Fx0Kh6lrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC30686ABCE;
        Thu, 22 Oct 2020 04:04:43 +0000 (UTC)
Received: from localhost (ovpn-12-84.pek2.redhat.com [10.72.12.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C036D60C04;
        Thu, 22 Oct 2020 04:04:42 +0000 (UTC)
Date:   Thu, 22 Oct 2020 12:04:40 +0800
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
Message-ID: <20201022040440.GX25604@MiWiFi-R3L-srv>
References: <DM6PR05MB52921FF90FA01CC337DD23A1A4080@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201010061124.GE25604@MiWiFi-R3L-srv>
 <DM6PR05MB529281F914953691E0F52D1CA4070@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201013131735.GL25604@MiWiFi-R3L-srv>
 <DM6PR05MB52926FDAB0E58F5CFA2E892DA41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201020151814.GU25604@MiWiFi-R3L-srv>
 <DM6PR05MB529293AC2B077B5170FFE625A41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR05MB529293AC2B077B5170FFE625A41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

On 10/20/20 at 03:26pm, Rahul Gopakumar wrote:
> >> Here, do you mean it even cost more time with the patch applied?
> 
> Yes, we ran it multiple times and it looks like there is a 
> very minor increase with the patch.
> 
...... 
> On 10/20/20 at 01:45pm, Rahul Gopakumar wrote:
> > Hi Baoquan,
> > 
> > We had some trouble applying the patch to problem commit and the latest upstream commit. Steven (CC'ed) helped us by providing the updated draft patch. We applied it on the latest commit (3e4fb4346c781068610d03c12b16c0cfb0fd24a3), and it doesn't look like improving the performance numbers.
> 
> Thanks for your feedback. From the code, I am sure what the problem is,
> but I didn't test it on system with huge memory. Forget mentioning my
> draft patch is based on akpm/master branch since it's a mm issue, it
> might be a little different with linus's mainline kernel, sorry for the
> inconvenience.
> 
> I will test and debug this on a server with 4T memory in our lab, and
> update if any progress.
> 
> > 
> > Patch on latest commit - 20.161 secs
> > Vanilla latest commit - 19.50 secs
> 

Can you tell how you measure the boot time? I checked the boot logs you
attached, E.g in below two logs, I saw patch_dmesg.log even has less
time during memmap init. Now I have got a machine with 1T memory for
testing, but didn't see obvious time cost increase. At above, you said
"Patch on latest commit - 20.161 secs", could you tell where this 20.161
secs comes from, so that I can investigate and reproduce on my system?

patch_dmesg.log:
[    0.023126] Initmem setup node 1 [mem 0x0000005600000000-0x000000aaffffffff]
[    0.023128] On node 1 totalpages: 89128960
[    0.023129]   Normal zone: 1392640 pages used for memmap
[    0.023130]   Normal zone: 89128960 pages, LIFO batch:63
[    0.023893] Initmem setup node 2 [mem 0x000000ab00000000-0x000001033fffffff]
[    0.023895] On node 2 totalpages: 89391104
[    0.023896]   Normal zone: 1445888 pages used for memmap
[    0.023897]   Normal zone: 89391104 pages, LIFO batch:63
[    0.026744] ACPI: PM-Timer IO Port: 0x448
[    0.026747] ACPI: Local APIC address 0xfee00000

vanilla_dmesg.log:
[    0.024295] Initmem setup node 1 [mem 0x0000005600000000-0x000000aaffffffff]
[    0.024298] On node 1 totalpages: 89128960
[    0.024299]   Normal zone: 1392640 pages used for memmap
[    0.024299]   Normal zone: 89128960 pages, LIFO batch:63
[    0.025289] Initmem setup node 2 [mem 0x000000ab00000000-0x000001033fffffff]
[    0.025291] On node 2 totalpages: 89391104
[    0.025292]   Normal zone: 1445888 pages used for memmap
[    0.025293]   Normal zone: 89391104 pages, LIFO batch:63
[    2.096982] ACPI: PM-Timer IO Port: 0x448
[    2.096987] ACPI: Local APIC address 0xfee00000

