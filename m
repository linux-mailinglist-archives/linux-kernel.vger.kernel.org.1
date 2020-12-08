Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03082D1ECA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 01:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgLHAKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 19:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgLHAKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:10:39 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE67C061749;
        Mon,  7 Dec 2020 16:09:59 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id o144so14568073ybg.7;
        Mon, 07 Dec 2020 16:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DPzrHqRCyZ5GHQe1sNkjeAT3AQ+rjPlPOpL9YVHWpQM=;
        b=pRRN4gMkJW/+MCm02wILJP3S3SwvjSQC/ydCEjLIQcIN+XXwdh9u7nBDXiLQUzoZ54
         NfOTAlroCteZfJI1/Eqw30bxWrvQuZZMprS0VeIM2FP/SvlnYh1X3e05cTPKwnroBdFJ
         S9ptoJY84D4TMA9C3FZ5WOUFarTtc5+jzGlJ+U0JIHE5r2qWQr4ROqmhOPS/+L7jQqgq
         IZW68uKaj4fspqBoQJYDSm/UTt6zm+rYN4j8tfiQnKvySKgJAZ5Jj/99nCeg9C1UG5+M
         Q0Wy/HYyN01SHPaeCsr2rsUtHESD59PNw/tP5TV8vUhm9ntlPc7Uy0RnfXVOi/l/6Mhw
         vNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DPzrHqRCyZ5GHQe1sNkjeAT3AQ+rjPlPOpL9YVHWpQM=;
        b=i3sqKsUxHoAxerG62FvutV5iIjRuezldzpu9Z/HpNPE+tvp4UuEkhQnYBTc2j9RTW5
         90xOqHsf6kzb16C0OTJNd0ZMCCekqa8HjGv3zot2RFjD7yoIVPEXu13irhRt6VnkO5Eo
         j60FmiZ5SmSrR1WxcUwbwp1YaGEuCxCO+nxcaMfiWENT6Sf4G4OlGFOouEysfF14qnPH
         5TbztYjR1nFfw+08NeDvsFLlQbJGKfxk6aCM3FCxfIElSU14/KYREct74EzagPQhMf7W
         852ksBXlNiSVFNIQIKXmSBVLyIWRnzrIqPwIx/yS4+tfm8FzPGShaBLLJ69dSFswdGUr
         b4Cg==
X-Gm-Message-State: AOAM532HU0thGQvy807HAII1RtkB3sRk4/oKNXqG9R53tOcRQK6iwEt8
        GUAzxByUjSurWWieFhn542mWJO3sazAUmo/pmwi8IAIxOfE=
X-Google-Smtp-Source: ABdhPJz3kD0lri3EvJQP8l7Wfw09EOxFwBZnEhaA+VT7lVFg9MVzc6v4mhzUK6k79Cz0ptLox1emkKHcoZE+ovDKWZg=
X-Received: by 2002:a05:6902:100f:: with SMTP id w15mr19058584ybt.25.1607386198579;
 Mon, 07 Dec 2020 16:09:58 -0800 (PST)
MIME-Version: 1.0
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 8 Dec 2020 03:09:47 +0300
Message-ID: <CADxRZqwn0uUi+J3bN=uLYMpXYhcYpkQb68Vkgmg70Tn87mhzOw@mail.gmail.com>
Subject: [sparc64] current git kernel networking is broken
To:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     debian-sparc <debian-sparc@lists.debian.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Sorry for the late report, being 5.10-rc7 is out, but current git
kernel (git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git)
is broken with the networking. It affects my openvpn tunnel and even
internet networking.

ping to a local ethernet network (i.e. gateway ping) works, but i
cannot download files from the internet.
openvpn tunnel does not work.

bisected kernel to the following commit:

linux-2.6$ git bisect good
fdf8bee96f9aeaac4559725c2dfae6e1bd7b7043 is the first bad commit
commit fdf8bee96f9aeaac4559725c2dfae6e1bd7b7043
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Jul 19 18:31:07 2020 -0400

    sparc64: propagate the calling convention changes down to
__csum_partial_copy_...()

    ... and rename them into csum_and_copy_...() - the wrappers become
pointless.
    [braino fixed]

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

 arch/sparc/include/asm/checksum.h    |  1 +
 arch/sparc/include/asm/checksum_32.h |  2 --
 arch/sparc/include/asm/checksum_64.h | 41 +++---------------------------------
 arch/sparc/lib/csum_copy.S           |  5 +++--
 arch/sparc/lib/csum_copy_from_user.S |  4 ++--
 arch/sparc/lib/csum_copy_to_user.S   |  4 ++--
 6 files changed, 11 insertions(+), 46 deletions(-)



full git bisect log:

$ git bisect log
git bisect start
# bad: [0477e92881850d44910a7e94fc2c46f96faa131f] Linux 5.10-rc7
git bisect bad 0477e92881850d44910a7e94fc2c46f96faa131f
# good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
git bisect good bbf5c979011a099af5dc76498918ed7df445635b
# bad: [4d0e9df5e43dba52d38b251e3b909df8fa1110be] lib, uaccess: add
failure injection to usercopy functions
git bisect bad 4d0e9df5e43dba52d38b251e3b909df8fa1110be
# bad: [f888bdf9823c85fe945c4eb3ba353f749dec3856] Merge tag
'devicetree-for-5.10' of
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect bad f888bdf9823c85fe945c4eb3ba353f749dec3856
# bad: [57218d7f2e87069f73c7a841b6ed6c1cc7acf616] Merge tag
'regmap-v5.10' of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
git bisect bad 57218d7f2e87069f73c7a841b6ed6c1cc7acf616
# bad: [39a5101f989e8d2be557136704d53990f9b402c8] Merge branch 'linus'
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad 39a5101f989e8d2be557136704d53990f9b402c8
# good: [ed016af52ee3035b4799ebd7d53f9ae59d5782c4] Merge tag
'locking-core-2020-10-12' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good ed016af52ee3035b4799ebd7d53f9ae59d5782c4
# good: [50d228345a03c882dfe11928ab41b42458b3f922] Merge tag
'docs-5.10' of git://git.lwn.net/linux
git bisect good 50d228345a03c882dfe11928ab41b42458b3f922
# good: [0f5e8323777bfc1c1d2cba71242db6a361de03b6] crypto:
arm/sha512-neon - avoid ADRL pseudo instruction
git bisect good 0f5e8323777bfc1c1d2cba71242db6a361de03b6
# good: [c2fb644638ae45cc4a34aa51a18d687d4781f8a1] hwrng: npcm -
modify readl to readb
git bisect good c2fb644638ae45cc4a34aa51a18d687d4781f8a1
# bad: [85ed13e78dbedf9433115a62c85429922bc5035c] Merge branch
'work.iov_iter' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect bad 85ed13e78dbedf9433115a62c85429922bc5035c
# good: [1cd95ab85df730b140156baac92fd2640290a5e5] mips: propagate the
calling convention change down into __csum_partial_copy_..._user()
git bisect good 1cd95ab85df730b140156baac92fd2640290a5e5
# good: [598b3cec831fd6ccb3cbe4919a722e868c6364a8] fs: remove
compat_sys_vmsplice
git bisect good 598b3cec831fd6ccb3cbe4919a722e868c6364a8
# bad: [70d65cd555c5e43c613700f604a47f7ebcf7b6f1] ppc: propagate the
calling conventions change down to csum_partial_copy_generic()
git bisect bad 70d65cd555c5e43c613700f604a47f7ebcf7b6f1
# bad: [fdf8bee96f9aeaac4559725c2dfae6e1bd7b7043] sparc64: propagate
the calling convention changes down to __csum_partial_copy_...()
git bisect bad fdf8bee96f9aeaac4559725c2dfae6e1bd7b7043
# good: [2a5d2bd159f33ef34484ee14705dcf8634061f2c] xtensa: propagate
the calling conventions change down into csum_partial_copy_generic()
git bisect good 2a5d2bd159f33ef34484ee14705dcf8634061f2c
# first bad commit: [fdf8bee96f9aeaac4559725c2dfae6e1bd7b7043]
sparc64: propagate the calling convention changes down to
__csum_partial_copy_...()
