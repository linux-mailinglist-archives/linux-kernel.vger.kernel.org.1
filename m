Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55BF2D3626
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 23:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbgLHWVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 17:21:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51618 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbgLHWVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 17:21:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8MJxpV044671;
        Tue, 8 Dec 2020 22:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=3/Vty7AIECOCA3XTolK6m4g5sM1npM0D4K6ushzDC54=;
 b=YsqN8ScC9P7zzCous8FFi3YGq8NX1Q2IidJid4QaEiGquuQ1ALqvxUr396JsKtmCNMGt
 eYOrbEDExfLwXaqCX56FA0sdwVl+RRHrC2XU8I5Ucotn0xjvoYWWwKhYMkYgYul4InpW
 +jGLyMx5gqW50/iQ5hRyRRYcjfH8OCpHdYqiXMJxliabNIC7ovA/dDd2aXhPTiwVg9gc
 yVFURZiJafCsIMZYzWhTistT9G9USTBvO08/jrVkGFI06NSOxeCcQZ5ZgIElaRbyEa3/
 YOtR4j9+O6u8SSmTZi471mgds53fEKq1WiLkhZmA/q0a/G7U/tHJXqC5Mq1n0rR0VJna Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3581mqw8x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 22:20:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8MGVnE063620;
        Tue, 8 Dec 2020 22:20:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 358m3ybrmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 22:20:35 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8MKWmo018662;
        Tue, 8 Dec 2020 22:20:32 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 14:20:32 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 76CA76A0121; Tue,  8 Dec 2020 17:22:20 -0500 (EST)
Date:   Tue, 8 Dec 2020 17:22:20 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     hch@lst.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@linux-intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com, Jon.Grimm@amd.com, rientjes@google.com
Subject: Re: [PATCH v8] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201208222220.GA27599@char.us.oracle.com>
References: <20201207231057.26403-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207231057.26403-1-Ashish.Kalra@amd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 11:10:57PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For SEV, all DMA to and from guest has to use shared (un-encrypted) pages.
> SEV uses SWIOTLB to make this happen without requiring changes to device
> drivers.  However, depending on workload being run, the default 64MB of
> SWIOTLB might not be enough and SWIOTLB may run out of buffers to use
> for DMA, resulting in I/O errors and/or performance degradation for
> high I/O workloads.
> 
> Adjust the default size of SWIOTLB for SEV guests using a
> percentage of the total memory available to guest for SWIOTLB buffers.
> 
> Using late_initcall() interface to invoke swiotlb_adjust() does not
> work as the size adjustment needs to be done before mem_encrypt_init()
> and reserve_crashkernel() which use the allocated SWIOTLB buffer size,
> hence call it explicitly from setup_arch().
> 
> The SWIOTLB default size adjustment needs to be added as an architecture
> specific interface/callback to allow architectures such as those supporting
> memory encryption to adjust/expand SWIOTLB size for their use.
> 
> v5 fixed build errors and warnings as
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/kernel/setup.c   |  2 ++
>  arch/x86/mm/mem_encrypt.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/swiotlb.h   |  6 ++++++
>  kernel/dma/swiotlb.c      | 22 ++++++++++++++++++++++
>  4 files changed, 67 insertions(+)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 84f581c91db4..31e24e198061 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1149,6 +1149,8 @@ void __init setup_arch(char **cmdline_p)
>  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
>  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>  
> +	swiotlb_adjust();
> +
>  	/*
>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>  	 * won't consume hotpluggable memory.
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 1bcfbcd2bfd7..d1b8d60040cf 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -485,7 +485,44 @@ static void print_mem_encrypt_feature_info(void)
>  	pr_cont("\n");
>  }
>  
> +/*
> + * The percentage of guest memory used here for SWIOTLB buffers
> + * is more of an approximation of the static adjustment which
> + * is 128M for <1G guests, 256M for 1G-4G guests and 512M for >4G guests.

No?

it is 64MB for <1G, and ~128M to 256M for 1G-to-4G

I will fix it up.
> + */
> +#define SEV_ADJUST_SWIOTLB_SIZE_PERCENT	6
> +
>  /* Architecture __weak replacement functions */
> +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> +{
> +	unsigned long size = iotlb_default_size;
> +
> +	/*
> +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> +	 * SEV uses SWOTLB to make this happen without changing device
> +	 * drivers. However, depending on the workload being run, the
> +	 * default 64MB of SWIOTLB may not be enough and`SWIOTLB may
> +	 * run out of buffers for DMA, resulting in I/O errors and/or
> +	 * performance degradation especially with high I/O workloads.
> +	 * Adjust the default size of SWIOTLB for SEV guests using
> +	 * a percentage of guest memory for SWIOTLB buffers.
> +	 * Also as the SWIOTLB bounce buffer memory is allocated
> +	 * from low memory, ensure that the adjusted size is within
> +	 * the limits of low available memory.
> +	 *
> +	 */
> +	if (sev_active()) {
> +		phys_addr_t total_mem = memblock_phys_mem_size();
> +
> +		size = total_mem * SEV_ADJUST_SWIOTLB_SIZE_PERCENT / 100;
> +		size = clamp_val(size, iotlb_default_size, SZ_1G);
> +		pr_info("SWIOTLB bounce buffer size adjusted to %luMB for SEV",
> +			size >> 20);
> +	}
> +
> +	return size;
> +}
> +
>  void __init mem_encrypt_init(void)
>  {
>  	if (!sme_me_mask)
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3bb72266a75a..b5904fa4b67c 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -33,6 +33,7 @@ extern void swiotlb_init(int verbose);
>  int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
>  extern unsigned long swiotlb_nr_tbl(void);
>  unsigned long swiotlb_size_or_default(void);
> +unsigned long __init arch_swiotlb_adjust(unsigned long size);
>  extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
>  extern int swiotlb_late_init_with_default_size(size_t default_size);
>  extern void __init swiotlb_update_mem_attributes(void);
> @@ -77,6 +78,7 @@ void __init swiotlb_exit(void);
>  unsigned int swiotlb_max_segment(void);
>  size_t swiotlb_max_mapping_size(struct device *dev);
>  bool is_swiotlb_active(void);
> +void __init swiotlb_adjust(void);
>  #else
>  #define swiotlb_force SWIOTLB_NO_FORCE
>  static inline bool is_swiotlb_buffer(phys_addr_t paddr)
> @@ -99,6 +101,10 @@ static inline bool is_swiotlb_active(void)
>  {
>  	return false;
>  }
> +
> +static inline void swiotlb_adjust(void)
> +{
> +}
>  #endif /* CONFIG_SWIOTLB */
>  
>  extern void swiotlb_print_info(void);
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 781b9dca197c..0150ca2336bc 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -163,6 +163,28 @@ unsigned long swiotlb_size_or_default(void)
>  	return size ? size : (IO_TLB_DEFAULT_SIZE);
>  }
>  
> +unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
> +{
> +	return size;
> +}
> +
> +void __init swiotlb_adjust(void)
> +{
> +	unsigned long size;
> +
> +	/*
> +	 * If swiotlb parameter has not been specified, give a chance to
> +	 * architectures such as those supporting memory encryption to
> +	 * adjust/expand SWIOTLB size for their use.
> +	 */
> +	if (!io_tlb_nslabs) {
> +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> +		size = ALIGN(size, 1 << IO_TLB_SHIFT);
> +		io_tlb_nslabs = size >> IO_TLB_SHIFT;
> +		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> +	}
> +}
> +
>  void swiotlb_print_info(void)
>  {
>  	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> -- 
> 2.17.1
> 
