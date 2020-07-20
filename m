Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1544B2265D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 17:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbgGTP5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 11:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730103AbgGTP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:57:33 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386B9C061794;
        Mon, 20 Jul 2020 08:57:31 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so13163161edq.8;
        Mon, 20 Jul 2020 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PvW3XVDy+rQEFwwQM6+F7fPiu+tQX07MeqjT24Y590=;
        b=qkNwFlO65sfUiFoIZ4iNnTliLA2k8RXzhtP23bl24kiTfg5EVrh1FeUAO4WT6x9nx0
         oQ7KjMNp61d20Xkv1PoYmrOTK4ukXCKirkEA6SnAVYof7VaQg8syuX4Du9jcm+/jreAm
         /ororTSMOuUTc69NFNR+pj0exx9lUMly1MhqQ43HRdT/tj3+JgVJewd4Ohjab9wPxRI9
         F7xKC1bVu8intaaKnV80KBVaAbAn8D3NkpN/H8o2shkmPuIQkNotD/GCh2J0bjHReFBk
         6Wo8k4bJ6JB6zeamO7J+pbF8fwHhWe1gUUv5EUxSuZaUppolDpCvr47WLcr6NgsdaUtC
         W/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PvW3XVDy+rQEFwwQM6+F7fPiu+tQX07MeqjT24Y590=;
        b=iHacFVBp9gGW/asXjyswRptc3OgVwEbNpqtBCmXxKKoBu0HHpfOeRA8EAaRjGUs2WY
         J97MJu6IZLpY20QR1ZarVaFIcNpakwzkjH16DvP/VSCeA4YRAm6B3Wv3mnZiUbxn1/h9
         4FZgDTkW8krQ+WAdefgb28sYzJAHx9Wi/Y3vLCI+rcTUrG9Qc/BooLcok8kYKd7h2d9Z
         QdtSqA1yyJRqhIl7q1qqpucchw8hNLNg0+nmIwK6bTS0OsdJ2VsT7MnUqtYGP6u7/Lkl
         BilGwDh8Do4BI8mIQ88v9TpSz62C5s1srt/1Mmg6/d9A1/WHbOpyjqRUr9YqhpivAwWS
         Fafg==
X-Gm-Message-State: AOAM5336aHDzo+DS+3fnnouYOozZZFnHXJTiO6gfunI6KDbBHhdSFkV4
        IiDvyB403qVLncSh0xL9sfcTCB3dZLQfhjGvZ7e8fDIJWUQ=
X-Google-Smtp-Source: ABdhPJyonBBTiMXUfR54zQA6LqT9AbdCsa3eg+/Tv/99i/hIC7tvYNSqrVF0C2Hhv4FEcx4cMke8IorXjqpIvtNpZgg=
X-Received: by 2002:a50:f392:: with SMTP id g18mr21561831edm.151.1595260649670;
 Mon, 20 Jul 2020 08:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuzqA0N6O-52uH9aHjsfF6HfhuxMby1Y6Yz7jGMAHW0zw@mail.gmail.com>
 <CAK8P3a1SHQKNNCVj9Gp25BLuXUC2nf7FuVrqfpPYQkvMbhjzFg@mail.gmail.com> <ad7ba016-c3eb-a833-e4d3-4cdcb53ca786@arm.com>
In-Reply-To: <ad7ba016-c3eb-a833-e4d3-4cdcb53ca786@arm.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 20 Jul 2020 08:58:04 -0700
Message-ID: <CAF6AEGsBRxFC918nNzJZnxMpFnNC6qcNGvMjjM8U3AAn6CusNA@mail.gmail.com>
Subject: Re: [Freedreno] arm64: Internal error: Oops: qcom_iommu_tlb_inv_context
 free_io_pgtable_ops on db410c
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Vinod Koul <vinod.koul@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <agross@kernel.org>, lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 4:28 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-07-20 08:17, Arnd Bergmann wrote:
> > On Mon, Jul 20, 2020 at 8:36 AM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> >>
> >> This kernel oops while boot linux mainline kernel on arm64  db410c device.
> >>
> >> metadata:
> >>    git branch: master
> >>    git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>    git commit: f8456690ba8eb18ea4714e68554e242a04f65cff
> >>    git describe: v5.8-rc5-48-gf8456690ba8e
> >>    make_kernelversion: 5.8.0-rc5
> >>    kernel-config:
> >> https://builds.tuxbuild.com/2aLnwV7BLStU0t1R1QPwHQ/kernel.config
> >
> > Thanks for the report. Adding freedreno folks to Cc, as this may have something
> > to do with that driver.
> >
> >>
> >> [    5.444121] Unable to handle kernel NULL pointer dereference at
> >> virtual address 0000000000000018
> >> [    5.456615]   ESR = 0x96000004
> >> [    5.464471]   SET = 0, FnV = 0
> >> [    5.464487]   EA = 0, S1PTW = 0
> >> [    5.466521] Data abort info:
> >> [    5.469971]   ISV = 0, ISS = 0x00000004
> >> [    5.472768]   CM = 0, WnR = 0
> >> [    5.476172] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000bacba000
> >> [    5.479349] [0000000000000018] pgd=0000000000000000, p4d=0000000000000000
> >> [    5.485820] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> >> [    5.492448] Modules linked in: crct10dif_ce adv7511(+)
> >> qcom_spmi_temp_alarm cec msm(+) mdt_loader qcom_camss videobuf2_dma_sg
> >> drm_kms_helper v4l2_fwnode videobuf2_memops videobuf2_v4l2 qcom_rng
> >> videobuf2_common i2c_qcom_cci display_connector socinfo drm qrtr ns
> >> rmtfs_mem fuse
> >> [    5.500256] CPU: 0 PID: 286 Comm: systemd-udevd Not tainted 5.8.0-rc5 #1
> >> [    5.522484] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> >> [    5.529170] pstate: 20000005 (nzCv daif -PAN -UAO BTYPE=--)
> >> [    5.535856] pc : qcom_iommu_tlb_inv_context+0x18/0xa8
> >> [    5.541148] lr : free_io_pgtable_ops+0x28/0x58
> >> [    5.546350] sp : ffff80001219b5f0
> >> [    5.550689] x29: ffff80001219b5f0 x28: 0000000000000013
> >> [    5.554078] x27: 0000000000000100 x26: ffff000036add3b8
> >> [    5.559459] x25: ffff80000915e910 x24: ffff00003a5458c0
> >> [    5.564753] x23: 0000000000000003 x22: ffff000036a37058
> >> [    5.570049] x21: ffff000036a3a100 x20: ffff000036a3a480
> >> [    5.575344] x19: ffff000036a37158 x18: 0000000000000000
> >> [    5.580639] x17: 0000000000000000 x16: 0000000000000000
> >> [    5.585935] x15: 0000000000000004 x14: 0000000000000368
> >> [    5.591229] x13: 0000000000000000 x12: ffff000039c61798
> >> [    5.596525] x11: ffff000039c616d0 x10: 0000000040000000
> >> [    5.601820] x9 : 0000000000000000 x8 : ffff000039c616f8
> >> [    5.607114] x7 : 0000000000000000 x6 : ffff000009f699a0
> >> [    5.612410] x5 : ffff80001219b520 x4 : ffff000036a3a000
> >> [    5.617705] x3 : ffff000009f69904 x2 : 0000000000000000
> >> [    5.623001] x1 : ffff8000107e27e8 x0 : ffff00003a545810
> >> [    5.628297] Call trace:
> >> [    5.633592]  qcom_iommu_tlb_inv_context+0x18/0xa8
> >
> > This means that dev_iommu_fwspec_get() has returned NULL
> > in qcom_iommu_tlb_inv_context(), either because dev->iommu
> > is NULL, or because dev->iommu->fwspec is NULL.
> >
> > qcom_iommu_tlb_inv_context() does not check for a NULL
> > pointer before using the returned object.
> >
> > The bug is either in the lack of error handling, or the fact
> > that it's possible to get into this function for a device
> > that has not been fully set up.
>
> Not quite - the device *was* properly set up, but has already been
> properly torn down again in the removal path by iommu_release_device().
> The problem is that qcom-iommu kept the device pointer as its TLB cookie
> for the domain, but the domain has a longer lifespan than the validity
> of that device - that's a fundamental design flaw in the driver.

fwiw, I just sent "iommu/qcom: Use domain rather than dev as tlb
cookie".. untested but looks like a straightforward enough change to
switch over to using the domain rather than dev as cookie

BR,
-R

>
> Robin.
>
> >> [    5.635764]  free_io_pgtable_ops+0x28/0x58
> >> [    5.640624]  qcom_iommu_domain_free+0x38/0x60
> >> [    5.644617]  iommu_group_release+0x4c/0x70
> >> [    5.649045]  kobject_put+0x6c/0x120
> >> [    5.653035]  kobject_del+0x64/0x90
> >> [    5.656421]  kobject_put+0xfc/0x120
> >> [    5.659893]  iommu_group_remove_device+0xdc/0xf0
> >> [    5.663281]  iommu_release_device+0x44/0x70
> >> [    5.668142]  iommu_bus_notifier+0xbc/0xd0
> >> [    5.672048]  notifier_call_chain+0x54/0x98
> >> [    5.676214]  blocking_notifier_call_chain+0x48/0x70
> >> [    5.680209]  device_del+0x26c/0x3a0
> >> [    5.684981]  platform_device_del.part.0+0x1c/0x88
> >> [    5.688453]  platform_device_unregister+0x24/0x40
> >> [    5.693316]  of_platform_device_destroy+0xe4/0xf8
> >> [    5.698002]  device_for_each_child+0x5c/0xa8
> >> [    5.702689]  of_platform_depopulate+0x3c/0x80
> >> [    5.707144]  msm_pdev_probe+0x1c4/0x308 [msm]
> >
> > It was triggered by a failure in msm_pdev_probe(), which was
> > calls of_platform_depopulate() in its error handling code.
> > This is a combination of two problems:
> >
> > a) Whatever caused msm_pdev_probe() to fail means that
> > the gpu won't be usable, though it should not have caused the
> > kernel to crash.
> >
> > b) the error handling itself causing additional problems due
> > to failed unwinding.
> >
> >> [    5.711286]  platform_drv_probe+0x54/0xa8
> >> [    5.715624]  really_probe+0xd8/0x320
> >> [    5.719617]  driver_probe_device+0x58/0xb8
> >> [    5.723263]  device_driver_attach+0x74/0x80
> >> [    5.727168]  __driver_attach+0x58/0xe0
> >> [    5.731248]  bus_for_each_dev+0x70/0xc0
> >> [    5.735067]  driver_attach+0x24/0x30
> >> [    5.738801]  bus_add_driver+0x14c/0x1f0
> >> [    5.742619]  driver_register+0x64/0x120
> >> [    5.746178]  __platform_driver_register+0x48/0x58
> >> [    5.750099]  msm_drm_register+0x58/0x70 [msm]
> >> [    5.754861]  do_one_initcall+0x54/0x1a0
> >> [    5.759200]  do_init_module+0x54/0x200
> >> [    5.762846]  load_module+0x1d1c/0x2300
> >> [    5.766664]  __do_sys_finit_module+0xd8/0xf0
> >> [    5.770398]  __arm64_sys_finit_module+0x20/0x30
> >> [    5.774826]  el0_svc_common.constprop.0+0x6c/0x168
> >> [    5.779078]  do_el0_svc+0x24/0x90
> >> [    5.783939]  el0_sync_handler+0x90/0x198
> >> [    5.787323]  el0_sync+0x158/0x180
> >> [    5.791323] Code: 910003fd f9417404 b4000484 f9401482 (b9401846)
> >> [    5.794532] ---[ end trace 3d6a53241629e560 ]---
> >>
> >> full crash log details.
> >> https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.8-rc5-48-gf8456690ba8e/testrun/2945157/suite/linux-log-parser/test/check-kernel-oops-1573988/log
> >
> > There are a couple of messages directly preceding the bug output that are
> > probably relevant here:
> >
> > [    5.259499] debugfs: Directory '1b0ac00.camss-vdda' with parent
> > 'smd:rpm:rpm-requests:pm8916-regulators-l2' already present!
> >           Starting Resize root filesystem to fit available disk space...
> >           Starting Start the WCN core...
> > [[0;32m  OK  [0m] Started Network Service.
> > [[0;32m  OK  [0m] Started QRTR service.
> > [    5.352993] adreno 1c00000.gpu: Adding to iommu group 1
> > [    5.357489] msm_mdp 1a01000.mdp: Adding to iommu group 2
> > [    5.357757] msm_mdp 1a01000.mdp: No interconnect support may cause
> > display underflows!
> > [    5.366215] adv7511 3-0039: supply dvdd not found, using dummy regulator
> > [    5.378036] msm 1a00000.mdss: supply vdd not found, using dummy regulator
> > [    5.378715] msm_mdp 1a01000.mdp: [drm:mdp5_bind [msm]] MDP5 version v1.6
> > [    5.380549] adv7511 3-0039: supply pvdd not found, using dummy regulator
> > [    5.384606] msm 1a00000.mdss: bound 1a01000.mdp (ops mdp5_ops [msm])
> > [    5.394368] adv7511 3-0039: supply a2vdd not found, using dummy regulator
> > [    5.397633] msm_dsi 1a98000.dsi: supply gdsc not found, using dummy regulator
> > [    5.411897] msm_dsi 1a98000.dsi: supply gdsc not found, using dummy regulator
> > [    5.420207] msm_dsi_manager_register: failed to register mipi dsi
> > host for DSI 0
> > [    5.425717] platform 1a01000.mdp: Removing from iommu group 2
> > [[0;1;31mFAILED[0m] Failed to start Entropy Daemon based on the HAVEGE
> > algorithm.[    5.444121] Unable to handle kernel NULL pointer
> > dereference at virtual address 0000000000000018
> >
> > See 'systemctl status haveged.service' for detai[    5.456615]   ESR =
> > 0x96000004
> > ls.
> > [    5.464471]   SET = 0, FnV = 0
> > [    5.464487]   EA = 0, S1PTW = 0
> >
> >          Arnd
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno
