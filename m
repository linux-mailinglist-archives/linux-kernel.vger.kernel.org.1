Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0194277036
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgIXLqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:46:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726406AbgIXLqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:46:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OBgKL0028663;
        Thu, 24 Sep 2020 07:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=cy9i3HKP06eSsk3EkUuP4ft7WU/EvISxSMpaosLKxSg=;
 b=QwUZCb8Q0xh6cMlgBmGwtgF3hQsUGhD7AXJADvr5CuXwTXIMMi0salXUAhjaigoNBBiL
 Eo55mdZAt70TgDWb321Xo4D43PxFy3uediLOMJLO4ek6gfk5hdHtVnqKiqLLC9gt7Q1f
 5+9qszMsHrpHqcn7krv2m69rmZ6bZ2McBr4dxt0FHFe5grWo/E850dEf4rqy0ayVlt41
 WEwLEONXo6oYldYs/0gRcqpyERKQtFkPJ6VDpEUjXs5Lh/VrNJDiPhWDKt6Y7WOqER1s
 VbEbZATbHEeLEIeVvkdXYgfE/5o/Uzae7dZI6EJSjQiBJ6I4IP3xkPWMSimZ5GxF2CZZ Mw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33rttgr2u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 07:46:09 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08OBhfn3009184;
        Thu, 24 Sep 2020 11:46:07 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 33n9m7tpfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 11:46:07 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08OBk5BB30802264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 11:46:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F81F52051;
        Thu, 24 Sep 2020 11:46:05 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.85.113.96])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 9954A5204F;
        Thu, 24 Sep 2020 11:46:01 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 24 Sep 2020 17:16:00 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Wang Wensheng <wangwensheng4@huawei.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        aneesh.kumar@linux.ibm.com, dan.j.williams@intel.com,
        ira.weiny@intel.com, santosh@fossix.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] powerpc/papr_scm: Fix warnings about undeclared
 variable
In-Reply-To: <20200918085951.44983-1-wangwensheng4@huawei.com>
References: <20200918085951.44983-1-wangwensheng4@huawei.com>
Date:   Thu, 24 Sep 2020 17:16:00 +0530
Message-ID: <87lfgz9z47.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_08:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=1 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=984 bulkscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the patch. This looks good to me.

Wang Wensheng <wangwensheng4@huawei.com> writes:

> Build the kernel with 'make C=2':
> arch/powerpc/platforms/pseries/papr_scm.c:825:1: warning: symbol
> 'dev_attr_perf_stats' was not declared. Should it be static?

> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>

-- 
Cheers
~ Vaibhav
