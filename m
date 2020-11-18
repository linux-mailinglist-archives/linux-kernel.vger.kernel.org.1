Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B89D2B8203
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgKRQhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:37:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725970AbgKRQhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:37:18 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AIGXlHa080320;
        Wed, 18 Nov 2020 11:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BfN1KHUKFM0k4smw1F6jTM0orYu4+OQCcAeBK/hKRdo=;
 b=qCDlMyG7sabTq2tAmkw3aouiTMieXTz/6daboAJPC5FglRe0zZsQ667crgoIxOwPlnCk
 7Y/H1JATQm53ec1JNvPbngDozhz0xhxwF6Iy9Maiep/HvGnUsGH5YdXW8pzj1L6VxFEX
 v/r4mwaRfXA2RjMKWMfPHH+seRxBSkIcp+7VU4WoMNHJhtM0Dr3vi8IQ+J+fb2gqBlVN
 JeRiXWFkac0zNfx0WGNl8BlteiSIy/Q06mefhW9yTleJlResTN8sZZ3Q4IrtznlzBdBR
 F1VIbjLeJbBTA0aEe8Zf3o7iRJo434qfjckwwyfxQrYFGbKD3skp8ByGWS+wVWWfw83z zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34w4x3wy3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 11:37:09 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AIGZT9s085111;
        Wed, 18 Nov 2020 11:37:09 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34w4x3wy2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 11:37:09 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AIGb7Jp003651;
        Wed, 18 Nov 2020 16:37:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 34t6v8arng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 16:37:07 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AIGZnQJ6029992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 16:35:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D990652052;
        Wed, 18 Nov 2020 16:35:49 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.87.122])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 71A5352051;
        Wed, 18 Nov 2020 16:35:49 +0000 (GMT)
Subject: Re: md: dm-writeback: add __noreturn to BUG-ging function
To:     Mike Snitzer <snitzer@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20201113225228.20563-1-rdunlap@infradead.org>
 <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com>
 <c29eeb5d-0683-49eb-f729-38b14fac7745@infradead.org>
 <20201117163147.GA27243@redhat.com> <20201118154944.GB545@redhat.com>
 <20201118160748.GA754@redhat.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <7ae2b73e-e6e5-3357-11e4-efd93e93ba35@de.ibm.com>
Date:   Wed, 18 Nov 2020 17:35:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <20201118160748.GA754@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_04:2020-11-17,2020-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=990 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.11.20 17:07, Mike Snitzer wrote:
> On Wed, Nov 18 2020 at 10:49am -0500,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
>> I don't think my suggestion will help.. given it'd still leave
>> persistent_memory_claim() without a return statement.
>>
>> Think it worthwhile to just add a dummy 'return 0;' after the BUG().
> 
> Decided to go with this, now staged for 5.11:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.11&id=a1e4865b4dda7071f3707f7e551289ead66e38b1
> 

Looks like a sane solution. Thank you for following up.
