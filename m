Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8E02DB093
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgLOPxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgLOPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:52:02 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B357C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:51:22 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id q25so19789307otn.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qSE8ZXqSYA1eNXc7k0UndW9BwjCEDLY1saGS6vnBF3k=;
        b=trX67BFB27FJYvRH6iSo8mz5xvRWHIkhGb/cndX2mZZAxq8Q0EFx1hIqYhwyiRSHNq
         4xmxv96nWWPEUvL1rOXGz+40aIcuqAPFchiqXvo9Di/cq0OUJsgZk9c6B8tiPtvK4b7J
         P+Bee2cB44+feSRankBK7T52zF0sa/PZJ0irhOCAAh/ruDwRxbxdHHrVsjOMIc8YAv2+
         hldXe09CJhmQfyoc0rZ5Zxiq4QQN/ZdsO7I8jHUv8l/GREZ5KuWHJfX/Z1v1k4wqprXH
         RuFkU78tMH43NpnZLogoev2AUTvNhlBzYkOKJzdwM6HhhrEAH33XWqMSk6c5AhVsl475
         uPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qSE8ZXqSYA1eNXc7k0UndW9BwjCEDLY1saGS6vnBF3k=;
        b=hBwhX7kCnWdqHiaiPBWqu6fXnL6D6zeMVAWURBK+HzTgMSGThb1JR/UtS0IeqW/3Ct
         bIVm67iCZNkv/phmFT6R8zDjSA9C6wfh3LU1iXHsequfM0VHfppRN7mU6zvVEWxGSiTJ
         +fETb5Gv1RtbBpQOws0zSZKYcmibZhHCTF/84LuVImDWvQNb0zKfFkxnzEo0YJqM/YJr
         0H/F00CY7ScuF54DMUlZiEPO0F3CFucsNsamN/rd1EYT7B/iG9yMxyaqU7Y40CTaUQ/M
         tF7QfrsXQo6QDH4LlK4b6SpBsR6sCLwtlZ5i1+hSnJb0JaSPLJAdnXBvYMqGQ47Ft8uo
         fpQw==
X-Gm-Message-State: AOAM533gKbVmx17aMqQp1wxU45vr4vxTfqmg2PvJu94AqXLkMwzR5Y1I
        O3kRaiKeFE8NmsFkfhu5uq9LhXChu0U9Fk2tD9o=
X-Google-Smtp-Source: ABdhPJy5B7G6xO7zA7cn13n4Ck5Td7SzQQORFDVEUT9WyWiJG5nlSjw3M3BfwKqhb6oCdbfQPtUXIZrrYvDmArS/PgY=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr23736177otg.311.1608047481581;
 Tue, 15 Dec 2020 07:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20201211155553.GC25974@zn.tnic> <CADnq5_MHqWqOd5ZngitF4UUDoZsh+fPrYJtHpJMbJdjAhFfhew@mail.gmail.com>
 <20201215154948.3muy72twmmstd3a3@outlook.office365.com>
In-Reply-To: <20201215154948.3muy72twmmstd3a3@outlook.office365.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Dec 2020 10:51:10 -0500
Message-ID: <CADnq5_Nere729YJ0KWWjc16RtESS=smjAkCtF4_XMGaeyHPVWw@mail.gmail.com>
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, Harry Wentland <hwentlan@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Chiawen Huang <chiawen.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 10:49 AM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> Hi Alex,
>
> I made the below patch that might fix the issue; I need to hear Boris's
> feedback first. Alex, did you already revert it?

I have not reverted it yet.

Alex

>
> * https://patchwork.freedesktop.org/series/84965/
>
> Thanks
>
> On 12/14, Alex Deucher wrote:
> > On Fri, Dec 11, 2020 at 11:49 AM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > Hi,
> > >
> > > patch in $Subject breaks booting on a laptop here, GPU details are
> > > below. The machine stops booting right when it attempts to switch mod=
es
> > > during boot, to a higher mode than the default VGA one. Machine doesn=
't
> > > ping and is otherwise unresponsive so that a hard reset is the only
> > > thing that helps.
> > >
> > > Reverting that patch ontop of -rc7 fixes it and the machine boots jus=
t fine.
> >
> > + a few more display folks
> >
> > This patch looks like a correctness fix, but not critical.  Unless
> > anyone has a proper fix handy, I'll just revert it for now and we can
> > revisit it properly.
> >
> > Alex
> >
> >
> > >
> > > Thx.
> > >
> > > [    1.628086] ata1.00: supports DRM functions and may not be fully a=
ccessible
> > > [    1.632050] ata1.00: supports DRM functions and may not be fully a=
ccessible
> > > [    1.895818] [drm] amdgpu kernel modesetting enabled.
> > > [    1.897628] [drm] initializing kernel modesetting (CARRIZO 0x1002:=
0x9874 0x103C:0x807E 0xC4).
> > > [    1.898256] [drm] register mmio base: 0xD0C00000
> > > [    1.898422] [drm] register mmio size: 262144
> > > [    1.898583] [drm] add ip block number 0 <vi_common>
> > > [    1.898759] [drm] add ip block number 1 <gmc_v8_0>
> > > [    1.898931] [drm] add ip block number 2 <cz_ih>
> > > [    1.899082] [drm] add ip block number 3 <gfx_v8_0>
> > > [    1.899241] [drm] add ip block number 4 <sdma_v3_0>
> > > [    1.899439] [drm] add ip block number 5 <powerplay>
> > > [    1.899573] [drm] add ip block number 6 <dm>
> > > [    1.899693] [drm] add ip block number 7 <uvd_v6_0>
> > > [    1.899827] [drm] add ip block number 8 <vce_v3_0>
> > > [    1.911458] [drm] BIOS signature incorrect 5b 7
> > > [    1.912551] [drm] UVD is enabled in physical mode
> > > [    1.912707] [drm] VCE enabled in physical mode
> > > [    1.912921] [drm] vm size is 64 GB, 2 levels, block size is 10-bit=
, fragment size is 9-bit
> > > [    1.913837] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
> > > [    1.913998] [drm] RAM width 128bits UNKNOWN
> > > [    1.915149] [drm] amdgpu: 512M of VRAM memory ready
> > > [    1.915306] [drm] amdgpu: 3072M of GTT memory ready.
> > > [    1.915468] [drm] GART: num cpu pages 262144, num gpu pages 262144
> > > [    1.916139] [drm] PCIE GART of 1024M enabled (table at 0x000000F40=
0900000).
> > > [    1.918733] [drm] Found UVD firmware Version: 1.91 Family ID: 11
> > > [    1.918950] [drm] UVD ENC is disabled
> > > [    1.919680] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
> > > [    1.925963] [drm] DM_PPLIB: values for Engine clock
> > > [    1.926106] [drm] DM_PPLIB:   300000
> > > [    1.926205] [drm] DM_PPLIB:   360000
> > > [    1.926304] [drm] DM_PPLIB:   423530
> > > [    1.926404] [drm] DM_PPLIB:   514290
> > > [    1.926516] [drm] DM_PPLIB:   626090
> > > [    1.926629] [drm] DM_PPLIB:   720000
> > > [    1.926743] [drm] DM_PPLIB: Validation clocks:
> > > [    1.926952] [drm] DM_PPLIB:    engine_max_clock: 72000
> > > [    1.927117] [drm] DM_PPLIB:    memory_max_clock: 80000
> > > [    1.927281] [drm] DM_PPLIB:    level           : 8
> > > [    1.927435] [drm] DM_PPLIB: values for Display clock
> > > [    1.927594] [drm] DM_PPLIB:   300000
> > > [    1.927708] [drm] DM_PPLIB:   400000
> > > [    1.927822] [drm] DM_PPLIB:   496560
> > > [    1.927936] [drm] DM_PPLIB:   626090
> > > [    1.928048] [drm] DM_PPLIB:   685720
> > > [    1.928161] [drm] DM_PPLIB:   757900
> > > [    1.928275] [drm] DM_PPLIB: Validation clocks:
> > > [    1.928419] [drm] DM_PPLIB:    engine_max_clock: 72000
> > > [    1.928584] [drm] DM_PPLIB:    memory_max_clock: 80000
> > > [    1.928748] [drm] DM_PPLIB:    level           : 8
> > > [    1.928901] [drm] DM_PPLIB: values for Memory clock
> > > [    1.929058] [drm] DM_PPLIB:   333000
> > > [    1.929172] [drm] DM_PPLIB:   800000
> > > [    1.929403] [drm] DM_PPLIB: Validation clocks:
> > > [    1.929549] [drm] DM_PPLIB:    engine_max_clock: 72000
> > > [    1.929716] [drm] DM_PPLIB:    memory_max_clock: 80000
> > > [    1.929919] [drm] DM_PPLIB:    level           : 8
> > > [    1.930148] [drm] Display Core initialized with v3.2.104!
> > > [    2.003938] [drm] UVD initialized successfully.
> > > [    2.204023] [drm] VCE initialized successfully.
> > > [    2.206228] [drm] fb mappable at 0xA0EE4000
> > > [    2.206375] [drm] vram apper at 0xA0000000
> > > [    2.206514] [drm] size 14745600
> > > [    2.206654] [drm] fb depth is 24
> > > [    2.206760] [drm]    pitch is 10240
> > > [    2.207123] fbcon: amdgpudrmfb (fb0) is primary device
> > > [    2.301263] amdgpu 0000:00:01.0: [drm] fb0: amdgpudrmfb frame buff=
er device
> > > [    2.320735] [drm] Initialized amdgpu 3.40.0 20150101 for 0000:00:0=
1.0 on minor 0
> > >
> > >
> > > --
> > > Regards/Gruss,
> > >     Boris.
> > >
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fp=
eople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=3D04%7C01%7CRodri=
go.Siqueira%40amd.com%7C36709b101b6e4c353e7e08d8a07a1d89%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637435793657547591%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd=
ata=3DCpb2l3OjKBeFwx%2FHIf%2F0d%2BSFiJL46p7Bct3JAIThSZ8%3D&amp;reserved=3D0
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRo=
drigo.Siqueira%40amd.com%7C36709b101b6e4c353e7e08d8a07a1d89%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637435793657547591%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp=
;sdata=3DXdoPAac6FCjulOvtOsdzO4rh5Qd9wwNIi%2B%2F5lvkaUoI%3D&amp;reserved=3D=
0
>
> --
> Rodrigo Siqueira
> https://siqueira.tech
