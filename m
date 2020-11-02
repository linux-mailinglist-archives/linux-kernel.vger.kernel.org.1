Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3ACE2A252C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgKBH3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgKBH3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:29:03 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1E2C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 23:29:03 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r12so4954542iot.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 23:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=LC4LD7vOLpY4WiibJdTNoTsnGYU+uUDvNd7qqbKW02w=;
        b=L+UzVL2nPt4s62aX/op3HOiEnnRYY4wqo5f/Uovf0Nt95ZYrT3gu9n1YHCBazzOX5f
         jkLW2g3qtEGLDKOtZpCL04FuBnkJ9dtfN3RPMg+ackRZazjpgSAwVH2Nd0SBrhpl53PJ
         XMhVlWz8RO0CaxUPHRcQB+xn2VKMs6N17w0EKMdtwdOGSfKADkKr/VBW8xiHJ8NXG5Cq
         zXlkkPkRRdm88twaAVEp+cIP3qGgL3Y48bbcqGSz4+e8F0F2bKAdtl9a2JkUcHL+HSkf
         vbf9LnuwnTkKDIE/u0ffp+lEZt7k1lrU5cIL7Qj3Zpl87eHJniFY4zL7BuqsphqXQEXM
         CEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=LC4LD7vOLpY4WiibJdTNoTsnGYU+uUDvNd7qqbKW02w=;
        b=MLyGrKNBc8kUkRcX/tRCa0vhS6/W5AYdyuv0RDUYPnaIJbT5h75xLPG1yWMU4yCG3J
         U7NIUNBmTq9WNdfkmPNk3/8qvwREiRDlPbOLt8yo+uvAFecLGlSNf3wl/M2QNKR8Q2rA
         uzFmPiEAyH9eonwHTqzaXV2ceLISiVukbKEQKnKiPJiNqesnK4OftwLv1l1aJYemkzBu
         7UWBX3RaTZzC1JQuiKIicrhsYSyPcSdt2FcHtLbBc3sYMm0U3gbM/Wuoav2kpmCiEnwd
         bfAMaTErGZ9S/3BmELDdcgAaX2r3hopruepPwxMtGi+1VsjBH3f26Ku2QS6IupwpFli7
         q76w==
X-Gm-Message-State: AOAM530LbK413HwKRcOWTpVg3xMHVoi0WWRBIo8Kzlah+6Lw5ZD3BHux
        tJKTCKdsOzrb04l3TTLZmdU=
X-Google-Smtp-Source: ABdhPJyh6lD72OdnXc+HxglsY9xt3UO3iQph7UWSKAL/4W0Bw3q4XJaJDqhX2+DUAZQeNtjworHP/A==
X-Received: by 2002:a02:cd02:: with SMTP id g2mr10863414jaq.22.1604302142843;
        Sun, 01 Nov 2020 23:29:02 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id z87sm11173713ilf.9.2020.11.01.23.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 23:29:02 -0800 (PST)
Date:   Mon, 2 Nov 2020 00:29:00 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Hard lockup on Raspberry Pi 4 after v5.10-rc1
Message-ID: <20201102072900.GA2124436@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Starting with v5.10-rc1, I appear to be experiencing hard lockups on my
Raspberry Pi 4 when compiling LLVM. My standard workflow for testing the
Raspberry Pi 4 has been compiling tip of tree LLVM (to catch host
AArch64 issues), compiling linux-next ARCH=arm64 defconfig, then booting
it with QEMU + KVM, which has caught a few issues so far. Starting with
v5.10-rc1, compiling LLVM causes the serial console to print junk like

 |▒pp▒p▒p▒p
 p|▒|▒|p▒p▒p|▒▒|▒|▒|p|▒▒|▒|▒|
 p▒pp▒▒▒|▒▒
 ▒
 ▒|▒|▒▒▒▒
 p▒
 ▒
 ▒▒
 ▒
 ▒p|p

then I lose my mosh connection and I see the lights on the front of the
Pi stop blinking.

I have managed to narrow it down to a commit somewhere in the armsoc DT
merge.

Good: 2e368dd2bbea ("Merge tag 'armsoc-drivers' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc")
Bad: e533cda12d8f ("Merge tag 'armsoc-dt' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc")

I have not been able to complete a full bisect due to a lack of time
unfortunately, I am sending this email to hopefully get some more eyes
on the issue.

$ head -n6 /boot/config.txt
# My settings
enable_uart=1
core_freq_min=500
kernel=Image
os_prefix=custom-mainline-gcc-arm64/
upstream_kernel=1

$ cat /boot/.firmware_revision
e8ddac7cd34b179efd702d4dc1efd0ccf44559b9

I can reproduce the issue with:

$ git clone --depth=1 https://github.com/llvm/llvm-project

$ mkdir -p llvm-project/build && cd llvm-project/build

$ cmake \
-G Ninja \
-DCMAKE_BUILD_TYPE=Release \
-DLLVM_ENABLE_PROJECTS="clang;lld" \
../llvm &&
ninja

If you need any more information or testing, please let me know!

Cheers,
Nathan
