Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDC827F94C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgJAGHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:07:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbgJAGHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:07:39 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09160wbL016873;
        Thu, 1 Oct 2020 02:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uA5mowoeweD99tZDuEShnULMMefM1qLpUThlt+WjlLI=;
 b=UYm8nJEffXl7u32roo8/XkrBvf4HSackwN08ihu/FrL4gAwWOvECV0pwFPEDOorsrpcS
 bfGTdUno+re+OhtcJiL+PRV782hcPgIFMqkfu8uuNs2+bWULMVf4/vXbTq4Zw9tiy3JL
 fH1oxgf0Cgu6m2gnaaTVgf+dhPRIkGe68s33e5Ox+3u43Ny2RZ5TqEpO7rl8J7Ay/Rj1
 TCTKgKSDdp/vqqCv1Dn+rKG01dTC51lQ1rGuAVTUXRmij0YrP6rtfH0Z4CZ6SgHeEpkO
 evkAPfqYwZnvRILoXc1QF0R6iykO16ZrelnCPnJHsX+EAqyuTvVFSbTWV9+BH7LkV1SW 3Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33w4f0769t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 02:07:02 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 091670x8017580;
        Thu, 1 Oct 2020 06:07:00 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33sw97w6f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 06:07:00 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09166wcm34472322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Oct 2020 06:06:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29349AE057;
        Thu,  1 Oct 2020 06:06:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68B60AE051;
        Thu,  1 Oct 2020 06:06:56 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.85.92.124])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  1 Oct 2020 06:06:56 +0000 (GMT)
Subject: Re: [PATCH v4 23/52] docs: trace-uses.rst: remove bogus c-domain tags
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
 <f1d8fc4bb976f8c25c6fb444b0b675d9a849ba06.1601467849.git.mchehab+huawei@kernel.org>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <5e19b1d5-8015-c41d-788d-00b121599c6b@linux.vnet.ibm.com>
Date:   Thu, 1 Oct 2020 11:36:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f1d8fc4bb976f8c25c6fb444b0b675d9a849ba06.1601467849.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_02:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1011 mlxlogscore=974 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 6:54 pm, Mauro Carvalho Chehab wrote:
> There are some c-domain tags that are wrong. While this won't
> cause problems with Sphinx < 3.0, this cause troubles with
> newer versions, as the C parser won't recognize the contents
> of the tag, and will drop it from the output.
> 
> Let's just place them at literal blocks.
> 

tired with Sphinx v3.2.1, invalid C declaration warnings are not
seen with the patch.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
Kamalesh
