Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF67B2AAFCD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 04:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgKIDPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 22:15:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:15296 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729092AbgKIDPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 22:15:18 -0500
IronPort-SDR: bLdrxsvohg4w4o6brnU0/0Hm2LxJW2et1A570O9W3CSqqtZA1R9ilZN+CK+hfKbeOqmwtlQ7qO
 o7a64699XvSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="168960554"
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="scan'208";a="168960554"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2020 19:15:17 -0800
IronPort-SDR: BQ6faZthxtz9NEKFYN02lfH9pzHFOpSiZswcFpSFStqw/05RK49JnfwRcpUnepgs1gl8CKXjiw
 SD4plW6brfuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="scan'208";a="427854948"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2020 19:15:14 -0800
Cc:     baolu.lu@linux.intel.com, ning.sun@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, jroedel@suse.de, tboot-devel@lists.sourceforge.net,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/vt-d: avoid unnecessory panic if iommu init fail in
 tboot
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201104081438.2075-1-zhenzhong.duan@gmail.com>
 <CAFH1YnMoNJZUJr-duEvzOMzeX0sXgE41T_A6HA+2oAU8WC=ktg@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9e5e5f48-e91d-adce-cbf5-b98fee3b56a6@linux.intel.com>
Date:   Mon, 9 Nov 2020 11:08:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFH1YnMoNJZUJr-duEvzOMzeX0sXgE41T_A6HA+2oAU8WC=ktg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenzhong,

On 11/9/20 10:27 AM, Zhenzhong Duan wrote:
> +intel iommu maintainers,
> 
> Can anyone help review this patch? Thanks
> 
> Zhenzhong
> 
> On Wed, Nov 4, 2020 at 4:15 PM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
>>
>> "intel_iommu=off" command line is used to disable iommu and iommu is force
>> enabled in a tboot system. Meanwhile "intel_iommu=tboot_noforce,off"
>> could be used to force disable iommu in tboot for better performance.
>>
>> By default kernel should panic if iommu init fail in tboot for security
>> reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".
>>
>> Fix it by return 0 in tboot_force_iommu() so that force_on is not set.
>>
>> Fixes: 7304e8f28bb2 ("iommu/vt-d: Correctly disable Intel IOMMU force on")
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
>> ---
>>   arch/x86/kernel/tboot.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
>> index 992fb1415c0f..9fd4d162b331 100644
>> --- a/arch/x86/kernel/tboot.c
>> +++ b/arch/x86/kernel/tboot.c
>> @@ -511,12 +511,9 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
>>
>>   int tboot_force_iommu(void)
>>   {
>> -       if (!tboot_enabled())
>> +       if (!tboot_enabled() || intel_iommu_tboot_noforce)
>>                  return 0;
>>
>> -       if (intel_iommu_tboot_noforce)
>> -               return 1;

This was obviously wrong. It should return false, right?

It looks odd that intel_iommu_tboot_noforce is defined in Intel iommu
implementation, but is used here. How about moving it back to the iommu
driver?

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 992fb1415c0f..420be871d9d4 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -514,9 +514,6 @@ int tboot_force_iommu(void)
         if (!tboot_enabled())
                 return 0;

-       if (intel_iommu_tboot_noforce)
-               return 1;
-
         if (no_iommu || swiotlb || dmar_disabled)
                 pr_warn("Forcing Intel-IOMMU to enabled\n");

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a41f9f13cc86..ba90eb4325d0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -179,7 +179,7 @@ static int rwbf_quirk;
   * (used when kernel is launched w/ TXT)
   */
  static int force_on = 0;
-int intel_iommu_tboot_noforce;
+static int intel_iommu_tboot_noforce;
  static int no_platform_optin;

  #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
@@ -4212,7 +4212,8 @@ int __init intel_iommu_init(void)
          * Intel IOMMU is required for a TXT/tboot launch or platform
          * opt in, so enforce that.
          */
-       force_on = tboot_force_iommu() || platform_optin_force_iommu();
+       force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
+                       platform_optin_force_iommu();

         if (iommu_init_mempool()) {
                 if (force_on)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fbf5b3e7707e..d956987ed032 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -798,7 +798,6 @@ extern int iommu_calculate_agaw(struct intel_iommu 
*iommu);
  extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
  extern int dmar_disabled;
  extern int intel_iommu_enabled;
-extern int intel_iommu_tboot_noforce;
  extern int intel_iommu_gfx_mapped;
  #else
  static inline int iommu_calculate_agaw(struct intel_iommu *iommu)

>> -
>>          if (no_iommu || swiotlb || dmar_disabled)
>>                  pr_warn("Forcing Intel-IOMMU to enabled\n");
>>
>> --
>> 2.25.1
>>

Best regards,
baolu
