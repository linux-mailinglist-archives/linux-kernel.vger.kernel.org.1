Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7175D28418A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgJEUkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:40:20 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:15736 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726935AbgJEUkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:40:19 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095Ka4jT032753;
        Mon, 5 Oct 2020 20:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=dSLllFpQfP9e6b7pjY9F7Db863NhII7MQZpc57rqh1U=;
 b=Csnx4YNosiqwEFf4KEmO9XzfcvU8EbBkGWoTBEdeU1NLqZP7B6bIf0VFvLCWp2sE2pU/
 NOsKPxvKX6StFpbzxV8dPZNBsDW3HF50Lncla66KCLmZz9t/VBeZgOHu2zFaJUueNQuO
 bfS6Xor9R4pSr24YPLeDT5TUiK/XhqVHXFyU4qiRSVLleRnVD2pV4TUStGBtQqN6NosU
 RKh+D4Lkr9iPgp0x1CT3qcGjhj8NsgpFkfalwczJe5bjg1nnWG8gvKWDJpA9KCWYozLM
 ShwzJGGutEP+8ftyjrQIHwDmo+r6BrBoMakq30KVgVB2I36C9iWFu6gaowULXxMFMOWk bw== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 33xgdvkaqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 20:39:46 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 0F1054E;
        Mon,  5 Oct 2020 20:39:46 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 4D66E4C;
        Mon,  5 Oct 2020 20:39:44 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mike Travis <mike.travis@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 00/13] x86/platform/uv: Updates for UV5 Architecture
Date:   Mon,  5 Oct 2020 15:39:16 -0500
Message-Id: <20201005203929.148656-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_15:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 mlxlogscore=565 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changes included in this patch set:

 * Add changes needed for new UV5 UV architecture.  Chief among the
   changes are 52 bits of physical memory address and 57 bits of
   virtual address space.

 * Remove the BAU TLB code cuurently being replaced by BAU APIC driver.

 * Remove System Controller (monitoring) code

 * Updated UV mmrs.h file removing UV1, adding UVY class, optimizing
   the arch selection of the MMR address/field, and trimming down MMR
   selection list reducing number of MMRs being defined.

 * Process UV ArchType in UV BIOS generated UVsystab allowing OEMs to
   use OEM_ID for their own purposes.

 * Update various mapping functions (MMIOH, MMR, GRU) to accommodate
   UV5 differences.

 * Update node present counting for change in MMRs.

 * Update TSC sync check of BIOS sync status.

 * Update NMI handler for UV5 MMR changes.

 * Update copyrights to conform to HPE standards.


This is version 4 with these changes since version 3: 

 * Fixed coding errors reported by kernel test robot <lkp@intel.com>

 - In [PATCH 04/13] x86/platform/uv: Update UV MMRs for UV5
     Remove pnodeid return from early_get_pnodeid() as it was only used by UV1.
     Remove read node_id in uv_init_hub_info() as it was no longer relevant.

 - In [PATCH v3 07/13] x86/platform/uv: Update MMIOH references based on new UV5 MMRs.
     Make calc_mmioh_map() a static function.


This is version 3 with these changes since version 2: 

 * Changes made to .gitconfig so no internal (unreachable) systems
   are referenced.


This is version 2 with these changes since version 1: 

 * Added diffstats to p-intro.

 * Updated Copyrights to be in one file and only include the year
   the code was modified.

 * Updated to use git format-patch to construct patch email and 
   git send-email to send the patches.


Mike Travis (13):
  x86/platform/uv: Remove UV BAU TLB Shootdown Handler
  x86/platform/uv: Remove SCIR MMR references for UVY systems.
  x86/platform/uv: Adjust references in UV kernel modules
  x86/platform/uv: Update UV MMRs for UV5
  x86/platform/uv: Add UV5 direct references
  x86/platform/uv: Add and Decode Arch Type in UVsystab
  x86/platform/uv: Update MMIOH references based on new UV5 MMRs.
  x86/platform/uv: Adjust GAM MMR references affected by UV5 updates
  x86/platform/uv: Update UV5 MMR references in UV GRU
  x86/platform/uv: Update Node Present Counting
  x86/platform/uv: Update UV5 TSC Checking
  x86/platform/uv: Update for UV5 NMI MMR changes
  x86/platform/uv: Update Copyrights to conform to HPE standards

 arch/x86/include/asm/idtentry.h     |    4 -
 arch/x86/include/asm/uv/bios.h      |   17 +-
 arch/x86/include/asm/uv/uv.h        |    4 +-
 arch/x86/include/asm/uv/uv_bau.h    |  755 ---
 arch/x86/include/asm/uv/uv_hub.h    |  165 +-
 arch/x86/include/asm/uv/uv_mmrs.h   | 7646 ++++++++++++++-------------
 arch/x86/kernel/apic/x2apic_uv_x.c  |  822 +--
 arch/x86/kernel/idt.c               |    3 -
 arch/x86/mm/tlb.c                   |   24 -
 arch/x86/platform/uv/Makefile       |    2 +-
 arch/x86/platform/uv/bios_uv.c      |   28 +-
 arch/x86/platform/uv/tlb_uv.c       | 2097 --------
 arch/x86/platform/uv/uv_nmi.c       |   65 +-
 arch/x86/platform/uv/uv_time.c      |   11 +-
 drivers/misc/sgi-gru/grufile.c      |    3 +-
 drivers/misc/sgi-xp/xp.h            |    9 +-
 drivers/misc/sgi-xp/xp_main.c       |    5 +-
 drivers/misc/sgi-xp/xp_uv.c         |    7 +-
 drivers/misc/sgi-xp/xpc_main.c      |    7 +-
 drivers/misc/sgi-xp/xpc_partition.c |    3 +-
 drivers/misc/sgi-xp/xpnet.c         |    3 +-
 21 files changed, 4797 insertions(+), 6883 deletions(-)
 delete mode 100644 arch/x86/include/asm/uv/uv_bau.h
 delete mode 100644 arch/x86/platform/uv/tlb_uv.c

-- 
2.21.0

