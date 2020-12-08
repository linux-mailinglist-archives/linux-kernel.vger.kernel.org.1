Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CBC2D2646
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgLHIf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:35:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727943AbgLHIf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:35:28 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B88WmNa010012;
        Tue, 8 Dec 2020 03:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=YjW1S1evXcX1VNVyjA60VPUN1DwZqqpWhVmBanVxlY8=;
 b=qY6onCAUMquqfqyZUaM9yhDgiV/uk6l7sJ0yLnlmyLxF/b/Au1iqK9a1VRs7Bg0hWbxf
 ISDUmoyfGxqcQDTvvAfyrRiWnfTNTt3DYzybLZuu9aCIiC75Rai85RkdpqIi3dUTLyVe
 ySHQOZYwYL9HPCgjW0ShtwrFmDsvViVcAYY/53YWjsQ/Tzu/vRh6AlTelOL5q9PtP0ir
 JxT20au5I8edTvnrKivzlRul2nDs2UmRd7TVMMBaSbPR3kWSI6lGq3m615P+1Aj2+mKU
 PyWlcZSZBlJ/0fcZDKTRC5SKmHJx0eM38t9WXf6gYc4X3E7TJkpgY+1y57ToF8V4neVb 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35a5tcrgd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 03:34:43 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B88XXDq012963;
        Tue, 8 Dec 2020 03:34:42 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35a5tcrgc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 03:34:42 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B88SBIO003889;
        Tue, 8 Dec 2020 08:34:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3581u83c2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 08:34:40 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B88YceC54526262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 08:34:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BBAB42041;
        Tue,  8 Dec 2020 08:34:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26A664204B;
        Tue,  8 Dec 2020 08:34:37 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.50.18])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Dec 2020 08:34:37 +0000 (GMT)
Date:   Tue, 8 Dec 2020 10:34:34 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>
Subject: Re: [PATCH] userfaultfd: prevent non-cooperative events vs
 mcopy_atomic races
Message-ID: <20201208083434.GA1164013@linux.ibm.com>
References: <1527061324-19949-1-git-send-email-rppt@linux.vnet.ibm.com>
 <31DA12CC-E9CC-497D-A2EE-B83549D95CE8@gmail.com>
 <20201206093703.GY123287@linux.ibm.com>
 <5921BA80-F263-4F8D-B7E6-316CEB602B51@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5921BA80-F263-4F8D-B7E6-316CEB602B51@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_03:2020-12-04,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 08:31:39PM -0800, Nadav Amit wrote:
> 
> Whenever I run into a non-standard and non-trivial synchronization algorithm
> in the kernel (and elsewhere), I become very confused and concerned. I
> raised my question since I wanted to modify the code and could not figure
> out how to properly do so. Based on your input that the monitor is expected
> to know the child mappings according to userfaultfd events, I now think that
> the kernel does not provide this ability and the locking scheme is broken.
> 
> Here are some scenarios that I think are broken - please correct me if I am
> wrong:
> 
> * Scenario 1: MADV_DONTNEED racing with userfaultfd page-faults
> 
> userfaultfd_remove() only holds the mmap_lock for read, so these events
> cannot be ordered with userfaultfd page-faults.
> 
> * Scenario 2: MADV_DONTNEED racing with fork()
> 
> As userfaultfd_remove() releases mmap_lock after the user notification and
> before the actual unmapping, concurrent fork() might happen before or after
> the actual unmapping in MADV_DONTNEED and the user therefore has no way of
> knowing whether the actual unmapping took place before or after the fork().
> 
> * Scenario 3: Concurrent MADV_DONTNEED can cause userfaultfd_remove() to
> clear mmap_changing cleared before all the notifications are completed.
> 
> As mmap_lock is only taken for read, the first thread the completed
> userfaultfd_remove() would clear the indication that was set by the other
> one.
> 
> * Scenario 4: Fork starts and ends between copying of two pages.
> 
> As mmap_lock might be released during ioctl_copy() (inside
> __mcopy_atomic()), some pages might be mapped in the child and others not:
> 
> 
> CPU0				CPU1
> ----				----
> ioctl_copy():
>  __mcopy_atomic()
>   mmap_read_lock()
>   !mmap_changing [ok]
>   mfill_atomic_pte() == 0 [page0 copied]
>   mfill_atomic_pte() == -ENOENT [page1 will be retried]
>   mmap_read_unlock()
>   goto retry
> 
> 				fork():
> 				 dup_userfaultfd()
> 				 -> mmap_changing=true
> 				 userfaultfd_event_wait_completion()
> 				 -> mmap_changing=false
> 
>   mmap_read_lock()
>   !mmap_changing [ok]
>   mfill_atomic_pte() == 0 [page1 copied]
>   mmap_read_unlock()
>  
>  return: 2 pages were mapped, while the first is present in the child and
>  the second one is non-present.
> 
> Bottom-line: it seems to me that mmap_changing should be a counter (not
> boolean) that is protected by mmap_lock. This counter should be kept
> elevated throughout the entire operation (in regard to MADV_DONTNEED).
> Perhaps mmap_lock does not have to be taken to decrease the counter, but
> then an smp_wmb() would be needed before the counter is decreased.
> 
> Let me know whether I am completely off or missing something.

I tried to remember what's going on there and wrap my head around your
examples. I'm not sure if userspace cannot workaround some of those, but
I can't say I can propose it right now.

There is for sure userspace is helpless in Scenario 4, but I think it is
very unlikely that fork() will be fast enough to grab and release
mmap_lock while uffd_copy() waits for CPU to retry.

I agree that a making mmap_changing a counter would be more robust
anyway.

> Thanks,
> Nadav
> 

-- 
Sincerely yours,
Mike.
