Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8A01EEE5E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 01:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgFDXmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 19:42:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbgFDXmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 19:42:50 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 054NWV6p070089;
        Thu, 4 Jun 2020 19:42:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31f9dsj2b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jun 2020 19:42:03 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 054NXpeR073871;
        Thu, 4 Jun 2020 19:42:02 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31f9dsj2am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jun 2020 19:42:02 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 054NecCA015089;
        Thu, 4 Jun 2020 23:42:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 31bf482wxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jun 2020 23:42:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 054NfvwL56033430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jun 2020 23:41:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F7104C040;
        Thu,  4 Jun 2020 23:41:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC8B54C04E;
        Thu,  4 Jun 2020 23:41:51 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.71.124])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu,  4 Jun 2020 23:41:51 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Fri, 05 Jun 2020 05:11:50 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH v10 2/6] seq_buf: Export seq_buf_printf
Date:   Fri,  5 Jun 2020 05:11:32 +0530
Message-Id: <20200604234136.253703-3-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604234136.253703-1-vaibhav@linux.ibm.com>
References: <20200604234136.253703-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-04_13:2020-06-04,2020-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006040160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'seq_buf' provides a very useful abstraction for writing to a string
buffer without needing to worry about it over-flowing. However even
though the API has been stable for couple of years now its still not
exported to kernel loadable modules limiting its usage.

Hence this patch proposes update to 'seq_buf.c' to mark
seq_buf_printf() which is part of the seq_buf API to be exported to
kernel loadable GPL modules. This symbol will be used in later parts
of this patch-set to simplify content creation for a sysfs attribute.

Cc: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Borislav Petkov <bp@alien8.de>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v9..v10:
* None

Resend:
* Added ack from Steven Rostedt

v8..v9:
* None

v7..v8:
* Updated the patch title [ Christoph Hellwig ]
* Updated patch description to replace confusing term 'external kernel
  modules' to 'kernel lodable modules'.

Resend:
* Added ack from Steven Rostedt

v6..v7:
* New patch in the series
---
 lib/seq_buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 4e865d42ab03..707453f5d58e 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -91,6 +91,7 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(seq_buf_printf);
 
 #ifdef CONFIG_BINARY_PRINTF
 /**
-- 
2.26.2

