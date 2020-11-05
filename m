Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095AB2A89C6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbgKEW2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:28:23 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:53518 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgKEW2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:28:19 -0500
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MN54f005820;
        Thu, 5 Nov 2020 22:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=oZ/CyIOlwPdexHswUSKKeAXLAazDo3wI6rnyOISf/Uc=;
 b=bqt263UggAkl2QCHfXbPXj/J1N/FaHzko2+qCwJxMsrIgdeZE4FpH+bvQb8nB/T7lHO/
 FgSHqpisMgsKghcKsMC9ulFuB1YovRE4Pi5TZztYgtS3feLDAH+sleFDT+U9O3HffXj9
 gWgLmRuMafWJa2HrHgrmnqDxpupR67piBhfMDN51JR2SPC3aOc819aqaQnkPJYXf3t+W
 JUDr8v8CSc3MsTwwGkr+hru1DQf/adu04jESlUNmLg52hHUrozwgVJnL9M2MrkmHDPav
 JzKE95/sAV0QOowtbdkMQdDT9e5GoJ768mpDDOlm8fH6lgd/fWOPxHDfH65/caIeMKa9 Wg== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 34kc8dw39u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 22:27:55 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id E62B365;
        Thu,  5 Nov 2020 22:27:54 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id C4C334B;
        Thu,  5 Nov 2020 22:27:53 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] x86/platform/uv: UV5 Update Fixes
Date:   Thu,  5 Nov 2020 16:27:38 -0600
Message-Id: <20201105222741.157029-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_15:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=692
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes for UV5 updates found in testing:

* Fix missing oem_table ids.

* Fix oem/oem_table ids with trailing spaces.

* Fix H3/UV5 hubless not being recognized.


Mike Travis (3):
  x86/platform/uv: Fix missing OEM_TABLE_ID
  x86/platform/uv: Remove spaces from OEM IDs
  x86/platform/uv: Recognize UV5 hubless system identifier

 arch/x86/kernel/apic/x2apic_uv_x.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
2.21.0

