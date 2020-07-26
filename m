Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591BC22E245
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 21:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGZTgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 15:36:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgGZTgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 15:36:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06QJVlF6028843;
        Sun, 26 Jul 2020 15:36:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ggw3xxxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 15:36:21 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06QJWDgL029560;
        Sun, 26 Jul 2020 15:36:21 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ggw3xxx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 15:36:21 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06QJZ7R2007080;
        Sun, 26 Jul 2020 19:36:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 32gcpw8vsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 19:36:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06QJaFJa50397516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 19:36:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB84B42049;
        Sun, 26 Jul 2020 19:36:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 114954203F;
        Sun, 26 Jul 2020 19:36:12 +0000 (GMT)
Received: from [192.168.0.8] (unknown [9.85.82.224])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 19:36:11 +0000 (GMT)
Subject: [RESEND PATCH v5 00/11] ppc64: enable kdump support for
 kexec_file_load syscall
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Pingfan Liu <piliu@redhat.com>, kernel test robot <lkp@intel.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Pingfan Liu <piliu@redhat.com>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pingfan Liu <piliu@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Date:   Mon, 27 Jul 2020 01:06:09 +0530
Message-ID: <159579157320.5790.6748078824637688685.stgit@hbathini>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_09:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007260150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry! There was a gateway issue on my system while posting v5, due to
which some patches did not make it through. Resending...

This patch series enables kdump support for kexec_file_load system
call (kexec -s -p) on PPC64. The changes are inspired from kexec-tools
code but heavily modified for kernel consumption.

The first patch adds a weak arch_kexec_locate_mem_hole() function to
override locate memory hole logic suiting arch needs. There are some
special regions in ppc64 which should be avoided while loading buffer
& there are multiple callers to kexec_add_buffer making it complicated
to maintain range sanity and using generic lookup at the same time.

The second patch marks ppc64 specific code within arch/powerpc/kexec
and arch/powerpc/purgatory to make the subsequent code changes easy
to understand.

The next patch adds helper function to setup different memory ranges
needed for loading kdump kernel, booting into it and exporting the
crashing kernel's elfcore.

The fourth patch overrides arch_kexec_locate_mem_hole() function to
locate memory hole for kdump segments by accounting for the special
memory regions, referred to as excluded memory ranges, and sets
kbuf->mem when a suitable memory region is found.

The fifth patch moves walk_drmem_lmbs() out of .init section with
a few changes to reuse it for setting up kdump kernel's usable memory
ranges. The next patch uses walk_drmem_lmbs() to look up the LMBs
and set linux,drconf-usable-memory & linux,usable-memory properties
in order to restrict kdump kernel's memory usage.

The seventh patch updates purgatory to setup r8 & r9 with opal base
and opal entry addresses respectively to aid kernels built with
CONFIG_PPC_EARLY_DEBUG_OPAL enabled. The next patch setups up backup
region as a kexec segment while loading kdump kernel and teaches
purgatory to copy data from source to destination.

Patch 09 builds the elfcore header for the running kernel & passes
the info to kdump kernel via "elfcorehdr=" parameter to export as
/proc/vmcore file. The next patch sets up the memory reserve map
for the kexec kernel and also claims kdump support for kdump as
all the necessary changes are added.

The last patch fixes a lookup issue for `kexec -l -s` case when
memory is reserved for crashkernel.

Tested the changes successfully on P8, P9 lpars, couple of OpenPOWER
boxes, one with secureboot enabled, KVM guest and a simulator.

v4 -> v5:
* Dropped patches 07/12 & 08/12 and updated purgatory to do everything
  in assembly.
* Added a new patch (which was part of patch 08/12 in v4) to update
  r8 & r9 registers with opal base & opal entry addresses as it is
  expected on kernels built with CONFIG_PPC_EARLY_DEBUG_OPAL enabled.
* Fixed kexec load issue on KVM guest.

v3 -> v4:
* Updated get_node_path() function to be iterative instead of a recursive one.
* Added comment explaining why low memory is added to kdump kernel's usable
  memory ranges though it doesn't fall in crashkernel region.
* Fixed stack_buf to be quadword aligned in accordance with ABI.
* Added missing of_node_put() in setup_purgatory_ppc64().
* Added a FIXME tag to indicate issue in adding opal/rtas regions to
  core image.

v2 -> v3:
* Fixed TOC pointer calculation for purgatory by using section info
  that has relocations applied.
* Fixed arch_kexec_locate_mem_hole() function to fallback to generic
  kexec_locate_mem_hole() lookup if exclude ranges list is empty.
* Dropped check for backup_start in trampoline_64.S as purgatory()
  function takes care of it anyway.

v1 -> v2:
* Introduced arch_kexec_locate_mem_hole() for override and dropped
  weak arch_kexec_add_buffer().
* Addressed warnings reported by lkp.
* Added patch to address kexec load issue when memory is reserved
  for crashkernel.
* Used the appropriate license header for the new files added.
* Added an option to merge ranges to minimize reallocations while
  adding memory ranges.
* Dropped within_crashkernel parameter for add_opal_mem_range() &
  add_rtas_mem_range() functions as it is not really needed.

---

Hari Bathini (11):
      kexec_file: allow archs to handle special regions while locating memory hole
      powerpc/kexec_file: mark PPC64 specific code
      powerpc/kexec_file: add helper functions for getting memory ranges
      ppc64/kexec_file: avoid stomping memory used by special regions
      powerpc/drmem: make lmb walk a bit more flexible
      ppc64/kexec_file: restrict memory usage of kdump kernel
      ppc64/kexec_file: enable early kernel's OPAL calls
      ppc64/kexec_file: setup backup region for kdump kernel
      ppc64/kexec_file: prepare elfcore header for crashing kernel
      ppc64/kexec_file: add appropriate regions for memory reserve map
      ppc64/kexec_file: fix kexec load failure with lack of memory hole


 arch/powerpc/include/asm/crashdump-ppc64.h |   19 
 arch/powerpc/include/asm/drmem.h           |    9 
 arch/powerpc/include/asm/kexec.h           |   29 +
 arch/powerpc/include/asm/kexec_ranges.h    |   25 +
 arch/powerpc/kernel/prom.c                 |   13 
 arch/powerpc/kexec/Makefile                |    2 
 arch/powerpc/kexec/elf_64.c                |   36 +
 arch/powerpc/kexec/file_load.c             |   60 +
 arch/powerpc/kexec/file_load_64.c          | 1209 ++++++++++++++++++++++++++++
 arch/powerpc/kexec/ranges.c                |  417 ++++++++++
 arch/powerpc/mm/drmem.c                    |   87 +-
 arch/powerpc/mm/numa.c                     |   13 
 arch/powerpc/purgatory/Makefile            |    4 
 arch/powerpc/purgatory/trampoline.S        |  117 ---
 arch/powerpc/purgatory/trampoline_64.S     |  162 ++++
 include/linux/kexec.h                      |   29 -
 kernel/kexec_file.c                        |   16 
 17 files changed, 2052 insertions(+), 195 deletions(-)
 create mode 100644 arch/powerpc/include/asm/crashdump-ppc64.h
 create mode 100644 arch/powerpc/include/asm/kexec_ranges.h
 create mode 100644 arch/powerpc/kexec/file_load_64.c
 create mode 100644 arch/powerpc/kexec/ranges.c
 delete mode 100644 arch/powerpc/purgatory/trampoline.S
 create mode 100644 arch/powerpc/purgatory/trampoline_64.S


