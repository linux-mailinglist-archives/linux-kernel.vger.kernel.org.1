Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA07D2A8527
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbgKERmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:42:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47772 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKERmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:42:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5HQ7RE171926;
        Thu, 5 Nov 2020 17:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Ygi5p2ytGYAOiTFCHa1IHIsoZmRXyEeKJ2onczmmk74=;
 b=jOi3adrSO9KNBupAJ7S4VihrMXGCDX9J5BpMBrLFGkwuyCDsq3WVf1drkDIKmERTAg1B
 s55DojrdLb0f7uZgn2zhd9G35SmBpqlzXyvPONt5ijA2I4aaf9nYIIm16EJzlhL38CrP
 nmm1T0gHph6CYMGotzry7GsB8VuQF6L1C1/78IOeZ6UeZtTq2yrdDmogqxbcHjkcZd49
 JHJmBKfd6EJ0+y2Ev1iFzZQoeFID3I8/X+sx0XbvHdmbCchN++sUIq5P6B99lO3PYlcX
 iLYsaRyFZW4FKF3FLtiI09zwnsMaE9TcgzLYKNaePuRCDQ4fXcm7I9ihdG0eO4pHQgmU AQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34hhvcn7qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 05 Nov 2020 17:41:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5HPDok109474;
        Thu, 5 Nov 2020 17:41:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34jf4chq16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Nov 2020 17:41:44 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A5HfTSv016553;
        Thu, 5 Nov 2020 17:41:34 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Nov 2020 09:41:29 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id C23D96A00F1; Thu,  5 Nov 2020 12:43:17 -0500 (EST)
Date:   Thu, 5 Nov 2020 12:43:17 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     hch@lst.de, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com,
        ssg.sos.patches@amd.com
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201105174317.GA4294@char.us.oracle.com>
References: <20201104220804.21026-1-Ashish.Kalra@amd.com>
 <20201104221452.GA26079@char.us.oracle.com>
 <20201104223913.GA25311@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104223913.GA25311@ashkalra_ubuntu_server>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 10:39:13PM +0000, Ashish Kalra wrote:
> Hello Konrad,
> 
> On Wed, Nov 04, 2020 at 05:14:52PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Wed, Nov 04, 2020 at 10:08:04PM +0000, Ashish Kalra wrote:
> > > From: Ashish Kalra <ashish.kalra@amd.com>
> > > 
> > > For SEV, all DMA to and from guest has to use shared
> > > (un-encrypted) pages. SEV uses SWIOTLB to make this
> > > happen without requiring changes to device drivers.
> > > However, depending on workload being run, the default
> > > 64MB of SWIOTLB might not be enough and SWIOTLB
> > > may run out of buffers to use for DMA, resulting
> > > in I/O errors and/or performance degradation for
> > > high I/O workloads.
> > > 
> > > Increase the default size of SWIOTLB for SEV guests
> > > using a minimum value of 128MB and a maximum value
> > 
> > <blinks>
> > 
> > 64MB for a 1GB VM is not enough?
> > 
> > > of 512MB, determining on amount of provisioned guest
> > 
> > I like the implementation on how this is done.. but
> > the choices of memory and how much seems very much
> > random. Could there be some math behind this?
> >
> 
> Earlier the patch was based on using a % of guest memory, as below:
> 
> +#define SEV_ADJUST_SWIOTLB_SIZE_PERCENT        5
> +#define SEV_ADJUST_SWIOTLB_SIZE_MAX    (1UL << 30)
> ...
> ...
> +       if (sev_active() && !io_tlb_nslabs) {
> +               unsigned long total_mem = get_num_physpages() << PAGE_SHIFT;
> +
> +               default_size = total_mem *
> +                       SEV_ADJUST_SWIOTLB_SIZE_PERCENT / 100;
> +
> +               default_size = ALIGN(default_size, 1 << IO_TLB_SHIFT);
> +
> +               default_size = clamp_val(default_size, IO_TLB_DEFAULT_SIZE,
> +                       SEV_ADJUST_SWIOTLB_SIZE_MAX);
> +       }
> 
> But, then it is difficult to predict what % of guest memory to use ?
> 
> Then there are other factors to consider, such as vcpu_count or if there
> is going to be high I/O workload, etc.
> 
> But that all makes it very complicated, what we basically want is a
> range from 128M to 512M and that's why the current patch which picks up
> this range from the amount of allocated guest memory keeps it simple. 

Right, so I am wondering if we can do this better.

That is you are never going to get any 32-bit devices with SEV right? That
is there is nothing that bounds you to always use the memory below 4GB?

What I wonder is if we can combine the boot-allocation of the SWIOTLB
with the post-boot-allocation of SWIOLTB to stitch together
continous physical ranges.

That way you have the flexibility at the start of using 64MB but if there
is pressure, we grow to a bigger size?

> 
> Thanks,
> Ashish
> 
> > > memory.
> > > 
> > > Using late_initcall() interface to invoke
> > > swiotlb_adjust() does not work as the size
> > > adjustment needs to be done before mem_encrypt_init()
> > > and reserve_crashkernel() which use the allocated
> > > SWIOTLB buffer size, hence calling it explicitly
> > > from setup_arch().
> > > 
> > > The SWIOTLB default size adjustment is added as an
> > > architecture specific interface/callback to allow
> > > architectures such as those supporting memory
> > > encryption to adjust/expand SWIOTLB size for their
> > > use.
> > > 
> > > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > > ---
> > >  arch/x86/kernel/setup.c   |  2 ++
> > >  arch/x86/mm/mem_encrypt.c | 42 +++++++++++++++++++++++++++++++++++++++
> > >  include/linux/swiotlb.h   |  1 +
> > >  kernel/dma/swiotlb.c      | 27 +++++++++++++++++++++++++
> > >  4 files changed, 72 insertions(+)
> > > 
> > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > index 3511736fbc74..b073d58dd4a3 100644
> > > --- a/arch/x86/kernel/setup.c
> > > +++ b/arch/x86/kernel/setup.c
> > > @@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)
> > >  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
> > >  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> > >  
> > > +	swiotlb_adjust();
> > > +
> > >  	/*
> > >  	 * Reserve memory for crash kernel after SRAT is parsed so that it
> > >  	 * won't consume hotpluggable memory.
> > > diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> > > index 3f248f0d0e07..e0deb157cddd 100644
> > > --- a/arch/x86/mm/mem_encrypt.c
> > > +++ b/arch/x86/mm/mem_encrypt.c
> > > @@ -489,7 +489,49 @@ static void print_mem_encrypt_feature_info(void)
> > >  	pr_cont("\n");
> > >  }
> > >  
> > > +#define TOTAL_MEM_1G	0x40000000UL
> > > +#define TOTAL_MEM_4G	0x100000000UL
> > > +
> > > +#define SIZE_128M (128UL<<20)
> > > +#define SIZE_256M (256UL<<20)
> > > +#define SIZE_512M (512UL<<20)
> > > +
> > >  /* Architecture __weak replacement functions */
> > > +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> > > +{
> > > +	unsigned long size = 0;
> > > +
> > > +	/*
> > > +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> > > +	 * SEV uses SWOTLB to make this happen without changing device
> > > +	 * drivers. However, depending on the workload being run, the
> > > +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
> > > +	 * run out of buffers for DMA, resulting in I/O errors and/or
> > > +	 * performance degradation especially with high I/O workloads.
> > > +	 * Increase the default size of SWIOTLB for SEV guests using
> > > +	 * a minimum value of 128MB and a maximum value of 512MB,
> > > +	 * depending on amount of provisioned guest memory.
> > > +	 */
> > > +	if (sev_active()) {
> > > +		phys_addr_t total_mem = memblock_phys_mem_size();
> > > +
> > > +		if (total_mem <= TOTAL_MEM_1G)
> > > +			size = clamp(iotlb_default_size * 2, SIZE_128M,
> > > +				     SIZE_128M);
> > > +		else if (total_mem <= TOTAL_MEM_4G)
> > > +			size = clamp(iotlb_default_size * 4, SIZE_256M,
> > > +				     SIZE_256M);
> > > +		else
> > > +			size = clamp(iotlb_default_size * 8, SIZE_512M,
> > > +				     SIZE_512M);
> > > +
> > > +		pr_info("SEV adjusted max SWIOTLB size = %luMB",
> > > +			size >> 20);
> > > +	}
> > > +
> > > +	return size;
> > > +}
> > > +
> > >  void __init mem_encrypt_init(void)
> > >  {
> > >  	if (!sme_me_mask)
> > > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > > index 046bb94bd4d6..01ae6d891327 100644
> > > --- a/include/linux/swiotlb.h
> > > +++ b/include/linux/swiotlb.h
> > > @@ -33,6 +33,7 @@ extern void swiotlb_init(int verbose);
> > >  int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
> > >  extern unsigned long swiotlb_nr_tbl(void);
> > >  unsigned long swiotlb_size_or_default(void);
> > > +extern void __init swiotlb_adjust(void);
> > >  extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
> > >  extern void __init swiotlb_update_mem_attributes(void);
> > >  
> > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > index c19379fabd20..66a9e627bb51 100644
> > > --- a/kernel/dma/swiotlb.c
> > > +++ b/kernel/dma/swiotlb.c
> > > @@ -163,6 +163,33 @@ unsigned long swiotlb_size_or_default(void)
> > >  	return size ? size : (IO_TLB_DEFAULT_SIZE);
> > >  }
> > >  
> > > +unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +void __init swiotlb_adjust(void)
> > > +{
> > > +	unsigned long size;
> > > +
> > > +	/*
> > > +	 * If swiotlb parameter has not been specified, give a chance to
> > > +	 * architectures such as those supporting memory encryption to
> > > +	 * adjust/expand SWIOTLB size for their use.
> > > +	 */
> > > +	if (!io_tlb_nslabs) {
> > > +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> > > +		if (size) {
> > > +			size = ALIGN(size, 1 << IO_TLB_SHIFT);
> > > +			io_tlb_nslabs = size >> IO_TLB_SHIFT;
> > > +			io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> > > +
> > > +			pr_info("architecture adjusted SWIOTLB slabs = %lu\n",
> > > +				io_tlb_nslabs);
> > > +		}
> > > +	}
> > > +}
> > > +
> > >  void swiotlb_print_info(void)
> > >  {
> > >  	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> > > -- 
> > > 2.17.1
> > > 
