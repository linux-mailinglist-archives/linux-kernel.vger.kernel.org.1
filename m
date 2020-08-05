Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819DE23CFFD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 21:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgHET1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 15:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgHERMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:12:35 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE69C0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 10:12:20 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k23so46628723iom.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=KkfsA9tbt51JhKe8sFTLvMpREroWrtYLfSyGKrepgnc=;
        b=sV/MLpudecnRU4GQxONhClJttWv3PUwHU66kJKLWiHum4YhBiyGbSz5MhfOBgXKOrr
         MKWe2ljEQ952stDe2dXiAh2gsZbWP9Z/HXkK2PxOkyxkjpUXWT6VYx0bhDB6qKEvtgAo
         0+8VpahpNTwnAPH32jAbzyTPZe00UK+uDCwUv51GlJVhvbo8Zy9YpIrVKbiPtA4iVEXe
         +O7bnZ7s/S+pDsjGSV9MVUNIi9PE1F0kTWRdUSroboeB0xUzpHzmdYlthsVDyMwIu8FR
         VzFuVtzTc3Jt62SIS85GIC7n8Iks7jgVMsvpNqFG4dlxCxIlwObJfeuAbSYL+Um7ewcM
         nY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=KkfsA9tbt51JhKe8sFTLvMpREroWrtYLfSyGKrepgnc=;
        b=fafwCy6/DkJA0BAqyzvJskDC6vXWOQTA6HQI5pBdpFqne8InNdAk2k0XXztvp0AkpS
         jFjQw72itpqtU3akD6joq7kMVzQthyp0UofES92eO1S1GWwYbU/fsaaq8SKP4+K+AOxA
         VirhcghQ2Q0QgbEtsKgFcdSihJU5/JGPMydZBCwpDFT843aXfBisVB5hYC8eu8g7X/7F
         4aTPfvEdHOsq+AfCNHAK8Uiez0kIim2pOxWc5u89O+9boB/Cj9qb5UhVZMgl43l+bzdp
         5xTsh5Ep8nTJWEyRoGEyjMz59IC9e1GTS0LWpgEbL/qEn/sq0lCzB04v4Vo7wQO20YdL
         63Sw==
X-Gm-Message-State: AOAM530WYTGdks6JsQudX5gEcCu6tJnpTvBrtnoZrTP/fPLdiTkB2ZR0
        87bUu0qeqj7EmWPFjaCcT7pS86hNV9yNjpC5IOKsuw==
X-Google-Smtp-Source: ABdhPJydvkbI8JuH0DRGc8fl99fy8gEfBBiNspPdGBUDSlzEmjUkpG8MId4QwMHSc07sfLFkkrPwZ1DMKb81MUx1Ntg=
X-Received: by 2002:a05:6638:1614:: with SMTP id x20mr5286536jas.92.1596647539517;
 Wed, 05 Aug 2020 10:12:19 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 5 Aug 2020 22:42:08 +0530
Message-ID: <CA+G9fYtpsT23+xXkOfhBt3RP6MeHKjQCrmgF921mDdwQ+wZu2g@mail.gmail.com>
Subject: stable rc 4.4 - v4.4.232-33-g0b3898baf614 - build breaks on arm64,
 arm, x86_64 and i386.
To:     linux- stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Jiang Ying <jiangying8582@126.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, wanglong19@meituan.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stable rc 4.4 build breaks on arm64, arm, x86_64 and i386.

Here are the build log failures on arm64.
   git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-s=
table-rc.git
    target_arch: arm64
    toolchain: gcc-9
    git_short_log: 0b3898baf614 (\Linux 4.4.233-rc1\)
    git_sha: 0b3898baf61459e1f963dcf893b4683174668975
    git_describe: v4.4.232-33-g0b3898baf614
    kernel_version: 4.4.233-rc1

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
aarch64-linux-gnu-gcc" O=3Dbuild Image
#
../arch/arm64/kernel/hw_breakpoint.c: In function =E2=80=98arch_bp_generic_=
fields=E2=80=99:
../arch/arm64/kernel/hw_breakpoint.c:348:5: note: parameter passing
for argument of type =E2=80=98struct arch_hw_breakpoint_ctrl=E2=80=99 chang=
ed in GCC
9.1
  348 | int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
      |     ^~~~~~~~~~~~~~~~~~~~~~
../fs/ext4/inode.c: In function =E2=80=98ext4_direct_IO=E2=80=99:
../fs/ext4/inode.c:3355:9: error: =E2=80=98offset=E2=80=99 redeclared as di=
fferent
kind of symbol
 3355 |  loff_t offset =3D iocb->ki_pos;
      |         ^~~~~~
../fs/ext4/inode.c:3349:17: note: previous definition of =E2=80=98offset=E2=
=80=99 was here
 3349 |          loff_t offset)
      |          ~~~~~~~^~~~~~
make[3]: *** [../scripts/Makefile.build:277: fs/ext4/inode.o] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:484: fs/ext4] Error 2
../drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning:
array =E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element
   32 | static const struct acpi_device_id xgene_enet_acpi_match[];
      |                                    ^~~~~~~~~~~~~~~~~~~~~
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/linux/Makefile:1006: fs] Error 2
make[1]: Target 'Image' not remade because of errors.
make: *** [Makefile:152: sub-make] Error 2
make: Target 'Image' not remade because of errors.

--=20
Linaro LKFT
https://lkft.linaro.org
