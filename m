Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D8A2F8A11
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbhAPAu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbhAPAu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:50:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7076C061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=gs9bS3Un6NrEIb6//P3MiYZp4NSHr8IQYQHiXaj08Pk=; b=Yr6uq8ZPx7Kyzke8cqH2hb+fuf
        Q2gIIRPafwwz2CtdKI9bOE9HGv5VEW0GaKYZLKWKDNs6Lt+DT2erRnh9uKI6JPBqwUntJZYSnHSRQ
        iVMRlpdBYX6+OBKgXafyzEUKbAz6PWFrU8lo0N8BtkBCSdui1AaHuBq9zATm7CqygcjCRRlPSMU62
        m5wq6egrQ96j3mmLfpfhm11ROa2u4Tc42OIEOmSm4GGCPz4p7P7wRyHoKGQ2qfz8XSJYoKBqpcspt
        1/1ClTE5iWyABUQ1dBdkyB6xfvWu9mjqTqNsEhodXlqazntvH00l/SkVXPp4ZPdBLposSw7mC9iFR
        LihTN+nA==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0Zn1-00016Q-CN; Sat, 16 Jan 2021 00:50:04 +0000
Subject: Re: [PATCH] fTPM: make sure TEE is initialized before fTPM
To:     Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Cc:     tyhicks@linux.microsoft.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Gromm <christian.gromm@microchip.com>
References: <20210116001301.16861-1-wei.liu@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b9d69278-9f69-041f-9cef-58584eac435c@infradead.org>
Date:   Fri, 15 Jan 2021 16:49:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210116001301.16861-1-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/15/21 4:12 PM, Wei Liu wrote:
> For built-in drivers, the order of initialization function invocation is
> determined by their link order.
> 
> The original code linked TPM drivers before TEE driver when they were
> both built in. That caused fTPM's initialization to be deferred to a
> worker thread instead of running on PID 1.
> 
> That is problematic because IMA's initialization routine, which runs on
> PID 1 as a late initcall, needs to have access to the default TPM
> instance. If fTPM's initialization is deferred, IMA will not be able to
> get hold of a TPM instance in time.
> 
> Fix this by modifying Makefile to make sure TEE is initialized before
> fTPM when they are both built in.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index fd11b9ac4cc3..45ea5ec9d0fd 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -180,6 +180,11 @@ obj-$(CONFIG_NVMEM)		+= nvmem/
>  obj-$(CONFIG_FPGA)		+= fpga/
>  obj-$(CONFIG_FSI)		+= fsi/
>  obj-$(CONFIG_TEE)		+= tee/
> +
> +# TPM drivers must come after TEE, otherwise fTPM initialization will be
> +# deferred, which causes IMA to not get a TPM device in time
> +obj-$(CONFIG_TCG_TPM)		+= char/tpm/
> +
>  obj-$(CONFIG_MULTIPLEXER)	+= mux/
>  obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
>  obj-$(CONFIG_SIOX)		+= siox/
> 

As I suspected and then tested, since you did not remove the other build
of char/tpm/, this ends up with multiple definition linker errors (below).

I would think that instead of depending on Makefile order you should use different
initcall levels as needed. Depending on Makefile order is what we did 15 years ago.


ld: drivers/char/tpm/tpm-chip.o:(.data+0xa0): multiple definition of `dev_nums_idr'; drivers/char/tpm/tpm-chip.o:(.data+0xa0): first defined here
ld: drivers/char/tpm/tpm-chip.o: in function `tpm_chip_start':
tpm-chip.c:(.text+0x119): multiple definition of `tpm_chip_start'; drivers/char/tpm/tpm-chip.o:tpm-chip.c:(.text+0x119): first defined here
ld: drivers/char/tpm/tpm-chip.o: in function `tpm_chip_stop':
tpm-chip.c:(.text+0x19d): multiple definition of `tpm_chip_stop'; drivers/char/tpm/tpm-chip.o:tpm-chip.c:(.text+0x19d): first defined here
ld: drivers/char/tpm/tpm-chip.o: in function `tpm_try_get_ops':
tpm-chip.c:(.text+0x217): multiple definition of `tpm_try_get_ops'; drivers/char/tpm/tpm-chip.o:tpm-chip.c:(.text+0x217): first defined here
ld: drivers/char/tpm/tpm-chip.o: in function `tpm_put_ops':
tpm-chip.c:(.text+0x285): multiple definition of `tpm_put_ops'; drivers/char/tpm/tpm-chip.o:tpm-chip.c:(.text+0x285): first defined here
ld: drivers/char/tpm/tpm-chip.o: in function `tpm_default_chip':
tpm-chip.c:(.text+0x2af): multiple definition of `tpm_default_chip'; drivers/char/tpm/tpm-chip.o:tpm-chip.c:(.text+0x2af): first defined here
ld: drivers/char/tpm/tpm-chip.o: in function `tpm_find_get_ops':
tpm-chip.c:(.text+0x308): multiple definition of `tpm_find_get_ops'; drivers/char/tpm/tpm-chip.o:tpm-chip.c:(.text+0x308): first defined here
ld: drivers/char/tpm/tpm-chip.o: in function `tpm_chip_alloc':
tpm-chip.c:(.text+0x348): multiple definition of `tpm_chip_alloc'; drivers/char/tpm/tpm-chip.o:tpm-chip.c:(.text+0x348): first defined here
ld: drivers/char/tpm/tpm-chip.o:(.bss+0x10): multiple definition of `tpm_class'; drivers/char/tpm/tpm-chip.o:(.bss+0x10): first defined here
ld: drivers/char/tpm/tpm-chip.o:(.bss+0x8): multiple definition of `tpmrm_class'; drivers/char/tpm/tpm-chip.o:(.bss+0x8): first defined here
ld: drivers/char/tpm/tpm-chip.o:(.bss+0x0): multiple definition of `tpm_devt'; drivers/char/tpm/tpm-chip.o:(.bss+0x0): first defined here
ld: drivers/char/tpm/tpm-chip.o: in function `tpmm_chip_alloc':
tpm-chip.c:(.text+0x582): multiple definition of `tpmm_chip_alloc'; drivers/char/tpm/tpm-chip.o:tpm-chip.c:(.text+0x582): first defined here
ld: drivers/char/tpm/tpm-chip.o: in function `tpm_chip_unregister':
tpm-chip.c:(.text+0x5cb): multiple definition of `tpm_chip_unregister'; drivers/char/tpm/tpm-chip.o:tpm-chip.c:(.text+0x5cb): first defined here
ld: drivers/char/tpm/tpm-chip.o: in function `tpm_chip_register':
tpm-chip.c:(.text+0x697): multiple definition of `tpm_chip_register'; drivers/char/tpm/tpm-chip.o:tpm-chip.c:(.text+0x697): first defined here
ld: drivers/char/tpm/tpm-dev-common.o: in function `tpm_common_open':
tpm-dev-common.c:(.text+0x1be): multiple definition of `tpm_common_open'; drivers/char/tpm/tpm-dev-common.o:tpm-dev-common.c:(.text+0x1be): first defined here
ld: drivers/char/tpm/tpm-dev-common.o: in function `tpm_common_read':
tpm-dev-common.c:(.text+0x2d3): multiple definition of `tpm_common_read'; drivers/char/tpm/tpm-dev-common.o:tpm-dev-common.c:(.text+0x2d3): first defined here
ld: drivers/char/tpm/tpm-dev-common.o: in function `tpm_common_write':
tpm-dev-common.c:(.text+0x3e5): multiple definition of `tpm_common_write'; drivers/char/tpm/tpm-dev-common.o:tpm-dev-common.c:(.text+0x3e5): first defined here
ld: drivers/char/tpm/tpm-dev-common.o: in function `tpm_common_poll':
tpm-dev-common.c:(.text+0x56b): multiple definition of `tpm_common_poll'; drivers/char/tpm/tpm-dev-common.o:tpm-dev-common.c:(.text+0x56b): first defined here
ld: drivers/char/tpm/tpm-dev-common.o: in function `tpm_common_release':
tpm-dev-common.c:(.text+0x5c4): multiple definition of `tpm_common_release'; drivers/char/tpm/tpm-dev-common.o:tpm-dev-common.c:(.text+0x5c4): first defined here
ld: drivers/char/tpm/tpm-dev-common.o: in function `tpm_dev_common_init':
tpm-dev-common.c:(.init.text+0x0): multiple definition of `tpm_dev_common_init'; drivers/char/tpm/tpm-dev-common.o:tpm-dev-common.c:(.init.text+0x0): first defined here
ld: drivers/char/tpm/tpm-dev-common.o: in function `tpm_dev_common_exit':
tpm-dev-common.c:(.exit.text+0x0): multiple definition of `tpm_dev_common_exit'; drivers/char/tpm/tpm-dev-common.o:tpm-dev-common.c:(.exit.text+0x0): first defined here
ld: drivers/char/tpm/tpm-dev.o:(.rodata+0x0): multiple definition of `tpm_fops'; drivers/char/tpm/tpm-dev.o:(.rodata+0x0): first defined here
ld: drivers/char/tpm/tpm-interface.o: in function `tpm_calc_ordinal_duration':
tpm-interface.c:(.text+0x0): multiple definition of `tpm_calc_ordinal_duration'; drivers/char/tpm/tpm-interface.o:tpm-interface.c:(.text+0x0): first defined here
ld: drivers/char/tpm/tpm-interface.o: in function `tpm_transmit':
tpm-interface.c:(.text+0x13): multiple definition of `tpm_transmit'; drivers/char/tpm/tpm-interface.o:tpm-interface.c:(.text+0x13): first defined here
ld: drivers/char/tpm/tpm-interface.o: in function `tpm_transmit_cmd':
tpm-interface.c:(.text+0x2bc): multiple definition of `tpm_transmit_cmd'; drivers/char/tpm/tpm-interface.o:tpm-interface.c:(.text+0x2bc): first defined here
ld: drivers/char/tpm/tpm-interface.o: in function `tpm_get_timeouts':
tpm-interface.c:(.text+0x33a): multiple definition of `tpm_get_timeouts'; drivers/char/tpm/tpm-interface.o:tpm-interface.c:(.text+0x33a): first defined here
ld: drivers/char/tpm/tpm-interface.o: in function `tpm_is_tpm2':
tpm-interface.c:(.text+0x355): multiple definition of `tpm_is_tpm2'; drivers/char/tpm/tpm-interface.o:tpm-interface.c:(.text+0x355): first defined here
ld: drivers/char/tpm/tpm-interface.o: in function `tpm_pcr_read':
tpm-interface.c:(.text+0x37c): multiple definition of `tpm_pcr_read'; drivers/char/tpm/tpm-interface.o:tpm-interface.c:(.text+0x37c): first defined here
ld: drivers/char/tpm/tpm-interface.o: in function `tpm_pcr_extend':
tpm-interface.c:(.text+0x3d8): multiple definition of `tpm_pcr_extend'; drivers/char/tpm/tpm-interface.o:tpm-interface.c:(.text+0x3d8): first defined here
ld: drivers/char/tpm/tpm-interface.o: in function `tpm_send':
tpm-interface.c:(.text+0x46c): multiple definition of `tpm_send'; drivers/char/tpm/tpm-interface.o:tpm-interface.c:(.text+0x46c): first defined here
ld: drivers/char/tpm/tpm-interface.o: in function `tpm_auto_startup':
tpm-interface.c:(.text+0x4b9): multiple definition of `tpm_auto_startup'; drivers/char/tpm/tpm-interface.o:tpm-interface.c:(.text+0x4b9): first defined here
ld: drivers/char/tpm/tpm-interface.o: in function `tpm_pm_suspend':
tpm-interface.c:(.text+0x4db): multiple definition of `tpm_pm_suspend'; drivers/char/tpm/tpm-interface.o:tpm-interface.c:(.text+0x4db): first defined here
ld: drivers/char/tpm/tpm-interface.o: in function `tpm_pm_resume':
tpm-interface.c:(.text+0x553): multiple definition of `tpm_pm_resume'; drivers/char/tpm/tpm-interface.o:tpm-interface.c:(.text+0x553): first defined here
ld: drivers/char/tpm/tpm-interface.o: in function `tpm_get_random':
tpm-interface.c:(.text+0x55e): multiple definition of `tpm_get_random'; drivers/char/tpm/tpm-interface.o:tpm-interface.c:(.text+0x55e): first defined here
ld: drivers/char/tpm/tpm1-cmd.o: in function `tpm1_calc_ordinal_duration':
tpm1-cmd.c:(.text+0x98): multiple definition of `tpm1_calc_ordinal_duration'; drivers/char/tpm/tpm1-cmd.o:tpm1-cmd.c:(.text+0x98): first defined here
ld: drivers/char/tpm/tpm1-cmd.o: in function `tpm1_pcr_extend':
tpm1-cmd.c:(.text+0xc3): multiple definition of `tpm1_pcr_extend'; drivers/char/tpm/tpm1-cmd.o:tpm1-cmd.c:(.text+0xc3): first defined here
ld: drivers/char/tpm/tpm1-cmd.o: in function `tpm1_getcap':
tpm1-cmd.c:(.text+0x13d): multiple definition of `tpm1_getcap'; drivers/char/tpm/tpm1-cmd.o:tpm1-cmd.c:(.text+0x13d): first defined here
ld: drivers/char/tpm/tpm1-cmd.o: in function `tpm1_get_timeouts':
tpm1-cmd.c:(.text+0x200): multiple definition of `tpm1_get_timeouts'; drivers/char/tpm/tpm1-cmd.o:tpm1-cmd.c:(.text+0x200): first defined here
ld: drivers/char/tpm/tpm1-cmd.o: in function `tpm1_get_random':
tpm1-cmd.c:(.text+0x58b): multiple definition of `tpm1_get_random'; drivers/char/tpm/tpm1-cmd.o:tpm1-cmd.c:(.text+0x58b): first defined here
ld: drivers/char/tpm/tpm1-cmd.o: in function `tpm1_pcr_read':
tpm1-cmd.c:(.text+0x695): multiple definition of `tpm1_pcr_read'; drivers/char/tpm/tpm1-cmd.o:tpm1-cmd.c:(.text+0x695): first defined here
ld: drivers/char/tpm/tpm1-cmd.o: in function `tpm1_do_selftest':
tpm1-cmd.c:(.text+0x71c): multiple definition of `tpm1_do_selftest'; drivers/char/tpm/tpm1-cmd.o:tpm1-cmd.c:(.text+0x71c): first defined here
ld: drivers/char/tpm/tpm1-cmd.o: in function `tpm1_auto_startup':
tpm1-cmd.c:(.text+0x836): multiple definition of `tpm1_auto_startup'; drivers/char/tpm/tpm1-cmd.o:tpm1-cmd.c:(.text+0x836): first defined here
ld: drivers/char/tpm/tpm1-cmd.o: in function `tpm1_pm_suspend':
tpm1-cmd.c:(.text+0x873): multiple definition of `tpm1_pm_suspend'; drivers/char/tpm/tpm1-cmd.o:tpm1-cmd.c:(.text+0x873): first defined here
ld: drivers/char/tpm/tpm1-cmd.o: in function `tpm1_get_pcr_allocation':
tpm1-cmd.c:(.text+0x94b): multiple definition of `tpm1_get_pcr_allocation'; drivers/char/tpm/tpm1-cmd.o:tpm1-cmd.c:(.text+0x94b): first defined here
ld: drivers/char/tpm/tpm2-cmd.o: in function `tpm2_get_timeouts':
tpm2-cmd.c:(.text+0x157): multiple definition of `tpm2_get_timeouts'; drivers/char/tpm/tpm2-cmd.o:tpm2-cmd.c:(.text+0x157): first defined here
ld: drivers/char/tpm/tpm2-cmd.o: in function `tpm2_calc_ordinal_duration':
tpm2-cmd.c:(.text+0x1b9): multiple definition of `tpm2_calc_ordinal_duration'; drivers/char/tpm/tpm2-cmd.o:tpm2-cmd.c:(.text+0x1b9): first defined here
ld: drivers/char/tpm/tpm2-cmd.o: in function `tpm2_pcr_read':
tpm2-cmd.c:(.text+0x1e5): multiple definition of `tpm2_pcr_read'; drivers/char/tpm/tpm2-cmd.o:tpm2-cmd.c:(.text+0x1e5): first defined here
ld: drivers/char/tpm/tpm2-cmd.o: in function `tpm2_pcr_extend':
tpm2-cmd.c:(.text+0x352): multiple definition of `tpm2_pcr_extend'; drivers/char/tpm/tpm2-cmd.o:tpm2-cmd.c:(.text+0x352): first defined here
ld: drivers/char/tpm/tpm2-cmd.o: in function `tpm2_get_random':
tpm2-cmd.c:(.text+0x442): multiple definition of `tpm2_get_random'; drivers/char/tpm/tpm2-cmd.o:tpm2-cmd.c:(.text+0x442): first defined here
ld: drivers/char/tpm/tpm2-cmd.o: in function `tpm2_flush_context':
tpm2-cmd.c:(.text+0x577): multiple definition of `tpm2_flush_context'; drivers/char/tpm/tpm2-cmd.o:tpm2-cmd.c:(.text+0x577): first defined here
ld: drivers/char/tpm/tpm2-cmd.o: in function `tpm2_get_tpm_pt':
tpm2-cmd.c:(.text+0x5da): multiple definition of `tpm2_get_tpm_pt'; drivers/char/tpm/tpm2-cmd.o:tpm2-cmd.c:(.text+0x5da): first defined here
ld: drivers/char/tpm/tpm2-cmd.o: in function `tpm2_shutdown':
tpm2-cmd.c:(.text+0x663): multiple definition of `tpm2_shutdown'; drivers/char/tpm/tpm2-cmd.o:tpm2-cmd.c:(.text+0x663): first defined here
ld: drivers/char/tpm/tpm2-cmd.o: in function `tpm2_probe':
tpm2-cmd.c:(.text+0x6b4): multiple definition of `tpm2_probe'; drivers/char/tpm/tpm2-cmd.o:tpm2-cmd.c:(.text+0x6b4): first defined here
ld: drivers/char/tpm/tpm2-cmd.o: in function `tpm2_get_pcr_allocation':
tpm2-cmd.c:(.text+0x735): multiple definition of `tpm2_get_pcr_allocation'; drivers/char/tpm/tpm2-cmd.o:tpm2-cmd.c:(.text+0x735): first defined here
ld: drivers/char/tpm/tpm2-cmd.o: in function `tpm2_get_cc_attrs_tbl':
tpm2-cmd.c:(.text+0x92a): multiple definition of `tpm2_get_cc_attrs_tbl'; drivers/char/tpm/tpm2-cmd.o:tpm2-cmd.c:(.text+0x92a): first defined here
ld: drivers/char/tpm/tpm2-cmd.o: in function `tpm2_auto_startup':
tpm2-cmd.c:(.text+0xa8e): multiple definition of `tpm2_auto_startup'; drivers/char/tpm/tpm2-cmd.o:tpm2-cmd.c:(.text+0xa8e): first defined here
ld: drivers/char/tpm/tpm2-cmd.o: in function `tpm2_find_cc':
tpm2-cmd.c:(.text+0xb3f): multiple definition of `tpm2_find_cc'; drivers/char/tpm/tpm2-cmd.o:tpm2-cmd.c:(.text+0xb3f): first defined here
ld: drivers/char/tpm/tpmrm-dev.o:(.rodata+0x0): multiple definition of `tpmrm_fops'; drivers/char/tpm/tpmrm-dev.o:(.rodata+0x0): first defined here
ld: drivers/char/tpm/tpm2-space.o: in function `tpm2_init_space':
tpm2-space.c:(.text+0x2b1): multiple definition of `tpm2_init_space'; drivers/char/tpm/tpm2-space.o:tpm2-space.c:(.text+0x2b1): first defined here
ld: drivers/char/tpm/tpm2-space.o: in function `tpm2_del_space':
tpm2-space.c:(.text+0x307): multiple definition of `tpm2_del_space'; drivers/char/tpm/tpm2-space.o:tpm2-space.c:(.text+0x307): first defined here
ld: drivers/char/tpm/tpm2-space.o: in function `tpm2_flush_space':
tpm2-space.c:(.text+0x377): multiple definition of `tpm2_flush_space'; drivers/char/tpm/tpm2-space.o:tpm2-space.c:(.text+0x377): first defined here
ld: drivers/char/tpm/tpm2-space.o: in function `tpm2_prepare_space':
tpm2-space.c:(.text+0x3c1): multiple definition of `tpm2_prepare_space'; drivers/char/tpm/tpm2-space.o:tpm2-space.c:(.text+0x3c1): first defined here
ld: drivers/char/tpm/tpm2-space.o: in function `tpm2_commit_space':
tpm2-space.c:(.text+0x600): multiple definition of `tpm2_commit_space'; drivers/char/tpm/tpm2-space.o:tpm2-space.c:(.text+0x600): first defined here
ld: drivers/char/tpm/tpm-sysfs.o: in function `tpm_sysfs_add_device':
tpm-sysfs.c:(.text+0x649): multiple definition of `tpm_sysfs_add_device'; drivers/char/tpm/tpm-sysfs.o:tpm-sysfs.c:(.text+0x649): first defined here
ld: drivers/char/tpm/eventlog/common.o: in function `tpm_bios_log_teardown':
common.c:(.text+0x9c): multiple definition of `tpm_bios_log_teardown'; drivers/char/tpm/eventlog/common.o:common.c:(.text+0x9c): first defined here
ld: drivers/char/tpm/eventlog/common.o: in function `tpm_bios_log_setup':
common.c:(.text+0xf8): multiple definition of `tpm_bios_log_setup'; drivers/char/tpm/eventlog/common.o:common.c:(.text+0xf8): first defined here
ld: drivers/char/tpm/eventlog/tpm1.o:(.rodata+0x40): multiple definition of `tpm1_binary_b_measurements_seqops'; drivers/char/tpm/eventlog/tpm1.o:(.rodata+0x40): first defined here
ld: drivers/char/tpm/eventlog/tpm1.o:(.rodata+0x60): multiple definition of `tpm1_ascii_b_measurements_seqops'; drivers/char/tpm/eventlog/tpm1.o:(.rodata+0x60): first defined here
ld: drivers/char/tpm/eventlog/tpm2.o:(.rodata+0x0): multiple definition of `tpm2_binary_b_measurements_seqops'; drivers/char/tpm/eventlog/tpm2.o:(.rodata+0x0): first defined here
ld: drivers/char/tpm/tpm_ppi.o: in function `tpm_add_ppi':
tpm_ppi.c:(.text+0x5c6): multiple definition of `tpm_add_ppi'; drivers/char/tpm/tpm_ppi.o:tpm_ppi.c:(.text+0x5c6): first defined here
ld: drivers/char/tpm/eventlog/acpi.o: in function `tpm_read_log_acpi':
acpi.c:(.text+0x0): multiple definition of `tpm_read_log_acpi'; drivers/char/tpm/eventlog/acpi.o:acpi.c:(.text+0x0): first defined here
ld: drivers/char/tpm/st33zp24/st33zp24.o: in function `st33zp24_probe':
st33zp24.c:(.text+0x6fe): multiple definition of `st33zp24_probe'; drivers/char/tpm/st33zp24/st33zp24.o:st33zp24.c:(.text+0x6fe): first defined here
ld: drivers/char/tpm/st33zp24/st33zp24.o: in function `st33zp24_remove':
st33zp24.c:(.text+0x8ab): multiple definition of `st33zp24_remove'; drivers/char/tpm/st33zp24/st33zp24.o:st33zp24.c:(.text+0x8ab): first defined here
ld: drivers/char/tpm/st33zp24/st33zp24.o: in function `st33zp24_pm_suspend':
st33zp24.c:(.text+0x8b3): multiple definition of `st33zp24_pm_suspend'; drivers/char/tpm/st33zp24/st33zp24.o:st33zp24.c:(.text+0x8b3): first defined here
ld: drivers/char/tpm/st33zp24/st33zp24.o: in function `st33zp24_pm_resume':
st33zp24.c:(.text+0x8de): multiple definition of `st33zp24_pm_resume'; drivers/char/tpm/st33zp24/st33zp24.o:st33zp24.c:(.text+0x8de): first defined here


-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
