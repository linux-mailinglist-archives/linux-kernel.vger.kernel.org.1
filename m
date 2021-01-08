Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F562EF4F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbhAHPhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:37:04 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:61598 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbhAHPhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:37:03 -0500
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108FRfxD003851;
        Fri, 8 Jan 2021 15:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=KeswbfIT/kAyOIzhlAD1GOt95NV7ccflCkWsbyfIScM=;
 b=JnleBx1wCICjK+8tDZNqsM1v7RXFsqCoMJsKaFhPM3vT1olIVwwtztx7EI5Taqxxo9Q7
 L/2LDo6xVGhP3otWkKWNWQjiBCmG7OPs8AIQ/zUJrCd4xomSxkateIbvDP0x+hAugGGH
 UdB8uiNN+GxRE372RTOHLtRNJhY90dfE8owVvqP8vIIuMvZrp7Py1yByoym2BlqvFSbL
 HMlw7r+PVELAw4TMB8qYyVgfcGANRU+WgrsQWw3/OMW7peC6FHXII5j11nqTJjdA9aab
 ey6z3DdKTVePnDvO8VDYCrw/q6kCWxYIxewvhVTSUAF9zv0HjO5Ie+eVt01RyKaxKycg Rw== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com with ESMTP id 35xmtyt80s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 15:35:55 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 04CDA63;
        Fri,  8 Jan 2021 15:35:51 +0000 (UTC)
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 43D7D37;
        Fri,  8 Jan 2021 15:35:50 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id BDBC964B800; Fri,  8 Jan 2021 09:35:49 -0600 (CST)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>, rja_direct@groups.int.hpe.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc:     "Liang, Kan" <kan.liang@intel.com>
Subject: [PATCH 0/2] perf/x86/intel/uncore: Derive die id from NUMA info with more than 8 nodes
Date:   Fri,  8 Jan 2021 09:35:47 -0600
Message-Id: <20210108153549.108989-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_07:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 mlxlogscore=703
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Intel uncore, the registers being used to identify the die don't
contain enough bits to uniquely identify more than 8 dies.  On
systems with more than 8 dies, this results in error messages of the
form "skx_uncore: probe of XXXX:XX:XX.X failed with error -22", and
some perf counters showing up as "<not supported>".

On such systems, use NUMA information to determine die id.

Continue to use the register information with 8 or fewer numa nodes to
cover cases like NUMA not being enabled.

The first patch moves translation from physical to logical die id
earlier in the code, and stores only the logical id.  The logical id
is the only one that is really used.  Without this change the second
patch would have to store both physical and logical id, which was much
more complicated.

The second patch adds the alternative of deriving the logical die id
from the NUMA information when there are more than 8 nodes.

Steve Wahl (2):
  perf/x86/intel/uncore: Store the logical die id instead of the
    physical die id.
  perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA
    info

 arch/x86/events/intel/uncore.c       |  58 +++++---------
 arch/x86/events/intel/uncore.h       |   5 +-
 arch/x86/events/intel/uncore_snb.c   |   2 +-
 arch/x86/events/intel/uncore_snbep.c | 114 ++++++++++++++++++---------
 4 files changed, 99 insertions(+), 80 deletions(-)

-- 
2.26.2

