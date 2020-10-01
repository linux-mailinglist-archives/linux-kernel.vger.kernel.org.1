Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B3C27FB75
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbgJAI2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:28:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgJAI2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:28:44 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0918QmQl142172;
        Thu, 1 Oct 2020 04:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hJe5IYbnXxWaynPPDG0hkAOrhAUGmw0xJhVB7on6ViY=;
 b=KZfmVcITXJqfMoBUqprUDRuB/i+1RuEiFSUuYrV7Geb/QgSQ5E/ZtgUhmcPD9h+Sq6v4
 gJFrONQGdF19j+Z9Sq5kI4WFqZou1Fecg4pzdJO2lge6nDNS2lD/u38rK2svoAu0MdRS
 zaKFyUbqD/T0gGe0IDYnFjQG2BtqN0diQKyLmVwmJ8xJ5OZDtL5ekeZpanIVMHKTFVb3
 cgaowgLl5RsMfuys6XE/Pd1LNqwaAabp4o9qeowfLB7DKkE3l1RYnwTVJfsdMTVfqzsW
 Cm2TkvJMRzTAp2LrBkgY6ZxGJbiw6ttmS9DGAaagKzauV387Iiq99qf+YCDj6W73Hvtf 7g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33wab6a0td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 04:28:02 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0918RN8b008924;
        Thu, 1 Oct 2020 08:27:58 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 33sw9859hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 08:27:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0918Ruun26214702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Oct 2020 08:27:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44D1EAE04D;
        Thu,  1 Oct 2020 08:27:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B868AE051;
        Thu,  1 Oct 2020 08:27:54 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.85.92.124])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  1 Oct 2020 08:27:54 +0000 (GMT)
Subject: Re: [PATCH v4 23/52] docs: trace-uses.rst: remove bogus c-domain tags
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
 <f1d8fc4bb976f8c25c6fb444b0b675d9a849ba06.1601467849.git.mchehab+huawei@kernel.org>
 <5e19b1d5-8015-c41d-788d-00b121599c6b@linux.vnet.ibm.com>
 <20201001084143.7c6f7836@coco.lan>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <3c1bca2d-b954-1f48-3cf9-617e01137e99@linux.vnet.ibm.com>
Date:   Thu, 1 Oct 2020 13:57:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201001084143.7c6f7836@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_02:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/20 12:11 pm, Mauro Carvalho Chehab wrote:
> Em Thu, 1 Oct 2020 11:36:53 +0530
> Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> escreveu:
> 
>> On 30/09/20 6:54 pm, Mauro Carvalho Chehab wrote:
>>> There are some c-domain tags that are wrong. While this won't
>>> cause problems with Sphinx < 3.0, this cause troubles with
>>> newer versions, as the C parser won't recognize the contents
>>> of the tag, and will drop it from the output.
>>>
>>> Let's just place them at literal blocks.
>>>   
>>
>> tired with Sphinx v3.2.1, invalid C declaration warnings are not
>> seen with the patch.
> 
> Well, it would be possible to use :c:expr: with Sphinx 3.2.1,
> in order for it to check for invalid C declarations.
> 
> Btw, this is one of the improvements over the last versions: the
> rewritten C parser there is a lot more pedantic with regards to the
> C syntax.
> 
> -
> 
> That's said, the backward-compatibility code I added at 
> Documentation/sphinx/cdomain.py will convert this into a 
> literal markup though, as there's no equivalent tag before 
> Sphinx 3.x.
> 
> As there are still one upstream issue on Sphinx 3.x that requires a fix[1],
> and we don't know yet the issues with :c:expr[2], at least for now, I would 
> avoid adding :c:expr: markups.
> 
> [1] Right now, the C domain is not able to have two names
>     for different types. So, it is not possible to have
>     a struct "foo" and a function "foo".
> 
>     Due to that, while I was able to fix all warnings with
>     Sphinx 2.x build, Sphinx 3.x will still have bogus
>     warnings.
> 
> [2] One of the limitations of :c:expr: is with regards to function
>     prototypes. You can't use it like: :c:expr:`int foo(void);`,
>     as it will complain with the function return type.
> 

Thank you for explaining in detail on the :c:expr: tag. I intended to 
say this patch fixes the warnings seen while using the c-domain tags
and are fixed by converting them into literals. 

-- 
Kamalesh
