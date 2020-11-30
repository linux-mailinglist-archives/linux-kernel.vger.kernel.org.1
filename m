Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EBB2C7D77
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgK3DrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:47:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726000AbgK3DrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:47:07 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AU3VZHO172154;
        Sun, 29 Nov 2020 22:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Xp5fIqGpHDQ+y4QgSyvNqdOqBbkZYUmxTfBztZv32jk=;
 b=XlHOoEthjRaAU617/LmOQ6pTiu2pnq34R3xsxmI1ROfoqNjNXvYPeaLTNmWCoOddo30n
 +jWC+ClddRg/WfyCHCxalYYZA1rcCiy+OrjrA1f10tiC2tXUskQQaRY+R5/HcbBhfwH8
 pmuLpgVv9XkkpuOqx77oTr+MBDHAlppQUC4KY/j7yClecHZPPXBt2d5j8SUn4epTt1zB
 SWJdAMufX7KwWPfybr/Hzp6jZKAvxEfWOCm/F9LX/hr8gvVdfZGLfDvubs28pz6E7dCp
 F9y7DIr0SqKsLXhzz9zgT85/cUoD5nU1/k/yljFsw0UYF00sOr11agwxt28hDd4CiCo6 5w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 354rra0bk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 22:46:23 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AU3fndo019654;
        Mon, 30 Nov 2020 03:46:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 354fpd8b2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 03:46:21 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AU3kI5k3277506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 03:46:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC0ED4C04E;
        Mon, 30 Nov 2020 03:46:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 696574C050;
        Mon, 30 Nov 2020 03:46:18 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Nov 2020 03:46:18 +0000 (GMT)
Received: from [9.102.59.125] (unknown [9.102.59.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2E7A260A2F;
        Mon, 30 Nov 2020 14:46:17 +1100 (AEDT)
Subject: Re: [ANNOUNCE] [CFP] Call for Sessions - linux.conf.au Online 2021
 Kernel Miniconf
To:     CRISTIAN ANDRES VARGAS GONZALEZ <vargascristian@americana.edu.co>
Cc:     LKML <linux-kernel@vger.kernel.org>, lwn@lwn.net
References: <f43afd8c-5ce6-c505-3f4c-bd8f130ff904@linux.ibm.com>
 <CABfRCziSf1iw3tb--j6F0ebPwx+kgtL_Jk9fA37gN7uDqEVPvg@mail.gmail.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <aab61c32-e6ec-ff19-8434-069aca2cd41d@linux.ibm.com>
Date:   Mon, 30 Nov 2020 14:46:16 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <CABfRCziSf1iw3tb--j6F0ebPwx+kgtL_Jk9fA37gN7uDqEVPvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-29_12:2020-11-26,2020-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1011 mlxscore=0
 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=939 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/20 2:38 pm, CRISTIAN ANDRES VARGAS GONZALEZ wrote:
>  > More info: https://lca-kernel.ozlabs.org/2021-cfs.html 
> <https://lca-kernel.ozlabs.org/2021-cfs.html>
> Hi, this link no working. :c

Ugh, let me fix my TLS setup. In the meantime, try plain old unencrypted 
HTTP: http://lca-kernel.ozlabs.org/2021-cfs.html

Thanks for reporting!


Andrew

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
