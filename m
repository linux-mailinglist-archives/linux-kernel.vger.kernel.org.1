Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17584280BA3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 02:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733271AbgJBA3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 20:29:55 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:33736 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbgJBA3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 20:29:55 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09205joU003404;
        Fri, 2 Oct 2020 00:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=bi5qeYHNN05AhivFE/qJMX6chnprVNesAQqgAB3tPLY=;
 b=huuutosvtpvrpJSD5lYcAuMhdEX3hzhHdBbvSBBcA226XIKDgSghcN3eL6siB2rKgppZ
 cZ3Fqo+IDfBDMGzRbWtMqvY7NURgIEijkdfJf52jiJCXQNyf3c1yI/rXIol0qRm0gC5o
 jQ1jLOj/XCEMJpKuJV3cW4yC0q5GTrD1vvTOzbv3LFdNvuvmzzBO4rW6DYaH+PIu+LZJ
 RWw7Atmv4IHb2LXgn/EL/FCd0LizamJw+2a32gKz3sEHeVV13ylYu52px79CrKdqtRff
 ORPDdPnAwbyLPEvaRbKCY8o30yBkbwkQbS+/V9cSzP/BsJh+9QJgvg5YoDBx7fA1TNFa 7A== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 33wg0vcghj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 00:05:56 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id E91248B;
        Fri,  2 Oct 2020 00:05:55 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 2BB1F37;
        Fri,  2 Oct 2020 00:05:53 +0000 (UTC)
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
Subject: [PATCH v3 00/13] x86/platform/uv: Updates for UV5 Architecture
Date:   Thu,  1 Oct 2020 19:05:25 -0500
Message-Id: <20201002000538.94424-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_10:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1011
 mlxlogscore=290 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010195
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


This is version 2 with these changes since version 1: 

 * Added diffstats to p-intro.

 * Updated Copyrights to be in one file and only include the year
   the code was modified.

 * Updated to use git format-patch to construct patch email and 
   git send-email to send the patches.


This is version 3 with these changes since version 2: 

 * Changes made to .gitconfig so no internal (unreachable) systems
   are referenced.


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
 arch/x86/kernel/apic/x2apic_uv_x.c  |  817 ++-
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
 21 files changed, 4797 insertions(+), 6878 deletions(-)
 delete mode 100644 arch/x86/include/asm/uv/uv_bau.h
 delete mode 100644 arch/x86/platform/uv/tlb_uv.c

-- 
2.21.0

