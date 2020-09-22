Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7271927472E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIVREB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:04:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726643AbgIVREB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:04:01 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08MH1XgZ016858;
        Tue, 22 Sep 2020 13:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=KzesJ+Wb6pMdAQ2+gjzp5hmkylzxRAwFx/QQLN1UBZo=;
 b=QwXLIVdmd5biHatOLMpxl10YaKkFRqJDSfz8Dfxv6uxs27u2z1O4wMka0Y2oOgzw7wBT
 lHj4kyyTOiifY/rVAkOwmtfd1HOnH4DKUy9MacvXYL6yw79752/IaYj9ZikXrCT+BHK7
 fky5gEz7wsSRLvugVFUm1LrbwWKpLH9wiOPAvc0Ls5ryfNYwSn5vqK3TLawzVwUdTXd+
 tcE56YmXtH7ladjTcJsMIl9k2othiIdnyg5RekgZDKr6eEV0a3q+fzuOCh5Ob3sToXiK
 sdI9TebCC/5oTBrT4SuR22AaO5iyIwmaDDin6iFAWkpmEJAeU/bSO8pX7OOJFDfa2y5N aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33qjcp6ej7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 13:03:58 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08MH3uIv024861;
        Tue, 22 Sep 2020 13:03:58 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33qjcp6eha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 13:03:57 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08MH2frm011830;
        Tue, 22 Sep 2020 17:03:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 33p1f3s8k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 17:03:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08MH3qHW25952614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 17:03:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FF9CA4062;
        Tue, 22 Sep 2020 17:03:52 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1E33A4060;
        Tue, 22 Sep 2020 17:03:51 +0000 (GMT)
Received: from thinkpad (unknown [9.171.5.34])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 22 Sep 2020 17:03:51 +0000 (GMT)
Date:   Tue, 22 Sep 2020 19:03:50 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Qian Cai <cai@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: Bad page state in process dirtyc0w_child
Message-ID: <20200922190350.7a0e0ca5@thinkpad>
In-Reply-To: <20200916142806.GD7076@osiris>
References: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
        <20200916142806.GD7076@osiris>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_16:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 16:28:06 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Sat, Sep 12, 2020 at 09:54:12PM -0400, Qian Cai wrote:
> > Occasionally, running this LTP test will trigger an error below on
> > s390:
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/dirtyc0w/dirtyc0w.c
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
> > 
> > this .config:
> > https://gitlab.com/cailca/linux-mm/-/blob/master/s390.config
> > 
> > [ 6970.253173] LTP: starting dirtyc0w
> > [ 6971.599102] BUG: Bad page state in process dirtyc0w_child  pfn:8865d
> > [ 6971.599867] page:000000001a8328d7 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8865d
> > [ 6971.599876] flags: 0x400000000008000e(referenced|uptodate|dirty|swapbacked)
> > [ 6971.599886] raw: 400000000008000e 0000000000000100 0000000000000122 0000000000000000
> > [ 6971.599893] raw: 0000000000000000 0000000000000000 ffffffff00000000 0000000000000000
> > [ 6971.599900] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> > [ 6971.599906] Modules linked in: loop kvm ip_tables x_tables dm_mirror dm_region_hash dm_log dm_mod [last unloaded: dummy_del_mod]
> > [ 6971.599952] CPU: 1 PID: 65238 Comm: dirtyc0w_child Tainted: G           O      5.9.0-rc4-next-20200909 #1
> > [ 6971.599959] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
> > [ 6971.599964] Call Trace:
> > [ 6971.599979]  [<0000000073aec038>] show_stack+0x158/0x1f0 
> > [ 6971.599986]  [<0000000073af724a>] dump_stack+0x1f2/0x238 
> > [ 6971.599994]  [<0000000072ed086a>] bad_page+0x1ba/0x1c0 
> > [ 6971.600000]  [<0000000072ed20c4>] free_pcp_prepare+0x4fc/0x658 
> > [ 6971.600006]  [<0000000072ed96a6>] free_unref_page+0xae/0x158 
> > [ 6971.600013]  [<0000000072e8286a>] unmap_page_range+0xb62/0x1df8 
> > [ 6971.600019]  [<0000000072e83bbc>] unmap_single_vma+0xbc/0x1c8 
> > [ 6971.600025]  [<0000000072e8418e>] zap_page_range+0x176/0x230 
> > [ 6971.600033]  [<0000000072eece8e>] do_madvise+0xfde/0x1270 
> > [ 6971.600039]  [<0000000072eed50a>] __s390x_sys_madvise+0x72/0x98 
> > [ 6971.600047]  [<0000000073b1cce4>] system_call+0xdc/0x278 
> > [ 6971.600053] 2 locks held by dirtyc0w_child/65238:
> > [ 6971.600058]  #0: 000000013442fa18 (&mm->mmap_lock){++++}-{3:3}, at: do_madvise+0x17a/0x1270
> > [ 6971.600432]  #1: 00000001343f9060 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: unmap_page_range+0x640/0x1df8
> > [ 6971.600487] Disabling lock debugging due to kernel taint
> > 
> > Once it happens, running it again will trigger in on another PFN.
> > 
> > [39717.085115] BUG: Bad page state in process dirtyc0w_child  pfn:af065 
> > 
> > Any thoughts?  
> 
> Alexander, Gerald, could you take a look?

Thanks for reporting. From the header of dirtyc0w.c it seems that this
is testing some gup behavior. Given that we have an issue with gup_fast
on s390, this could be related. I'll try to reproduce and do more
analysis.

A fix for our gup_fast issue is also in linux-next now, as of 2020-09-20,
but it was not yet included in your kernel version 5.9.0-rc4-next-20200909.
So if this is related to the gup_fast issue, it should not occur again
with linux-next kernels after 2020-09-20.
