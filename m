Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFAB2F97D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 03:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbhARCRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 21:17:34 -0500
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:39780 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731034AbhARCKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 21:10:30 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E826E181D330D;
        Mon, 18 Jan 2021 02:09:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:599:857:966:968:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1730:1747:1777:1792:2196:2198:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3866:3867:3873:4050:4119:4321:4385:5007:6119:7652:7903:9010:10004:10848:11026:11232:11658:11914:12043:12294:12296:12297:12438:12555:12740:12760:12895:13439:13972:14096:14097:14659:21080:21433:21451:21619:21773:21987:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bait02_4c01e3e27545
X-Filterd-Recvd-Size: 8425
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 Jan 2021 02:09:46 +0000 (UTC)
Message-ID: <0037bf34a326f44585c634d346c8134cf9efc062.camel@perches.com>
Subject: Re: [PATCH] mm/memcontrol: Remove unneeded semicolons
From:   Joe Perches <joe@perches.com>
To:     Chengyang Fan <cy.fan@huawei.com>, akpm@linux-foundation.org
Cc:     richard.weiyang@gmail.com, linux-kernel@vger.kernel.org
Date:   Sun, 17 Jan 2021 18:09:45 -0800
In-Reply-To: <20210118015229.2599778-1-cy.fan@huawei.com>
References: <20210118015229.2599778-1-cy.fan@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-01-18 at 09:52 +0800, Chengyang Fan wrote:
> Remove superfluous semicolons after function definitions.

Are you intending to submit patches for all of these?
(there are probably many more)

$ git grep -P 'static\s+inline.*\(.*\)\s*\{\s*;?\s*\}\s*;' -- '*.[ch]'
arch/arm/include/asm/mpu.h:static inline void pmsav7_adjust_lowmem_bounds(void) {};
arch/arm/include/asm/mpu.h:static inline void pmsav8_adjust_lowmem_bounds(void) {};
arch/arm/include/asm/mpu.h:static inline void pmsav7_setup(void) {};
arch/arm/include/asm/mpu.h:static inline void pmsav8_setup(void) {};
arch/arm/mach-mvebu/kirkwood-pm.h:static inline void kirkwood_pm_init(void) {};
arch/arm/mach-pxa/littleton.c:static inline void littleton_init_lcd(void) {};
arch/mips/include/asm/spram.h:static inline void spram_config(void) { };
arch/powerpc/include/asm/book3s/32/mmu-hash.h:static inline void cleanup_cpu_mmu_context(void) { };
arch/powerpc/include/asm/book3s/64/mmu.h:static inline void radix_init_pseries(void) { };
arch/powerpc/include/asm/firmware.h:static inline void pseries_probe_fw_features(void) { };
arch/powerpc/include/asm/kvm_ppc.h:static inline void kvmppc_alloc_host_rm_ops(void) {};
arch/powerpc/include/asm/kvm_ppc.h:static inline void kvmppc_free_host_rm_ops(void) {};
arch/powerpc/include/asm/kvm_ppc.h:static inline void kvmppc_free_pimap(struct kvm *kvm) {};
arch/powerpc/include/asm/paca.h:static inline void allocate_paca_ptrs(void) { };
arch/powerpc/include/asm/paca.h:static inline void allocate_paca(int cpu) { };
arch/powerpc/include/asm/paca.h:static inline void free_unused_pacas(void) { };
arch/powerpc/include/asm/rtas.h:static inline void rtas_initialize(void) { };
arch/powerpc/include/asm/setup.h:static inline void setup_barrier_nospec(void) { };
arch/powerpc/include/asm/setup.h:static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
arch/powerpc/include/asm/setup.h:static inline void setup_spectre_v2(void) {};
arch/powerpc/include/asm/simple_spinlock.h:static inline void splpar_spin_yield(arch_spinlock_t *lock) {};
arch/powerpc/include/asm/simple_spinlock.h:static inline void splpar_rw_yield(arch_rwlock_t *lock) {};
arch/powerpc/include/asm/smp.h:static inline void smp_release_cpus(void) { };
arch/powerpc/include/asm/xmon.h:static inline void xmon_setup(void) { };
arch/powerpc/include/asm/xmon.h:static inline void xmon_register_spus(struct list_head *list) { };
arch/powerpc/kernel/prom.c:static inline void save_fscr_to_task(void) {};
arch/powerpc/kernel/setup.h:static inline void setup_power_save(void) { };
arch/powerpc/kernel/setup.h:static inline void check_smt_enabled(void) { };
arch/powerpc/kernel/setup.h:static inline void setup_tlb_core_data(void) { };
arch/powerpc/kernel/setup.h:static inline void exc_lvl_early_init(void) { };
arch/powerpc/kernel/setup.h:static inline void emergency_stack_init(void) { };
arch/powerpc/kernel/setup.h:static inline void kvm_cma_reserve(void) { };
arch/powerpc/platforms/powernv/subcore.h:static inline void update_subcore_sibling_mask(void) { };
arch/powerpc/platforms/pseries/pseries.h:static inline void smp_init_pseries(void) { };
arch/riscv/include/asm/set_memory.h:static inline void protect_kernel_text_data(void) {};
arch/s390/include/asm/ap.h:static inline void ap_bus_cfg_chg(void){};
arch/x86/include/asm/mshyperv.h:static inline void hyperv_stop_tsc_emulation(void) {};
arch/x86/platform/ce4100/ce4100.c:static inline void sdv_serial_fixup(void) {};
drivers/block/zram/zram_drv.c:static inline void reset_bdev(struct zram *zram) {};
drivers/clk/qcom/gdsc.h:static inline void gdsc_unregister(struct gdsc_desc *desc) {};
drivers/gpu/drm/nouveau/nouveau_led.h:static inline void nouveau_led_suspend(struct drm_device *dev) { };
drivers/gpu/drm/nouveau/nouveau_led.h:static inline void nouveau_led_resume(struct drm_device *dev) { };
drivers/gpu/drm/nouveau/nouveau_led.h:static inline void nouveau_led_fini(struct drm_device *dev) { };
drivers/gpu/drm/rcar-du/rcar_du_vsp.h:static inline void rcar_du_vsp_enable(struct rcar_du_crtc *crtc) { };
drivers/gpu/drm/rcar-du/rcar_du_vsp.h:static inline void rcar_du_vsp_disable(struct rcar_du_crtc *crtc) { };
drivers/gpu/drm/rcar-du/rcar_du_vsp.h:static inline void rcar_du_vsp_atomic_begin(struct rcar_du_crtc *crtc) { };
drivers/gpu/drm/rcar-du/rcar_du_vsp.h:static inline void rcar_du_vsp_atomic_flush(struct rcar_du_crtc *crtc) { };
drivers/hv/hyperv_vmbus.h:static inline void hv_debug_rm_dev_dir(struct hv_device *dev) {};
drivers/hv/hyperv_vmbus.h:static inline void hv_debug_rm_all_dir(void) {};
drivers/media/common/siano/smsdvb.h:static inline void smsdvb_debugfs_unregister(void) {};
drivers/media/platform/coda/imx-vdoa.h:static inline void vdoa_context_destroy(struct vdoa_ctx *ctx) { };
drivers/media/platform/omap/omap_vout_vrfb.h:static inline void omap_vout_free_vrfb_buffers(struct omap_vout_device *vout) { };
drivers/media/platform/omap/omap_vout_vrfb.h:static inline void omap_vout_release_vrfb(struct omap_vout_device *vout) { };
drivers/media/platform/omap/omap_vout_vrfb.h:static inline void omap_vout_calculate_vrfb_offset(struct omap_vout_device *vout) { };
drivers/media/usb/au0828/au0828.h:static inline void au0828_usb_v4l2_media_release(struct au0828_dev *dev) { };
drivers/media/usb/au0828/au0828.h:static inline void au0828_v4l2_suspend(struct au0828_dev *dev) { };
drivers/media/usb/au0828/au0828.h:static inline void au0828_v4l2_resume(struct au0828_dev *dev) { };
drivers/net/ethernet/mellanox/mlx5/core/en_rep.h:static inline void mlx5e_rep_cleanup(void) {};
drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.h:static inline void mlx5_fpga_ipsec_build_fs_cmds(void) {};
drivers/net/wireless/ath/ath9k/ath9k.h:static inline void ath_pci_exit(void) {};
drivers/net/wireless/ath/ath9k/ath9k.h:static inline void ath_ahb_exit(void) {};
drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.h:static inline void brcms_led_unregister(struct brcms_info *wl) {};
drivers/nvme/host/nvme.h:static inline void nvme_nvm_unregister(struct nvme_ns *ns) {};
drivers/of/of_private.h:static inline void of_overlay_mutex_lock(void) {};
drivers/of/of_private.h:static inline void of_overlay_mutex_unlock(void) {};
drivers/of/of_private.h:static inline void unittest_unflatten_overlay_base(void) {};
drivers/pci/xen-pcifront.c:static inline void pci_frontend_registrar(int enable) { };
drivers/tty/serial/icom.c:static inline void trace(struct icom_port *icom_port, char *trace_pt, unsigned long trace_data) {};
drivers/usb/core/usb.h:static inline void usb_acpi_unregister(void) { };
drivers/video/fbdev/matrox/matroxfb_g450.h:static inline void matroxfb_g450_connect(struct matrox_fb_info *minfo) { };
drivers/video/fbdev/matrox/matroxfb_g450.h:static inline void matroxfb_g450_shutdown(struct matrox_fb_info *minfo) { };
include/linux/fs.h:static inline void lockdep_annotate_inode_mutex_key(struct inode *inode) { };
include/linux/led-class-multicolor.h:static inline void led_classdev_multicolor_unregister(struct led_classdev_mc *mcled_cdev) {};
include/linux/memcontrol.h:static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
include/linux/memcontrol.h:static inline void mem_cgroup_sk_free(struct sock *sk) { };
include/linux/vgaarb.h:static inline void vga_set_default_device(struct pci_dev *pdev) { };
include/net/x25.h:static inline void x25_unregister_sysctl(void) {};
include/video/omapfb_dss.h:static inline void omap_dss_put_device(struct omap_dss_device *dssdev) {};
include/video/omapfb_dss.h:static inline void omapdss_compat_uninit(void) {};


