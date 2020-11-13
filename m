Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F2E2B1B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgKMMZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:25:01 -0500
Received: from 6.mo52.mail-out.ovh.net ([188.165.49.222]:54287 "EHLO
        6.mo52.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMMY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:24:57 -0500
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Nov 2020 07:24:56 EST
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.48])
        by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 1D58D204EF1;
        Fri, 13 Nov 2020 13:06:16 +0100 (CET)
Received: from kaod.org (37.59.142.97) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 13 Nov
 2020 13:06:15 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-97G002d415765a-705b-4da2-9b01-67ac23f9e562,
                    6CF58D6617F62A349CE936A1177A29C0D3476033) smtp.auth=clg@kaod.org
Subject: Re: [RFC PATCH kernel 2/2] powerpc/pci: Remove LSI mappings on device
 teardown
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        <linuxppc-dev@lists.ozlabs.org>
CC:     Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>, Qian Cai <cai@lca.pw>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <20201027090655.14118-1-aik@ozlabs.ru>
 <20201027090655.14118-3-aik@ozlabs.ru>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6c6702bd-dff2-1d34-0f93-4f8011417c64@kaod.org>
Date:   Fri, 13 Nov 2020 13:06:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027090655.14118-3-aik@ozlabs.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: e67374c8-6bc1-40fc-bd7f-1a030246aa01
X-Ovh-Tracer-Id: 8554306020416981938
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedruddvhedgfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekudeuudevleegudeugeekleffveeludejteffiedvledvgfekueefudehheefnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheprghikhesohiilhgrsghsrdhruh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 10:06 AM, Alexey Kardashevskiy wrote:
> From: Oliver O'Halloran <oohall@gmail.com>
> 
> When a passthrough IO adapter is removed from a pseries machine using hash
> MMU and the XIVE interrupt mode, the POWER hypervisor expects the guest OS
> to clear all page table entries related to the adapter. If some are still
> present, the RTAS call which isolates the PCI slot returns error 9001
> "valid outstanding translations" and the removal of the IO adapter fails.
> This is because when the PHBs are scanned, Linux maps automatically the
> INTx interrupts in the Linux interrupt number space but these are never
> removed.
> 
> This problem can be fixed by adding the corresponding unmap operation when
> the device is removed. There's no pcibios_* hook for the remove case, but
> the same effect can be achieved using a bus notifier.
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks taking care of this.

C. 

> ---
>  arch/powerpc/kernel/pci-common.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index be108616a721..95f4e173368a 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -404,6 +404,27 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>  	return 0;
>  }
>  
> +static int ppc_pci_unmap_irq_line(struct notifier_block *nb,
> +			       unsigned long action, void *data)
> +{
> +	struct pci_dev *pdev = to_pci_dev(data);
> +
> +	if (action == BUS_NOTIFY_DEL_DEVICE)
> +		irq_dispose_mapping(pdev->irq);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block ppc_pci_unmap_irq_notifier = {
> +	.notifier_call = ppc_pci_unmap_irq_line,
> +};
> +
> +static int ppc_pci_register_irq_notifier(void)
> +{
> +	return bus_register_notifier(&pci_bus_type, &ppc_pci_unmap_irq_notifier);
> +}
> +arch_initcall(ppc_pci_register_irq_notifier);
> +
>  /*
>   * Platform support for /proc/bus/pci/X/Y mmap()s.
>   *  -- paulus.
> 

