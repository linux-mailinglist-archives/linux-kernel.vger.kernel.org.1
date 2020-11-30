Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6202C7C13
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 01:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgK3AVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 19:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgK3AVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 19:21:05 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406B3C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 16:20:24 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id y16so14644665ljk.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 16:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=J1sE12BxZ3HJVp/i/GGOJ49doyG8OKqssrla0v17yxI=;
        b=iBBI2/m7G+govMP7wGAFlVHgOgr+w+Dv7PqAVMqtRDRsx+qk2/7b4/YD21oVfC3Cq1
         FPYa3KCcxtISChkR6B1vDkF6zdal6NUzfiv2RQMsbuzQOZ24v2SryE4Q6sP7w8ox0/4C
         /+kKHBUf7halU4h3vasWmdVL1aIG4xDkbtWgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=J1sE12BxZ3HJVp/i/GGOJ49doyG8OKqssrla0v17yxI=;
        b=nNyhCw7BVjk8Vo2fPm5m08oxkiJjF+GwIho/vsX/G5w9BVj/jiJ96XTpGjdCstNaHg
         FFn227+PkEIiCLb9KiVT5c+9J6nqgRvAgFHQadtV5jwxX47z7vfovMOkWGaxCu6TC8Sz
         LsJ3/IzBflLeLSlAe8E00ls8c8/Sg778m0y5fuhV+hbP2KbtketR4d4b+sTClqqiQ+8E
         x6QeEqIfsAEyUkptegtsrPWENHRUPKjJW/dOtRJHWxnQX6g7sh9oIbHcfARR7YS01aV0
         zSIHVASj8sT6PK9ewnnaaxPZUDrQfhnXs05aXmNqJ6Ns+VJse+r8wDHk/+HO+my5LMdT
         c1Mg==
X-Gm-Message-State: AOAM5306H+eBdZY7hwZKhUpMmJz18sBIP4nSib6tOjRKxWLNYd1e+jR7
        61AOpdTo+zqIhvzFvVVii+isSyl/SR7vkQ==
X-Google-Smtp-Source: ABdhPJylHPJDsaoeQ5ZCgULPq8PIonPwU9yiDC2jYLP87fgqOy//ONTmoBW23kwc5aG9qSuQWWaicw==
X-Received: by 2002:a2e:b54b:: with SMTP id a11mr8825010ljn.40.1606695621668;
        Sun, 29 Nov 2020 16:20:21 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id l9sm2376708ljj.129.2020.11.29.16.20.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 16:20:20 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id r24so17655348lfm.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 16:20:20 -0800 (PST)
X-Received: by 2002:a19:3f55:: with SMTP id m82mr7767181lfa.344.1606695619466;
 Sun, 29 Nov 2020 16:20:19 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Nov 2020 16:20:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSJRZPhfZ4QZhpb78uxRHwO3XLGQFJ5=+5rikOBgQ9rA@mail.gmail.com>
Message-ID: <CAHk-=wgSJRZPhfZ4QZhpb78uxRHwO3XLGQFJ5=+5rikOBgQ9rA@mail.gmail.com>
Subject: Linux 5.10-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the first part of the week, it really looked like things were
calming down quite nicely, and I mentally already went "Ahh,
Thanksgiving week, this is going to be a nice small, calm rc".

And then Friday rolled around, and everybody sent me their pull
requests for the week, and it all looks very normal again.

But at least this week isn't unusually bigger than normal - it's a
pretty normal rc6 stat-wise.  So unless we have some big surprising
left-overs coming up, I think we're in good shape.

And the diffstat looks nice and flat too,  which is a sign of just
widespread small fixes, rather than some big last-minute changes. The
exception is a chunk of fixes to the new vidtv driver, but that is not
only a new driver, it's a virtual test-driver for validation and
development rather than something that would affect users.

That vidtv driver shows up very clearly in the patch stats too, but
other than that it all looks very normal: mostly driver updates (even
ignoring the vidtv ones), with the usual smattering of small fixes
elsewhere - architecture code, networking, some filesystem stuff.

So I'm feeling pretty good about 5.10, and I hope I won't be proven
wrong about that. But please do test,

                 Linus

---

Al Cooper (1):
      phy: usb: Fix incorrect clearing of tca_drv_sel bit in SETUP reg for =
7211

Alan Stern (2):
      USB: core: Fix regression in Hercules audio card
      USB: core: Change %pK for __user pointers to %px

Alexander Duyck (3):
      tcp: Allow full IP tos/IPv6 tclass to be reflected in L3 header
      tcp: Set INET_ECN_xmit configuration in tcp_reinit_congestion_control
      tcp: Set ECT0 bit in tos/tclass for synack when BPF needs ECN

Alexandra Winter (1):
      s390/qeth: Remove pnso workaround

Alexandre Courbot (2):
      media: mtk-vcodec: move firmware implementations into their own files
      media: mtk-vcodec: fix build breakage when one of VPU or SCP is enabl=
ed

Amadeusz S=C5=82awi=C5=84ski (1):
      efi/efivars: Set generic ops before loading SSDT

Amelie Delaunay (1):
      usb: typec: stusb160x: fix power-opmode property with typec-power-opm=
ode

Amit Sunil Dhamne (1):
      firmware: xilinx: Use hash-table for api feature check

Anand K Mistry (1):
      x86/speculation: Fix prctl() when spectre_v2_user=3D{seccomp,prctl},i=
bpb

Anmol Karn (1):
      rose: Fix Null pointer dereference in rose_send_frame()

Antonio Borneo (1):
      net: stmmac: fix incorrect merge of patch upstream

Anup Patel (1):
      RISC-V: Add missing jump label initialization

Ard Biesheuvel (1):
      efivarfs: revert "fix memory leak in efivarfs_create()"

Arnaldo Carvalho de Melo (1):
      perf tools: Update copy of libbpf's hashmap.c

Arnd Bergmann (1):
      arch: pgtable: define MAX_POSSIBLE_PHYSMEM_BITS where needed

Ashish Kalra (1):
      KVM: SVM: Fix offset computation bug in __sev_dbg_decrypt().

Avraham Stern (1):
      iwlwifi: mvm: write queue_sync_state only for sync

Benjamin Berg (1):
      platform/x86: thinkpad_acpi: Send tablet mode switch at wakeup time

Bryan O'Donoghue (2):
      phy: qualcomm: usb: Fix SuperSpeed PHY OF dependency
      phy: qualcomm: Fix 28 nm Hi-Speed USB PHY OF dependency

CK Hu (1):
      drm/mediatek: dsi: Modify horizontal front/back porch byte formula

Can Guo (2):
      scsi: ufs: Fix unexpected values from ufshcd_read_desc_param()
      scsi: ufs: Make sure clk scaling happens only when HBA is runtime ACT=
IVE

Chen Baozi (1):
      irqchip/exiu: Fix the index of fwspec for IRQ type

Chen Zhou (1):
      KVM: SVM: fix error return code in svm_create_vcpu()

Chi-Hsien Lin (1):
      MAINTAINERS: update maintainers list for Cypress

Chris Wilson (4):
      drm/i915/gt: Defer enabling the breadcrumb interrupt to after submiss=
ion
      drm/i915/gt: Track signaled breadcrumbs outside of the breadcrumb spi=
nlock
      drm/i915/gt: Don't cancel the interrupt shadow too early
      drm/i915/gt: Free stale request on destroying the virtual engine

Christian Borntraeger (2):
      s390/uv: handle destroy page legacy interface
      MAINTAINERS: add uv.c also to KVM/s390

Christophe Leroy (1):
      powerpc/32s: Use relocation offset when setting early hash table

Clark Wang (1):
      spi: imx: fix the unbalanced spi runtime pm management

Colin Ian King (1):
      phy: mediatek: fix spelling mistake in Kconfig "veriosn" -> "version"

Collin Walling (1):
      KVM: s390: remove diag318 reset code

C=C3=A9dric Le Goater (1):
      KVM: PPC: Book3S HV: XIVE: Fix possible oops when accessing ESB page

Daniel W. S. Almeida (6):
      media: vidtv: extract the initial CRC value to into a #define
      media: vidtv: psi: add a Network Information Table (NIT)
      media: vidtv: psi: Implement an Event Information Table (EIT)
      media: vidtv: psi: extract descriptor chaining code into a helper
      media: vidtv: Move s302m specific fields into encoder context
      media: vidtv: psi: fix missing assignments in while loops

Daniel Xu (1):
      btrfs: tree-checker: add missing return after error in root_item

David Bauer (1):
      arm64: dts: rockchip: fix NanoPi R2S GMAC clock name

David Sterba (1):
      btrfs: tree-checker: add missing returns after data_ref alignment che=
cks

David Woodhouse (1):
      iommu/vt-d: Don't read VCCAP register unless it exists

Dennis Dalessandro (1):
      IB/hfi1: Ensure correct mm is used at all times

Dexuan Cui (1):
      video: hyperv_fb: Fix the cache type when mapping the VRAM

Dipen Patel (1):
      arm64: tegra: Wrong AON HSP reg property size

Eelco Chaudron (1):
      net: openvswitch: fix TTL decrement action netlink message format

Emmanuel Grumbach (2):
      iwlwifi: mvm: use the HOT_SPOT_CMD to cancel an AUX ROC
      iwlwifi: mvm: properly cancel a session protection for P2P

Enric Balletbo i Serra (1):
      drm/mediatek: mtk_dpi: Fix unused variable 'mtk_dpi_encoder_funcs'

Eric Biggers (1):
      block/keyslot-manager: prevent crash when num_slots=3D1

Eric Dumazet (1):
      gro_cells: reduce number of synchronize_net() calls

Eyal Birger (1):
      net/packet: fix packet receive on L3 devices without visible hard hea=
der

Ezequiel Garcia (1):
      dpaa2-eth: Fix compile error due to missing devlink support

Feng Tang (1):
      mm: memcg: relayout structure mem_cgroup to avoid cache interference

Filipe Manana (4):
      btrfs: fix missing delalloc new bit for new delalloc ranges
      btrfs: fix lockdep splat when reading qgroup config on mount
      btrfs: do nofs allocations when adding and removing qgroup relations
      btrfs: fix lockdep splat when enabling and disabling qgroups

Flavio Suligoi (1):
      ARC: mm: fix spelling mistakes

Gabriele Paoloni (1):
      x86/mce: Do not overwrite no_way_out if mce_end() fails

Geert Uytterhoeven (2):
      phy: intel: PHY_INTEL_KEEMBAY_EMMC should depend on ARCH_KEEMBAY
      efi: EFI_EARLYCON should depend on EFI

Georgi Djakov (4):
      interconnect: qcom: msm8974: Prevent integer overflow in rate
      interconnect: qcom: msm8974: Don't boost the NoC rate during boot
      interconnect: qcom: msm8916: Remove rpm-ids from non-RPM nodes
      interconnect: qcom: qcs404: Remove GPU and display RPM IDsAl Cooper (=
1):
      phy: usb: Fix incorrect clearing of tca_drv_sel bit in SETUP reg for =
7211

Alan Stern (2):
      USB: core: Fix regression in Hercules audio card
      USB: core: Change %pK for __user pointers to %px

Alexander Duyck (3):
      tcp: Allow full IP tos/IPv6 tclass to be reflected in L3 header
      tcp: Set INET_ECN_xmit configuration in tcp_reinit_congestion_control
      tcp: Set ECT0 bit in tos/tclass for synack when BPF needs ECN

Alexandra Winter (1):
      s390/qeth: Remove pnso workaround

Alexandre Courbot (2):
      media: mtk-vcodec: move firmware implementations into their own files
      media: mtk-vcodec: fix build breakage when one of VPU or SCP is enabl=
ed

Amadeusz S=C5=82awi=C5=84ski (1):
      efi/efivars: Set generic ops before loading SSDT

Amelie Delaunay (1):
      usb: typec: stusb160x: fix power-opmode property with typec-power-opm=
ode

Amit Sunil Dhamne (1):
      firmware: xilinx: Use hash-table for api feature check

Anand K Mistry (1):
      x86/speculation: Fix prctl() when spectre_v2_user=3D{seccomp,prctl},i=
bpb

Anmol Karn (1):
      rose: Fix Null pointer dereference in rose_send_frame()

Antonio Borneo (1):
      net: stmmac: fix incorrect merge of patch upstream

Anup Patel (1):
      RISC-V: Add missing jump label initialization

Ard Biesheuvel (1):
      efivarfs: revert "fix memory leak in efivarfs_create()"

Arnaldo Carvalho de Melo (1):
      perf tools: Update copy of libbpf's hashmap.c

Arnd Bergmann (1):
      arch: pgtable: define MAX_POSSIBLE_PHYSMEM_BITS where needed

Ashish Kalra (1):
      KVM: SVM: Fix offset computation bug in __sev_dbg_decrypt().

Avraham Stern (1):
      iwlwifi: mvm: write queue_sync_state only for sync

Benjamin Berg (1):
      platform/x86: thinkpad_acpi: Send tablet mode switch at wakeup time

Bryan O'Donoghue (2):
      phy: qualcomm: usb: Fix SuperSpeed PHY OF dependency
      phy: qualcomm: Fix 28 nm Hi-Speed USB PHY OF dependency

CK Hu (1):
      drm/mediatek: dsi: Modify horizontal front/back porch byte formula

Can Guo (2):
      scsi: ufs: Fix unexpected values from ufshcd_read_desc_param()
      scsi: ufs: Make sure clk scaling happens only when HBA is runtime ACT=
IVE

Chen Baozi (1):
      irqchip/exiu: Fix the index of fwspec for IRQ type

Chen Zhou (1):
      KVM: SVM: fix error return code in svm_create_vcpu()

Chi-Hsien Lin (1):
      MAINTAINERS: update maintainers list for Cypress

Chris Wilson (4):
      drm/i915/gt: Defer enabling the breadcrumb interrupt to after submiss=
ion
      drm/i915/gt: Track signaled breadcrumbs outside of the breadcrumb spi=
nlock
      drm/i915/gt: Don't cancel the interrupt shadow too early
      drm/i915/gt: Free stale request on destroying the virtual engine

Christian Borntraeger (2):
      s390/uv: handle destroy page legacy interface
      MAINTAINERS: add uv.c also to KVM/s390

Christophe Leroy (1):
      powerpc/32s: Use relocation offset when setting early hash table

Clark Wang (1):
      spi: imx: fix the unbalanced spi runtime pm management

Colin Ian King (1):
      phy: mediatek: fix spelling mistake in Kconfig "veriosn" -> "version"

Collin Walling (1):
      KVM: s390: remove diag318 reset code

C=C3=A9dric Le Goater (1):
      KVM: PPC: Book3S HV: XIVE: Fix possible oops when accessing ESB page

Daniel W. S. Almeida (6):
      media: vidtv: extract the initial CRC value to into a #define
      media: vidtv: psi: add a Network Information Table (NIT)
      media: vidtv: psi: Implement an Event Information Table (EIT)
      media: vidtv: psi: extract descriptor chaining code into a helper
      media: vidtv: Move s302m specific fields into encoder context
      media: vidtv: psi: fix missing assignments in while loops

Daniel Xu (1):
      btrfs: tree-checker: add missing return after error in root_item

David Bauer (1):
      arm64: dts: rockchip: fix NanoPi R2S GMAC clock name

David Sterba (1):
      btrfs: tree-checker: add missing returns after data_ref alignment che=
cks

David Woodhouse (1):
      iommu/vt-d: Don't read VCCAP register unless it exists

Dennis Dalessandro (1):
      IB/hfi1: Ensure correct mm is used at all times

Dexuan Cui (1):
      video: hyperv_fb: Fix the cache type when mapping the VRAM

Dipen Patel (1):
      arm64: tegra: Wrong AON HSP reg property size

Eelco Chaudron (1):
      net: openvswitch: fix TTL decrement action netlink message format

Emmanuel Grumbach (2):
      iwlwifi: mvm: use the HOT_SPOT_CMD to cancel an AUX ROC
      iwlwifi: mvm: properly cancel a session protection for P2P

Enric Balletbo i Serra (1):
      drm/mediatek: mtk_dpi: Fix unused variable 'mtk_dpi_encoder_funcs'

Eric Biggers (1):
      block/keyslot-manager: prevent crash when num_slots=3D1

Eric Dumazet (1):
      gro_cells: reduce number of synchronize_net() calls

Eyal Birger (1):
      net/packet: fix packet receive on L3 devices without visible hard hea=
der

Ezequiel Garcia (1):
      dpaa2-eth: Fix compile error due to missing devlink support

Feng Tang (1):
      mm: memcg: relayout structure mem_cgroup to avoid cache interference

Filipe Manana (4):
      btrfs: fix missing delalloc new bit for new delalloc ranges
      btrfs: fix lockdep splat when reading qgroup config on mount
      btrfs: do nofs allocations when adding and removing qgroup relations
      btrfs: fix lockdep splat when enabling and disabling qgroups

Flavio Suligoi (1):
      ARC: mm: fix spelling mistakes

Gabriele Paoloni (1):
      x86/mce: Do not overwrite no_way_out if mce_end() fails

Geert Uytterhoeven (2):
      phy: intel: PHY_INTEL_KEEMBAY_EMMC should depend on ARCH_KEEMBAY
      efi: EFI_EARLYCON should depend on EFI

Georgi Djakov (4):
      interconnect: qcom: msm8974: Prevent integer overflow in rate
      interconnect: qcom: msm8974: Don't boost the NoC rate during boot
      interconnect: qcom: msm8916: Remove rpm-ids from non-RPM nodes
      interconnect: qcom: qcs404: Remove GPU and display RPM IDs

Grygorii Strashko (2):
      ARM: dts: am437x-l4: fix compatible for cpsw switch dt node
      bus: ti-sysc: suppress err msg for timers used as clockevent/source

Gustavo Pimentel (1):
      ARC: bitops: Remove unecessary operation and value

Hans de Goede (4):
      platform/x86: thinkpad_acpi: Do not report SW_TABLET_MODE on Yoga 11e
      platform/x86: thinkpad_acpi: Add BAT1 is primary battery quirk
for Thinkpad Yoga 11e 4th gen
      platform/x86: touchscreen_dmi: Add info for the Predia Basic tablet
      platform/x86: touchscreen_dmi: Add info for the Irbis TW118 tablet

Hao Si (1):
      soc: fsl: dpio: Get the cpumask through cpumask_of(cpu)

Hugh Dickins (1):
      mm: fix VM_BUG_ON(PageTail) and BUG_ON(PageWriteback)

Hui Su (1):
      trace: fix potenial dangerous pointer

Iakov 'Jake' Kirilenko (1):
      platform/x86: thinkpad_acpi: add P1 gen3 second fan support

Ioana Ciornei (1):
      dpaa2-eth: select XGMAC_MDIO for MDIO bus support

JC Kuo (1):
      arm64: tegra: Fix USB_VBUS_EN0 regulator on Jetson TX1

Jakub Kicinski (1):
      Documentation: netdev-FAQ: suggest how to post co-dependent series

Jamie Iles (2):
      KVM: arm64: Correctly align nVHE percpu data
      bonding: wait for sysfs kobject destruction before freeing struct sla=
ve

Janosch Frank (1):
      KVM: s390: pv: Mark mm as protected after the set secure
parameters and improve cleanup

Jens Axboe (1):
      tun: honor IOCB_NOWAIT flag

Jernej Skrabec (1):
      media: cedrus: h264: Fix check for presence of scaling matrix

Jesper Dangaard Brouer (1):
      MAINTAINERS: Update page pool entry

Johannes Berg (2):
      iwlwifi: pcie: limit memory read spin time
      iwlwifi: pcie: set LTR to avoid completion timeout

Johannes Thumshirn (1):
      btrfs: don't access possibly stale fs_info data for printing
duplicate device

John Ogness (1):
      printk: finalize records with trailing newlines

John Stultz (1):
      arm-smmu-qcom: Ensure the qcom_scm driver has finished probing

Jon Hunter (3):
      arm64: tegra: Disable the ACONNECT for Jetson TX2
      arm64: tegra: Correct the UART for Jetson Xavier NX
      arm64: tegra: Fix Tegra234 VDK node names

Joseph Qi (1):
      io_uring: fix shift-out-of-bounds when round up cq size

Julian Wiedmann (4):
      s390/qeth: make af_iucv TX notification call more robust
      s390/qeth: fix af_iucv notification race
      s390/qeth: fix tear down of async TX buffers
      net/af_iucv: set correct sk_protocol for child sockets

Kaixu Xia (1):
      platform/x86: toshiba_acpi: Fix the wrong variable assignment

Kenneth Feng (1):
      drm/amd/amdgpu: fix null pointer in runtime pm

Krzysztof Kozlowski (2):
      drm/exynos: depend on COMMON_CLK to fix compile tests
      nfc: s3fwrn5: use signed integer for parsing GPIO numbers

Lars Povlsen (1):
      spi: dw: Fix spi registration for controllers overriding CS

Lijun Pan (6):
      ibmvnic: fix call_netdevice_notifiers in do_reset
      ibmvnic: notify peers when failover and migration happen
      ibmvnic: skip tx timeout reset while in resetting
      ibmvnic: fix NULL pointer dereference in reset_sub_crq_queues
      ibmvnic: fix NULL pointer dereference in ibmvic_reset_crq
      ibmvnic: enhance resetting status check during module exit

Likun Gao (1):
      drm/amdgpu: update golden setting for sienna_cichlid

Lincoln Ramsay (1):
      aquantia: Remove the build_skb path

Linus Torvalds (1):
      Linux 5.10-rc6

Lionel Landwerlin (1):
      drm/i915/perf: workaround register corruption in OATAILPTR

Lu Baolu (1):
      x86/tboot: Don't disable swiotlb when iommu is forced on

Lukas Bulwahn (1):
      printk: remove unneeded dead-store assignment

Maciej Matuszczyk (1):
      arm64: dts: rockchip: Remove system-power-controller from pmic
on Odroid Go Advance

Manish Narani (1):
      firmware: xilinx: Fix SD DLL node reset issue

Marc Kleine-Budde (5):
      ARM: dts: dra76x: m_can: fix order of clocks
      can: gs_usb: fix endianess problem with candleLight firmware
      can: mcp251xfd: mcp251xfd_probe(): bail out if no IRQ was given
      can: m_can: m_can_open(): remove IRQF_TRIGGER_FALLING from
request_threaded_irq()'s flags
      can: m_can: fix nominal bitiming tseg2 min for version >=3D 3.1

Marc Zyngier (1):
      phy: tegra: xusb: Fix dangling pointer on probe failure

Marek Szyprowski (1):
      interconnect: fix memory trashing in of_count_icc_providers()

Markus Reichl (2):
      arm64: dts: rockchip: Assign a fixed index to mmc devices on
rk3399 boards.
      arm64: dts: rockchip: Reorder LED triggers from mmc devices on
rk3399-roc-pc.

Martin Habets (1):
      MAINTAINERS: Change Solarflare maintainers

Masami Hiramatsu (2):
      perf probe: Fix to die_entrypc() returns error correctly
      perf probe: Change function definition check due to broken DWARF

Mathieu Poirier (1):
      MAINTAINERS: Adding help for coresight subsystem

Matthias Maier (1):
      platform/x86: thinkpad_acpi: Whitelist P15 firmware for dual fan cont=
rol

Matti Hamalainen (1):
      drm/nouveau: fix relocations applying logic and a double-free

Mauro Carvalho Chehab (30):
      media: vidtv: reorganize includes
      media: vidtv: add error checks
      media: vidtv: don't use recursive functions
      media: vidtv: fix the name of the program
      media: vidtv: fix the tone generator logic
      media: vidtv: fix some notes at the tone generator
      media: vidtv: avoid data copy when initializing the multiplexer
      media: vidtv: avoid copying data for PES structs
      media: vidtv: do some cleanups at the driver
      media: vidtv: remove some unused functions
      media: vidtv: pre-initialize mux arrays
      media: vidtv: cleanup null packet initialization logic
      media: vidtv: improve EIT data
      media: vidtv: fix the network ID range
      media: vidtv: properly fill EIT service_id
      media: vidtv: add a PID entry for the NIT table
      media: vidtv: fix service type
      media: vidtv: fix service_id at SDT table
      media: vidtv: add date to the current event
      media: vidtv: simplify PSI write function
      media: vidtv: simplify the crc writing logic
      media: vidtv: cleanup PSI descriptor write function
      media: vidtv: cleanup PSI table header function
      media: vidtv: cleanup PAT write function
      media: vidtv: cleanup PMT write table function
      media: vidtv: simplify SDT write function
      media: vidtv: simplify NIT write function
      media: vidtv: simplify EIT write function
      media: vidtv.rst: update vidtv documentation
      media: vidtv.rst: add kernel-doc markups

Max Verevkin (1):
      platform/x86: intel-vbtn: Support for tablet mode on HP Pavilion
13 x360 PC

Maxim Mikityanskiy (1):
      net/tls: Protect from calling tls_dev_del for TLS RX twice

Maxime Ripard (11):
      drm/vc4: hdmi: Make sure our clock rate is within limits
      drm/vc4: hdmi: Block odd horizontal timings
      drm/vc4: kms: Switch to drmm_add_action_or_reset
      drm/vc4: kms: Remove useless define
      drm/vc4: kms: Rename NUM_CHANNELS
      drm/vc4: kms: Split the HVS muxing check in a separate function
      drm/vc4: kms: Document the muxing corner cases
      dt-bindings: display: Add a property to deal with WiFi coexistence
      drm/vc4: hdmi: Disable Wifi Frequencies
      drm/vc4: kms: Store the unassigned channel list in the state
      drm/vc4: kms: Don't disable the muxing of an active CRTC

Michael Chan (1):
      bnxt_en: Release PCI regions when DMA mask setup fails during probe.

Michael Ellerman (1):
      powerpc: Drop -me200 addition to build flags

Min Li (1):
      ptp: clockmatrix: bug fix for idtcm_strverscmp

Miquel Raynal (19):
      mtd: rawnand: gpio: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: xway: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: ams-delta: Move the ECC initialization to ->attach_chip=
()
      mtd: rawnand: au1550: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: cs553x: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: davinci: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: diskonchip: Move the ECC initialization to ->attach_chi=
p()
      mtd: rawnand: fsmc: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: lpc32xx_mlc: Move the ECC initialization to ->attach_ch=
ip()
      mtd: rawnand: lpc32xx_slc: Move the ECC initialization to ->attach_ch=
ip()
      mtd: rawnand: mpc5121: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: orion: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: txx9ndfmc: Move the ECC initialization to ->attach_chip=
()
      mtd: rawnand: tmio: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: pasemi: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: plat_nand: Move the ECC initialization to ->attach_chip=
()
      mtd: rawnand: r852: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: sharpsl: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: socrates: Move the ECC initialization to ->attach_chip(=
)

Mordechay Goodstein (1):
      iwlwifi: sta: set max HE max A-MPDU according to HE capa

Moshe Shemesh (1):
      devlink: Fix reload stats structure

Namhyung Kim (2):
      perf record: Synthesize cgroup events only if needed
      perf stat: Use proper cpu for shadow stats

Namjae Jeon (1):
      cifs: fix a memleak with modefromsid

Nathan Chancellor (1):
      riscv: Explicitly specify the build id style in vDSO Makefile again

Nicholas Piggin (2):
      powerpc/64s: Fix KVM system reset handling when CONFIG_PPC_PSERIES=3D=
y
      powerpc/64s/exception: KVM Fix for host DSI being taken in HPT
guest MMU context

Oded Gabbay (1):
      habanalabs/gaudi: fix missing code in ECC handling

Oliver Hartkopp (1):
      can: af_can: can_rx_unregister(): remove WARN() statement from
list operation sanity check

Pankaj Sharma (1):
      can: m_can: m_can_dev_setup(): add support for bosch mcan version 3.3=
.0

Paolo Abeni (1):
      mptcp: fix NULL ptr dereference on bad MPJ

Paolo Bonzini (2):
      KVM: x86: handle !lapic_in_kernel case in kvm_cpu_*_extint
      KVM: x86: Fix split-irqchip vs interrupt injection window request

Parav Pandit (2):
      devlink: Hold rtnl lock while reading netdev attributes
      devlink: Make sure devlink instance and port are in same net namespac=
e

Paul Menzel (1):
      init/Kconfig: Fix CPU number in LOG_CPU_MAX_BUF_SHIFT description

Pavel Begunkov (2):
      io_uring: fix ITER_BVEC check
      io_uring: fix files grab/cancel race

Peter Chen (2):
      usb: cdns3: gadget: initialize link_trb as NULL
      usb: cdns3: gadget: calculate TD_SIZE based on TD

Peter Zijlstra (2):
      sched/idle: Fix arch_cpu_idle() vs tracing
      intel_idle: Fix intel_idle() vs tracing

Qu Wenruo (1):
      btrfs: qgroup: don't commit transaction when we already hold the hand=
le

Raju Rangoju (1):
      cxgb4: fix the panic caused by non smac rewrite

Ran Wang (1):
      spi: spi-nxp-fspi: fix fspi panic by unexpected interrupts

Randy Dunlap (4):
      media: media/platform/marvell-ccic: fix warnings when CONFIG_PM
is not enabled
      usb: typec: qcom-pmic-typec: fix builtin build errors
      arm64/fpsimd: add <asm/insn.h> to <asm/kprobes.h> to fix fpsimd build
      RISC-V: fix barrier() use in <vdso/processor.h>

Ricardo Dias (1):
      tcp: fix race condition when creating child sockets from syncookies

Rodrigo Siqueira (1):
      drm/amd/display: Avoid HDCP initialization in devices without output

Rohit Maheshwari (1):
      ch_ktls: lock is not freed

Rohith Surabattula (3):
      smb3: Call cifs reconnect from demultiplex thread
      smb3: Avoid Mid pending list corruption
      smb3: Handle error case during offload read path

Rui Miguel Silva (1):
      optee: add writeback to valid memory type

Sara Sharon (1):
      iwlwifi: mvm: fix kernel panic in case of assert during CSA

Sean Christopherson (1):
      MAINTAINERS: Update email address for Sean Christopherson

Serge Semin (1):
      spi: Take the SPI IO-mutex in the spi_setup() method

Shameer Kolothum (1):
      iommu: Check return of __iommu_attach_device()

Shay Agroskin (3):
      net: ena: handle bad request id in ena_netdev
      net: ena: set initial DMA width to avoid intel iommu issue
      net: ena: fix packet's addresses for rx_offset feature

Shiju Jose (1):
      ACPI/IORT: Fix doc warnings in iort.c

Shiraz Saleem (1):
      RDMA/i40iw: Address an mmap handler exploit in i40iw

Sonny Jiang (2):
      drm/amdgpu: fix SI UVD firmware validate resume fail
      drm/amdgpu: fix a page fault

Stanimir Varbanov (2):
      media: venus: venc: Fix setting of profile and level
      media: venus: pm_helpers: Fix kernel module reload

Stanley Chu (1):
      scsi: ufs: Fix race between shutdown and runtime resume flow

Stefano Garzarella (1):
      vsock/virtio: discard packets only when socket is really closed

Stephen Boyd (1):
      phy: qcom-qmp: Initialize another pointer to NULL

Stephen Rothwell (1):
      powerpc/64s: Fix allnoconfig build since uaccess flush

Sudeep Holla (1):
      cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK

Suravee Suthikulpanit (1):
      iommu/amd: Enforce 4k mapping for certain IOMMU data structures

Sven Joachim (1):
      builddeb: Fix rootless build in setuid/setgid directory

Sven Schnelle (1):
      s390: fix fpu restore in entry.S

Sylvain Lemieux (1):
      MAINTAINERS: Remove myself as LPC32xx maintainers

Sylwester Dziedziuch (1):
      i40e: Fix removing driver while bare-metal VFs pass traffic

Taehee Yoo (1):
      batman-adv: set .owner to THIS_MODULE

Thomas Zimmermann (1):
      drm/ast: Reload gamma LUT after changing primary plane's color format

Timo Witte (1):
      platform/x86: acer-wmi: add automatic keyboard background light
toggle key as KEY_LIGHTS_TOGGLE

Tom Rix (1):
      rtw88: fix fw_fifo_addr check

Tom Seewald (1):
      cxgb4: Fix build failure when CONFIG_TLS=3Dm

Tony Lindgren (5):
      ARM: OMAP2+: Fix location for select PM_GENERIC_DOMAINS
      ARM: OMAP2+: Fix missing select PM_GENERIC_DOMAINS_OF
      bus: ti-sysc: Fix reset status check for modules with quirks
      bus: ti-sysc: Fix bogus resetdone warning on enable for cpsw
      ARM: OMAP2+: Manage MPU state properly for omap_enter_idle_coupled()

Vadim Fedorenko (1):
      net/tls: missing received data after fast remote close

Vasily Gorbik (1):
      kbuild: remove unused OBJSIZE

Vineet Gupta (2):
      ARC: stack unwinding: don't assume non-current task is sleeping
      ARC: stack unwinding: reorganize how initial register state setup

Vitaly Kuznetsov (1):
      kvm: x86/mmu: Fix get_mmio_spte() on CPUs supporting 5-level PT

Vladimir Oltean (1):
      enetc: Let the hardware auto-advance the taprio base-time of 0

Wang Hai (1):
      ipv6: addrlabel: fix possible memory leak in ip6addrlbl_net_init

Wenpeng Liang (2):
      RDMA/hns: Fix wrong field of SRQ number the device supports
      RDMA/hns: Fix retry_cnt and rnr_cnt when querying QP

Will Deacon (2):
      arm64: pgtable: Fix pte_accessible()
      arm64: pgtable: Ensure dirty bit is preserved across pte_wrprotect()

Willem de Bruijn (1):
      sock: set sk_err to ee_errno on dequeue from errq

Xiaochen Shen (2):
      x86/resctrl: Remove superfluous kernfs_get() calls to prevent
refcount leak
      x86/resctrl: Add necessary kernfs_put() calls to prevent refcount lea=
k

Xiongfeng Wang (1):
      IB/mthca: fix return value of error branch in mthca_init_cq()

Xu Qiang (1):
      irqchip/gic-v3-its: Unconditionally save/restore the ITS state on sus=
pend

Yan Zhao (1):
      drm/i915/gvt: correct a false comment of flag F_UNALIGN

Yan-Hsuan Chuang (1):
      MAINTAINERS: update Yan-Hsuan's email address

Yixian Liu (1):
      RDMA/hns: Bugfix for memory window mtpt configuration

Yves-Alexis Perez (1):
      usbnet: ipheth: fix connectivity with iOS 14

Zenghui Yu (1):
      KVM: arm64: vgic-v3: Drop the reporting of GICR_TYPER.Last for usersp=
ace

Zhang Changzhong (2):
      bnxt_en: fix error return code in bnxt_init_one()
      bnxt_en: fix error return code in bnxt_init_board()

Zhang Qilong (2):
      usb: gadget: f_midi: Fix memleak in f_midi_alloc
      usb: gadget: Fix memleak in gadgetfs_fill_super

Zhen Lei (3):
      arm64: dts: broadcom: clear the warnings caused by empty dma-ranges
      arm64: dts: qcom: clear the warnings caused by empty dma-ranges
      perf diff: Fix error return value in __cmd_diff()

Zou Wei (1):
      phy: cpcap-usb: Use IRQF_ONESHOT

penghao (1):
      USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk for Lenovo
A630Z TIO built-in usb-audio card

xinhui pan (1):
      drm/amdgpu: Fix size calculation when init onchip memory


Grygorii Strashko (2):
      ARM: dts: am437x-l4: fix compatible for cpsw switch dt node
      bus: ti-sysc: suppress err msg for timers used as clockevent/source

Gustavo Pimentel (1):
      ARC: bitops: Remove unecessary operation and value

Hans de Goede (4):
      platform/x86: thinkpad_acpi: Do not report SW_TABLET_MODE on Yoga 11e
      platform/x86: thinkpad_acpi: Add BAT1 is primary battery quirk
for Thinkpad Yoga 11e 4th gen
      platform/x86: touchscreen_dmi: Add info for the Predia Basic tablet
      platform/x86: touchscreen_dmi: Add info for the Irbis TW118 tablet

Hao Si (1):
      soc: fsl: dpio: Get the cpumask through cpumask_of(cpu)

Hugh Dickins (1):
      mm: fix VM_BUG_ON(PageTail) and BUG_ON(PageWriteback)

Hui Su (1):
      trace: fix potenial dangerous pointer

Iakov 'Jake' Kirilenko (1):
      platform/x86: thinkpad_acpi: add P1 gen3 second fan support

Ioana Ciornei (1):
      dpaa2-eth: select XGMAC_MDIO for MDIO bus support

JC Kuo (1):
      arm64: tegra: Fix USB_VBUS_EN0 regulator on Jetson TX1

Jakub Kicinski (1):
      Documentation: netdev-FAQ: suggest how to post co-dependent series

Jamie Iles (2):
      KVM: arm64: Correctly align nVHE percpu data
      bonding: wait for sysfs kobject destruction before freeing struct sla=
ve

Janosch Frank (1):
      KVM: s390: pv: Mark mm as protected after the set secure
parameters and improve cleanup

Jens Axboe (1):
      tun: honor IOCB_NOWAIT flag

Jernej Skrabec (1):
      media: cedrus: h264: Fix check for presence of scaling matrix

Jesper Dangaard Brouer (1):
      MAINTAINERS: Update page pool entry

Johannes Berg (2):
      iwlwifi: pcie: limit memory read spin time
      iwlwifi: pcie: set LTR to avoid completion timeout

Johannes Thumshirn (1):
      btrfs: don't access possibly stale fs_info data for printing
duplicate device

John Ogness (1):
      printk: finalize records with trailing newlines

John Stultz (1):
      arm-smmu-qcom: Ensure the qcom_scm driver has finished probing

Jon Hunter (3):
      arm64: tegra: Disable the ACONNECT for Jetson TX2
      arm64: tegra: Correct the UART for Jetson Xavier NX
      arm64: tegra: Fix Tegra234 VDK node names

Joseph Qi (1):
      io_uring: fix shift-out-of-bounds when round up cq size

Julian Wiedmann (4):
      s390/qeth: make af_iucv TX notification call more robust
      s390/qeth: fix af_iucv notification race
      s390/qeth: fix tear down of async TX buffers
      net/af_iucv: set correct sk_protocol for child sockets

Kaixu Xia (1):
      platform/x86: toshiba_acpi: Fix the wrong variable assignment

Kenneth Feng (1):
      drm/amd/amdgpu: fix null pointer in runtime pm

Krzysztof Kozlowski (2):
      drm/exynos: depend on COMMON_CLK to fix compile tests
      nfc: s3fwrn5: use signed integer for parsing GPIO numbers

Lars Povlsen (1):
      spi: dw: Fix spi registration for controllers overriding CS

Lijun Pan (6):
      ibmvnic: fix call_netdevice_notifiers in do_reset
      ibmvnic: notify peers when failover and migration happen
      ibmvnic: skip tx timeout reset while in resetting
      ibmvnic: fix NULL pointer dereference in reset_sub_crq_queues
      ibmvnic: fix NULL pointer dereference in ibmvic_reset_crq
      ibmvnic: enhance resetting status check during module exit

Likun Gao (1):
      drm/amdgpu: update golden setting for sienna_cichlid

Lincoln Ramsay (1):
      aquantia: Remove the build_skb path

Linus Torvalds (1):
      Linux 5.10-rc6

Lionel Landwerlin (1):
      drm/i915/perf: workaround register corruption in OATAILPTR

Lu Baolu (1):
      x86/tboot: Don't disable swiotlb when iommu is forced on

Lukas Bulwahn (1):
      printk: remove unneeded dead-store assignment

Maciej Matuszczyk (1):
      arm64: dts: rockchip: Remove system-power-controller from pmic
on Odroid Go Advance

Manish Narani (1):
      firmware: xilinx: Fix SD DLL node reset issue

Marc Kleine-Budde (5):
      ARM: dts: dra76x: m_can: fix order of clocks
      can: gs_usb: fix endianess problem with candleLight firmware
      can: mcp251xfd: mcp251xfd_probe(): bail out if no IRQ was given
      can: m_can: m_can_open(): remove IRQF_TRIGGER_FALLING from
request_threaded_irq()'s flags
      can: m_can: fix nominal bitiming tseg2 min for version >=3D 3.1

Marc Zyngier (1):
      phy: tegra: xusb: Fix dangling pointer on probe failure

Marek Szyprowski (1):
      interconnect: fix memory trashing in of_count_icc_providers()

Markus Reichl (2):
      arm64: dts: rockchip: Assign a fixed index to mmc devices on
rk3399 boards.
      arm64: dts: rockchip: Reorder LED triggers from mmc devices on
rk3399-roc-pc.

Martin Habets (1):
      MAINTAINERS: Change Solarflare maintainers

Masami Hiramatsu (2):
      perf probe: Fix to die_entrypc() returns error correctly
      perf probe: Change function definition check due to broken DWARF

Mathieu Poirier (1):
      MAINTAINERS: Adding help for coresight subsystem

Matthias Maier (1):
      platform/x86: thinkpad_acpi: Whitelist P15 firmware for dual fan cont=
rol

Matti Hamalainen (1):
      drm/nouveau: fix relocations applying logic and a double-free

Mauro Carvalho Chehab (30):
      media: vidtv: reorganize includes
      media: vidtv: add error checks
      media: vidtv: don't use recursive functions
      media: vidtv: fix the name of the program
      media: vidtv: fix the tone generator logic
      media: vidtv: fix some notes at the tone generator
      media: vidtv: avoid data copy when initializing the multiplexer
      media: vidtv: avoid copying data for PES structs
      media: vidtv: do some cleanups at the driver
      media: vidtv: remove some unused functions
      media: vidtv: pre-initialize mux arrays
      media: vidtv: cleanup null packet initialization logic
      media: vidtv: improve EIT data
      media: vidtv: fix the network ID range
      media: vidtv: properly fill EIT service_id
      media: vidtv: add a PID entry for the NIT table
      media: vidtv: fix service type
      media: vidtv: fix service_id at SDT table
      media: vidtv: add date to the current event
      media: vidtv: simplify PSI write function
      media: vidtv: simplify the crc writing logic
      media: vidtv: cleanup PSI descriptor write function
      media: vidtv: cleanup PSI table header function
      media: vidtv: cleanup PAT write function
      media: vidtv: cleanup PMT write table function
      media: vidtv: simplify SDT write function
      media: vidtv: simplify NIT write function
      media: vidtv: simplify EIT write function
      media: vidtv.rst: update vidtv documentation
      media: vidtv.rst: add kernel-doc markups

Max Verevkin (1):
      platform/x86: intel-vbtn: Support for tablet mode on HP Pavilion
13 x360 PC

Maxim Mikityanskiy (1):
      net/tls: Protect from calling tls_dev_del for TLS RX twice

Maxime Ripard (11):
      drm/vc4: hdmi: Make sure our clock rate is within limits
      drm/vc4: hdmi: Block odd horizontal timings
      drm/vc4: kms: Switch to drmm_add_action_or_reset
      drm/vc4: kms: Remove useless define
      drm/vc4: kms: Rename NUM_CHANNELS
      drm/vc4: kms: Split the HVS muxing check in a separate function
      drm/vc4: kms: Document the muxing corner cases
      dt-bindings: display: Add a property to deal with WiFi coexistence
      drm/vc4: hdmi: Disable Wifi Frequencies
      drm/vc4: kms: Store the unassigned channel list in the state
      drm/vc4: kms: Don't disable the muxing of an active CRTC

Michael Chan (1):
      bnxt_en: Release PCI regions when DMA mask setup fails during probe.

Michael Ellerman (1):
      powerpc: Drop -me200 addition to build flags

Min Li (1):
      ptp: clockmatrix: bug fix for idtcm_strverscmp

Miquel Raynal (19):
      mtd: rawnand: gpio: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: xway: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: ams-delta: Move the ECC initialization to ->attach_chip=
()
      mtd: rawnand: au1550: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: cs553x: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: davinci: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: diskonchip: Move the ECC initialization to ->attach_chi=
p()
      mtd: rawnand: fsmc: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: lpc32xx_mlc: Move the ECC initialization to ->attach_ch=
ip()
      mtd: rawnand: lpc32xx_slc: Move the ECC initialization to ->attach_ch=
ip()
      mtd: rawnand: mpc5121: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: orion: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: txx9ndfmc: Move the ECC initialization to ->attach_chip=
()
      mtd: rawnand: tmio: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: pasemi: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: plat_nand: Move the ECC initialization to ->attach_chip=
()
      mtd: rawnand: r852: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: sharpsl: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: socrates: Move the ECC initialization to ->attach_chip(=
)

Mordechay Goodstein (1):
      iwlwifi: sta: set max HE max A-MPDU according to HE capa

Moshe Shemesh (1):
      devlink: Fix reload stats structure

Namhyung Kim (2):
      perf record: Synthesize cgroup events only if needed
      perf stat: Use proper cpu for shadow stats

Namjae Jeon (1):
      cifs: fix a memleak with modefromsid

Nathan Chancellor (1):
      riscv: Explicitly specify the build id style in vDSO Makefile again

Nicholas Piggin (2):
      powerpc/64s: Fix KVM system reset handling when CONFIG_PPC_PSERIES=3D=
y
      powerpc/64s/exception: KVM Fix for host DSI being taken in HPT
guest MMU context

Oded Gabbay (1):
      habanalabs/gaudi: fix missing code in ECC handling

Oliver Hartkopp (1):
      can: af_can: can_rx_unregister(): remove WARN() statement from
list operation sanity check

Pankaj Sharma (1):
      can: m_can: m_can_dev_setup(): add support for bosch mcan version 3.3=
.0

Paolo Abeni (1):
      mptcp: fix NULL ptr dereference on bad MPJ

Paolo Bonzini (2):
      KVM: x86: handle !lapic_in_kernel case in kvm_cpu_*_extint
      KVM: x86: Fix split-irqchip vs interrupt injection window request

Parav Pandit (2):
      devlink: Hold rtnl lock while reading netdev attributes
      devlink: Make sure devlink instance and port are in same net namespac=
e

Paul Menzel (1):
      init/Kconfig: Fix CPU number in LOG_CPU_MAX_BUF_SHIFT description

Pavel Begunkov (2):
      io_uring: fix ITER_BVEC check
      io_uring: fix files grab/cancel race

Peter Chen (2):
      usb: cdns3: gadget: initialize link_trb as NULL
      usb: cdns3: gadget: calculate TD_SIZE based on TD

Peter Zijlstra (2):
      sched/idle: Fix arch_cpu_idle() vs tracing
      intel_idle: Fix intel_idle() vs tracing

Qu Wenruo (1):
      btrfs: qgroup: don't commit transaction when we already hold the hand=
le

Raju Rangoju (1):
      cxgb4: fix the panic caused by non smac rewrite

Ran Wang (1):
      spi: spi-nxp-fspi: fix fspi panic by unexpected interrupts

Randy Dunlap (4):
      media: media/platform/marvell-ccic: fix warnings when CONFIG_PM
is not enabled
      usb: typec: qcom-pmic-typec: fix builtin build errors
      arm64/fpsimd: add <asm/insn.h> to <asm/kprobes.h> to fix fpsimd build
      RISC-V: fix barrier() use in <vdso/processor.h>

Ricardo Dias (1):
      tcp: fix race condition when creating child sockets from syncookies

Rodrigo Siqueira (1):
      drm/amd/display: Avoid HDCP initialization in devices without output

Rohit Maheshwari (1):
      ch_ktls: lock is not freed

Rohith Surabattula (3):
      smb3: Call cifs reconnect from demultiplex thread
      smb3: Avoid Mid pending list corruption
      smb3: Handle error case during offload read path

Rui Miguel Silva (1):
      optee: add writeback to valid memory type

Sara Sharon (1):
      iwlwifi: mvm: fix kernel panic in case of assert during CSA

Sean Christopherson (1):
      MAINTAINERS: Update email address for Sean Christopherson

Serge Semin (1):
      spi: Take the SPI IO-mutex in the spi_setup() method

Shameer Kolothum (1):
      iommu: Check return of __iommu_attach_device()

Shay Agroskin (3):
      net: ena: handle bad request id in ena_netdev
      net: ena: set initial DMA width to avoid intel iommu issue
      net: ena: fix packet's addresses for rx_offset feature

Shiju Jose (1):
      ACPI/IORT: Fix doc warnings in iort.c

Shiraz Saleem (1):
      RDMA/i40iw: Address an mmap handler exploit in i40iw

Sonny Jiang (2):
      drm/amdgpu: fix SI UVD firmware validate resume fail
      drm/amdgpu: fix a page fault

Stanimir Varbanov (2):
      media: venus: venc: Fix setting of profile and level
      media: venus: pm_helpers: Fix kernel module reload

Stanley Chu (1):
      scsi: ufs: Fix race between shutdown and runtime resume flow

Stefano Garzarella (1):
      vsock/virtio: discard packets only when socket is really closed

Stephen Boyd (1):
      phy: qcom-qmp: Initialize another pointer to NULL

Stephen Rothwell (1):
      powerpc/64s: Fix allnoconfig build since uaccess flush

Sudeep Holla (1):
      cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK

Suravee Suthikulpanit (1):
      iommu/amd: Enforce 4k mapping for certain IOMMU data structures

Sven Joachim (1):
      builddeb: Fix rootless build in setuid/setgid directory

Sven Schnelle (1):
      s390: fix fpu restore in entry.S

Sylvain Lemieux (1):
      MAINTAINERS: Remove myself as LPC32xx maintainers

Sylwester Dziedziuch (1):
      i40e: Fix removing driver while bare-metal VFs pass traffic

Taehee Yoo (1):
      batman-adv: set .owner to THIS_MODULE

Thomas Zimmermann (1):
      drm/ast: Reload gamma LUT after changing primary plane's color format

Timo Witte (1):
      platform/x86: acer-wmi: add automatic keyboard background light
toggle key as KEY_LIGHTS_TOGGLE

Tom Rix (1):
      rtw88: fix fw_fifo_addr check

Tom Seewald (1):
      cxgb4: Fix build failure when CONFIG_TLS=3Dm

Tony Lindgren (5):
      ARM: OMAP2+: Fix location for select PM_GENERIC_DOMAINS
      ARM: OMAP2+: Fix missing select PM_GENERIC_DOMAINS_OF
      bus: ti-sysc: Fix reset status check for modules with quirks
      bus: ti-sysc: Fix bogus resetdone warning on enable for cpsw
      ARM: OMAP2+: Manage MPU state properly for omap_enter_idle_coupled()

Vadim Fedorenko (1):
      net/tls: missing received data after fast remote close

Vasily Gorbik (1):
      kbuild: remove unused OBJSIZE

Vineet Gupta (2):
      ARC: stack unwinding: don't assume non-current task is sleeping
      ARC: stack unwinding: reorganize how initial register state setup

Vitaly Kuznetsov (1):
      kvm: x86/mmu: Fix get_mmio_spte() on CPUs supporting 5-level PT

Vladimir Oltean (1):
      enetc: Let the hardware auto-advance the taprio base-time of 0

Wang Hai (1):
      ipv6: addrlabel: fix possible memory leak in ip6addrlbl_net_init

Wenpeng Liang (2):
      RDMA/hns: Fix wrong field of SRQ number the device supports
      RDMA/hns: Fix retry_cnt and rnr_cnt when querying QP

Will Deacon (2):
      arm64: pgtable: Fix pte_accessible()
      arm64: pgtable: Ensure dirty bit is preserved across pte_wrprotect()

Willem de Bruijn (1):
      sock: set sk_err to ee_errno on dequeue from errq

Xiaochen Shen (2):
      x86/resctrl: Remove superfluous kernfs_get() calls to prevent
refcount leak
      x86/resctrl: Add necessary kernfs_put() calls to prevent refcount lea=
k

Xiongfeng Wang (1):
      IB/mthca: fix return value of error branch in mthca_init_cq()

Xu Qiang (1):
      irqchip/gic-v3-its: Unconditionally save/restore the ITS state on sus=
pend

Yan Zhao (1):
      drm/i915/gvt: correct a false comment of flag F_UNALIGN

Yan-Hsuan Chuang (1):
      MAINTAINERS: update Yan-Hsuan's email address

Yixian Liu (1):
      RDMA/hns: Bugfix for memory window mtpt configuration

Yves-Alexis Perez (1):
      usbnet: ipheth: fix connectivity with iOS 14

Zenghui Yu (1):
      KVM: arm64: vgic-v3: Drop the reporting of GICR_TYPER.Last for usersp=
ace

Zhang Changzhong (2):
      bnxt_en: fix error return code in bnxt_init_one()
      bnxt_en: fix error return code in bnxt_init_board()

Zhang Qilong (2):
      usb: gadget: f_midi: Fix memleak in f_midi_alloc
      usb: gadget: Fix memleak in gadgetfs_fill_super

Zhen Lei (3):
      arm64: dts: broadcom: clear the warnings caused by empty dma-ranges
      arm64: dts: qcom: clear the warnings caused by empty dma-ranges
      perf diff: Fix error return value in __cmd_diff()

Zou Wei (1):
      phy: cpcap-usb: Use IRQF_ONESHOT

penghao (1):
      USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk for Lenovo
A630Z TIO built-in usb-audio card

xinhui pan (1):
      drm/amdgpu: Fix size calculation when init onchip memory
