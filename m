Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7722B20E4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgKMQwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:52:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgKMQwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:52:20 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ADGXH87066679;
        Fri, 13 Nov 2020 11:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=20opIcxHL6KerUt1ZtOZ7lNdftubKY4nb3a7SIpkdXM=;
 b=h0zuYmCgYo5cXz2KTcmHrJ7bEe36PHxRyBFDdCq1OEwtxhkpRxzpeMlpGUe4FVx9BGTH
 6IVrO2tIQRosMqcGgG+tq6cQ6Y0tMSvYowSJ9edCalUV120fLzyTiMSqolhWq7+Ypk1b
 oRd+HtWfKQsfFx3NayQPW65jjBdb0H+4ny2I/aFlPHlUNIXgn6KeswLrvHPE+e9VOF4P
 gjPWdk0XatzcC0Q1IO9wv58VEFH8AzSe46kZ9MALWY3XAV6fgNMcqBxAkgsEnJX6HepR
 0H42Lhsg6xcXvqK5o8KrSeu71sHAFiQRmt5B8l9+J3sB7kquMldCo9WUAPXPL7bHR/hI Mw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34swrd0gs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 11:52:10 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ADGpwN2016720;
        Fri, 13 Nov 2020 16:52:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 34njuh6w7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 16:52:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ADGq5Ml3539496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 16:52:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C696E11C058;
        Fri, 13 Nov 2020 16:52:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E94A11C05B;
        Fri, 13 Nov 2020 16:52:05 +0000 (GMT)
Received: from [9.171.37.149] (unknown [9.171.37.149])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Nov 2020 16:52:05 +0000 (GMT)
Subject: Re: [PATCH 0/2] nvme-pic: improve max I/O queue handling
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
 <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com>
 <10908f20-7e18-e967-76dd-1a38e216b378@linux.ibm.com>
 <20201112173634.GA2626470@dhcp-10-100-145-180.wdc.com>
 <c753af20-878a-91ad-c5c2-692016fe2014@linux.ibm.com>
 <20201113162502.GA16940@lst.de>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <822e0e06-28c2-a069-6cc1-a0810b17fbdd@linux.ibm.com>
Date:   Fri, 13 Nov 2020 17:52:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201113162502.GA16940@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_10:2020-11-13,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/20 5:25 PM, Christoph Hellwig wrote:
> On Fri, Nov 13, 2020 at 02:15:59PM +0100, Niklas Schnelle wrote:
>>
>>
>> On 11/12/20 6:36 PM, Keith Busch wrote:
>>> On Thu, Nov 12, 2020 at 04:45:35PM +0100, Niklas Schnelle wrote:
>>>> You got to get something wrong, I hope in this case it's just the subject
>>>> of the cover letter :D
>>>
>>> I suppose the change logs could be worded a little better :)
>>
>> Do you think I should send a v2 with an improved message?
>> I just realized I'm pretty alone (and wrong) in starting
>> the commit message body lower case too.
> 
> I'll pull in soon, no need to resend.
> 

Thanks, appreciate your effort!
