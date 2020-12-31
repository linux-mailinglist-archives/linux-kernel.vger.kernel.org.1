Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1065F2E7D84
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 01:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgLaAlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 19:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgLaAlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 19:41:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69774C061573
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 16:40:33 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 23so41106315lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 16:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M67MbkYLxSdOa9oNcNplN7jJDJwLu2PsQUeqJdvpyic=;
        b=OF7Nm9YBgnrjTgTX1Mc2Wj1H5W17rZ9V82YydDt4k3Mrc6s4zc7lm1sKO+HuivVfbJ
         0U3G4/JXxT0rhzgwQERoXxp7ISbvGFb9HypkINnGAaP5mIkT9B3SaFj6WASZmmVj3kPk
         TmBCtqHTl7LAFi8DUwmz6333VYwv7pgy4hM2VMW/oehTBo472dGWRjibuBArVOpEFlCO
         884sDfXr+LpMcjruQtiBJauoY7ZwM+O/IVhgeydBF+esVt7Hc9bFaRv6Mv53atUawC0w
         LRLcZhcu9gZ9u5b99QhVwj+lqJePjDXKl4VQEkVFS2kVOQVa1xoVyj6MdFkUutVGPTSB
         N5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M67MbkYLxSdOa9oNcNplN7jJDJwLu2PsQUeqJdvpyic=;
        b=IzF9nIjgyeAiParB8OxLNdDhgwhfNCgcuAKQFo+iM71uTyviMjAuWZMR0IjcIavaBZ
         eFN2LynVgO8kA8JB+R+wXs+fWO0nkVXUEDEmyjcOmCnTRujTuyUK4Q6pK3miUTD6WEhV
         m6woMA0ugmFKwHagSaU8/d5FDCJU6EqeTXWtzn4Iur3h4VrqPKgmjCLv5XaVjzis2REb
         LZhSG0FL5xDMc/uEO3IjOsDZsRjj6LLSBMgChODOe0BFegK6CcxySGJtlo1nygl0aG/2
         TVv5NnH1aGGrZgtefJbqu++I/S4J1juXNrM15uix9nwLE+pNL9K9G0iQKb6i5/0kGuqZ
         wphw==
X-Gm-Message-State: AOAM531bGyTPP3ZpqZoOJylsF+pfR2NzjmlWkxfjGjkg6f/Rm1AiY3aM
        S64S8ondNezJ/XVRwrynAfL632b7+JWogBcWU9U=
X-Google-Smtp-Source: ABdhPJwDI3T5RePav+oBWL1/QTVV3ixeyBUrivDpTU4GoQEcaDTmAqZRfVWlkXVAe1i/zpNCvghrjMaQvZ4MO5kgDac=
X-Received: by 2002:a2e:9787:: with SMTP id y7mr26688745lji.420.1609375230908;
 Wed, 30 Dec 2020 16:40:30 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsPsXSTh+WO2XESOU+Q1ocrWmS1c1YJFarzmA=woK_ke5Q@mail.gmail.com>
 <CABXGCsPBBDX3ozAgtT174nesiM+Gx4UkQi+PD27jB3i9OQ=G0g@mail.gmail.com> <MN2PR12MB4488AAA880BA8896EEA97491F7D80@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4488AAA880BA8896EEA97491F7D80@MN2PR12MB4488.namprd12.prod.outlook.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 31 Dec 2020 05:40:19 +0500
Message-ID: <CABXGCsO=6--KOALpNhj1439_wN65247A89dPwByR3e8w49Om1Q@mail.gmail.com>
Subject: Re: [bug] Radeon 3900XT not switch to graphic mode on kernel 5.10
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Dec 2020 at 20:15, Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> It looks like the driver is not able to access the firmware for some reason.  Please make sure it is available in your initrd or compiled into the kernel depending on your config.

Exactly! Thanks!

# lsinitrd /boot/initramfs-5.10.0-0.rc6.20201204git34816d20f173.92.fc34.x86_64.img
| grep sienna_cichlid

# ls /usr/lib/firmware/amdgpu | grep sienna_cichlid
sienna_cichlid_ce.bin
sienna_cichlid_dmcub.bin
sienna_cichlid_me.bin
sienna_cichlid_mec2.bin
sienna_cichlid_mec.bin
sienna_cichlid_pfp.bin
sienna_cichlid_rlc.bin
sienna_cichlid_sdma.bin
sienna_cichlid_smc.bin
sienna_cichlid_sos.bin
sienna_cichlid_ta.bin
sienna_cichlid_vcn.bin

# dracut -f --regenerate-all

# lsinitrd /boot/initramfs-5.10.0-0.rc6.20201204git34816d20f173.92.fc34.x86_64.img
| grep sienna_cichlid
-rw-r--r--   1 root     root       263296 Dec 15 14:00
usr/lib/firmware/amdgpu/sienna_cichlid_ce.bin
-rw-r--r--   1 root     root        80244 Dec 15 14:00
usr/lib/firmware/amdgpu/sienna_cichlid_dmcub.bin
-rw-r--r--   1 root     root       263424 Dec 15 14:00
usr/lib/firmware/amdgpu/sienna_cichlid_me.bin
-rw-r--r--   2 root     root       268592 Dec 15 14:00
usr/lib/firmware/amdgpu/sienna_cichlid_mec2.bin
-rw-r--r--   2 root     root            0 Dec 15 14:00
usr/lib/firmware/amdgpu/sienna_cichlid_mec.bin
-rw-r--r--   1 root     root       263424 Dec 15 14:00
usr/lib/firmware/amdgpu/sienna_cichlid_pfp.bin
-rw-r--r--   1 root     root       128592 Dec 15 14:00
usr/lib/firmware/amdgpu/sienna_cichlid_rlc.bin
-rw-r--r--   1 root     root        34048 Dec 15 14:00
usr/lib/firmware/amdgpu/sienna_cichlid_sdma.bin
-rw-r--r--   1 root     root       247396 Dec 15 14:00
usr/lib/firmware/amdgpu/sienna_cichlid_smc.bin
-rw-r--r--   1 root     root       215152 Dec 15 14:00
usr/lib/firmware/amdgpu/sienna_cichlid_sos.bin
-rw-r--r--   1 root     root       333568 Dec 15 14:00
usr/lib/firmware/amdgpu/sienna_cichlid_ta.bin
-rw-r--r--   1 root     root       504224 Dec 15 14:00
usr/lib/firmware/amdgpu/sienna_cichlid_vcn.bin

# grep '20201204git34816d20f173\|linux-firmware-20201218-116'
/var/log/dnf.rpm.log
2020-12-06T12:40:44+0500 SUBDEBUG Installed:
kernel-core-5.10.0-0.rc6.20201204git34816d20f173.92.fc34.x86_64
2020-12-06T12:40:46+0500 SUBDEBUG Installed:
kernel-modules-5.10.0-0.rc6.20201204git34816d20f173.92.fc34.x86_64
2020-12-06T12:41:03+0500 SUBDEBUG Installed:
kernel-5.10.0-0.rc6.20201204git34816d20f173.92.fc34.x86_64
2020-12-06T12:41:03+0500 SUBDEBUG Installed:
kernel-modules-extra-5.10.0-0.rc6.20201204git34816d20f173.92.fc34.x86_64
2020-12-21T10:52:43+0500 SUBDEBUG Upgrade:
linux-firmware-20201218-116.fc34.noarch

I think every update of linux-firmware should regenerate initramfs.
But my downstream report was closed:
https://bugzilla.redhat.com/show_bug.cgi?id=1911745

--
Best Regards,
Mike Gavrilov.
