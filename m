Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995AF27749B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgIXO7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:59:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48090 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbgIXO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:58:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OEsmD7071825;
        Thu, 24 Sep 2020 14:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=C5MbyzBg6BPfwBGwswcqD+xcwRSEH1xE70etsgV+vlw=;
 b=W6+yNm5y2L9RtyvbgNfiJ+S/eZmgA25mpQJ9ESEB2AYRM0AcvQDEmOeOKASeEWBYWB3X
 YBTr12BzQFegWs6rUgp2mVGW/x9ODeJy8x5kdxOGPS/Z1a+M+On3Ik0L7avUoz7BGrSB
 /uCrZBGy92qEBvgSqlBhMLtoAHqFT/pnmR0XqGD6pjZSNBaADFcR8qqjx05W3vxOZOiD
 l+2wwal4sgK8umE0/2FhLIIqiKkmKcRkiG2mLkcPM5pCyADrgblYTW7WBJV3a070YXJE
 zkXWa10OktoIWFM/38p8DxpVKcXIuKFz+7do6jHcJuOqF4cefv3jccBxPzXCYIJSPko0 wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33ndnurum9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 14:58:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OEuT1G096338;
        Thu, 24 Sep 2020 14:58:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33nurw9x5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 14:58:17 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08OEwDpZ016156;
        Thu, 24 Sep 2020 14:58:14 GMT
Received: from disposition.us.oracle.com (/10.152.32.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 07:58:13 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Date:   Thu, 24 Sep 2020 10:58:35 -0400
Message-Id: <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=2
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=2 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Secure Launch (SL) stub provides the entry point for Intel TXT (and
later AMD SKINIT) to vector to during the late launch. The symbol
sl_stub_entry is that entry point and its offset into the kernel is
conveyed to the launching code using the MLE (Measured Launch
Environment) header in the structure named mle_header. The offset of the
MLE header is set in the kernel_info. The routine sl_stub contains the
very early late launch setup code responsible for setting up the basic
environment to allow the normal kernel startup_32 code to proceed. It is
also responsible for properly waking and handling the APs on Intel
platforms. The routine sl_main which runs after entering 64b mode is
responsible for measuring configuration and module information before
it is used like the boot params, the kernel command line, the TXT heap,
an external initramfs, etc.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 Documentation/x86/boot.rst             |   9 +
 arch/x86/boot/compressed/Makefile      |   1 +
 arch/x86/boot/compressed/head_64.S     |  34 ++
 arch/x86/boot/compressed/kernel_info.S |   7 +
 arch/x86/boot/compressed/sl_main.c     | 390 +++++++++++++++++++++
 arch/x86/boot/compressed/sl_stub.S     | 606 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/asm-offsets.c          |  16 +
 7 files changed, 1063 insertions(+)
 create mode 100644 arch/x86/boot/compressed/sl_main.c
 create mode 100644 arch/x86/boot/compressed/sl_stub.S

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 7fafc7a..7232801 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1026,6 +1026,15 @@ Offset/size:	0x000c/4
 
   This field contains maximal allowed type for setup_data and setup_indirect structs.
 
+============	=================
+Field name:	mle_header_offset
+Offset/size:	0x0010/4
+============	=================
+
+  This field contains the offset to the Secure Launch Measured Launch Environment
+  (MLE) header. This offset is used to locate information needed during a secure
+  late launch using Intel TXT and AMD SKINIT.
+
 
 The Image Checksum
 ==================
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 35947b9..d881ff7 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -102,6 +102,7 @@ vmlinux-objs-$(CONFIG_SECURE_LAUNCH_SHA512) += $(obj)/early_sha512.o
 vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/tpm/tpmio.o $(obj)/tpm/tpm_buff.o \
 	$(obj)/tpm/tis.o $(obj)/tpm/crb.o $(obj)/tpm/tpm1_cmds.o \
 	$(obj)/tpm/tpm2_cmds.o $(obj)/tpm/tpm2_auth.o $(obj)/tpm/tpm.o
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sl_main.o $(obj)/sl_stub.o
 
 # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
 # can place it anywhere in memory and it will still run. However, since
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 97d37f0..42043bf 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -279,6 +279,21 @@ SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
 SYM_FUNC_END(efi32_stub_entry)
 #endif
 
+#ifdef CONFIG_SECURE_LAUNCH
+SYM_FUNC_START(sl_stub_entry)
+	/*
+	 * On entry, %ebx has the entry abs offset to sl_stub_entry. To
+	 * find the beginning of where we are loaded, sub off from the
+	 * beginning.
+	 */
+	leal	(startup_32 - sl_stub_entry)(%ebx), %ebx
+
+	/* More room to work in sl_stub in the text section */
+	jmp	sl_stub
+
+SYM_FUNC_END(sl_stub_entry)
+#endif
+
 	.code64
 	.org 0x200
 SYM_CODE_START(startup_64)
@@ -537,6 +552,25 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	shrq	$3, %rcx
 	rep	stosq
 
+#ifdef CONFIG_SECURE_LAUNCH
+	/*
+	 * Have to do the final early sl stub work in 64b area.
+	 *
+	 * *********** NOTE ***********
+	 *
+	 * Several boot params get used before we get a chance to measure
+	 * them in this call. This is a known issue and we currently don't
+	 * have a solution. The scratch field doesn't matter and loadflags
+	 * have KEEP_SEGMENTS set by the stub code. There is no obvious way
+	 * to do anything about the use of kernel_alignment or init_size
+	 * though these seem low risk.
+	 */
+	pushq	%rsi
+	movq	%rsi, %rdi
+	callq	sl_main
+	popq	%rsi
+#endif
+
 /*
  * Do the extraction, and jump to the new kernel..
  */
diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
index f818ee8..192d557 100644
--- a/arch/x86/boot/compressed/kernel_info.S
+++ b/arch/x86/boot/compressed/kernel_info.S
@@ -17,6 +17,13 @@ kernel_info:
 	/* Maximal allowed type for setup_data and setup_indirect structs. */
 	.long	SETUP_TYPE_MAX
 
+	/* Offset to the MLE header structure */
+#ifdef CONFIG_SECURE_LAUNCH
+	.long	mle_header
+#else
+	.long	0
+#endif
+
 kernel_info_var_len_data:
 	/* Empty for time being... */
 kernel_info_end:
diff --git a/arch/x86/boot/compressed/sl_main.c b/arch/x86/boot/compressed/sl_main.c
new file mode 100644
index 0000000..09ec92d
--- /dev/null
+++ b/arch/x86/boot/compressed/sl_main.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Secure Launch early measurement and validation routines.
+ *
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/linkage.h>
+#include <linux/efi.h>
+#include <asm/segment.h>
+#include <asm/boot.h>
+#include <asm/msr.h>
+#include <asm/io.h>
+#include <asm/mtrr.h>
+#include <asm/processor-flags.h>
+#include <asm/asm-offsets.h>
+#include <asm/bootparam.h>
+#include <asm/efi.h>
+#include <linux/slaunch.h>
+#ifdef CONFIG_SECURE_LAUNCH_SHA256
+#include <config/crypto/sha256.h>
+#endif
+#ifdef CONFIG_SECURE_LAUNCH_SHA512
+#include <linux/sha512.h>
+#endif
+
+#include "early_sha1.h"
+#include "tpm/tpm_common.h"
+#include "tpm/tpm2_constants.h"
+#include "tpm/tpm.h"
+
+#define CAPS_VARIABLE_MTRR_COUNT_MASK	0xff
+
+#define SL_MAX_EVENT_DATA	64
+#define SL_TPM12_LOG_SIZE	(sizeof(struct tpm12_pcr_event) + \
+				SL_MAX_EVENT_DATA)
+#define SL_TPM20_LOG_SIZE	(sizeof(struct tpm20_ha) + \
+				SHA512_SIZE + \
+				sizeof(struct tpm20_digest_values) + \
+				sizeof(struct tpm20_pcr_event_head) + \
+				sizeof(struct tpm20_pcr_event_tail) + \
+				SL_MAX_EVENT_DATA)
+
+static void *evtlog_base;
+static struct txt_heap_event_log_pointer2_1_element *log20_elem;
+
+extern u32 sl_cpu_type;
+
+static u64 sl_txt_read(u32 reg)
+{
+	return readq((void *)(u64)(TXT_PRIV_CONFIG_REGS_BASE + reg));
+}
+
+static void sl_txt_write(u32 reg, u64 val)
+{
+	writeq(val, (void *)(u64)(TXT_PRIV_CONFIG_REGS_BASE + reg));
+}
+
+static void __noreturn sl_txt_reset(u64 error)
+{
+	/* Reading the E2STS register acts as a barrier for TXT registers */
+	sl_txt_write(TXT_CR_ERRORCODE, error);
+	sl_txt_read(TXT_CR_E2STS);
+	sl_txt_write(TXT_CR_CMD_UNLOCK_MEM_CONFIG, 1);
+	sl_txt_read(TXT_CR_E2STS);
+	sl_txt_write(TXT_CR_CMD_RESET, 1);
+
+	for ( ; ; )
+		asm volatile ("hlt");
+
+	unreachable();
+}
+
+static u64 sl_rdmsr(u32 reg)
+{
+	u64 lo, hi;
+
+	asm volatile ("rdmsr" : "=a" (lo), "=d" (hi) : "c" (reg));
+
+	return (hi << 32) | lo;
+}
+
+/*
+ * Some MSRs are modified by the pre-launch code including the MTRRs.
+ * The early MLE code has to restore these values. This code validates
+ * the values after they are measured.
+ */
+static void sl_txt_validate_msrs(struct txt_os_mle_data *os_mle_data)
+{
+	u64 mtrr_caps, mtrr_def_type, mtrr_var, misc_en_msr;
+	u32 vcnt, i;
+	struct txt_mtrr_state *saved_bsp_mtrrs =
+		&(os_mle_data->saved_bsp_mtrrs);
+
+	mtrr_caps = sl_rdmsr(MSR_MTRRcap);
+	vcnt = (u32)(mtrr_caps & CAPS_VARIABLE_MTRR_COUNT_MASK);
+
+	if (saved_bsp_mtrrs->mtrr_vcnt > vcnt)
+		sl_txt_reset(SL_ERROR_MTRR_INV_VCNT);
+	if (saved_bsp_mtrrs->mtrr_vcnt > TXT_OS_MLE_MAX_VARIABLE_MTRRS)
+		sl_txt_reset(SL_ERROR_MTRR_INV_VCNT);
+
+	mtrr_def_type = sl_rdmsr(MSR_MTRRdefType);
+	if (saved_bsp_mtrrs->default_mem_type != mtrr_def_type)
+		sl_txt_reset(SL_ERROR_MTRR_INV_DEF_TYPE);
+
+	for (i = 0; i < saved_bsp_mtrrs->mtrr_vcnt; i++) {
+		mtrr_var = sl_rdmsr(MTRRphysBase_MSR(i));
+		if (saved_bsp_mtrrs->mtrr_pair[i].mtrr_physbase != mtrr_var)
+			sl_txt_reset(SL_ERROR_MTRR_INV_BASE);
+		mtrr_var = sl_rdmsr(MTRRphysMask_MSR(i));
+		if (saved_bsp_mtrrs->mtrr_pair[i].mtrr_physmask != mtrr_var)
+			sl_txt_reset(SL_ERROR_MTRR_INV_MASK);
+	}
+
+	misc_en_msr = sl_rdmsr(MSR_IA32_MISC_ENABLE);
+	if (os_mle_data->saved_misc_enable_msr != misc_en_msr)
+		sl_txt_reset(SL_ERROR_MSR_INV_MISC_EN);
+}
+
+static void sl_find_event_log(struct tpm *tpm)
+{
+	struct txt_os_mle_data *os_mle_data;
+	void *os_sinit_data;
+	void *txt_heap;
+
+	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
+
+	os_mle_data = txt_os_mle_data_start(txt_heap);
+	evtlog_base = (void *)os_mle_data->evtlog_addr;
+
+	if (tpm->family != TPM20)
+		return;
+
+	/*
+	 * For TPM 2.0, the event log 2.1 extended data structure has to also
+	 * be located and fixed up.
+	 */
+	os_sinit_data = txt_os_sinit_data_start(txt_heap);
+
+	/* Find the TPM2.0 logging extended heap element */
+	log20_elem = tpm20_find_log2_1_element(os_sinit_data);
+
+	if (!log20_elem)
+		sl_txt_reset(SL_ERROR_TPM_INVALID_LOG20);
+}
+
+static void sl_tpm12_log_event(u32 pcr, u8 *digest,
+			       const u8 *event_data, u32 event_size)
+{
+	struct tpm12_pcr_event *pcr_event;
+	u32 total_size;
+	u8 log_buf[SL_TPM12_LOG_SIZE] = {0};
+
+	pcr_event = (struct tpm12_pcr_event *)log_buf;
+	pcr_event->pcr_index = pcr;
+	pcr_event->type = TXT_EVTYPE_SLAUNCH;
+	memcpy(&pcr_event->digest[0], digest, SHA1_SIZE);
+	pcr_event->size = event_size;
+	memcpy((u8 *)pcr_event + sizeof(struct tpm12_pcr_event),
+	       event_data, event_size);
+
+	total_size = sizeof(struct tpm12_pcr_event) + event_size;
+
+	if (tpm12_log_event(evtlog_base, total_size, pcr_event))
+		sl_txt_reset(SL_ERROR_TPM_LOGGING_FAILED);
+}
+
+static void sl_tpm20_log_event(u32 pcr, u8 *digest, u16 algo,
+			       const u8 *event_data, u32 event_size)
+{
+	struct tpm20_pcr_event_head *head;
+	struct tpm20_digest_values *dvs;
+	struct tpm20_ha *ha;
+	struct tpm20_pcr_event_tail *tail;
+	u8 *dptr;
+	u32 total_size;
+	u8 log_buf[SL_TPM20_LOG_SIZE] = {0};
+
+	head = (struct tpm20_pcr_event_head *)log_buf;
+	head->pcr_index = pcr;
+	head->event_type = TXT_EVTYPE_SLAUNCH;
+	dvs = (struct tpm20_digest_values *)
+		((u8 *)head + sizeof(struct tpm20_pcr_event_head));
+	dvs->count = 1;
+	ha = (struct tpm20_ha *)
+		((u8 *)dvs + sizeof(struct tpm20_digest_values));
+	ha->algorithm_id = algo;
+	dptr = (u8 *)ha + sizeof(struct tpm20_ha);
+
+	switch (algo) {
+	case TPM_ALG_SHA512:
+		memcpy(dptr, digest, SHA512_SIZE);
+		tail = (struct tpm20_pcr_event_tail *)
+			(dptr + SHA512_SIZE);
+		break;
+	case TPM_ALG_SHA256:
+		memcpy(dptr, digest, SHA256_SIZE);
+		tail = (struct tpm20_pcr_event_tail *)
+			(dptr + SHA256_SIZE);
+		break;
+	case TPM_ALG_SHA1:
+	default:
+		memcpy(dptr, digest, SHA1_SIZE);
+		tail = (struct tpm20_pcr_event_tail *)
+			(dptr + SHA1_SIZE);
+	};
+
+	tail->event_size = event_size;
+	memcpy((u8 *)tail + sizeof(struct tpm20_pcr_event_tail),
+	       event_data, event_size);
+
+	total_size = (u32)((u8 *)tail - (u8 *)head) +
+		sizeof(struct tpm20_pcr_event_tail) + event_size;
+
+	if (tpm20_log_event(log20_elem, evtlog_base, total_size, &log_buf[0]))
+		sl_txt_reset(SL_ERROR_TPM_LOGGING_FAILED);
+}
+
+void sl_tpm_extend_pcr(struct tpm *tpm, u32 pcr, const u8 *data, u32 length,
+		       const char *desc)
+{
+	struct sha1_state sctx = {0};
+	u8 sha1_hash[SHA1_SIZE] = {0};
+	int ret;
+
+	if (tpm->family == TPM20) {
+#ifdef CONFIG_SECURE_LAUNCH_SHA256
+		struct sha256_state sctx = {0};
+		u8 sha256_hash[SHA256_SIZE] = {0};
+
+		sha256_init(&sctx);
+		sha256_update(&sctx, data, length);
+		sha256_final(&sctx, &sha256_hash[0]);
+		ret = tpm_extend_pcr(tpm, pcr, TPM_ALG_SHA256, &sha256_hash[0]);
+		if (!ret) {
+			sl_tpm20_log_event(pcr, &sha256_hash[0],
+					   TPM_ALG_SHA256,
+					   (const u8 *)desc, strlen(desc));
+			return;
+		} else
+			sl_txt_reset(SL_ERROR_TPM_EXTEND);
+#endif
+#ifdef CONFIG_SECURE_LAUNCH_SHA512
+		struct sha512_state sctx = {0};
+		u8 sha512_hash[SHA512_SIZE] = {0};
+
+		sha512_init(&sctx);
+		sha512_update(&sctx, data, length);
+		sha512_final(&sctx, &sha512_hash[0]);
+		ret = tpm_extend_pcr(tpm, pcr, TPM_ALG_SHA512, &sha512_hash[0]);
+		if (!ret) {
+			sl_tpm20_log_event(pcr, &sha512_hash[0],
+					   TPM_ALG_SHA512,
+					   (const u8 *)desc, strlen(desc));
+			return;
+		} else
+			sl_txt_reset(SL_ERROR_TPM_EXTEND);
+#endif
+	}
+
+	early_sha1_init(&sctx);
+	early_sha1_update(&sctx, data, length);
+	early_sha1_final(&sctx, &sha1_hash[0]);
+	ret = tpm_extend_pcr(tpm, pcr, TPM_ALG_SHA1, &sha1_hash[0]);
+	if (ret)
+		sl_txt_reset(SL_ERROR_TPM_EXTEND);
+
+	if (tpm->family == TPM20)
+		sl_tpm20_log_event(pcr, &sha1_hash[0], TPM_ALG_SHA1,
+				   (const u8 *)desc, strlen(desc));
+	else
+		sl_tpm12_log_event(pcr, &sha1_hash[0],
+				   (const u8 *)desc, strlen(desc));
+}
+
+void sl_main(u8 *bootparams)
+{
+	struct tpm *tpm;
+	struct boot_params *bp;
+	struct setup_data *data;
+	struct txt_os_mle_data *os_mle_data;
+	struct txt_os_mle_data os_mle_tmp = {0};
+	const char *signature;
+	unsigned long mmap = 0;
+	void *txt_heap;
+	u32 data_count;
+
+	/*
+	 * Currently only Intel TXT is supported for Secure Launch. Testing
+	 * this value also indicates that the kernel was booted successfully
+	 * through the Secure Launch entry point and is in SMX mode.
+	 */
+	if (!(sl_cpu_type & SL_CPU_INTEL))
+		return;
+
+	/*
+	 * If enable_tpm fails there is no point going on. The entire secure
+	 * environment depends on this and the other TPM operations succeeding.
+	 */
+	tpm = enable_tpm();
+	if (!tpm)
+		sl_txt_reset(SL_ERROR_TPM_INIT);
+
+	/* Locate the TPM event log. */
+	sl_find_event_log(tpm);
+
+	/*
+	 * Locality 2 is being opened so that the DRTM PCRs can be updated,
+	 * specifically 17 and 18.
+	 */
+	if (tpm_request_locality(tpm, 2) == TPM_NO_LOCALITY)
+		sl_txt_reset(SL_ERROR_TPM_GET_LOC);
+
+	/* Measure the zero page/boot params */
+	sl_tpm_extend_pcr(tpm, SL_CONFIG_PCR18, bootparams, PAGE_SIZE,
+			  "Measured boot parameters into PCR18");
+
+	/* Now safe to use boot params */
+	bp = (struct boot_params *)bootparams;
+
+	/* Measure the command line */
+	sl_tpm_extend_pcr(tpm, SL_CONFIG_PCR18,
+			  (u8 *)((unsigned long)bp->hdr.cmd_line_ptr),
+			  bp->hdr.cmdline_size,
+			  "Measured Kernel command line into PCR18");
+
+	/*
+	 * Measuring the boot params measured the fixed e820 memory map.
+	 * Measure any setup_data entries including e820 extended entries.
+	 */
+	data = (struct setup_data *)(unsigned long)bp->hdr.setup_data;
+	while (data) {
+		sl_tpm_extend_pcr(tpm, SL_CONFIG_PCR18,
+				  ((u8 *)data) + sizeof(struct setup_data),
+				  data->len,
+				  "Measured Kernel setup_data into PCR18");
+
+		data = (struct setup_data *)(unsigned long)data->next;
+	}
+
+	/* If bootloader was EFI, measure the memory map passed across */
+	signature =
+		(const char *)&bp->efi_info.efi_loader_signature;
+
+	if (!strncmp(signature, EFI32_LOADER_SIGNATURE, 4))
+		mmap =  bp->efi_info.efi_memmap;
+	else if (!strncmp(signature, EFI64_LOADER_SIGNATURE, 4))
+		mmap = (bp->efi_info.efi_memmap |
+			((u64)bp->efi_info.efi_memmap_hi << 32));
+
+	if (mmap)
+		sl_tpm_extend_pcr(tpm, SL_CONFIG_PCR18, (void *)mmap,
+				  bp->efi_info.efi_memmap_size,
+				  "Measured EFI memory map into PCR18");
+
+	/* Measure any external initrd */
+	if (bp->hdr.ramdisk_image != 0 && bp->hdr.ramdisk_size != 0)
+		sl_tpm_extend_pcr(tpm, SL_IMAGE_PCR17,
+				  (u8 *)((u64)bp->hdr.ramdisk_image),
+				  bp->hdr.ramdisk_size,
+				  "Measured initramfs into PCR17");
+
+	/*
+	 * Some extra work to do on Intel, have to measure the OS-MLE
+	 * heap area.
+	 */
+	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
+	os_mle_data = txt_os_mle_data_start(txt_heap);
+
+	/* Measure only portions of OS-MLE data, not addresses/sizes etc. */
+	os_mle_tmp.version = os_mle_data->version;
+	os_mle_tmp.saved_misc_enable_msr = os_mle_data->saved_misc_enable_msr;
+	os_mle_tmp.saved_bsp_mtrrs = os_mle_data->saved_bsp_mtrrs;
+
+	sl_tpm_extend_pcr(tpm, SL_CONFIG_PCR18, (u8 *)&os_mle_tmp,
+			  sizeof(struct txt_os_mle_data),
+			  "Measured TXT OS-MLE data into PCR18");
+
+	/*
+	 * Now that the OS-MLE data is measured, ensure the MTRR and
+	 * misc enable MSRs are what we expect.
+	 */
+	sl_txt_validate_msrs(os_mle_data);
+
+	tpm_relinquish_locality(tpm);
+	free_tpm(tpm);
+}
diff --git a/arch/x86/boot/compressed/sl_stub.S b/arch/x86/boot/compressed/sl_stub.S
new file mode 100644
index 0000000..a1e7c13
--- /dev/null
+++ b/arch/x86/boot/compressed/sl_stub.S
@@ -0,0 +1,606 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Secure Launch protected mode entry point.
+ *
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+	.code32
+	.text
+#include <linux/linkage.h>
+#include <asm/segment.h>
+#include <asm/msr.h>
+#include <asm/processor-flags.h>
+#include <asm/asm-offsets.h>
+#include <asm/bootparam.h>
+#include <asm/irq_vectors.h>
+#include <linux/slaunch.h>
+
+/* Can't include apiddef.h in asm */
+#define XAPIC_ENABLE	(1 << 11)
+#define X2APIC_ENABLE	(1 << 10)
+
+/* Can't include traps.h in asm */
+#define X86_TRAP_NMI	2
+
+/* Can't include mtrr.h in asm */
+#define MTRRphysBase0	0x200
+
+#define IDT_VECTOR_LO_BITS	0
+#define IDT_VECTOR_HI_BITS	6
+
+/*
+ * The GETSEC op code is open coded because older versions of
+ * GCC do not support the getsec mnemonic.
+ */
+.macro GETSEC leaf
+	pushl	%ebx
+	xorl	%ebx, %ebx	/* Must be zero for SMCTRL */
+	movl	\leaf, %eax	/* Leaf function */
+	.byte 	0x0f, 0x37	/* GETSEC opcode */
+	popl	%ebx
+.endm
+
+.macro TXT_RESET error
+	/*
+	 * Set a sticky error value and reset. Note the movs to %eax act as
+	 * TXT register barriers.
+	 */
+	movl	\error, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_ERRORCODE)
+	movl	(TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_E2STS), %eax
+	movl	$1, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_CMD_NO_SECRETS)
+	movl	(TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_E2STS), %eax
+	movl	$1, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_CMD_UNLOCK_MEM_CONFIG)
+	movl	(TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_E2STS), %eax
+	movl	$1, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_CMD_RESET)
+1:
+	hlt
+	jmp	1b
+.endm
+
+	/*
+	 * The MLE Header per the TXT Specification, section 2.1
+	 * MLE capabilities, see table 4. Capabilities set:
+	 * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
+	 * bit 1: Support for RLP wakeup using MONITOR address
+	 * bit 5: TPM 1.2 family: Details/authorities PCR usage support
+	 * bit 9: Supported format of TPM 2.0 event log - TCG compliant
+	 */
+SYM_DATA_START(mle_header)
+	.long	0x9082ac5a    /* UUID0 */
+	.long	0x74a7476f    /* UUID1 */
+	.long	0xa2555c0f    /* UUID2 */
+	.long	0x42b651cb    /* UUID3 */
+	.long	0x00000034    /* MLE header size */
+	.long	0x00020002    /* MLE version 2.2 */
+	.long	sl_stub_entry /* Linear entry point of MLE (virt. address) */
+	.long	0x00000000    /* First valid page of MLE */
+	.long	0x00000000    /* Offset within binary of first byte of MLE */
+	.long	0x00000000    /* Offset within binary of last byte + 1 of MLE */
+	.long	0x00000223    /* Bit vector of MLE-supported capabilities */
+	.long	0x00000000    /* Starting linear address of command line (unused) */
+	.long	0x00000000    /* Ending linear address of command line (unused) */
+SYM_DATA_END(mle_header)
+
+	.code32
+SYM_FUNC_START(sl_stub)
+	/*
+	 * On entry, %ebx has the base address from head_64.S
+	 * and only %cs and %ds segments are known good.
+	 */
+	cli
+	cld
+
+	/* Load GDT, set segment regs and lret to __SL32_CS */
+	addl	%ebx, (sl_gdt_desc + 2)(%ebx)
+	lgdt	sl_gdt_desc(%ebx)
+
+	movl	$(__SL32_DS), %eax
+	movw	%ax, %ds
+	movw	%ax, %es
+	movw	%ax, %fs
+	movw	%ax, %gs
+	movw	%ax, %ss
+
+	/*
+	 * Now that %ss us known good, take the first stack for the BSP. The
+	 * AP stacks are only used on Intel.
+	 */
+	leal	sl_stacks_end(%ebx), %esp
+
+	leal	.Lsl_cs(%ebx), %eax
+	pushl	$(__SL32_CS)
+	pushl	%eax
+	lret
+
+.Lsl_cs:
+	/* Save our base pointer reg */
+	pushl	%ebx
+
+	/* Now see if it is GenuineIntel. CPUID 0 returns the manufacturer */
+	xorl	%eax, %eax
+	cpuid
+	cmpl	$(INTEL_CPUID_MFGID_EBX), %ebx
+	jnz	.Ldo_unknown_cpu
+	cmpl	$(INTEL_CPUID_MFGID_EDX), %edx
+	jnz	.Ldo_unknown_cpu
+	cmpl	$(INTEL_CPUID_MFGID_ECX), %ecx
+	jnz	.Ldo_unknown_cpu
+
+	popl	%ebx
+
+	/* Know it is Intel */
+	movl	$(SL_CPU_INTEL), sl_cpu_type(%ebx)
+
+	/* Increment CPU count for BSP */
+	incl	sl_txt_cpu_count(%ebx)
+
+	/* Enable SMI with GETSEC[SMCTRL] */
+	GETSEC	$(SMX_X86_GETSEC_SMCTRL)
+
+	/* IRET-to-self can be used to enable NMIs which SENTER disabled */
+	leal	.Lnmi_enabled(%ebx), %eax
+	pushfl
+	pushl	$(__SL32_CS)
+	pushl	%eax
+	iret
+
+.Lnmi_enabled:
+	/* Clear the TXT error registers for a clean start of day */
+	movl	$0, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_ERRORCODE)
+	movl	$0xffffffff, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_ESTS)
+
+	/* On Intel, the zero page address is passed in the TXT heap */
+	/* Read physical base of heap into EAX */
+	movl	(TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_HEAP_BASE), %eax
+	/* Read the size of the BIOS data into ECX (first 8 bytes) */
+	movl	(%eax), %ecx
+	/* Skip over BIOS data and size of OS to MLE data section */
+	leal	8(%eax, %ecx), %eax
+
+	/* Check that the AP wake block is big enough */
+	cmpl	$(sl_txt_ap_wake_end - sl_txt_ap_wake_begin), \
+		SL_ap_wake_block_size(%eax)
+	jae	.Lwake_block_ok
+	TXT_RESET $(SL_ERROR_WAKE_BLOCK_TOO_SMALL)
+
+.Lwake_block_ok:
+	/*
+	 * Get the boot params address from the heap. Note %esi and %ebx MUST
+	 * be preserved across calls and operations.
+	 */
+	movl	SL_boot_params_addr(%eax), %esi
+
+	/* Save %ebx so the APs can find their way home */
+	movl	%ebx, (SL_mle_scratch + SL_SCRATCH_AP_EBX)(%eax)
+
+	/* Fetch the AP wake code block address from the heap */
+	movl	SL_ap_wake_block(%eax), %edi
+	movl	%edi, sl_txt_ap_wake_block(%ebx)
+
+	/* Store the offset in the AP wake block to the jmp address */
+	movl	$(sl_ap_jmp_offset - sl_txt_ap_wake_begin), \
+		(SL_mle_scratch + SL_SCRATCH_AP_JMP_OFFSET)(%eax)
+
+	/* %eax still is the base of the OS-MLE block, save it */
+	pushl	%eax
+
+	/* Relocate the AP wake code to the safe block */
+	call	sl_txt_reloc_ap_wake
+
+	/*
+	 * Wake up all APs that are blocked in the ACM and wait for them to
+	 * halt. This should be done before restoring the MTRRs so the ACM is
+	 * still properly in WB memory.
+	 */
+	call	sl_txt_wake_aps
+
+	/*
+	 * Pop OS-MLE base address (was in %eax above) for call to load
+	 * MTRRs/MISC MSR
+	 */
+	popl	%edi
+	call	sl_txt_load_regs
+
+	jmp	.Lcpu_setup_done
+
+.Ldo_unknown_cpu:
+	/* Non-Intel CPUs are not yet supported */
+	ud2
+
+.Lcpu_setup_done:
+	/*
+	 * Don't enable MCE at this point. The kernel will enable
+	 * it on the BSP later when it is ready.
+	 */
+
+	/* Keep SL segments for the early portion of the kernel boot */
+	orb	$(KEEP_SEGMENTS), BP_loadflags(%esi)
+
+	/* Done, jump to normal 32b pm entry */
+	jmp	startup_32
+SYM_FUNC_END(sl_stub)
+
+SYM_FUNC_START(sl_txt_ap_entry)
+	cli
+	cld
+	/*
+	 * The %cs and %ds segments are known good after waking the AP.
+	 * First order of business is to find where we are and
+	 * save it in %ebx.
+	 */
+
+	/* Read physical base of heap into EAX */
+	movl	(TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_HEAP_BASE), %eax
+	/* Read the size of the BIOS data into ECX (first 8 bytes) */
+	movl	(%eax), %ecx
+	/* Skip over BIOS data and size of OS to MLE data section */
+	leal	8(%eax, %ecx), %eax
+
+	/* Saved %ebx from the BSP and stash OS-MLE pointer */
+	movl	(SL_mle_scratch + SL_SCRATCH_AP_EBX)(%eax), %ebx
+	/* Save OS-MLE base in %edi for call to sl_txt_load_regs */
+	movl	%eax, %edi
+
+	/* Lock and get our stack index */
+	movl	$1, %ecx
+.Lspin:
+	xorl	%eax, %eax
+	lock cmpxchgl	%ecx, sl_txt_spin_lock(%ebx)
+	pause
+	jnz	.Lspin
+
+	/* Increment the stack index and use the next value inside lock */
+	incl	sl_txt_stack_index(%ebx)
+	movl	sl_txt_stack_index(%ebx), %eax
+
+	/* Unlock */
+	movl	$0, sl_txt_spin_lock(%ebx)
+
+	/* Location of the relocated AP wake block */
+	movl	sl_txt_ap_wake_block(%ebx), %ecx
+
+	/* Load reloc GDT, set segment regs and lret to __SL32_CS */
+	lgdt	(sl_ap_gdt_desc - sl_txt_ap_wake_begin)(%ecx)
+
+	movl	$(__SL32_DS), %edx
+	movw	%dx, %ds
+	movw	%dx, %es
+	movw	%dx, %fs
+	movw	%dx, %gs
+	movw	%dx, %ss
+
+	/* Load our reloc AP stack */
+	movl	$(TXT_BOOT_STACK_SIZE), %edx
+	mull	%edx
+	leal	(sl_stacks_end - sl_txt_ap_wake_begin)(%ecx), %esp
+	subl	%eax, %esp
+
+	/* Switch to AP code segment */
+	leal	.Lsl_ap_cs(%ebx), %eax
+	pushl	$(__SL32_CS)
+	pushl	%eax
+	lret
+
+.Lsl_ap_cs:
+	/* Load the relocated AP IDT */
+	lidt	(sl_ap_idt_desc - sl_txt_ap_wake_begin)(%ecx)
+
+	/* Fixup MTRRs and misc enable MSR on APs too */
+	call	sl_txt_load_regs
+
+	/* Enable SMI with GETSEC[SMCTRL] */
+	GETSEC $(SMX_X86_GETSEC_SMCTRL)
+
+	/* IRET-to-self can be used to enable NMIs which SENTER disabled */
+	leal	.Lnmi_enabled_ap(%ebx), %eax
+	pushfl
+	pushl	$(__SL32_CS)
+	pushl	%eax
+	iret
+
+.Lnmi_enabled_ap:
+	/* Put APs in X2APIC mode like the BSP */
+	movl	$(MSR_IA32_APICBASE), %ecx
+	rdmsr
+	orl	$(XAPIC_ENABLE | X2APIC_ENABLE), %eax
+	wrmsr
+
+	/*
+	 * Basically done, increment the CPU count and jump off to the AP
+	 * wake block to wait.
+	 */
+	lock incl	sl_txt_cpu_count(%ebx)
+
+	movl	sl_txt_ap_wake_block(%ebx), %eax
+	jmp	*%eax
+SYM_FUNC_END(sl_txt_ap_entry)
+
+SYM_FUNC_START(sl_txt_reloc_ap_wake)
+	/* Save boot params register */
+	pushl	%esi
+
+	movl	sl_txt_ap_wake_block(%ebx), %edi
+
+	/* Fixup AP IDT and GDT descriptor before relocating */
+	addl	%edi, (sl_ap_idt_desc + 2)(%ebx)
+	addl	%edi, (sl_ap_gdt_desc + 2)(%ebx)
+
+	/*
+	 * Copy the AP wake code and AP GDT/IDT to the protected wake block
+	 * provided by the loader. Destination already in %edi.
+	 */
+	movl	$(sl_txt_ap_wake_end - sl_txt_ap_wake_begin), %ecx
+	leal	sl_txt_ap_wake_begin(%ebx), %esi
+	rep movsb
+
+	/* Setup the IDT for the APs to use in the relocation block */
+	movl	sl_txt_ap_wake_block(%ebx), %ecx
+	addl	$(sl_ap_idt - sl_txt_ap_wake_begin), %ecx
+	xorl	%edx, %edx
+
+	/* Form the default reset vector relocation address */
+	movl	sl_txt_ap_wake_block(%ebx), %esi
+	addl	$(sl_txt_int_reset - sl_txt_ap_wake_begin), %esi
+
+1:
+	cmpw	$(NR_VECTORS), %dx
+	jz	.Lap_idt_done
+
+	cmpw	$(X86_TRAP_NMI), %dx
+	jz	2f
+
+	/* Load all other fixed vectors with reset handler */
+	movl	%esi, %eax
+	movw	%ax, (IDT_VECTOR_LO_BITS)(%ecx)
+	shrl	$16, %eax
+	movw	%ax, (IDT_VECTOR_HI_BITS)(%ecx)
+	jmp	3f
+
+2:
+	/* Load single wake NMI IPI vector at the relocation address */
+	movl	sl_txt_ap_wake_block(%ebx), %eax
+	addl	$(sl_txt_int_ipi_wake - sl_txt_ap_wake_begin), %eax
+	movw	%ax, (IDT_VECTOR_LO_BITS)(%ecx)
+	shrl	$16, %eax
+	movw	%ax, (IDT_VECTOR_HI_BITS)(%ecx)
+
+3:
+	incw	%dx
+	addl	$8, %ecx
+	jmp	1b
+
+.Lap_idt_done:
+	popl	%esi
+	ret
+SYM_FUNC_END(sl_txt_reloc_ap_wake)
+
+SYM_FUNC_START(sl_txt_load_regs)
+	/* Save base pointer register */
+	pushl	%ebx
+
+	/*
+	 * On Intel, the original variable MTRRs and Misc Enable MSR are
+	 * restored on the BSP at early boot. Each AP will also restore
+	 * its MTRRs and Misc Enable MSR.
+	 */
+	pushl	%edi
+	addl	$(SL_saved_bsp_mtrrs), %edi
+	movl	(%edi), %ebx
+	pushl	%ebx /* default_mem_type lo */
+	addl	$4, %edi
+	movl	(%edi), %ebx
+	pushl	%ebx /* default_mem_type hi */
+	addl	$4, %edi
+	movl	(%edi), %ebx /* mtrr_vcnt lo, don't care about hi part */
+	addl	$8, %edi /* now at MTRR pair array */
+	/* Write the variable MTRRs */
+	movl	$(MTRRphysBase0), %ecx
+1:
+	cmpl	$0, %ebx
+	jz	2f
+
+	movl	(%edi), %eax /* MTRRphysBaseX lo */
+	addl	$4, %edi
+	movl	(%edi), %edx /* MTRRphysBaseX hi */
+	wrmsr
+	addl	$4, %edi
+	incl	%ecx
+	movl	(%edi), %eax /* MTRRphysMaskX lo */
+	addl	$4, %edi
+	movl	(%edi), %edx /* MTRRphysMaskX hi */
+	wrmsr
+	addl	$4, %edi
+	incl	%ecx
+
+	decl	%ebx
+	jmp	1b
+2:
+	/* Write the default MTRR register */
+	popl	%edx
+	popl	%eax
+	movl	$(MSR_MTRRdefType), %ecx
+	wrmsr
+
+	/* Return to beginning and write the misc enable msr */
+	popl	%edi
+	addl	$(SL_saved_misc_enable_msr), %edi
+	movl	(%edi), %eax /* saved_misc_enable_msr lo */
+	addl	$4, %edi
+	movl	(%edi), %edx /* saved_misc_enable_msr hi */
+	movl	$(MSR_IA32_MISC_ENABLE), %ecx
+	wrmsr
+
+	popl	%ebx
+	ret
+SYM_FUNC_END(sl_txt_load_regs)
+
+SYM_FUNC_START(sl_txt_wake_aps)
+	/* Save boot params register */
+	pushl	%esi
+
+	/* First setup the MLE join structure and load it into TXT reg */
+	leal	sl_gdt(%ebx), %eax
+	leal	sl_txt_ap_entry(%ebx), %ecx
+	leal	sl_smx_rlp_mle_join(%ebx), %edx
+	movl	%eax, SL_rlp_gdt_base(%edx)
+	movl	%ecx, SL_rlp_entry_point(%edx)
+	movl	%edx, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_MLE_JOIN)
+
+	/* Another TXT heap walk to find various values needed to wake APs */
+	movl	(TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_HEAP_BASE), %eax
+	/* At BIOS data size, find the number of logical processors */
+	movl	(SL_num_logical_procs + 8)(%eax), %edx
+	/* Skip over BIOS data */
+	movl	(%eax), %ecx
+	addl	%ecx, %eax
+	/* Skip over OS to MLE */
+	movl	(%eax), %ecx
+	addl	%ecx, %eax
+	/* At OS-SNIT size, get capabilities to know how to wake up the APs */
+	movl	(SL_capabilities + 8)(%eax), %esi
+	/* Skip over OS to SNIT */
+	movl	(%eax), %ecx
+	addl	%ecx, %eax
+	/* At SINIT-MLE size, get the AP wake MONITOR address */
+	movl	(SL_rlp_wakeup_addr + 8)(%eax), %edi
+
+	/* Determine how to wake up the APs */
+	testl	$(1 << TXT_SINIT_MLE_CAP_WAKE_MONITOR), %esi
+	jz	.Lwake_getsec
+
+	/* Wake using MWAIT MONITOR */
+	movl	$1, (%edi)
+	jmp	.Laps_awake
+
+.Lwake_getsec:
+	/* Wake using GETSEC(WAKEUP) */
+	GETSEC	$(SMX_X86_GETSEC_WAKEUP)
+
+.Laps_awake:
+	/*
+	 * All of the APs are woken up and rendesvous in the relocated wake
+	 * block starting at sl_txt_ap_wake_begin. Wait for all of them to
+	 * halt.
+	 */
+	pause
+	cmpl	sl_txt_cpu_count(%ebx), %edx
+	jne	.Laps_awake
+
+	popl	%esi
+	ret
+SYM_FUNC_END(sl_txt_wake_aps)
+
+/* This is the beginning of the relocated AP wake code block */
+	.global sl_txt_ap_wake_begin
+sl_txt_ap_wake_begin:
+
+	/*
+	 * Wait for NMI IPI in the relocated AP wake block which was provided
+	 * and protected in the memory map by the prelaunch code. Leave all
+	 * other interrupts masked since we do not expect anything but an NMI.
+	 */
+	xorl	%edx, %edx
+
+1:
+	hlt
+	testl	%edx, %edx
+	jz	1b
+
+	/*
+	 * This is the long absolute jump to the 32b Secure Launch protected
+	 * mode stub code in the rmpiggy. The jump address will be fixed in
+	 * the SMP boot code when the first AP is brought up. This whole area
+	 * is provided and protected in the memory map by the prelaunch code.
+	 */
+	.byte	0xea
+sl_ap_jmp_offset:
+	.long	0x00000000
+	.word	__SL32_CS
+
+SYM_FUNC_START(sl_txt_int_ipi_wake)
+	movl	$1, %edx
+
+	/* NMI context, just IRET */
+	iret
+SYM_FUNC_END(sl_txt_int_ipi_wake)
+
+SYM_FUNC_START(sl_txt_int_reset)
+	TXT_RESET $(SL_ERROR_INV_AP_INTERRUPT)
+SYM_FUNC_END(sl_txt_int_reset)
+
+	.balign 16
+sl_ap_idt_desc:
+	.word	sl_ap_idt_end - sl_ap_idt - 1		/* Limit */
+	.long	sl_ap_idt - sl_txt_ap_wake_begin	/* Base */
+sl_ap_idt_desc_end:
+
+	.balign 16
+sl_ap_idt:
+	.rept	NR_VECTORS
+	.word	0x0000		/* Offset 15 to 0 */
+	.word	__SL32_CS	/* Segment selector */
+	.word	0x8e00		/* Present, DPL=0, 32b Vector, Interrupt */
+	.word	0x0000		/* Offset 31 to 16 */
+	.endr
+sl_ap_idt_end:
+
+	.balign 16
+sl_ap_gdt_desc:
+	.word	sl_ap_gdt_end - sl_ap_gdt - 1
+	.long	sl_ap_gdt - sl_txt_ap_wake_begin
+sl_ap_gdt_desc_end:
+
+	.balign	16
+sl_ap_gdt:
+	.quad	0x0000000000000000	/* NULL */
+	.quad	0x00cf9a000000ffff	/* __SL32_CS */
+	.quad	0x00cf92000000ffff	/* __SL32_DS */
+sl_ap_gdt_end:
+
+	/* Small stacks for BSP and APs to work with */
+	.balign 4
+sl_stacks:
+	.fill (TXT_MAX_CPUS * TXT_BOOT_STACK_SIZE), 1, 0
+sl_stacks_end:
+
+/* This is the end of the relocated AP wake code block */
+	.global sl_txt_ap_wake_end
+sl_txt_ap_wake_end:
+
+	.data
+	.balign 16
+sl_gdt_desc:
+	.word	sl_gdt_end - sl_gdt - 1
+	.long	sl_gdt
+sl_gdt_desc_end:
+
+	.balign	16
+sl_gdt:
+	.quad	0x0000000000000000	/* NULL */
+	.quad	0x00cf9a000000ffff	/* __SL32_CS */
+	.quad	0x00cf92000000ffff	/* __SL32_DS */
+sl_gdt_end:
+
+	.balign 16
+sl_smx_rlp_mle_join:
+	.long	sl_gdt_end - sl_gdt - 1	/* GDT limit */
+	.long	0x00000000		/* GDT base */
+	.long	__SL32_CS	/* Seg Sel - CS (DS, ES, SS = seg_sel+8) */
+	.long	0x00000000	/* Entry point physical address */
+
+SYM_DATA_START(sl_cpu_type)
+	.long	0x00000000
+SYM_DATA_END(sl_cpu_type)
+
+sl_txt_spin_lock:
+	.long	0x00000000
+
+sl_txt_stack_index:
+	.long	0x00000000
+
+sl_txt_cpu_count:
+	.long	0x00000000
+
+sl_txt_ap_wake_block:
+	.long	0x00000000
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 3ca07ad..c7e5ed1 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -12,6 +12,7 @@
 #include <linux/hardirq.h>
 #include <linux/suspend.h>
 #include <linux/kbuild.h>
+#include <linux/slaunch.h>
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 #include <asm/sigframe.h>
@@ -104,4 +105,19 @@ static void __used common(void)
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
+
+#ifdef CONFIG_SECURE_LAUNCH
+	BLANK();
+	OFFSET(SL_boot_params_addr, txt_os_mle_data, boot_params_addr);
+	OFFSET(SL_saved_misc_enable_msr, txt_os_mle_data, saved_misc_enable_msr);
+	OFFSET(SL_saved_bsp_mtrrs, txt_os_mle_data, saved_bsp_mtrrs);
+	OFFSET(SL_ap_wake_block, txt_os_mle_data, ap_wake_block);
+	OFFSET(SL_ap_wake_block_size, txt_os_mle_data, ap_wake_block_size);
+	OFFSET(SL_mle_scratch, txt_os_mle_data, mle_scratch);
+	OFFSET(SL_num_logical_procs, txt_bios_data, num_logical_procs);
+	OFFSET(SL_capabilities, txt_os_sinit_data, capabilities);
+	OFFSET(SL_rlp_wakeup_addr, txt_sinit_mle_data, rlp_wakeup_addr);
+	OFFSET(SL_rlp_gdt_base, smx_rlp_mle_join, rlp_gdt_base);
+	OFFSET(SL_rlp_entry_point, smx_rlp_mle_join, rlp_entry_point);
+#endif
 }
-- 
1.8.3.1

