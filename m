Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA222C7D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 05:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgK3ENV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 23:13:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbgK3ENU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 23:13:20 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AU42IxO109864;
        Sun, 29 Nov 2020 23:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ymsD2ULh3b3VwtDyvsqydScvD+IBj0YNejWUSxvfJgQ=;
 b=Js/PnaQya8doFUkDF88NYKDYWTI5Vej6x7wFoxqjuEKtmtItH2xYDKbZ12Ag4hh+qmnt
 6KdzZEb1Kqc8YZ3KlMieTQGZWZr6v6h7gr86mCSgoiO6l6a4bRPE7cIiSNvo0Gq/3G+d
 02jrE15JQLjcvMSxTHMFG90wa4GS9LLoGcfoZpzZTh1AkflnlqhCUoScqXXB5KKfx6lj
 L6k4wcmCYF7oPtSbihexRw2Ka1LYqFxg5+4B1lQbQqmrXHkcCGfHUfgNqTnoOqJIRy3y
 SvY0TUJT8sncaD/Qr2vYzaUfQIIc1lpcsqFUOqkNLrR8stinKLi8hdUmtpvN/wp+ikY0 Kw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 354qxusnyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 23:12:39 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AU4CbH6007477;
        Mon, 30 Nov 2020 04:12:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 353e682da5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 04:12:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AU4BKgM9503480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 04:11:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF18552051;
        Mon, 30 Nov 2020 04:11:19 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9FA2452050;
        Mon, 30 Nov 2020 04:11:19 +0000 (GMT)
Received: from [9.102.59.125] (unknown [9.102.59.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6E30160A2F;
        Mon, 30 Nov 2020 15:11:18 +1100 (AEDT)
Subject: Re: [ANNOUNCE] [CFP] Call for Sessions - linux.conf.au Online 2021
 Kernel Miniconf
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     CRISTIAN ANDRES VARGAS GONZALEZ <vargascristian@americana.edu.co>
Cc:     LKML <linux-kernel@vger.kernel.org>, lwn@lwn.net
References: <f43afd8c-5ce6-c505-3f4c-bd8f130ff904@linux.ibm.com>
 <CABfRCziSf1iw3tb--j6F0ebPwx+kgtL_Jk9fA37gN7uDqEVPvg@mail.gmail.com>
 <aab61c32-e6ec-ff19-8434-069aca2cd41d@linux.ibm.com>
Message-ID: <5519219c-1490-97c1-d72e-72029d22d997@linux.ibm.com>
Date:   Mon, 30 Nov 2020 15:11:17 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <aab61c32-e6ec-ff19-8434-069aca2cd41d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-29_12:2020-11-26,2020-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=937
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/20 2:46 pm, Andrew Donnellan wrote:
> On 30/11/20 2:38 pm, CRISTIAN ANDRES VARGAS GONZALEZ wrote:
>>  > More info: https://lca-kernel.ozlabs.org/2021-cfs.html 
>> <https://lca-kernel.ozlabs.org/2021-cfs.html>
>> Hi, this link no working. :c
> 
> Ugh, let me fix my TLS setup. In the meantime, try plain old unencrypted 
> HTTP: http://lca-kernel.ozlabs.org/2021-cfs.html
> 
> Thanks for reporting!

Should be all fixed.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
