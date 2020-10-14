Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7537128E839
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 23:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgJNVLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 17:11:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38356 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgJNVLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 17:11:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EKruSF050068;
        Wed, 14 Oct 2020 21:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3ciIFl7IEMSSFZDXPUxOkqELug/KZW0g2FveLtZMUyQ=;
 b=tKf2a0wz8h19V94PM5PPs2DBzcak6v1iDdSMBTG7wJ7GkmU+o16OyLEtCGw4OrNvzMyy
 wLA0fAFFdQZqZ6aBFa1O1kvKruvYrCf7ib2AR6YEok3llzVaLlVOzdeuKLj+w7/uDnrw
 +xRZ7+o/b4CGeWJCznmvgNIJYHtty4D+XPQ7nP9NyZCuSnND3uxxz1u77aV3GbOSQSPu
 sYACPRdDmMKIreGJVQxm51qYIgu+6L6u7Q5yUccpFVYtZQ9QjHkyc7YYv8dEpzyZtIxa
 pPnqi61tlPJcptmT07pRS9xK2+UibW1/6fRYX1NMdX1z7kc9LkRGqs0+2xOnH4rjok4u yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 343vaeg553-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 21:11:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EKsadi034896;
        Wed, 14 Oct 2020 21:11:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 343pvyd6h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 21:11:24 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09ELBMQR015380;
        Wed, 14 Oct 2020 21:11:22 GMT
Received: from [10.159.149.68] (/10.159.149.68)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 14:11:21 -0700
Subject: Re: [PATCH 4/8] x86/asm: add clear_page_nt()
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jslaby@suse.cz>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
 <20201014083300.19077-5-ankur.a.arora@oracle.com>
 <20201014195614.GB18196@zn.tnic>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <15b8e9b1-cc72-cbc3-5cc0-64b02b617a5b@oracle.com>
Date:   Wed, 14 Oct 2020 14:11:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201014195614.GB18196@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-14 12:56 p.m., Borislav Petkov wrote:
> On Wed, Oct 14, 2020 at 01:32:55AM -0700, Ankur Arora wrote:
>> This can potentially improve page-clearing bandwidth (see below for
>> performance numbers for two microarchitectures where it helps and one
>> where it doesn't) and can help indirectly by consuming less cache
>> resources.
>>
>> Any performance benefits are expected for extents larger than LLC-sized
>> or more -- when we are DRAM-BW constrained rather than cache-BW
>> constrained.
> 
> "potentially", "expected", I don't like those formulations.
That's fair. The reason for those weasel words is mostly because it
is microarchitecture specific.
For example on Intel where I did compare across generations: I see good
performance on Broadwellx, not good on Skylakex and then good again on
some pre-production CPUs.

> Do you have
> some actual benchmark data where this shows any improvement and not
> microbenchmarks only, to warrant the additional complexity?
Yes, guest creation under QEMU (pinned guests) shows similar improvements.
I've posted performance numbers in patches 7, 8 with a simple page-fault
test derived from that.

I can add numbers from QEMU as well.

Thanks,
Ankur

> 
