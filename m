Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F374C1A78C0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 12:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438633AbgDNKtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 06:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438467AbgDNKls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:41:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED16C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 03:40:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l14so4928201ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=T179D3eRoLN88D7RVCyrh7LHaNyQ/yslwq1ZnFtDWfY=;
        b=vEhh+JxWP9awgfSYyZmQklmj9E6jnGIYPWxmYvYQ5ktndWXGJ0LRdD7gvaQ5rN6Ko/
         oYdPE9ixMM5XH1rTgc/+kFbL+czFilxujz0tVU927wZb2HJ5FvadVVH6Bh48L9WmbjlR
         7mzF5y+OSstsSnbrPYySELvJQaAbOd8zcWgT/3pbNyEJV9SZ2Cq8kdkXisaIgbNVOF+e
         5rpC0sFxG5ajjCSyCDvzTvZtpIawtC2yXlevHSN27nprMGKf1YA/nBNQOCVmD9kiAVik
         zqpH5LbL7p+as/SqMCnMHpupf04SJpZxG7IIjvrZCZ8GqBJm7LIWQJ74fo/EZ/iNosEE
         ieUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=T179D3eRoLN88D7RVCyrh7LHaNyQ/yslwq1ZnFtDWfY=;
        b=CisbZoMpbbw/vfgmMa64mzyyqWlpDV/UVJeJ25fOUD4Cj8SG+VMWjvsQ9NuWNOsJkX
         txzl5IEfeGUqvIA35vJ5kd71JLSg4/JVPgSrNtOEOxztkw7+zYKyNZTlmTdVg88ETE7b
         Hq57e052fp/Kgytr2e39aj1E22pD3Lf59NDdE0yGfK0YpN+Cu63pVeIDnzzATB4CoNhA
         eoObOx394BOqAeKQISmf5hgc/c7+rSjmC/PkvmRso7657+cNTHGXClFwyeE1e5dLi2K2
         UAzA9Mxhrn4JTHOBGa8Lvlq7nJY0dMZSoGCM3w7vabxbOgH+i3IwgW84q0nQQYtrl8mV
         2U9g==
X-Gm-Message-State: AGi0PuZHLAfL4ce4ToTDuNGlsvuW/g8T7oda3yoOzPxZammxPRu3FR6Q
        c1tmqDwHAglDHm8pKGl1YM4WYG/wioXEfcTapQ39Uyo=
X-Google-Smtp-Source: APiQypJdA8WYcdWypF3dQJflQVPMgqJ+D8ao2y8YfEyEysxIXuW1/pN3rwwf86feYl4/YJQayvAuu0Es6M8ogXiAJtY=
X-Received: by 2002:a2e:6c0a:: with SMTP id h10mr12753268ljc.195.1586860850303;
 Tue, 14 Apr 2020 03:40:50 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date:   Tue, 14 Apr 2020 12:40:39 +0200
Message-ID: <CADDKRnBdM_T1W=iECrt89hmAmbRRyskGhS4d3ozTz1nWj_i_qQ@mail.gmail.com>
Subject: Kernel V5.7-rc1 doesn't boot (EFI?)
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting my notebook with kernel V57-rc1 I get following
display:

exit_boot() failed!
efi_main() failed!
StartImage failed: Buffer Too Small

Booting Kernel V5.6 works well.

From dmesg (kernel V5.6):
efi: EFI v2.31 by Phoenix Technologies Ltd.
efi:  ACPI=3D0xdcffe000  ACPI 2.0=3D0xdcffe014  SMBIOS=3D0xdce80000  RNG=3D=
0xdc3cd198
efi: seeding entropy pool
efi: [Firmware Bug]: Invalid EFI memory map entries:
efi: mem47: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
|  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
efi: mem48: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
|  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
efi: mem49: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
|  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
efi: mem50: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
|  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
efi: mem51: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
|  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
efi: Removing 5 invalid memory map entries.


Thanks, J=C3=B6rg
