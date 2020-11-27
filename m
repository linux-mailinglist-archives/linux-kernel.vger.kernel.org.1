Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295112C6142
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgK0I55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:57:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726736AbgK0I54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:57:56 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AR8uKA2112627;
        Fri, 27 Nov 2020 03:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=wY0ebjHGGKcnDPCUPGV9wkQk3QCJJGxvqQbQ0CxXCyA=;
 b=BOTzB/mJ5hZlE6o+Lf0IoKLBezag1aTD6Uf2BRfcwTXo+uJdKep86BcMMDQaIbJMFLSr
 zxZrSenMkygrco2UU29BRvW+RpwRi1Dmsy5B+cxY/PYRFWqUoCz9R9a6/ER2dbi1KleA
 DG89OWoFJC85rqUbkvpMEKIiCatqpC77kWdv/6erY07ixp1qqVDFylUnZzsNL7PCZk2m
 ui8xO7oCiqjE6kIhw7nGs+Obkog7XysShpmAPGBtTM6hZ2L6xnCwyKxMNrZeqsiATvog
 9tAzy6yzVad974AB02O1+Hz5XjMb102lx2wYYbGNYOeVHCrnYzBsppyZLqmXJ15wsySl Lg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 352xcug1eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 03:57:54 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AR8qcCU005615;
        Fri, 27 Nov 2020 08:57:53 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 352jgsgq3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 08:57:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AR8uZCM11272716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Nov 2020 08:56:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA0DDA4057;
        Fri, 27 Nov 2020 08:56:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52C0CA4053;
        Fri, 27 Nov 2020 08:56:35 +0000 (GMT)
Received: from oc2783563651 (unknown [9.171.0.176])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 27 Nov 2020 08:56:35 +0000 (GMT)
Date:   Fri, 27 Nov 2020 09:56:33 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] s390/pci: fix CPU address in MSI for directed IRQ
Message-ID: <20201127095633.60f8a544.pasic@linux.ibm.com>
In-Reply-To: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
References: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_04:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 18:00:37 +0100
Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> The directed MSIs are delivered to CPUs whose address is
> written to the MSI message data. The current code assumes
> that a CPU logical number (as it is seen by the kernel)
> is also that CPU address.
> 
> The above assumption is not correct, as the CPU address
> is rather the value returned by STAP instruction. That
> value does not necessarily match the kernel logical CPU
> number.
> 
> Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts")
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/pci/pci_irq.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 743f257cf2cb..75217fb63d7b 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -103,9 +103,10 @@ static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *de
>  {
>  	struct msi_desc *entry = irq_get_msi_desc(data->irq);
>  	struct msi_msg msg = entry->msg;
> +	int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
>  
>  	msg.address_lo &= 0xff0000ff;
> -	msg.address_lo |= (cpumask_first(dest) << 8);
> +	msg.address_lo |= (cpu_addr << 8);
>  	pci_write_msi_msg(data->irq, &msg);
>  
>  	return IRQ_SET_MASK_OK;
> @@ -238,6 +239,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  	unsigned long bit;
>  	struct msi_desc *msi;
>  	struct msi_msg msg;
> +	int cpu_addr;
>  	int rc, irq;
>  
>  	zdev->aisb = -1UL;
> @@ -287,9 +289,15 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  					 handle_percpu_irq);
>  		msg.data = hwirq - bit;
>  		if (irq_delivery == DIRECTED) {
> +			if (msi->affinity)
> +				cpu = cpumask_first(&msi->affinity->mask);
> +			else
> +				cpu = 0;
> +			cpu_addr = smp_cpu_get_cpu_address(cpu);
> +

I thin style wise, I would prefer keeping the ternary operator instead
of rewriting it as an if-then-else, i.e.:
                        cpu_addr = smp_cpu_get_cpu_address(msi->affinity ?      
                                cpumask_first(&msi->affinity->mask) : 0);
but either way:

Reviewed-by: Halil Pasic <pasic@linux.ibm.com> 

>  			msg.address_lo = zdev->msi_addr & 0xff0000ff;
> -			msg.address_lo |= msi->affinity ?
> -				(cpumask_first(&msi->affinity->mask) << 8) : 0;
> +			msg.address_lo |= (cpu_addr << 8);
> +
>  			for_each_possible_cpu(cpu) {
>  				airq_iv_set_data(zpci_ibv[cpu], hwirq, irq);
>  			}

