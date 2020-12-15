Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6222DA967
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgLOIpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:45:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbgLOIpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:45:09 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BF8VrOI074862;
        Tue, 15 Dec 2020 03:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=mUv3bSvDf8As47IwRkFi9URtIX6TbD2NXNi3OAjNOT4=;
 b=rUKTsqIua8e0HvzJjoCoBpJ38lwdKIlz9qPVJMxtbN0IT1L8yYL4SpzWV9Y6KtaTt+VN
 Y0XWGbA2Pa5L/WjMPFV5y70SH0sDdIXyknSKrUl4lysFV/ntX1MeQFxqrMbWEOq3VJ/R
 qBStw7CmbEBmXYtxASXfnFPCKfK7sr0BdaXYM0KLMCKsm28iX8TLiTxfTlvxJicA4kW6
 6ReDeYBb/Q0Ta3vPOnbdBE3Zq8Z/H6PCekNIZTfE3Q8+IZGTaw3ZlE4YjDZQZYItt/js
 jOO8eCzAo8v46uKv/33pJOvxxlQdST7FxYhrgWXf92h+YAIJjgklDUbhh7Gk8X7X0Uzf Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35esje8j98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 03:44:18 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BF8WfLj081453;
        Tue, 15 Dec 2020 03:44:17 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35esje8j8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 03:44:17 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BF8gWqa006284;
        Tue, 15 Dec 2020 08:44:15 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 35cng8b0yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 08:44:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BF8iCni43319724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 08:44:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF2C6AE056;
        Tue, 15 Dec 2020 08:44:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C41CBAE045;
        Tue, 15 Dec 2020 08:44:10 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 15 Dec 2020 08:44:10 +0000 (GMT)
Date:   Tue, 15 Dec 2020 14:14:10 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] powerpc/cacheinfo: Print correct cache-sibling
 map/list for L2 cache
Message-ID: <20201215084410.GE1239129@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1607596739-32439-1-git-send-email-ego@linux.vnet.ibm.com>
 <1607596739-32439-6-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1607596739-32439-6-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_04:2020-12-11,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2020-12-10 16:08:59]:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On POWER platforms where only some groups of threads within a core
> share the L2-cache (indicated by the ibm,thread-groups device-tree
> property), we currently print the incorrect shared_cpu_map/list for
> L2-cache in the sysfs.
> 
> This patch reports the correct shared_cpu_map/list on such platforms.
> 
> Example:
> On a platform with "ibm,thread-groups" set to
>                  00000001 00000002 00000004 00000000
>                  00000002 00000004 00000006 00000001
>                  00000003 00000005 00000007 00000002
>                  00000002 00000004 00000000 00000002
>                  00000004 00000006 00000001 00000003
>                  00000005 00000007
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju
