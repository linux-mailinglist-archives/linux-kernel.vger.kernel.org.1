Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494632C6285
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgK0KJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:09:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbgK0KJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:09:31 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ARA2TPO120254;
        Fri, 27 Nov 2020 05:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9CgQx4X+B/5a/3dpEyVt7OrqSJb7OKqR7acV/bnm/xs=;
 b=iYxKZuUVOaPRvdH6KB3glvcC3v5U66b97zEuMO9HzekYAXjNISR2+cyodV5Smks6KwWq
 1guUJjYdzhh8qGr6OYledPyYO6ZB5csWRCL3SPmlhYrt4JILb3K+54xXiQ0Q9bkxYWkY
 4pn3EM83IyQQSS80lnGY2hPc8lrKjs4Y/og1iyV9hEVPicGQQWsdygnPQDe4qi84AaPE
 uSQnYUOJocjAyvBEKvagqazAmblZGuBwcmtcSkObe97i0m8WdMWJ8czEhhF+bzCniwS/
 62lFgI9y9QjXRsmNNfmfrdp4oSQIHT0bdfso2Nqg+CKl7SWupiKcKd+OYRtzrO4+9xWm MQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352uke60gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 05:09:30 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ARA2Nhh013374;
        Fri, 27 Nov 2020 10:09:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 352jgsgsr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 10:09:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ARA8AdJ7012932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Nov 2020 10:08:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CAA6AE053;
        Fri, 27 Nov 2020 10:08:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45951AE05A;
        Fri, 27 Nov 2020 10:08:10 +0000 (GMT)
Received: from [9.171.3.231] (unknown [9.171.3.231])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Nov 2020 10:08:10 +0000 (GMT)
Subject: Re: [PATCH v3] s390/pci: fix CPU address in MSI for directed IRQ
To:     Halil Pasic <pasic@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
 <20201127095633.60f8a544.pasic@linux.ibm.com>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <16fe9017-407f-1bb0-1599-fb46d93009fc@linux.ibm.com>
Date:   Fri, 27 Nov 2020 11:08:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201127095633.60f8a544.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_05:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/20 9:56 AM, Halil Pasic wrote:
> On Thu, 26 Nov 2020 18:00:37 +0100
> Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> 
>> The directed MSIs are delivered to CPUs whose address is
>> written to the MSI message data. The current code assumes
>> that a CPU logical number (as it is seen by the kernel)
>> is also that CPU address.
>>
>> The above assumption is not correct, as the CPU address
>> is rather the value returned by STAP instruction. That
>> value does not necessarily match the kernel logical CPU
>> number.
>>
>> Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts")
>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>> ---
>>  arch/s390/pci/pci_irq.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
>> index 743f257cf2cb..75217fb63d7b 100644
>> --- a/arch/s390/pci/pci_irq.c
>> +++ b/arch/s390/pci/pci_irq.c
>> @@ -103,9 +103,10 @@ static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *de
>>  {
>>  	struct msi_desc *entry = irq_get_msi_desc(data->irq);
>>  	struct msi_msg msg = entry->msg;
>> +	int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
>>  
>>  	msg.address_lo &= 0xff0000ff;
>> -	msg.address_lo |= (cpumask_first(dest) << 8);
>> +	msg.address_lo |= (cpu_addr << 8);
>>  	pci_write_msi_msg(data->irq, &msg);
>>  
>>  	return IRQ_SET_MASK_OK;
>> @@ -238,6 +239,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>>  	unsigned long bit;
>>  	struct msi_desc *msi;
>>  	struct msi_msg msg;
>> +	int cpu_addr;
>>  	int rc, irq;
>>  
>>  	zdev->aisb = -1UL;
>> @@ -287,9 +289,15 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>>  					 handle_percpu_irq);
>>  		msg.data = hwirq - bit;
>>  		if (irq_delivery == DIRECTED) {
>> +			if (msi->affinity)
>> +				cpu = cpumask_first(&msi->affinity->mask);
>> +			else
>> +				cpu = 0;
>> +			cpu_addr = smp_cpu_get_cpu_address(cpu);
>> +
> 
> I thin style wise, I would prefer keeping the ternary operator instead
> of rewriting it as an if-then-else, i.e.:
>                         cpu_addr = smp_cpu_get_cpu_address(msi->affinity ?      
>                                 cpumask_first(&msi->affinity->mask) : 0);
> but either way:
> 
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com> 

Thanks for your review, lets keep the if/else its certainly not less
readable even if it may be less pretty.

Found another thing (not directly in the touched code) but I'm now
wondering about. In zpci_handle_cpu_local_irq()
we do
	struct airq_iv *dibv = zpci_ibv[smp_processor_id()];

does that also need to use some _address() variant? If it does that
then dicatates that the CPU addresses must start at 0.

> 
>>  			msg.address_lo = zdev->msi_addr & 0xff0000ff;
>> -			msg.address_lo |= msi->affinity ?
>> -				(cpumask_first(&msi->affinity->mask) << 8) : 0;
>> +			msg.address_lo |= (cpu_addr << 8);
>> +
>>  			for_each_possible_cpu(cpu) {
>>  				airq_iv_set_data(zpci_ibv[cpu], hwirq, irq);
>>  			}
> 
