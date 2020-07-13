Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A5621E235
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 23:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGMVb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 17:31:26 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:42042 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726777AbgGMVat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:30:49 -0400
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DLECxu003502;
        Mon, 13 Jul 2020 21:30:01 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 328x6fgfn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 21:30:01 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 5967791;
        Mon, 13 Jul 2020 21:30:00 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 4C08D200BDCD5; Mon, 13 Jul 2020 16:29:55 -0500 (CDT)
Message-ID: <20200713212955.203480177@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 13 Jul 2020 16:30:00 -0500
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
Cc:     Russ Anderson <rja@hpe.com>
Subject: [patch v3 06/13] x86: Remove support for uv1 platform from uv_hub.h
References: <20200713212954.444086564@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_17:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=889 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/include/asm/uv/uv_hub.h: remove UV1 support

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/uv_hub.h |   34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

--- linux.orig/arch/x86/include/asm/uv/uv_hub.h	2020-07-07 10:49:50.229510422 -0500
+++ linux/arch/x86/include/asm/uv/uv_hub.h	2020-07-07 10:56:14.473046623 -0500
@@ -224,17 +224,11 @@ static inline struct uv_hub_info_s *uv_c
  * This is a software convention - NOT the hardware revision numbers in
  * the hub chip.
  */
-#define UV1_HUB_REVISION_BASE		1
 #define UV2_HUB_REVISION_BASE		3
 #define UV3_HUB_REVISION_BASE		5
 #define UV4_HUB_REVISION_BASE		7
 #define UV4A_HUB_REVISION_BASE		8	/* UV4 (fixed) rev 2 */
 
-static inline int is_uv1_hub(void)
-{
-	return is_uv_hubbed(uv(1));
-}
-
 static inline int is_uv2_hub(void)
 {
 	return is_uv_hubbed(uv(2));
@@ -265,7 +259,7 @@ static inline int is_uvx_hub(void)
 
 static inline int is_uv_hub(void)
 {
-	return is_uv1_hub() || is_uvx_hub();
+	return is_uvx_hub();
 }
 
 union uvh_apicid {
@@ -292,11 +286,6 @@ union uvh_apicid {
 #define UV_PNODE_TO_GNODE(p)		((p) |uv_hub_info->gnode_extra)
 #define UV_PNODE_TO_NASID(p)		(UV_PNODE_TO_GNODE(p) << 1)
 
-#define UV1_LOCAL_MMR_BASE		0xf4000000UL
-#define UV1_GLOBAL_MMR32_BASE		0xf8000000UL
-#define UV1_LOCAL_MMR_SIZE		(64UL * 1024 * 1024)
-#define UV1_GLOBAL_MMR32_SIZE		(64UL * 1024 * 1024)
-
 #define UV2_LOCAL_MMR_BASE		0xfa000000UL
 #define UV2_GLOBAL_MMR32_BASE		0xfc000000UL
 #define UV2_LOCAL_MMR_SIZE		(32UL * 1024 * 1024)
@@ -313,25 +302,21 @@ union uvh_apicid {
 #define UV4_GLOBAL_MMR32_SIZE		(16UL * 1024 * 1024)
 
 #define UV_LOCAL_MMR_BASE		(				\
-					is_uv1_hub() ? UV1_LOCAL_MMR_BASE : \
 					is_uv2_hub() ? UV2_LOCAL_MMR_BASE : \
 					is_uv3_hub() ? UV3_LOCAL_MMR_BASE : \
 					/*is_uv4_hub*/ UV4_LOCAL_MMR_BASE)
 
 #define UV_GLOBAL_MMR32_BASE		(				\
-					is_uv1_hub() ? UV1_GLOBAL_MMR32_BASE : \
 					is_uv2_hub() ? UV2_GLOBAL_MMR32_BASE : \
 					is_uv3_hub() ? UV3_GLOBAL_MMR32_BASE : \
 					/*is_uv4_hub*/ UV4_GLOBAL_MMR32_BASE)
 
 #define UV_LOCAL_MMR_SIZE		(				\
-					is_uv1_hub() ? UV1_LOCAL_MMR_SIZE : \
 					is_uv2_hub() ? UV2_LOCAL_MMR_SIZE : \
 					is_uv3_hub() ? UV3_LOCAL_MMR_SIZE : \
 					/*is_uv4_hub*/ UV4_LOCAL_MMR_SIZE)
 
 #define UV_GLOBAL_MMR32_SIZE		(				\
-					is_uv1_hub() ? UV1_GLOBAL_MMR32_SIZE : \
 					is_uv2_hub() ? UV2_GLOBAL_MMR32_SIZE : \
 					is_uv3_hub() ? UV3_GLOBAL_MMR32_SIZE : \
 					/*is_uv4_hub*/ UV4_GLOBAL_MMR32_SIZE)
@@ -352,8 +337,6 @@ union uvh_apicid {
 #define UVH_APICID		0x002D0E00L
 #define UV_APIC_PNODE_SHIFT	6
 
-#define UV_APICID_HIBIT_MASK	0xffff0000
-
 /* Local Bus from cpu's perspective */
 #define LOCAL_BUS_BASE		0x1c00000
 #define LOCAL_BUS_SIZE		(4 * 1024 * 1024)
@@ -560,15 +543,6 @@ static inline int uv_apicid_to_pnode(int
 	return s2pn ? s2pn[pnode - uv_hub_info->min_socket] : pnode;
 }
 
-/* Convert an apicid to the socket number on the blade */
-static inline int uv_apicid_to_socket(int apicid)
-{
-	if (is_uv1_hub())
-		return (apicid >> (uv_hub_info->apic_pnode_shift - 1)) & 1;
-	else
-		return 0;
-}
-
 /*
  * Access global MMRs using the low memory MMR32 space. This region supports
  * faster MMR access but not all MMRs are accessible in this space.
@@ -660,7 +634,7 @@ static inline int uv_cpu_blade_processor
 	return uv_cpu_info_per(cpu)->blade_cpu_id;
 }
 
-/* Blade number to Node number (UV1..UV4 is 1:1) */
+/* Blade number to Node number (UV2..UV4 is 1:1) */
 static inline int uv_blade_to_node(int blade)
 {
 	return blade;
@@ -674,7 +648,7 @@ static inline int uv_numa_blade_id(void)
 
 /*
  * Convert linux node number to the UV blade number.
- * .. Currently for UV1 thru UV4 the node and the blade are identical.
+ * .. Currently for UV2 thru UV4 the node and the blade are identical.
  * .. If this changes then you MUST check references to this function!
  */
 static inline int uv_node_to_blade_id(int nid)
@@ -821,8 +795,6 @@ static inline void uv_set_cpu_scir_bits(
 	}
 }
 
-extern unsigned int uv_apicid_hibits;
-
 /*
  * Get the minimum revision number of the hub chips within the partition.
  * (See UVx_HUB_REVISION_BASE above for specific values.)

