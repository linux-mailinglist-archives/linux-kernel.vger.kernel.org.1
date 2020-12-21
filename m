Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672182DFE12
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgLUQcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:32:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgLUQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:31:59 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BLG25T2178197;
        Mon, 21 Dec 2020 11:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=4jZZgxcbuSl+aYjNnN3k2Qw6lzT2zFTqDBaRKCHt0Ws=;
 b=WNYBhSnqL55dhrshZJj2MQskizcPFTuX/i0PsTYVAoHwDz01DzOufJmXyJUOlOE5TPt3
 rhVXcSySWVxYLb005W60opFUYvMIBVby9xRQLvy4yjSGqcOBr1SCafDu+bqT4gaskPRY
 LKcfeBpI+vMqydbWAtYWRNjRcJvY9xj/9NglbA3aJRtC9hFtf+brKWjm+g7DhKHWsuLc
 Y2IPApAHDTrtuqebu+ZvXULjLoXObcGHsi8vM9pzZNxWabyCvq+oKVAWBAqDii4ajTvb
 0XTx47q7E1rmKaPspUX1X+WKPdk8P6EpMPFqAIhEfLwBg+3B/0W6gW8rTlo0+BAG+8DZ yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35jxk4hfyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 11:31:02 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BLG2O67180408;
        Mon, 21 Dec 2020 11:31:02 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35jxk4hfy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 11:31:01 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BLGLZx1014051;
        Mon, 21 Dec 2020 16:31:01 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 35h9594q2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 16:31:01 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BLGUxZk17891740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Dec 2020 16:30:59 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3E0378060;
        Mon, 21 Dec 2020 16:30:59 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F16A7805E;
        Mon, 21 Dec 2020 16:30:59 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.87.162])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Dec 2020 16:30:59 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, eajames@linux.ibm.com, bjwyman@gmail.com
Subject: [PATCH 0/2] hwmon: (pmbus) Add a NO_PEC flag to probe chips with faulty CAPABILITY
Date:   Mon, 21 Dec 2020 10:30:56 -0600
Message-Id: <20201221163058.33257-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_09:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=804 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012210111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PMBus chips don't respond with valid data when reading the
CAPABILITY register. For instance the register may report that the
chip supports PEC when in reality it does not. For such chips, PEC
must not be enabled while probing the chip, so this series adds a flag
that allows device drivers to force PEC off. The second patch enables
this flag for the IBM CFFPS driver, which supports power supplies that
report invalid in the CAPABILITY register and must therefore force PEC
off.

Eddie James (2):
  hwmon: (pmbus) Add a NO_PEC flag to probe chips with faulty CAPABILITY
  hwmon: (pmbus/ibm-cffps) Set the PMBUS_NO_PEC flag

 drivers/hwmon/pmbus/ibm-cffps.c  |  2 +-
 drivers/hwmon/pmbus/pmbus_core.c |  8 +++++---
 include/linux/pmbus.h            | 10 ++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.27.0

