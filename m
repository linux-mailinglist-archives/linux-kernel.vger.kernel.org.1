Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31CD2A6B72
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgKDRLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 12:11:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:31242 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgKDRLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:11:23 -0500
IronPort-SDR: k6dLDofQDYjRes+IFeB385WpWUQCzlvwJjrOsBIRMrK+YfS1gQBOsNuycrVfE+z0xgfj/Sa7zh
 zX5m0Crd0gsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="165744424"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="165744424"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 09:11:21 -0800
IronPort-SDR: Lr/Y7zEvdicNtQ0R7ZuoI4GkU+irMwn+uc0cVR6estW0Y84IJiO1vp87beccNjvJPTJcTQ8mgY
 qoxtcVzf/Rqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="306488216"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 04 Nov 2020 09:11:21 -0800
Received: from [10.251.0.36] (kliang2-MOBL.ccr.corp.intel.com [10.251.0.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0CFE25805EC;
        Wed,  4 Nov 2020 09:11:18 -0800 (PST)
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <877drz1qbc.fsf@mpe.ellerman.id.au> <20201012084829.GA1151@willie-the-truck>
 <de47984b-9a69-733c-3bd1-7b24ceb9b7f0@linux.intel.com>
 <20201013154615.GE2594@hirez.programming.kicks-ass.net>
 <20201013163449.GR2651@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8e88ba79-7c40-ea32-a7ed-bdc4fc04b2af@linux.intel.com>
Date:   Wed, 4 Nov 2020 12:11:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201013163449.GR2651@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2020 12:34 PM, Peter Zijlstra wrote:
> Subject: perf,mm: Handle non-page-table-aligned hugetlbfs
> From: Peter Zijlstra<peterz@infradead.org>
> Date: Fri, 9 Oct 2020 11:09:27 +0200
> 
> A limited nunmber of architectures support hugetlbfs sizes that do not
> align with the page-tables (ARM64, Power, Sparc64). Add support for
> this to the generic perf_get_page_size() implementation, and also
> allow an architecture to override this implementation.
> 
> This latter is only needed when it uses non-page-table aligned huge
> pages in its kernel map.
> 
> Signed-off-by: Peter Zijlstra (Intel)<peterz@infradead.org>
> ---
>   kernel/events/core.c |   39 +++++++++++++++++++++++++++++++++------
>   1 file changed, 33 insertions(+), 6 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6996,10 +6996,18 @@ static u64 perf_virt_to_phys(u64 virt)
>   #ifdef CONFIG_MMU
>   
>   /*
> - * Return the MMU page size of a given virtual address
> + * Return the MMU page size of a given virtual address.
> + *
> + * This generic implementation handles page-table aligned huge pages, as well
> + * as non-page-table aligned hugetlbfs compound pages.
> + *
> + * If an architecture supports and uses non-page-table aligned pages in their
> + * kernel mapping it will need to provide it's own implementation of this
> + * function.
>    */
> -static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
> +__weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr)
>   {
> +	struct page *page;
>   	pgd_t *pgd;
>   	p4d_t *p4d;
>   	pud_t *pud;
> @@ -7021,15 +7029,27 @@ static u64 __perf_get_page_size(struct m
>   	if (!pud_present(*pud))
>   		return 0;
>   
> -	if (pud_leaf(*pud))
> +	if (pud_leaf(*pud)) {
> +#ifdef pud_page
> +		page = pud_page(*pud);
> +		if (PageHuge(page))
> +			return page_size(compound_head(page));
> +#endif
>   		return 1ULL << PUD_SHIFT;
> +	}
>   
>   	pmd = pmd_offset(pud, addr);
>   	if (!pmd_present(*pmd))
>   		return 0;
>   
> -	if (pmd_leaf(*pmd))
> +	if (pmd_leaf(*pmd)) {
> +#ifdef pmd_page
> +		page = pmd_page(*pmd);
> +		if (PageHuge(page))
> +			return page_size(compound_head(page));
> +#endif
>   		return 1ULL << PMD_SHIFT;
> +	}
>   
>   	pte = pte_offset_map(pmd, addr);
>   	if (!pte_present(*pte)) {
> @@ -7037,13 +7057,20 @@ static u64 __perf_get_page_size(struct m
>   		return 0;
>   	}
>   
> +	page = pte_page(*pte);
> +	if (PageHuge(page)) {
> +		u64 size = page_size(compound_head(page));
> +		pte_unmap(pte);
> +		return size;
> +	}
> +

The PageHuge() check for PTE crashes my machine when I did page size 
test. (Sorry, I didn't find the issue earlier. I just found some time to 
re-run the page size test.)

It seems we don't need the check for PTE here. The size should be always 
PAGE_SIZE, no? After I remove the check, everything looks good.

Thanks,
Kan

[  167.383120] BUG: unable to handle page fault for address: 
fffffca803fb8000
[  167.383121] #PF: supervisor read access in kernel mode
[  167.383121] #PF: error_code(0x0000) - not-present page
[  167.383121] PGD 4adfc8067 P4D 4adfc8067 PUD 4adfc7067 PMD 0
[  167.383122] Oops: 0000 [#1] SMP NOPTI
[  167.383122] CPU: 0 PID: 2461 Comm: perf Not tainted 
5.10.0-rc1_page_size+ #54
[  167.383123] Hardware name: Intel Corporation Ice Lake Client 
Platform/IceLake U DDR4 SODIMM PD RVP TLC, BIOS 
ICLSFWR1.R00.3162.A00.1904162000 04/16/2019
[  167.383123] traps: PANIC: double fault, error_code: 0x0
[  167.383123] double fault: 0000 [#2] SMP NOPTI
[  167.383123] CPU: 0 PID: 2461 Comm: perf Not tainted 
5.10.0-rc1_page_size+ #54
[  167.383124] Hardware name: Intel Corporation Ice Lake Client 
Platform/IceLake U DDR4 SODIMM PD RVP TLC, BIOS 
ICLSFWR1.R00.3162.A00.1904162000 04/16/2019
[  167.383124] RIP: 0010:__sprint_symbol+0xb/0x100
[  167.383124] Code: 85 e4 75 b9 48 85 c0 75 bc 49 89 d8 4c 89 e1 4c 89 
fa 4c 89 f6 4c 89 ef e8 42 70 04 00 eb a6 0f 1f 44 00 00 55 48 89 e5 41 
57 <41> 56 49 89 f6 41 55 41 89 cd 48 8d 4d b8 41 54 49 89 fc 53 48 63
[  167.383125] RSP: 0018:fffffe000000b000 EFLAGS: 00010046
[  167.383125] RAX: 0000000000000053 RBX: 00000000ffff0a00 RCX: 
0000000000000001
[  167.383125] RDX: 0000000000000000 RSI: ffffffff9f8a6176 RDI: 
fffffe000000b029
[  167.383126] RBP: fffffe000000b008 R08: ffffffffa0bf8661 R09: 
0000000000000001
[  167.383126] R10: 000000000000000f R11: ffff9e641dc189c8 R12: 
ffff9e641dc189c9
[  167.383126] R13: ffff9e641dc1a7e0 R14: ffff0a00ffffff05 R15: 
fffffe000000b029
[  167.383126] FS:  0000000000000000(0000) GS:ffff9e641dc00000(0000) 
knlGS:0000000000000000
[  167.383127] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  167.383127] CR2: fffffe000000aff8 CR3: 000000014a0ba004 CR4: 
0000000000770ef0
[  167.383127] PKRU: 55555554
[  167.383127] Call Trace:
[  167.383127]  <NMI>
[  167.383128]  sprint_symbol+0x15/0x20
[  167.383128]  symbol_string+0x49/0x90
[  167.383128]  pointer+0x118/0x3e0
[  167.383128]  vsnprintf+0x1ec/0x4e0
[  167.383128]  vscnprintf+0xd/0x30
[  167.383129]  printk_safe_log_store+0x65/0xe0
[  167.383129]  vprintk_func+0x8d/0x100
[  167.383129]  printk+0x58/0x6f
[  167.383129]  ? PageHuge+0x6/0x40
[  167.383129]  show_ip+0x2c/0x3d
[  167.383130]  show_iret_regs+0x17/0x40
[  167.383130]  __show_regs+0x27/0x40
[  167.383130]  ? dump_stack_print_info+0x9e/0xb0
[  167.383130]  show_regs+0x3b/0x50
[  167.383130]  __die_body+0x20/0x70
[  167.383131]  __die+0x2b/0x33
[  167.383131]  no_context+0x152/0x350
[  167.383131]  __bad_area_nosemaphore+0x50/0x160
[  167.383131]  bad_area_nosemaphore+0x16/0x20
[  167.383131]  do_kern_addr_fault+0x62/0x70
[  167.383132]  exc_page_fault+0xcd/0x150
[  167.383132]  asm_exc_page_fault+0x1e/0x30
[  167.383132] RIP: 0010:PageHuge+0x6/0x40
[  167.383132] Code: c8 48 89 0e 48 39 47 08 48 0f 46 47 08 48 89 02 c3 
0f 1f 00 55 be 00 04 00 00 48 89 e5 e8 72 90 2a 00 5d c3 0f 1f 44 00 00 
55 <48> 8b 07 48 89 e5 a9 00 00 01 00 75 09 48 8b 47 08 83 e0 01 74 17
[  167.383133] RSP: 0018:fffffe000000b5c0 EFLAGS: 00010086
[  167.383133] RAX: 00000000fee0017b RBX: fffffca803fb8000 RCX: 
0000000000000000
[  167.383133] RDX: 7fffffff011ffe84 RSI: ffff9e635b614fe8 RDI: 
fffffca803fb8000
[  167.383134] RBP: fffffe000000b5d8 R08: 000fffffc0000000 R09: 
000000000000000d
[  167.383134] R10: 0000000000000001 R11: 00000000000011da R12: 
000000000048c14f
[  167.383134] R13: fffffe000000b8c0 R14: ffff9e60955aa800 R15: 
ffffffffff5fd340
[  167.383134]  ? arch_perf_get_page_size+0x2e4/0x330
[  167.383135]  perf_get_page_size.part.0+0x3c/0x50
[  167.383135]  perf_prepare_sample+0x1cc/0x740
[  167.383135]  perf_event_output_forward+0x30/0x90
[  167.383135]  ? sched_clock+0x9/0x10
[  167.383135]  ? __perf_event_account_interrupt+0xcc/0xe0
[  167.383136]  __perf_event_overflow+0x57/0xf0
[  167.383136]  perf_event_overflow+0x14/0x20
[  167.383136]  __intel_pmu_pebs_event+0x2a8/0x3a0
[  167.383136]  ? get_data_src.isra.0+0xc0/0xc0
[  167.383136]  ? perf_event_stop+0xa0/0xa0
[  167.383137]  ? native_apic_mem_write+0x2/0x10
[  167.383137]  ? native_apic_mem_write+0x2/0x10
[  167.383137]  intel_pmu_drain_pebs_icl+0x1bf/0x1f0
[  167.383137]  ? get_data_src.isra.0+0xc0/0xc0
[  167.383137]  handle_pmi_common+0xb6/0x2a0
[  167.383138]  intel_pmu_handle_irq+0xca/0x170
[  167.383138]  perf_event_nmi_handler+0x2d/0x50
[  167.383138]  nmi_handle+0x5d/0x100
[  167.383138]  default_do_nmi+0x45/0x110
[  167.383138]  exc_nmi+0x15a/0x1a0
[  167.383139]  end_repeat_nmi+0x16/0x55
[  167.383139] RIP: 0010:perf_iterate_ctx+0x0/0x170
[  167.383139] Code: b0 95 01 41 89 c5 72 d9 48 c7 c7 40 a0 fb a0 e8 16 
47 b8 00 b8 f4 ff ff ff e9 cb fe ff ff 66 90 66 2e 0f 1f 84 00 00 00 00 
00 <55> 48 89 e5 41 57 41 56 41 55 41 54 4c 8d 67 60 53 48 83 ec 08 48
[  167.383140] RSP: 0018:ffffb51d01907ca8 EFLAGS: 00000246
[  167.383140] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000001
[  167.383140] RDX: 0000000000000000 RSI: ffffffff9f815460 RDI: 
ffff9e60c5423500
[  167.383140] RBP: ffffb51d01907d08 R08: 00000026f8cdcae0 R09: 
0000000000000021
[  167.383141] R10: 0000000000000000 R11: ffff9e641dc11ec8 R12: 
0000000000000000
[  167.383141] R13: ffff9e641dc33300 R14: ffff9e60aaf69e00 R15: 
ffff9e60c5423500
[  167.383141]  ? perf_event_stop+0xa0/0xa0
[  167.383141]  ? perf_swevent_init+0x190/0x190
[  167.383142]  ? perf_swevent_init+0x190/0x190
[  167.383142]  </NMI>
[  167.383142]  ? perf_event_exec+0x1ca/0x210
[  167.383142]  begin_new_exec+0x5ba/0x980
[  167.383142]  load_elf_binary+0x6ae/0x17a0
[  167.383143]  ? __kernel_read+0x1a0/0x2d0
[  167.383143]  ? __kernel_read+0x1a0/0x2d0
[  167.383143]  bprm_execve+0x2f6/0x660
[  167.383143]  do_execveat_common.isra.0+0x189/0x1c0
[  167.383143]  __x64_sys_execve+0x37/0x50
[  167.383144]  do_syscall_64+0x38/0x90
[  167.383144]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  167.383144] RIP: 0033:0x7f2c347dae97
[  167.383144] Code: Unable to access opcode bytes at RIP 0x7f2c347dae6d.
[  167.383144] RSP: 002b:00007ffe73f584a8 EFLAGS: 00000202 ORIG_RAX: 
000000000000003b
[  167.383145] RAX: ffffffffffffffda RBX: 00005625a990cd70 RCX: 
00007f2c347dae97
[  167.383145] RDX: 00005625a990caf0 RSI: 00005625a990cd70 RDI: 
00007ffe73f6069f
[  167.383145] RBP: 00007ffe73f58540 R08: 00007ffe73f584a0 R09: 
00007f2c368502b0
[  167.383146] R10: 0000000000000016 R11: 0000000000000202 R12: 
00005625a990caf0
[  167.383146] R13: 00005625a8c06870 R14: 0000000000000000 R15: 
00007ffe73f6069f
[  167.383146] Modules linked in: snd_hda_codec_hdmi 
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio 
nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype 
br_netfilter xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c 
ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter 
ebtables ip6table_filter ip6_tables iptable_filter overlay bnep 
hid_sensor_magn_3d hid_sensor_gyro_3d hid_sensor_als hid_sensor_accel_3d 
hid_sensor_rotation hid_sensor_incl_3d hid_sensor_trigger 
industrialio_triggered_buffer kfifo_buf hid_sensor_iio_common 
industrialio hid_sensor_custom hid_sensor_hub intel_ishtp_hid 
binfmt_misc spi_pxa2xx_platform dw_dmac dw_dmac_core 8250_dw mei_hdcp 
i2c_designware_platform i2c_designware_core intel_rapl_msr wmi_bmof 
intl_wmi_thunderbolt x86_pkg_temp_thermal snd_hda_intel intel_powerclamp 
coretemp snd_intel_dspcfg nls_iso8859_1 snd_hda_codec kvm_intel 
snd_hda_core snd_hwdep kvm
[  167.383158]  snd_pcm irqbypass snd_seq_midi crct10dif_pclmul 
crc32_pclmul ghash_clmulni_intel snd_seq_midi_event snd_rawmidi 
aesni_intel crypto_simd cryptd snd_seq glue_helper rapl snd_seq_device 
intel_cstate snd_timer ofpart cmdlinepart intel_spi_pci snd e1000e 
intel_spi spi_nor soundcore mtd iwlmvm mei_me mei mac80211 libarc4 
iwlwifi intel_lpss_pci intel_lpss cfg80211 asix usbnet mii joydev btusb 
btrtl btbcm btintel bluetooth ecdh_generic ecc intel_ish_ipc 
processor_thermal_device intel_ishtp intel_rapl_common 
int340x_thermal_zone thunderbolt intel_soc_dts_iosf ucsi_acpi typec_ucsi 
typec wmi intel_hid int3400_thermal sparse_keymap acpi_pad 
acpi_thermal_rel acpi_tad sch_fq_codel parport_pc ppdev lp parport 
ip_tables x_tables hid_generic usbhid hid input_leds serio_raw mac_hid 
pinctrl_icelake
[  168.121417] ---[ end trace 7f4c6d2d09e5e90f ]---
[  168.121417] RIP: 0010:PageHuge+0x6/0x40
[  168.121417] ode: c8 48 89 0e 48 39 47 08 48 0f 46 47 08 48 89 02 c3 
0f 1f 00 55 be 00 04 00 00 48 89 e5 e8 72 90 2a 00 5d c3 0f 1f 44 00 00 
55 <48> 8b 07 48 89 e5 a9 00 00 01 00 75 09 48 8b 47 08 83 e0 01 74 17
[  168.121418] RSP: 0018:fffffe000000b5c0 EFLAGS: 00010086
[  168.121418] RAX: 00000000fee0017b RBX: fffffca803fb8000 RCX: 
0000000000000000
[  168.121419] RDX: 7fffffff011ffe84 RSI: ffff9e635b614fe8 RDI: 
fffffca803fb8000
[  168.121419] RBP: fffffe000000b5d8 R08: 000fffffc0000000 R09: 
000000000000000d
[  168.121419] R10: 0000000000000001 R11: 00000000000011da R12: 
000000000048c14f
[  168.121419] R13: fffffe000000b8c0 R14: ffff9e60955aa800 R15: 
ffffffffff5fd340
[  168.121420] FS:  0000000000000000(0000) GS:ffff9e641dc00000(0000) 
knlGS:0000000000000000
[  168.121420] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.121420] CR2: 00007f2c347dae6d CR3: 000000014a0ba004 CR4: 
0000000000770ef0
[  168.121420] PKRU: 55555554
[  168.121421] Kernel panic - not syncing: Fatal exception in interrupt
[  168.121520] Kernel Offset: 0x1e600000 from 0xffffffff81000000 
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
