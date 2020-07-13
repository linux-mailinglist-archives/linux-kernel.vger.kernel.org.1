Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B1021E224
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 23:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGMVbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 17:31:02 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:41900 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726823AbgGMVay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:30:54 -0400
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DLEJRH003677;
        Mon, 13 Jul 2020 21:29:58 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 328x6fgfmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 21:29:58 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 73AD684;
        Mon, 13 Jul 2020 21:29:56 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id CC537200953D7; Mon, 13 Jul 2020 16:29:54 -0500 (CDT)
Message-ID: <20200713212954.728022415@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 13 Jul 2020 16:29:56 -0500
From:   steve.wahl@hpe.com
To:     Steve Wahl <steve.wahl@hpe.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Cc:     Russ Anderson <rja@hpe.com>, kernel test robot <lkp@intel.com>
Subject: [patch v3 02/13] x86: Remove support for UV1 platform from uv_tlb.c
References: <20200713212954.444086564@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_17:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/platform/uv/uv_tlb.c: remove UV1 support
Include removing unused timeout_base_ns as reported by lkp@intel.com.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/x86/platform/uv/tlb_uv.c |  237 +++++-------------------------------------
 1 file changed, 31 insertions(+), 206 deletions(-)

--- linux.orig/arch/x86/platform/uv/tlb_uv.c	2020-07-07 10:49:50.481510115 -0500
+++ linux/arch/x86/platform/uv/tlb_uv.c	2020-07-07 10:56:13.665047592 -0500
@@ -23,18 +23,6 @@
 
 static struct bau_operations ops __ro_after_init;
 
-/* timeouts in nanoseconds (indexed by UVH_AGING_PRESCALE_SEL urgency7 30:28) */
-static const int timeout_base_ns[] = {
-		20,
-		160,
-		1280,
-		10240,
-		81920,
-		655360,
-		5242880,
-		167772160
-};
-
 static int timeout_us;
 static bool nobau = true;
 static int nobau_perm;
@@ -510,70 +498,6 @@ static inline void end_uvhub_quiesce(str
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
@@ -853,24 +777,6 @@ static void record_send_stats(cycles_t t
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
@@ -899,50 +805,30 @@ static int uv_flush_send_and_wait(struct
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
 
@@ -1162,7 +1048,6 @@ const struct cpumask *uv_flush_tlb_other
 		address = TLB_FLUSH_ALL;
 
 	switch (bcp->uvhub_version) {
-	case UV_BAU_V1:
 	case UV_BAU_V2:
 	case UV_BAU_V3:
 		bau_desc->payload.uv1_2_3.address = address;
@@ -1300,7 +1185,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_uv_bau_mes
 		if (bcp->uvhub_version == UV_BAU_V2)
 			process_uv2_message(&msgdesc, bcp);
 		else
-			/* no error workaround for uv1 or uv3 */
+			/* no error workaround for uv3 */
 			bau_process_message(&msgdesc, bcp, 1);
 
 		msg++;
@@ -1350,12 +1235,7 @@ static void __init enable_timeouts(void)
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
@@ -1711,14 +1591,12 @@ static void activation_descriptor_init(i
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
 
@@ -1733,8 +1611,6 @@ static void activation_descriptor_init(i
 	gpa = uv_gpa(bau_desc);
 	n = uv_gpa_to_gnode(gpa);
 	m = ops.bau_gpa_to_offset(gpa);
-	if (is_uv1_hub())
-		uv1 = 1;
 
 	/* the 14-bit pnode */
 	write_mmr_descriptor_base(pnode,
@@ -1746,37 +1622,15 @@ static void activation_descriptor_init(i
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
@@ -1861,7 +1715,7 @@ static void __init init_uvhub(int uvhub,
 	 * The below initialization can't be in firmware because the
 	 * messaging IRQ will be determined by the OS.
 	 */
-	apicid = uvhub_to_first_apicid(uvhub) | uv_apicid_hibits;
+	apicid = uvhub_to_first_apicid(uvhub);
 	write_mmr_data_config(pnode, ((apicid << 32) | vector));
 }
 
@@ -1874,33 +1728,20 @@ static int calculate_destination_timeout
 {
 	unsigned long mmr_image;
 	int mult1;
-	int mult2;
-	int index;
 	int base;
 	int ret;
-	unsigned long ts_ns;
 
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
 
@@ -2039,9 +1880,7 @@ static int scan_sock(struct socket_desc
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
@@ -2123,7 +1962,7 @@ static int __init init_per_cpu(int nuvhu
 	struct uvhub_desc *uvhub_descs;
 	unsigned char *uvhub_mask = NULL;
 
-	if (is_uv3_hub() || is_uv2_hub() || is_uv1_hub())
+	if (is_uv3_hub() || is_uv2_hub())
 		timeout_us = calculate_destination_timeout();
 
 	uvhub_descs = kcalloc(nuvhubs, sizeof(struct uvhub_desc), GFP_KERNEL);
@@ -2151,17 +1990,6 @@ fail:
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
@@ -2206,8 +2034,6 @@ static int __init uv_bau_init(void)
 		ops = uv2_3_bau_ops;
 	else if (is_uv2_hub())
 		ops = uv2_3_bau_ops;
-	else if (is_uv1_hub())
-		ops = uv1_bau_ops;
 
 	nuvhubs = uv_num_possible_blades();
 	if (nuvhubs < 2) {
@@ -2228,7 +2054,7 @@ static int __init uv_bau_init(void)
 	}
 
 	/* software timeouts are not supported on UV4 */
-	if (is_uv3_hub() || is_uv2_hub() || is_uv1_hub())
+	if (is_uv3_hub() || is_uv2_hub())
 		enable_timeouts();
 
 	if (init_per_cpu(nuvhubs, uv_base_pnode)) {
@@ -2251,8 +2077,7 @@ static int __init uv_bau_init(void)
 			val = 1L << 63;
 			write_gmmr_activation(pnode, val);
 			mmr = 1; /* should be 1 to broadcast to both sockets */
-			if (!is_uv1_hub())
-				write_mmr_data_broadcast(pnode, mmr);
+			write_mmr_data_broadcast(pnode, mmr);
 		}
 	}
 

