Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A96F210D75
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 16:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbgGAOTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 10:19:10 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:45060 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731039AbgGAOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:18:35 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E3eMr002940;
        Wed, 1 Jul 2020 14:17:36 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 320r3bhy2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:17:35 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 0A231AF;
        Wed,  1 Jul 2020 14:17:32 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id C5C292015D826; Wed,  1 Jul 2020 09:17:31 -0500 (CDT)
Message-ID: <20200701141731.692010374@hpe.com>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 09:17:33 -0500
From:   steve.wahl@hpe.com
To:     Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mike Travis <mike.travis@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Austin Kim <austindh.kim@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     Russ Anderson <rja@hpe.com>
Subject: [patch 02/13] Remove support for UV1 platform from uv_tlb.c
References: <20200701141731.377252388@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 cotscore=-2147483648 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/platform/uv/uv_tlb.c: remove UV1 support

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/platform/uv/tlb_uv.c | 228 ++++++------------------------------------
 1 file changed, 33 insertions(+), 195 deletions(-)

diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 1fd321f37f1b..a3a51abaedc7 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -510,70 +510,6 @@ static inline void end_uvhub_quiesce(struct bau_control *hmaster)
 	atom_asr(-1, (struct atomic_short *)&hmaster->uvhub_quiesce);
 }
 
-static unsigned long uv1_read_status(unsigned long mmr_offset, int right_shift)
-{
-	unsigned long descriptor_status;
-
-	descriptor_status = uv_read_local_mmr(mmr_offset);
-	descriptor_status >>= right_shift;
-	descriptor_status &= UV_ACT_STATUS_MASK;
-	return descriptor_status;
-}
-
-/*
- * Wait for completion of a broadcast software ack message
- * return COMPLETE, RETRY(PLUGGED or TIMEOUT) or GIVEUP
- */
-static int uv1_wait_completion(struct bau_desc *bau_desc,
-				struct bau_control *bcp, long try)
-{
-	unsigned long descriptor_status;
-	cycles_t ttm;
-	u64 mmr_offset = bcp->status_mmr;
-	int right_shift = bcp->status_index;
-	struct ptc_stats *stat = bcp->statp;
-
-	descriptor_status = uv1_read_status(mmr_offset, right_shift);
-	/* spin on the status MMR, waiting for it to go idle */
-	while ((descriptor_status != DS_IDLE)) {
-		/*
-		 * Our software ack messages may be blocked because
-		 * there are no swack resources available.  As long
-		 * as none of them has timed out hardware will NACK
-		 * our message and its state will stay IDLE.
-		 */
-		if (descriptor_status == DS_SOURCE_TIMEOUT) {
-			stat->s_stimeout++;
-			return FLUSH_GIVEUP;
-		} else if (descriptor_status == DS_DESTINATION_TIMEOUT) {
-			stat->s_dtimeout++;
-			ttm = get_cycles();
-
-			/*
-			 * Our retries may be blocked by all destination
-			 * swack resources being consumed, and a timeout
-			 * pending.  In that case hardware returns the
-			 * ERROR that looks like a destination timeout.
-			 */
-			if (cycles_2_us(ttm - bcp->send_message) < timeout_us) {
-				bcp->conseccompletes = 0;
-				return FLUSH_RETRY_PLUGGED;
-			}
-
-			bcp->conseccompletes = 0;
-			return FLUSH_RETRY_TIMEOUT;
-		} else {
-			/*
-			 * descriptor_status is still BUSY
-			 */
-			cpu_relax();
-		}
-		descriptor_status = uv1_read_status(mmr_offset, right_shift);
-	}
-	bcp->conseccompletes++;
-	return FLUSH_COMPLETE;
-}
-
 /*
  * UV2 could have an extra bit of status in the ACTIVATION_STATUS_2 register.
  * But not currently used.
@@ -853,24 +789,6 @@ static void record_send_stats(cycles_t time1, cycles_t time2,
 }
 
 /*
- * Because of a uv1 hardware bug only a limited number of concurrent
- * requests can be made.
- */
-static void uv1_throttle(struct bau_control *hmaster, struct ptc_stats *stat)
-{
-	spinlock_t *lock = &hmaster->uvhub_lock;
-	atomic_t *v;
-
-	v = &hmaster->active_descriptor_count;
-	if (!atomic_inc_unless_ge(lock, v, hmaster->max_concurr)) {
-		stat->s_throttles++;
-		do {
-			cpu_relax();
-		} while (!atomic_inc_unless_ge(lock, v, hmaster->max_concurr));
-	}
-}
-
-/*
  * Handle the completion status of a message send.
  */
 static void handle_cmplt(int completion_status, struct bau_desc *bau_desc,
@@ -899,50 +817,30 @@ static int uv_flush_send_and_wait(struct cpumask *flush_mask,
 {
 	int seq_number = 0;
 	int completion_stat = 0;
-	int uv1 = 0;
 	long try = 0;
 	unsigned long index;
 	cycles_t time1;
 	cycles_t time2;
 	struct ptc_stats *stat = bcp->statp;
 	struct bau_control *hmaster = bcp->uvhub_master;
-	struct uv1_bau_msg_header *uv1_hdr = NULL;
 	struct uv2_3_bau_msg_header *uv2_3_hdr = NULL;
 
-	if (bcp->uvhub_version == UV_BAU_V1) {
-		uv1 = 1;
-		uv1_throttle(hmaster, stat);
-	}
-
 	while (hmaster->uvhub_quiesce)
 		cpu_relax();
 
 	time1 = get_cycles();
-	if (uv1)
-		uv1_hdr = &bau_desc->header.uv1_hdr;
-	else
-		/* uv2 and uv3 */
-		uv2_3_hdr = &bau_desc->header.uv2_3_hdr;
+	uv2_3_hdr = &bau_desc->header.uv2_3_hdr;
 
 	do {
 		if (try == 0) {
-			if (uv1)
-				uv1_hdr->msg_type = MSG_REGULAR;
-			else
-				uv2_3_hdr->msg_type = MSG_REGULAR;
+			uv2_3_hdr->msg_type = MSG_REGULAR;
 			seq_number = bcp->message_number++;
 		} else {
-			if (uv1)
-				uv1_hdr->msg_type = MSG_RETRY;
-			else
-				uv2_3_hdr->msg_type = MSG_RETRY;
+			uv2_3_hdr->msg_type = MSG_RETRY;
 			stat->s_retry_messages++;
 		}
 
-		if (uv1)
-			uv1_hdr->sequence = seq_number;
-		else
-			uv2_3_hdr->sequence = seq_number;
+		uv2_3_hdr->sequence = seq_number;
 		index = (1UL << AS_PUSH_SHIFT) | bcp->uvhub_cpu;
 		bcp->send_message = get_cycles();
 
@@ -1162,7 +1060,6 @@ const struct cpumask *uv_flush_tlb_others(const struct cpumask *cpumask,
 		address = TLB_FLUSH_ALL;
 
 	switch (bcp->uvhub_version) {
-	case UV_BAU_V1:
 	case UV_BAU_V2:
 	case UV_BAU_V3:
 		bau_desc->payload.uv1_2_3.address = address;
@@ -1300,7 +1197,7 @@ void uv_bau_message_interrupt(struct pt_regs *regs)
 		if (bcp->uvhub_version == UV_BAU_V2)
 			process_uv2_message(&msgdesc, bcp);
 		else
-			/* no error workaround for uv1 or uv3 */
+			/* no error workaround for uv3 */
 			bau_process_message(&msgdesc, bcp, 1);
 
 		msg++;
@@ -1350,12 +1247,7 @@ static void __init enable_timeouts(void)
 		mmr_image &= ~((unsigned long)0xf << SOFTACK_PSHIFT);
 		mmr_image |= (SOFTACK_TIMEOUT_PERIOD << SOFTACK_PSHIFT);
 		write_mmr_misc_control(pnode, mmr_image);
-		/*
-		 * UV1:
-		 * Subsequent reversals of the timebase bit (3) cause an
-		 * immediate timeout of one or all INTD resources as
-		 * indicated in bits 2:0 (7 causes all of them to timeout).
-		 */
+
 		mmr_image |= (1L << SOFTACK_MSHIFT);
 		if (is_uv2_hub()) {
 			/* do not touch the legacy mode bit */
@@ -1711,14 +1603,12 @@ static void activation_descriptor_init(int node, int pnode, int base_pnode)
 {
 	int i;
 	int cpu;
-	int uv1 = 0;
 	unsigned long gpa;
 	unsigned long m;
 	unsigned long n;
 	size_t dsize;
 	struct bau_desc *bau_desc;
 	struct bau_desc *bd2;
-	struct uv1_bau_msg_header *uv1_hdr;
 	struct uv2_3_bau_msg_header *uv2_3_hdr;
 	struct bau_control *bcp;
 
@@ -1733,8 +1623,6 @@ static void activation_descriptor_init(int node, int pnode, int base_pnode)
 	gpa = uv_gpa(bau_desc);
 	n = uv_gpa_to_gnode(gpa);
 	m = ops.bau_gpa_to_offset(gpa);
-	if (is_uv1_hub())
-		uv1 = 1;
 
 	/* the 14-bit pnode */
 	write_mmr_descriptor_base(pnode,
@@ -1746,37 +1634,15 @@ static void activation_descriptor_init(int node, int pnode, int base_pnode)
 	 */
 	for (i = 0, bd2 = bau_desc; i < (ADP_SZ * ITEMS_PER_DESC); i++, bd2++) {
 		memset(bd2, 0, sizeof(struct bau_desc));
-		if (uv1) {
-			uv1_hdr = &bd2->header.uv1_hdr;
-			uv1_hdr->swack_flag = 1;
-			/*
-			 * The base_dest_nasid set in the message header
-			 * is the nasid of the first uvhub in the partition.
-			 * The bit map will indicate destination pnode numbers
-			 * relative to that base. They may not be consecutive
-			 * if nasid striding is being used.
-			 */
-			uv1_hdr->base_dest_nasid =
-			                          UV_PNODE_TO_NASID(base_pnode);
-			uv1_hdr->dest_subnodeid  = UV_LB_SUBNODEID;
-			uv1_hdr->command         = UV_NET_ENDPOINT_INTD;
-			uv1_hdr->int_both        = 1;
-			/*
-			 * all others need to be set to zero:
-			 *   fairness chaining multilevel count replied_to
-			 */
-		} else {
-			/*
-			 * BIOS uses legacy mode, but uv2 and uv3 hardware always
-			 * uses native mode for selective broadcasts.
-			 */
-			uv2_3_hdr = &bd2->header.uv2_3_hdr;
-			uv2_3_hdr->swack_flag      = 1;
-			uv2_3_hdr->base_dest_nasid =
-			                          UV_PNODE_TO_NASID(base_pnode);
-			uv2_3_hdr->dest_subnodeid  = UV_LB_SUBNODEID;
-			uv2_3_hdr->command         = UV_NET_ENDPOINT_INTD;
-		}
+		/*
+		 * BIOS uses legacy mode, but uv2 and uv3 hardware always
+		 * uses native mode for selective broadcasts.
+		 */
+		uv2_3_hdr = &bd2->header.uv2_3_hdr;
+		uv2_3_hdr->swack_flag      = 1;
+		uv2_3_hdr->base_dest_nasid = UV_PNODE_TO_NASID(base_pnode);
+		uv2_3_hdr->dest_subnodeid  = UV_LB_SUBNODEID;
+		uv2_3_hdr->command         = UV_NET_ENDPOINT_INTD;
 	}
 	for_each_present_cpu(cpu) {
 		if (pnode != uv_blade_to_pnode(uv_cpu_to_blade_id(cpu)))
@@ -1861,7 +1728,7 @@ static void __init init_uvhub(int uvhub, int vector, int base_pnode)
 	 * The below initialization can't be in firmware because the
 	 * messaging IRQ will be determined by the OS.
 	 */
-	apicid = uvhub_to_first_apicid(uvhub) | uv_apicid_hibits;
+	apicid = uvhub_to_first_apicid(uvhub);
 	write_mmr_data_config(pnode, ((apicid << 32) | vector));
 }
 
@@ -1874,33 +1741,20 @@ static int calculate_destination_timeout(void)
 {
 	unsigned long mmr_image;
 	int mult1;
-	int mult2;
-	int index;
 	int base;
 	int ret;
-	unsigned long ts_ns;
-
-	if (is_uv1_hub()) {
-		mult1 = SOFTACK_TIMEOUT_PERIOD & BAU_MISC_CONTROL_MULT_MASK;
-		mmr_image = uv_read_local_mmr(UVH_AGING_PRESCALE_SEL);
-		index = (mmr_image >> BAU_URGENCY_7_SHIFT) & BAU_URGENCY_7_MASK;
-		mmr_image = uv_read_local_mmr(UVH_TRANSACTION_TIMEOUT);
-		mult2 = (mmr_image >> BAU_TRANS_SHIFT) & BAU_TRANS_MASK;
-		ts_ns = timeout_base_ns[index];
-		ts_ns *= (mult1 * mult2);
-		ret = ts_ns / 1000;
-	} else {
-		/* same destination timeout for uv2 and uv3 */
-		/* 4 bits  0/1 for 10/80us base, 3 bits of multiplier */
-		mmr_image = uv_read_local_mmr(UVH_LB_BAU_MISC_CONTROL);
-		mmr_image = (mmr_image & UV_SA_MASK) >> UV_SA_SHFT;
-		if (mmr_image & (1L << UV2_ACK_UNITS_SHFT))
-			base = 80;
-		else
-			base = 10;
-		mult1 = mmr_image & UV2_ACK_MASK;
-		ret = mult1 * base;
-	}
+
+	/* same destination timeout for uv2 and uv3 */
+	/* 4 bits  0/1 for 10/80us base, 3 bits of multiplier */
+	mmr_image = uv_read_local_mmr(UVH_LB_BAU_MISC_CONTROL);
+	mmr_image = (mmr_image & UV_SA_MASK) >> UV_SA_SHFT;
+	if (mmr_image & (1L << UV2_ACK_UNITS_SHFT))
+		base = 80;
+	else
+		base = 10;
+	mult1 = mmr_image & UV2_ACK_MASK;
+	ret = mult1 * base;
+
 	return ret;
 }
 
@@ -2039,9 +1893,7 @@ static int scan_sock(struct socket_desc *sdp, struct uvhub_desc *bdp,
 		bcp->cpus_in_socket = sdp->num_cpus;
 		bcp->socket_master = *smasterp;
 		bcp->uvhub = bdp->uvhub;
-		if (is_uv1_hub())
-			bcp->uvhub_version = UV_BAU_V1;
-		else if (is_uv2_hub())
+		if (is_uv2_hub())
 			bcp->uvhub_version = UV_BAU_V2;
 		else if (is_uv3_hub())
 			bcp->uvhub_version = UV_BAU_V3;
@@ -2123,7 +1975,7 @@ static int __init init_per_cpu(int nuvhubs, int base_part_pnode)
 	struct uvhub_desc *uvhub_descs;
 	unsigned char *uvhub_mask = NULL;
 
-	if (is_uv3_hub() || is_uv2_hub() || is_uv1_hub())
+	if (is_uv3_hub() || is_uv2_hub())
 		timeout_us = calculate_destination_timeout();
 
 	uvhub_descs = kcalloc(nuvhubs, sizeof(struct uvhub_desc), GFP_KERNEL);
@@ -2151,17 +2003,6 @@ static int __init init_per_cpu(int nuvhubs, int base_part_pnode)
 	return 1;
 }
 
-static const struct bau_operations uv1_bau_ops __initconst = {
-	.bau_gpa_to_offset       = uv_gpa_to_offset,
-	.read_l_sw_ack           = read_mmr_sw_ack,
-	.read_g_sw_ack           = read_gmmr_sw_ack,
-	.write_l_sw_ack          = write_mmr_sw_ack,
-	.write_g_sw_ack          = write_gmmr_sw_ack,
-	.write_payload_first     = write_mmr_payload_first,
-	.write_payload_last      = write_mmr_payload_last,
-	.wait_completion	 = uv1_wait_completion,
-};
-
 static const struct bau_operations uv2_3_bau_ops __initconst = {
 	.bau_gpa_to_offset       = uv_gpa_to_offset,
 	.read_l_sw_ack           = read_mmr_sw_ack,
@@ -2206,8 +2047,6 @@ static int __init uv_bau_init(void)
 		ops = uv2_3_bau_ops;
 	else if (is_uv2_hub())
 		ops = uv2_3_bau_ops;
-	else if (is_uv1_hub())
-		ops = uv1_bau_ops;
 
 	nuvhubs = uv_num_possible_blades();
 	if (nuvhubs < 2) {
@@ -2228,7 +2067,7 @@ static int __init uv_bau_init(void)
 	}
 
 	/* software timeouts are not supported on UV4 */
-	if (is_uv3_hub() || is_uv2_hub() || is_uv1_hub())
+	if (is_uv3_hub() || is_uv2_hub())
 		enable_timeouts();
 
 	if (init_per_cpu(nuvhubs, uv_base_pnode)) {
@@ -2251,8 +2090,7 @@ static int __init uv_bau_init(void)
 			val = 1L << 63;
 			write_gmmr_activation(pnode, val);
 			mmr = 1; /* should be 1 to broadcast to both sockets */
-			if (!is_uv1_hub())
-				write_mmr_data_broadcast(pnode, mmr);
+			write_mmr_data_broadcast(pnode, mmr);
 		}
 	}
 
-- 
2.12.3


