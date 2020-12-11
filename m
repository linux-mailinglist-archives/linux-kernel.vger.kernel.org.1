Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BB52D7A19
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394047AbgLKP5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:57:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43426 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390243AbgLKP4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:56:39 -0500
Received: from zn.tnic (p200300ec2f1243001aca9a018be89b1b.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:4300:1aca:9a01:8be8:9b1b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F10EB1EC0283;
        Fri, 11 Dec 2020 16:55:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607702158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=Wk20W9o+oBR4Y7j7QLiN431q4nnn5/lI7oRCb6pYJn4=;
        b=YhYEOW6Bq666YL1g0gQ0mXuIVu34aNve69ajIv0OTQO/Se3LJxDd7tjmRKXHT8ROuS8YpY
        73E9UWDuBXllCYiLWMDRhuloygunuNdCc8THxUlry8HTCr4zLNAHi3I1zThhuHG2ifL3P9
        VYf+pkGbaWo3jlVr0PQdCpkcDEm+Y0c=
Date:   Fri, 11 Dec 2020 16:55:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chiawen Huang <chiawen.huang@amd.com>
Cc:     Tony Cheng <Tony.Cheng@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
Message-ID: <20201211155553.GC25974@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

patch in $Subject breaks booting on a laptop here, GPU details are
below. The machine stops booting right when it attempts to switch modes
during boot, to a higher mode than the default VGA one. Machine doesn't
ping and is otherwise unresponsive so that a hard reset is the only
thing that helps.

Reverting that patch ontop of -rc7 fixes it and the machine boots just fine.

Thx.

[    1.628086] ata1.00: supports DRM functions and may not be fully accessible
[    1.632050] ata1.00: supports DRM functions and may not be fully accessible
[    1.895818] [drm] amdgpu kernel modesetting enabled.
[    1.897628] [drm] initializing kernel modesetting (CARRIZO 0x1002:0x9874 0x103C:0x807E 0xC4).
[    1.898256] [drm] register mmio base: 0xD0C00000
[    1.898422] [drm] register mmio size: 262144
[    1.898583] [drm] add ip block number 0 <vi_common>
[    1.898759] [drm] add ip block number 1 <gmc_v8_0>
[    1.898931] [drm] add ip block number 2 <cz_ih>
[    1.899082] [drm] add ip block number 3 <gfx_v8_0>
[    1.899241] [drm] add ip block number 4 <sdma_v3_0>
[    1.899439] [drm] add ip block number 5 <powerplay>
[    1.899573] [drm] add ip block number 6 <dm>
[    1.899693] [drm] add ip block number 7 <uvd_v6_0>
[    1.899827] [drm] add ip block number 8 <vce_v3_0>
[    1.911458] [drm] BIOS signature incorrect 5b 7
[    1.912551] [drm] UVD is enabled in physical mode
[    1.912707] [drm] VCE enabled in physical mode
[    1.912921] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
[    1.913837] [drm] Detected VRAM RAM=512M, BAR=512M
[    1.913998] [drm] RAM width 128bits UNKNOWN
[    1.915149] [drm] amdgpu: 512M of VRAM memory ready
[    1.915306] [drm] amdgpu: 3072M of GTT memory ready.
[    1.915468] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    1.916139] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
[    1.918733] [drm] Found UVD firmware Version: 1.91 Family ID: 11
[    1.918950] [drm] UVD ENC is disabled
[    1.919680] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
[    1.925963] [drm] DM_PPLIB: values for Engine clock
[    1.926106] [drm] DM_PPLIB:   300000
[    1.926205] [drm] DM_PPLIB:   360000
[    1.926304] [drm] DM_PPLIB:   423530
[    1.926404] [drm] DM_PPLIB:   514290
[    1.926516] [drm] DM_PPLIB:   626090
[    1.926629] [drm] DM_PPLIB:   720000
[    1.926743] [drm] DM_PPLIB: Validation clocks:
[    1.926952] [drm] DM_PPLIB:    engine_max_clock: 72000
[    1.927117] [drm] DM_PPLIB:    memory_max_clock: 80000
[    1.927281] [drm] DM_PPLIB:    level           : 8
[    1.927435] [drm] DM_PPLIB: values for Display clock
[    1.927594] [drm] DM_PPLIB:   300000
[    1.927708] [drm] DM_PPLIB:   400000
[    1.927822] [drm] DM_PPLIB:   496560
[    1.927936] [drm] DM_PPLIB:   626090
[    1.928048] [drm] DM_PPLIB:   685720
[    1.928161] [drm] DM_PPLIB:   757900
[    1.928275] [drm] DM_PPLIB: Validation clocks:
[    1.928419] [drm] DM_PPLIB:    engine_max_clock: 72000
[    1.928584] [drm] DM_PPLIB:    memory_max_clock: 80000
[    1.928748] [drm] DM_PPLIB:    level           : 8
[    1.928901] [drm] DM_PPLIB: values for Memory clock
[    1.929058] [drm] DM_PPLIB:   333000
[    1.929172] [drm] DM_PPLIB:   800000
[    1.929403] [drm] DM_PPLIB: Validation clocks:
[    1.929549] [drm] DM_PPLIB:    engine_max_clock: 72000
[    1.929716] [drm] DM_PPLIB:    memory_max_clock: 80000
[    1.929919] [drm] DM_PPLIB:    level           : 8
[    1.930148] [drm] Display Core initialized with v3.2.104!
[    2.003938] [drm] UVD initialized successfully.
[    2.204023] [drm] VCE initialized successfully.
[    2.206228] [drm] fb mappable at 0xA0EE4000
[    2.206375] [drm] vram apper at 0xA0000000
[    2.206514] [drm] size 14745600
[    2.206654] [drm] fb depth is 24
[    2.206760] [drm]    pitch is 10240
[    2.207123] fbcon: amdgpudrmfb (fb0) is primary device
[    2.301263] amdgpu 0000:00:01.0: [drm] fb0: amdgpudrmfb frame buffer device
[    2.320735] [drm] Initialized amdgpu 3.40.0 20150101 for 0000:00:01.0 on minor 0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
