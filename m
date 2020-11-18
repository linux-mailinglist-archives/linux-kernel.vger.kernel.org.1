Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024452B789A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgKRI22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:28:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbgKRI21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:28:27 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AI80gOS183098;
        Wed, 18 Nov 2020 03:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WsM33R3NmfivUoHOe/IzJWetyDzxLnZBlculDwtEhsk=;
 b=dbv6FKXePsOFmIqmIjhXUAsyzxwyI481gQ22fCB3Vin/BV8PZz3UaWTBQzLoaIZo9Zcn
 fnO7vHuZAa/LJ5RW9gsCyFgmsvH+OLzi6GyP0qBk4fLS665i3MAkTnoO0HUCuJUORmye
 e5gQamy6vuLkwyEvVMOvoY30gNOaxExwt0gKK2W5iinadEQwQwgc4Ipx1X0BeKJftqJA
 mgMwI9O15yymUpsPmku7sth0L27EUDyXH6RRKu6NADVuO7aPBWmu+V/H2fxM06enp06q
 RtamQ1w7bDmM3vAGFg6NKpEspQLfCgQPTSsgklvWYWibqDQG885+HqZJ52TwEqXiCJI4 Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34vx4bkhc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 03:28:14 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AI80oxa183862;
        Wed, 18 Nov 2020 03:28:14 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34vx4bkhba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 03:28:14 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AI8MlBW032094;
        Wed, 18 Nov 2020 08:28:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 34t6v8bq56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 08:28:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AI8S9RD58392962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 08:28:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E4E14203F;
        Wed, 18 Nov 2020 08:28:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 308BC42041;
        Wed, 18 Nov 2020 08:28:07 +0000 (GMT)
Received: from bharata.ibmuc.com (unknown [9.77.201.99])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Nov 2020 08:28:07 +0000 (GMT)
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, guro@fb.com,
        vbabka@suse.cz, shakeelb@google.com, hannes@cmpxchg.org,
        aneesh.kumar@linux.ibm.com, Bharata B Rao <bharata@linux.ibm.com>
Subject: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the slub page order
Date:   Wed, 18 Nov 2020 13:57:59 +0530
Message-Id: <20201118082759.1413056-1-bharata@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_01:2020-11-17,2020-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page order of the slab that gets chosen for a given slab
cache depends on the number of objects that can be fit in the
slab while meeting other requirements. We start with a value
of minimum objects based on nr_cpu_ids that is driven by
possible number of CPUs and hence could be higher than the
actual number of CPUs present in the system. This leads to
calculate_order() chosing a page order that is on the higher
side leading to increased slab memory consumption on systems
that have bigger page sizes.

Hence rely on the number of online CPUs when determining the
mininum objects, thereby increasing the chances of chosing
a lower conservative page order for the slab.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
This is a generic change and I am unsure how it would affect
other archs, but as a start, here are some numbers from
PowerPC pseries KVM guest with and without this patch:

This table shows how this change has affected some of the slab
caches.
===================================================================
		Current				Patched
Cache	<objperslab> <pagesperslab>	<objperslab> <pagesperslab>
===================================================================
TCPv6		53    2			26    1
net_namespace	53    4			26    2
dtl		32    2			16    1
names_cache	32    2			16    1
task_struct	53    8			13    2
thread_stack	32    8			8     2
pgtable-2^11	16    8			8     4
pgtable-2^8	32    2			16    1
kmalloc-32k	16    8			8     4
kmalloc-16k	32    8			8     2
kmalloc-8k	32    4			8     1
kmalloc-4k	32    2			16    1
===================================================================

Slab memory (kB) consumption comparision
==================================================================
			Current		Patched
==================================================================
After-boot		205760		156096
During-hackbench	629145		506752 (Avg of 5 runs)
After-hackbench		474176		331840 (after drop_caches)
==================================================================

Hackbench Time (Avg of 5 runs)
(hackbench -s 1024 -l 200 -g 200 -f 25 -P)
==========================================
Current		Patched
==========================================
10.990		11.010
==========================================

Measuring the effect due to CPU hotplug
----------------------------------------
Since the patch doesn't consider all the possible CPUs for page
order calcluation, let's see how affects the case when CPUs are
hotplugged. Here I compare a system that is booted with 64CPUs
with a system that is booted with 16CPUs but hotplugged with
48CPUs after boot. These numbers are with the patch applied.

Slab memory (kB) consumption comparision
===================================================================
			64bootCPUs	16bootCPUs+48HotPluggedCPUs
===================================================================
After-boot		390272		159744
After-hotplug		-		251328
During-hackbench	1001267		941926 (Avg of 5 runs)
After-hackbench		913600		827200 (after drop_caches)
===================================================================

Hackbench Time (Avg of 5 runs)
(hackbench -s 1024 -l 200 -g 200 -f 25 -P)
===========================================
64bootCPUs	16bootCPUs+48HotPluggedCPUs
===========================================
12.554		12.589
===========================================
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 34dcc09e2ec9..8342c0a167b2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3433,7 +3433,7 @@ static inline int calculate_order(unsigned int size)
 	 */
 	min_objects = slub_min_objects;
 	if (!min_objects)
-		min_objects = 4 * (fls(nr_cpu_ids) + 1);
+		min_objects = 4 * (fls(num_online_cpus()) + 1);
 	max_objects = order_objects(slub_max_order, size);
 	min_objects = min(min_objects, max_objects);
 
-- 
2.26.2

