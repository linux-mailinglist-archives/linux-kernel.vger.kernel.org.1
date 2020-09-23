Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5802758E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIWNju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:39:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726487AbgIWNjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:39:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NDVSf4076386;
        Wed, 23 Sep 2020 09:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Jl280IxXooA8HvValtUSpa6BRZDC1vAdpRBNTiRs6z0=;
 b=LVGKeTi4SqG/2jmXbtEsBIHJoTklBcUbObsE2v39JT66DvvB2YZi35hGh4JRaXZGmKpQ
 x9fsO2nJrV61Sx/Esv/MF0ICcQblzHTFIhdMDuJAUOsDIY8QrQ5xKenWtKh3kIazysLx
 1Si58j/dPdfciFdS3S4xOAlMI0XE+Z9XYUL8xcSJ5Ob/XktR+UHh4hKRfJXQ9+vDPTRP
 hksPMFrXiCNvWKmKiyoG9kGQ3arCFNiGXzeGV6Y6FgoJjm0t2npVnmuU3gwyQ0uSm9zU
 MLjJ+ZuK64Ai3POZpQS63HbVT3RKSm/QVOLQXuO8f5d4ZvCAW9HJ8hN3cbCL4QqETlJp 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33r76gghjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 09:39:46 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08NDVUeK076702;
        Wed, 23 Sep 2020 09:39:45 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33r76gghhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 09:39:45 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08NDcSBW026990;
        Wed, 23 Sep 2020 13:39:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33payuaxwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 13:39:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08NDdebh33096186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 13:39:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A06C411C050;
        Wed, 23 Sep 2020 13:39:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3895311C058;
        Wed, 23 Sep 2020 13:39:40 +0000 (GMT)
Received: from thinkpad (unknown [9.171.62.28])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 23 Sep 2020 13:39:40 +0000 (GMT)
Date:   Wed, 23 Sep 2020 15:39:38 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>, Qian Cai <cai@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: Bad page state in process dirtyc0w_child
Message-ID: <20200923153938.5be5dd2c@thinkpad>
In-Reply-To: <20200922190350.7a0e0ca5@thinkpad>
References: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
        <20200916142806.GD7076@osiris>
        <20200922190350.7a0e0ca5@thinkpad>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_09:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 19:03:50 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

> On Wed, 16 Sep 2020 16:28:06 +0200
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > On Sat, Sep 12, 2020 at 09:54:12PM -0400, Qian Cai wrote:
> > > Occasionally, running this LTP test will trigger an error below on
> > > s390:
> > > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/dirtyc0w/dirtyc0w.c
> > > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
> > > 
> > > this .config:
> > > https://gitlab.com/cailca/linux-mm/-/blob/master/s390.config
> > > 
> > > [ 6970.253173] LTP: starting dirtyc0w
> > > [ 6971.599102] BUG: Bad page state in process dirtyc0w_child  pfn:8865d
> > > [ 6971.599867] page:000000001a8328d7 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8865d
> > > [ 6971.599876] flags: 0x400000000008000e(referenced|uptodate|dirty|swapbacked)
> > > [ 6971.599886] raw: 400000000008000e 0000000000000100 0000000000000122 0000000000000000
> > > [ 6971.599893] raw: 0000000000000000 0000000000000000 ffffffff00000000 0000000000000000
> > > [ 6971.599900] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> > > [ 6971.599906] Modules linked in: loop kvm ip_tables x_tables dm_mirror dm_region_hash dm_log dm_mod [last unloaded: dummy_del_mod]
> > > [ 6971.599952] CPU: 1 PID: 65238 Comm: dirtyc0w_child Tainted: G           O      5.9.0-rc4-next-20200909 #1
> > > [ 6971.599959] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
> > > [ 6971.599964] Call Trace:
> > > [ 6971.599979]  [<0000000073aec038>] show_stack+0x158/0x1f0 
> > > [ 6971.599986]  [<0000000073af724a>] dump_stack+0x1f2/0x238 
> > > [ 6971.599994]  [<0000000072ed086a>] bad_page+0x1ba/0x1c0 
> > > [ 6971.600000]  [<0000000072ed20c4>] free_pcp_prepare+0x4fc/0x658 
> > > [ 6971.600006]  [<0000000072ed96a6>] free_unref_page+0xae/0x158 
> > > [ 6971.600013]  [<0000000072e8286a>] unmap_page_range+0xb62/0x1df8 
> > > [ 6971.600019]  [<0000000072e83bbc>] unmap_single_vma+0xbc/0x1c8 
> > > [ 6971.600025]  [<0000000072e8418e>] zap_page_range+0x176/0x230 
> > > [ 6971.600033]  [<0000000072eece8e>] do_madvise+0xfde/0x1270 
> > > [ 6971.600039]  [<0000000072eed50a>] __s390x_sys_madvise+0x72/0x98 
> > > [ 6971.600047]  [<0000000073b1cce4>] system_call+0xdc/0x278 
> > > [ 6971.600053] 2 locks held by dirtyc0w_child/65238:
> > > [ 6971.600058]  #0: 000000013442fa18 (&mm->mmap_lock){++++}-{3:3}, at: do_madvise+0x17a/0x1270
> > > [ 6971.600432]  #1: 00000001343f9060 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: unmap_page_range+0x640/0x1df8
> > > [ 6971.600487] Disabling lock debugging due to kernel taint
> > > 
> > > Once it happens, running it again will trigger in on another PFN.
> > > 
> > > [39717.085115] BUG: Bad page state in process dirtyc0w_child  pfn:af065 
> > > 
> > > Any thoughts?  
> > 
> > Alexander, Gerald, could you take a look?
> 
> Thanks for reporting. From the header of dirtyc0w.c it seems that this
> is testing some gup behavior. Given that we have an issue with gup_fast
> on s390, this could be related. I'll try to reproduce and do more
> analysis.
> 
> A fix for our gup_fast issue is also in linux-next now, as of 2020-09-20,
> but it was not yet included in your kernel version 5.9.0-rc4-next-20200909.
> So if this is related to the gup_fast issue, it should not occur again
> with linux-next kernels after 2020-09-20.

OK, I can now reproduce this, and unfortunately also with the gup_fast
fix, so it is something different. Bisecting is a bit hard, as it will
not always show immediately, sometimes takes up to an hour.

Still, I think I found the culprit, merge commit b25d1dc9474e "Merge
branch 'simplify-do_wp_page'". Without those 4 patches, it works fine,
running over night.

Not sure why this only shows on s390, should not be architecture-specific,
but we do often see subtle races earlier than others due to hypervisor
impact.

The first commit 09854ba94c6a ("mm: do_wp_page() simplification") already
introduces this error. The dirtyc0w_child test seems to play with cow
and racing madvise(MADV_DONTNEED), but I have not yet fully understood
it and also not the changes from commit 09854ba94c6a. As Linus already
mentioned in the merge commit message, this is some bad timing for such
a change, so I don't want to delay this further with trying to understand
it better before reporting. Maybe Peter or Linus can spot some obvious
issue.

One thing that seems strange to me is that the page flags from the
bad page state output are (uptodate|swapbacked), see below, or
(referenced|uptodate|dirty|swapbacked) in the original report. But IIUC,
that should not qualify for the "PAGE_FLAGS_CHECK_AT_FREE flag(s) set"
reason. So it seems that the flags have changed between check_free_page()
and __dump_page(), which would be very odd. Or maybe some issue with
compound pages, because __dump_page() looks at head->flags.

[ 1863.237707] BUG: Bad page state in process dirtyc0w_child  pfn:58527d
[ 1863.237721] page:000000008866956b refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x58527d
[ 1863.237727] flags: 0x3ffff00000080004(uptodate|swapbacked)
[ 1863.237734] raw: 3ffff00000080004 0000000000000100 0000000000000122 0000000000000000
[ 1863.237738] raw: 0000000000000000 0000000000000000 ffffffff00000000 0000000000000000
[ 1863.237742] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
[ 1863.237745] Modules linked in:
[ 1863.237752] CPU: 16 PID: 9074 Comm: dirtyc0w_child Tainted: G    B             5.9.0-rc6-00020-geff48ddeab78-dirty #104
[ 1863.237756] Hardware name: IBM 3906 M03 703 (LPAR)
[ 1863.237759] Call Trace:
[ 1863.237768]  [<0000000000115f28>] show_stack+0x100/0x158 
[ 1863.237775]  [<000000000096b41a>] dump_stack+0xa2/0xd8 
[ 1863.237781]  [<00000000003d497c>] bad_page+0xdc/0x140 
[ 1863.237785]  [<00000000003d5b62>] free_pcp_prepare+0x31a/0x360 
[ 1863.237789]  [<00000000003d906a>] free_unref_page+0x32/0xb8 
[ 1863.237794]  [<00000000003b05f4>] zap_p4d_range+0x64c/0xcf8 
[ 1863.237797]  [<00000000003b0e7a>] unmap_page_range+0x9a/0x110 
[ 1863.237801]  [<00000000003b0f84>] unmap_single_vma+0x94/0x100 
[ 1863.237805]  [<00000000003b14c2>] zap_page_range+0x14a/0x1f0 
[ 1863.237809]  [<00000000003e3a24>] do_madvise+0x75c/0x918 
[ 1863.237812]  [<00000000003e3c06>] __s390x_sys_madvise+0x26/0x38 
[ 1863.237817]  [<0000000000d280d4>] system_call+0xe0/0x2c0 
[ 1863.237820] INFO: lockdep is turned off.
