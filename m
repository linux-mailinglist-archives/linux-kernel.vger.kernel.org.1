Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989E02EFEAF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 09:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbhAIIvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 03:51:51 -0500
Received: from www17.your-server.de ([213.133.104.17]:52798 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbhAIIvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:51:51 -0500
X-Greylist: delayed 1237 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jan 2021 03:51:50 EST
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www17.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <thomas@m3y3r.de>)
        id 1ky9dl-00090E-FR
        for linux-kernel@vger.kernel.org; Sat, 09 Jan 2021 09:30:29 +0100
Received: from [95.222.19.205] (helo=DESKTOP-DQBDJ0U.localdomain)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <thomas@m3y3r.de>)
        id 1ky9dl-000PpE-Ac
        for linux-kernel@vger.kernel.org; Sat, 09 Jan 2021 09:30:29 +0100
Date:   Sat, 9 Jan 2021 09:30:30 +0100
From:   Thomas Meyer <thomas@m3y3r.de>
To:     linux-kernel@vger.kernel.org
Subject: Same symbol with EXPORT_SYMBOL and EXPORT_SYMBOL_GPL
Message-ID: <20210109083030.GA5006@DESKTOP-DQBDJ0U.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26043/Fri Jan  8 13:38:18 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question regarding EXPORT_SYMBOL vs. EXPORT_SYMBOL_GPL:
I did stumble upon different export declarations between different architectures, e.g.:

$ grep -r -e "EXPORT_SYMBOL[^(]*(" * | tr ":()" "   " | sort -s -k 3 -k 2  | grep __virt_addr_valid
arch/mips/mm/mmap.c EXPORT_SYMBOL_GPL __virt_addr_valid ;
arch/x86/mm/physaddr.c EXPORT_SYMBOL __virt_addr_valid ;

Bug or feature?

Other examples are:
clk_disable	EXPORT_SYMBOL	7
clk_disable	EXPORT_SYMBOL_GPL	3
clk_enable	EXPORT_SYMBOL	7
clk_enable	EXPORT_SYMBOL_GPL	3
clk_get_parent	EXPORT_SYMBOL	4
clk_get_parent	EXPORT_SYMBOL_GPL	2
clk_get_rate	EXPORT_SYMBOL	7
clk_get_rate	EXPORT_SYMBOL_GPL	3
clk_register	EXPORT_SYMBOL	2
clk_register	EXPORT_SYMBOL_GPL	2
clk_round_rate	EXPORT_SYMBOL	6
clk_round_rate	EXPORT_SYMBOL_GPL	4
clk_set_parent	EXPORT_SYMBOL	5
clk_set_parent	EXPORT_SYMBOL_GPL	2
clk_set_rate	EXPORT_SYMBOL	6
clk_set_rate	EXPORT_SYMBOL_GPL	4
clk_unregister	EXPORT_SYMBOL	2
clk_unregister	EXPORT_SYMBOL_GPL	2
copy_user_highpage	EXPORT_SYMBOL	4
copy_user_highpage	EXPORT_SYMBOL_GPL	1
cpu_have_feature	EXPORT_SYMBOL	1
cpu_have_feature	EXPORT_SYMBOL_GPL	1
ec_read	EXPORT_SYMBOL	1
ec_read	EXPORT_SYMBOL_GPL	1
ec_write	EXPORT_SYMBOL	1
ec_write	EXPORT_SYMBOL_GPL	1
elf_hwcap	EXPORT_SYMBOL	2
elf_hwcap	EXPORT_SYMBOL_GPL	2
empty_zero_page	EXPORT_SYMBOL	26
empty_zero_page	EXPORT_SYMBOL_GPL	1
flush_icache_range	EXPORT_SYMBOL	9
flush_icache_range	EXPORT_SYMBOL_GPL	2
ioremap_uc	EXPORT_SYMBOL	1
ioremap_uc	EXPORT_SYMBOL_GPL	1
irq_of_parse_and_map	EXPORT_SYMBOL	1
irq_of_parse_and_map	EXPORT_SYMBOL_GPL	1
irq_to_desc	EXPORT_SYMBOL	1
irq_to_desc	EXPORT_SYMBOL_GPL	1
machine_power_off	EXPORT_SYMBOL	1
machine_power_off	EXPORT_SYMBOL_GPL	1
memcpy_flushcache	EXPORT_SYMBOL	1
memcpy_flushcache	EXPORT_SYMBOL_GPL	1
memstart_addr	EXPORT_SYMBOL	1
memstart_addr	EXPORT_SYMBOL_GPL	1
node_data	EXPORT_SYMBOL	7
node_data	EXPORT_SYMBOL_GPL	1
pci_domain_nr	EXPORT_SYMBOL	2
pci_domain_nr	EXPORT_SYMBOL_GPL	1
pci_iomap_wc	EXPORT_SYMBOL	1
pci_iomap_wc	EXPORT_SYMBOL_GPL	1
pci_iomap_wc_range	EXPORT_SYMBOL	1
pci_iomap_wc_range	EXPORT_SYMBOL_GPL	1
perf_num_counters	EXPORT_SYMBOL	1
perf_num_counters	EXPORT_SYMBOL_GPL	2
perf_pmu_name	EXPORT_SYMBOL	1
perf_pmu_name	EXPORT_SYMBOL_GPL	2
pm_power_off	EXPORT_SYMBOL	22
pm_power_off	EXPORT_SYMBOL_GPL	3
pv_ops	EXPORT_SYMBOL	1
pv_ops	EXPORT_SYMBOL_GPL	2
rcu_barrier	EXPORT_SYMBOL	1
rcu_barrier	EXPORT_SYMBOL_GPL	1
return_address	EXPORT_SYMBOL	1
return_address	EXPORT_SYMBOL_GPL	3
rtc_lock	EXPORT_SYMBOL	5
rtc_lock	EXPORT_SYMBOL_GPL	2
save_stack_trace	EXPORT_SYMBOL	1
save_stack_trace	EXPORT_SYMBOL_GPL	14
save_stack_trace_tsk	EXPORT_SYMBOL	1
save_stack_trace_tsk	EXPORT_SYMBOL_GPL	11
smp_call_function_single_async	EXPORT_SYMBOL	1
smp_call_function_single_async	EXPORT_SYMBOL_GPL	1
start_thread	EXPORT_SYMBOL	4
start_thread	EXPORT_SYMBOL_GPL	2
ww_mutex_lock	EXPORT_SYMBOL	1
ww_mutex_lock	EXPORT_SYMBOL_GPL	1
ww_mutex_lock_interruptible	EXPORT_SYMBOL	1
ww_mutex_lock_interruptible	EXPORT_SYMBOL_GPL	1
xen_domain_type	EXPORT_SYMBOL	1
xen_domain_type	EXPORT_SYMBOL_GPL	1
xen_start_info	EXPORT_SYMBOL	1
xen_start_info	EXPORT_SYMBOL_GPL	1

Mfg
thomas
