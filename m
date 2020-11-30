Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB032C7FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgK3IbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:31:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbgK3IbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:31:20 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AU81eYQ111270;
        Mon, 30 Nov 2020 03:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7ssBlBYTySl82gc1CsMyXLf7OFpzpGhtCYXblGBd0IY=;
 b=e/cSGDfpdOP6yN+QbjD0kkUKfYrQmJCd8NJsBd2RTbNzPKUb82bzWsmDZs3njsFnATbL
 jj/2xLhd7ke3gvMVwuRSy6Nk2i6oudGAWd4LMfsR8Rn7HUIYtPCIfvVfSVRLAW1CVhke
 6SVjZwln4RHImtDRN3M54cO//+uHNibeHhFh477vqEQtb6483a9fMtXBBSroWUb1Seye
 H9q4ziJuwQZCVNJgUquLGmBCf3xnIlEUj1+xX/Ii4E2lHriilrT7dp5TW4MSmP5TMFsG
 FWvI3qR/SIGhUxdId4Jtbu6GdmvqIzW86lMWrRD8Ht0sgkGLynXqP64CIurS0E5hbppa Uw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 354v989n5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 03:30:38 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AU8R9KF003142;
        Mon, 30 Nov 2020 08:30:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 353e688xar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 08:30:36 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AU8UXc157082148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 08:30:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A032542047;
        Mon, 30 Nov 2020 08:30:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66B434204C;
        Mon, 30 Nov 2020 08:30:33 +0000 (GMT)
Received: from [9.171.29.181] (unknown [9.171.29.181])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Nov 2020 08:30:33 +0000 (GMT)
Subject: Re: [PATCH v3] s390/pci: fix CPU address in MSI for directed IRQ
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
 <20201127095633.60f8a544.pasic@linux.ibm.com>
 <16fe9017-407f-1bb0-1599-fb46d93009fc@linux.ibm.com>
 <20201127163936.38a51c15.pasic@linux.ibm.com>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <2400bc6a-ff0a-f0b8-66fc-25e11032dacb@linux.ibm.com>
Date:   Mon, 30 Nov 2020 09:30:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201127163936.38a51c15.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_02:2020-11-26,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/20 4:39 PM, Halil Pasic wrote:
> On Fri, 27 Nov 2020 11:08:10 +0100
> Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> 
>>
>>
>> On 11/27/20 9:56 AM, Halil Pasic wrote:
>>> On Thu, 26 Nov 2020 18:00:37 +0100
>>> Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>>>
>>>> The directed MSIs are delivered to CPUs whose address is
>>>> written to the MSI message data. The current code assumes
>>>> that a CPU logical number (as it is seen by the kernel)
>>>> is also that CPU address.
>>>>
>>>> The above assumption is not correct, as the CPU address
>>>> is rather the value returned by STAP instruction. That
>>>> value does not necessarily match the kernel logical CPU
>>>> number.
>>>>
>>>> Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts")
>>>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>>>> ---
>>>>  arch/s390/pci/pci_irq.c | 14 +++++++++++---
>>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
>>>> index 743f257cf2cb..75217fb63d7b 100644
>>>> --- a/arch/s390/pci/pci_irq.c
>>>> +++ b/arch/s390/pci/pci_irq.c
>>>> @@ -103,9 +103,10 @@ static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *de
>>>>  {
>>>>  	struct msi_desc *entry = irq_get_msi_desc(data->irq);
>>>>  	struct msi_msg msg = entry->msg;
>>>> +	int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
>>>>  
>>>>  	msg.address_lo &= 0xff0000ff;
>>>> -	msg.address_lo |= (cpumask_first(dest) << 8);
>>>> +	msg.address_lo |= (cpu_addr << 8);
>>>>  	pci_write_msi_msg(data->irq, &msg);
>>>>  
>>>>  	return IRQ_SET_MASK_OK;
>>>> @@ -238,6 +239,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>>>>  	unsigned long bit;
>>>>  	struct msi_desc *msi;
>>>>  	struct msi_msg msg;
>>>> +	int cpu_addr;
>>>>  	int rc, irq;
>>>>  
>>>>  	zdev->aisb = -1UL;
>>>> @@ -287,9 +289,15 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>>>>  					 handle_percpu_irq);
>>>>  		msg.data = hwirq - bit;
>>>>  		if (irq_delivery == DIRECTED) {
>>>> +			if (msi->affinity)
>>>> +				cpu = cpumask_first(&msi->affinity->mask);
>>>> +			else
>>>> +				cpu = 0;
>>>> +			cpu_addr = smp_cpu_get_cpu_address(cpu);
>>>> +
>>>
>>> I thin style wise, I would prefer keeping the ternary operator instead
>>> of rewriting it as an if-then-else, i.e.:
>>>                         cpu_addr = smp_cpu_get_cpu_address(msi->affinity ?      
>>>                                 cpumask_first(&msi->affinity->mask) : 0);
>>> but either way:
>>>
>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com> 
>>
>> Thanks for your review, lets keep the if/else its certainly not less
>> readable even if it may be less pretty.
>>
>> Found another thing (not directly in the touched code) but I'm now
>> wondering about. In zpci_handle_cpu_local_irq()
>> we do
>> 	struct airq_iv *dibv = zpci_ibv[smp_processor_id()];
>>
>> does that also need to use some _address() variant? If it does that
>> then dicatates that the CPU addresses must start at 0.
>>
> 
> I didn't go to the bottom of this, but my understanding is that it
> does not need a _address() variant. What we need is, probably, the
> mapping between the 'id' and 'address' being a stable one.
> 
> Please notice that cpu_enable_directed_irq() is called on each cpu. That
> establishes the mapping/relationship between the id and the address,
> as the machine cares for the address, and cpu_enable_directed_irq()
> cares for the id:
> static void __init cpu_enable_directed_irq(void *unused)                        
> {                                                                               
>         union zpci_sic_iib iib = {{0}};                                         
>                                                                                 
>         iib.cdiib.dibv_addr = (u64) zpci_ibv[smp_processor_id()]->vector;       
>                                                                                 
>         __zpci_set_irq_ctrl(SIC_IRQ_MODE_SET_CPU, 0, &iib);                     
>         zpci_set_irq_ctrl(SIC_IRQ_MODE_D_SINGLE, PCI_ISC);                      
> }

Thanks for the very clear and understandable explanation, I think
you're exactly right. I didn't look very closely and missed that
cpu_enable_directed_irq() uses the smp_processor_id() thereby
establishing the mapping.

> 
> Now were the id <-> address mapping to change, we would be in trouble. If
> that's possible, I don't know. My guess is that it would require cpu hot
> unplug. Niklas, are you familiar with that stuff? Should we ask, Heiko
> and Vasily?
> 
> Regards,
> Halil

I'm not really familiar, with it but I think this is closely related
to what I asked Bernd Nerz. I fear that if CPUs go away we might already
be in trouble at the firmware/hardware/platform level because the CPU Address is
"programmed into the device" so to speak. Thus a directed interrupt from
a device may race with anything reordering/removing CPUs even if
CPU addresses of dead CPUs are not reused and the mapping is stable.

Furthermore our floating fallback path will try to send a SIGP
to the target CPU which clearly doesn't work when that is permanently
gone. Either way I think these issues are out of scope for this fix
so I will go ahead and merge this.

> 
>>>
>>>>  			msg.address_lo = zdev->msi_addr & 0xff0000ff;
>>>> -			msg.address_lo |= msi->affinity ?
>>>> -				(cpumask_first(&msi->affinity->mask) << 8) : 0;
>>>> +			msg.address_lo |= (cpu_addr << 8);
>>>> +
>>>>  			for_each_possible_cpu(cpu) {
>>>>  				airq_iv_set_data(zpci_ibv[cpu], hwirq, irq);
>>>>  			}
>>>
> 
