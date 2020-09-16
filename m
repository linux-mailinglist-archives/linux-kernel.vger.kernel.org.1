Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815E926CBF4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgIPUhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:37:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726219AbgIPRKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:10:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GE1BKg185476;
        Wed, 16 Sep 2020 10:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=B86K0WGBcLMY6iZqRViO8LVek9C0fU/tfYsBQekprmM=;
 b=OVqHN6j4hKQIU5KwMwPlOYqVD9hDm1qyhDMupfiWJfVRSzEOmOw+IlWJRUGIGAVRU9co
 b232ZfHECRL72B4HxeQEp3oI+VgRB6KNR3FBUeRhR4umIO/4xD/g6MJiacj/If9LxZ18
 m8/jnPavaikmhnR9WIV6dQ0y0RE+TFOWFVH7XOPcJ/zyuXlbhRAjB6dqf9yOqlwzK9FO
 2KGiFlUf6NCZxrNdU9H5I1VwLTfofPD9uB+w3jjgVzsVS+7llRUNhZdF2omnUftaMwWN
 X3N88nCJ7x7vx+nhBYZQ4oAWCEaFqIACH++q/VCoHS3wkbyE3JgKoa136c2xb0AOsj2U Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33kkthhju2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 10:28:13 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08GE1c1q188101;
        Wed, 16 Sep 2020 10:28:13 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33kkthhjtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 10:28:12 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08GEGn0u019444;
        Wed, 16 Sep 2020 14:28:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 33k5u7rcwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 14:28:11 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08GES87Z26345832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 14:28:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DA9842049;
        Wed, 16 Sep 2020 14:28:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9EDC42045;
        Wed, 16 Sep 2020 14:28:07 +0000 (GMT)
Received: from osiris (unknown [9.171.80.23])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Sep 2020 14:28:07 +0000 (GMT)
Date:   Wed, 16 Sep 2020 16:28:06 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Qian Cai <cai@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: Bad page state in process dirtyc0w_child
Message-ID: <20200916142806.GD7076@osiris>
References: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_07:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 09:54:12PM -0400, Qian Cai wrote:
> Occasionally, running this LTP test will trigger an error below on
> s390:
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/dirtyc0w/dirtyc0w.c
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
> 
> this .config:
> https://gitlab.com/cailca/linux-mm/-/blob/master/s390.config
> 
> [ 6970.253173] LTP: starting dirtyc0w
> [ 6971.599102] BUG: Bad page state in process dirtyc0w_child  pfn:8865d
> [ 6971.599867] page:000000001a8328d7 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8865d
> [ 6971.599876] flags: 0x400000000008000e(referenced|uptodate|dirty|swapbacked)
> [ 6971.599886] raw: 400000000008000e 0000000000000100 0000000000000122 0000000000000000
> [ 6971.599893] raw: 0000000000000000 0000000000000000 ffffffff00000000 0000000000000000
> [ 6971.599900] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> [ 6971.599906] Modules linked in: loop kvm ip_tables x_tables dm_mirror dm_region_hash dm_log dm_mod [last unloaded: dummy_del_mod]
> [ 6971.599952] CPU: 1 PID: 65238 Comm: dirtyc0w_child Tainted: G           O      5.9.0-rc4-next-20200909 #1
> [ 6971.599959] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
> [ 6971.599964] Call Trace:
> [ 6971.599979]  [<0000000073aec038>] show_stack+0x158/0x1f0 
> [ 6971.599986]  [<0000000073af724a>] dump_stack+0x1f2/0x238 
> [ 6971.599994]  [<0000000072ed086a>] bad_page+0x1ba/0x1c0 
> [ 6971.600000]  [<0000000072ed20c4>] free_pcp_prepare+0x4fc/0x658 
> [ 6971.600006]  [<0000000072ed96a6>] free_unref_page+0xae/0x158 
> [ 6971.600013]  [<0000000072e8286a>] unmap_page_range+0xb62/0x1df8 
> [ 6971.600019]  [<0000000072e83bbc>] unmap_single_vma+0xbc/0x1c8 
> [ 6971.600025]  [<0000000072e8418e>] zap_page_range+0x176/0x230 
> [ 6971.600033]  [<0000000072eece8e>] do_madvise+0xfde/0x1270 
> [ 6971.600039]  [<0000000072eed50a>] __s390x_sys_madvise+0x72/0x98 
> [ 6971.600047]  [<0000000073b1cce4>] system_call+0xdc/0x278 
> [ 6971.600053] 2 locks held by dirtyc0w_child/65238:
> [ 6971.600058]  #0: 000000013442fa18 (&mm->mmap_lock){++++}-{3:3}, at: do_madvise+0x17a/0x1270
> [ 6971.600432]  #1: 00000001343f9060 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: unmap_page_range+0x640/0x1df8
> [ 6971.600487] Disabling lock debugging due to kernel taint
> 
> Once it happens, running it again will trigger in on another PFN.
> 
> [39717.085115] BUG: Bad page state in process dirtyc0w_child  pfn:af065 
> 
> Any thoughts?

Alexander, Gerald, could you take a look?
