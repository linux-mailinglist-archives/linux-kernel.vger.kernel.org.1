Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC892D0248
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 10:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgLFJiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 04:38:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgLFJiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 04:38:01 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B69WEiS159503;
        Sun, 6 Dec 2020 04:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=XmcTBFq44vi836zyAohHF6X1GupydpiV7SbX5aQ9n68=;
 b=n3Q1zxJ0QVMlJFa+ffz/mjTyDCNcVipIbrNM3klFKxE7UJxiG0YGFc0WL/m2GFkHjsij
 ykr8WU8suLKLQjrJ3O2y77eBRTHiL8ehddJtSneRzBl++nafJpgUxq5HPOcEtk/ynst9
 SkEzC7luLaBhbl7zlQZBCYU6l8gW2ihqTp7Ee7VOVJT8ZGhy0ZxKEE2fC95dYU3ATAA2
 cvqhUWakUHb4E72CIQ4lVxMK+vW6CDH+VTXxxFDXc01GpXZoYJAVv7kJzRgAeoM0Bdnh
 JE2905nJOL2ipe75QQXbG2uiYA0xMvr0UOKikcc6SLMc0EXVzPHSsSRbBR5kmF8VdnSq Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 358rmxm2h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Dec 2020 04:37:11 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B69WH43159873;
        Sun, 6 Dec 2020 04:37:10 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 358rmxm2fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Dec 2020 04:37:10 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B69Wol5021109;
        Sun, 6 Dec 2020 09:37:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3583svgxdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Dec 2020 09:37:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B69b69x58327394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Dec 2020 09:37:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B0EB4203F;
        Sun,  6 Dec 2020 09:37:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 849EB4204B;
        Sun,  6 Dec 2020 09:37:05 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.50.18])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  6 Dec 2020 09:37:05 +0000 (GMT)
Date:   Sun, 6 Dec 2020 11:37:03 +0200
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
Message-ID: <20201206093703.GY123287@linux.ibm.com>
References: <1527061324-19949-1-git-send-email-rppt@linux.vnet.ibm.com>
 <31DA12CC-E9CC-497D-A2EE-B83549D95CE8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31DA12CC-E9CC-497D-A2EE-B83549D95CE8@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-06_04:2020-12-04,2020-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012060058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nadav,

On Thu, Dec 03, 2020 at 11:57:46AM -0800, Nadav Amit wrote:
> Hello Mike,
> 
> Regarding your (old) patch:
> 
> > On May 23, 2018, at 12:42 AM, Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> > 
> > If a process monitored with userfaultfd changes it's memory mappings or
> > forks() at the same time as uffd monitor fills the process memory with
> > UFFDIO_COPY, the actual creation of page table entries and copying of the
> > data in mcopy_atomic may happen either before of after the memory mapping
> > modifications and there is no way for the uffd monitor to maintain
> > consistent view of the process memory layout.
> > 
> > For instance, let's consider fork() running in parallel with
> > userfaultfd_copy():
> > 
> > process        		         |	uffd monitor
> > ---------------------------------+------------------------------
> > fork()        		         | userfaultfd_copy()
> > ...        		         | ...
> >    dup_mmap()        	         |     down_read(mmap_sem)
> >    down_write(mmap_sem)         |     /* create PTEs, copy data */
> >        dup_uffd()               |     up_read(mmap_sem)
> >        copy_page_range()        |
> >        up_write(mmap_sem)       |
> >        dup_uffd_complete()      |
> >            /* notify monitor */ |
> > 
> > If the userfaultfd_copy() takes the mmap_sem first, the new page(s) will be
> > present by the time copy_page_range() is called and they will appear in the
> > child's memory mappings. However, if the fork() is the first to take the
> > mmap_sem, the new pages won't be mapped in the child's address space.
> > 
> > Since userfaultfd monitor has no way to determine what was the order, let's
> > disallow userfaultfd_copy in parallel with the non-cooperative events. In
> > such case we return -EAGAIN and the uffd monitor can understand that
> > userfaultfd_copy() clashed with a non-cooperative event and take an
> > appropriate action.
> 
> I am struggling to understand this patch and would appreciate your
> assistance.
 
The tl;dr version is that without this commit we had failing fork tests
in CRIU [1] :)

> Specifically, I have two questions:
> 
> 1. How can memory corruption occur? If the page is already mapped and the
> handler “mistakenly" calls userfaultfd_copy(), wouldn't mcopy_atomic_pte()
> return -EEXIST once it sees the PTE already exists? In such case, I would
> presume that the handler should be able to recover gracefully by waking the
> faulting thread.
 
The issue we had was when fork() in a monitored process happened
concurrently with "background copy" of pages into the process address
space during a post-copy process migration.

The userspace has no way to tell who won the race for mmap_lock and
depending on that we can have two different cases:

* fork() took the mmap_lock, pages in the parent are still empty, so
they will be empty in the child

* userfaultfd_copy() won the lock, there is data in the parent and the
child's inherits these mappings

The uffd monotor should *know* what is the state of child's memory and
without this patch it could only guess.

> 2. How is memory ordering supposed to work here? IIUC, mmap_changing is not
> protected by any lock and there are no memory barriers that are associated
> with the assignment. Indeed, the code calls WRITE_ONCE()/READ_ONCE(), but
> AFAIK this does not guarantee ordering with non-volatile reads/writes.

There is also mmap_lock involved, so I don't see how copy can start in
parallel with fork processing. Fork sets mmap_chaning to true while
holding mmap_lock, so copy cannot start in parallel. When mmap_lock is
realeased, mmap_chaning remains true until fork event is pushed to
userspace and when this is done there is no issue with
userfaultfd_copy.

Maybe I am missing something...

[1] https://github.com/checkpoint-restore/criu/blob/criu-dev/test/zdtm/transition/fork.c

> Thanks,
> Nadav

-- 
Sincerely yours,
Mike.
