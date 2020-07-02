Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57DF212D6B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 21:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgGBTyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 15:54:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26190 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725915AbgGBTyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:54:35 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 062JVqHD164636;
        Thu, 2 Jul 2020 15:54:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 320s23makb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jul 2020 15:54:24 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 062JWZj5170654;
        Thu, 2 Jul 2020 15:54:23 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 320s23majt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jul 2020 15:54:23 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 062Jj8Tc016618;
        Thu, 2 Jul 2020 19:54:21 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 31wyyauugj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jul 2020 19:54:21 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 062JsIL658064976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jul 2020 19:54:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C2215204F;
        Thu,  2 Jul 2020 19:54:18 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.102.21.221])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C129952052;
        Thu,  2 Jul 2020 19:54:14 +0000 (GMT)
Subject: [PATCH v2 01/12] kexec_file: allow archs to handle special regions
 while locating memory hole
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>, Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Date:   Fri, 03 Jul 2020 01:24:13 +0530
Message-ID: <159371964681.21555.573193508667543223.stgit@hbathini.in.ibm.com>
In-Reply-To: <159371956443.21555.18251597651350106920.stgit@hbathini.in.ibm.com>
References: <159371956443.21555.18251597651350106920.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-02_09:2020-07-02,2020-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 cotscore=-2147483648 spamscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures may have special memory regions, within the given
memory range, which can't be used for the buffer in a kexec segment.
Implement weak arch_kexec_locate_mem_hole() definition which arch code
may override, to take care of special regions, while trying to locate
a memory hole.

Also, add the missing declarations for arch overridable functions and
and drop the __weak descriptors in the declarations to avoid non-weak
definitions from becoming weak.

Reported-by: kernel test robot <lkp@intel.com>
[lkp: In v1, arch_kimage_file_post_load_cleanup() declaration was missing]
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v2:
* Introduced arch_kexec_locate_mem_hole() for override and dropped
  weak arch_kexec_add_buffer().
* Dropped __weak identifier for arch overridable functions.
* Fixed the missing declaration for arch_kimage_file_post_load_cleanup()
  reported by lkp. lkp report for reference:
    - https://lore.kernel.org/patchwork/patch/1264418/


 include/linux/kexec.h |   29 ++++++++++++++++++-----------
 kernel/kexec_file.c   |   16 ++++++++++++++--
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ea67910..9e93bef 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -183,17 +183,24 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   bool get_value);
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
 
-int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
-					 unsigned long buf_len);
-void * __weak arch_kexec_kernel_image_load(struct kimage *image);
-int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
-					    Elf_Shdr *section,
-					    const Elf_Shdr *relsec,
-					    const Elf_Shdr *symtab);
-int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
-					Elf_Shdr *section,
-					const Elf_Shdr *relsec,
-					const Elf_Shdr *symtab);
+/* Architectures may override the below functions */
+int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
+				  unsigned long buf_len);
+void *arch_kexec_kernel_image_load(struct kimage *image);
+int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
+				     Elf_Shdr *section,
+				     const Elf_Shdr *relsec,
+				     const Elf_Shdr *symtab);
+int arch_kexec_apply_relocations(struct purgatory_info *pi,
+				 Elf_Shdr *section,
+				 const Elf_Shdr *relsec,
+				 const Elf_Shdr *symtab);
+int arch_kimage_file_post_load_cleanup(struct kimage *image);
+#ifdef CONFIG_KEXEC_SIG
+int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
+				 unsigned long buf_len);
+#endif
+int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 09cc78d..e89912d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -636,6 +636,19 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 
 /**
+ * arch_kexec_locate_mem_hole - Find free memory to place the segments.
+ * @kbuf:                       Parameters for the memory search.
+ *
+ * On success, kbuf->mem will have the start address of the memory region found.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
+{
+	return kexec_locate_mem_hole(kbuf);
+}
+
+/**
  * kexec_add_buffer - place a buffer in a kexec segment
  * @kbuf:	Buffer contents and memory parameters.
  *
@@ -647,7 +660,6 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
  */
 int kexec_add_buffer(struct kexec_buf *kbuf)
 {
-
 	struct kexec_segment *ksegment;
 	int ret;
 
@@ -675,7 +687,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
-	ret = kexec_locate_mem_hole(kbuf);
+	ret = arch_kexec_locate_mem_hole(kbuf);
 	if (ret)
 		return ret;
 

