Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386CF28C8FC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 09:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbgJMHJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 03:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbgJMHJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 03:09:24 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACFEC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 00:09:22 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b1so17586819lfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 00:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KC1mZXARGtkTctLye+KjyZ7VTAKnhcLVAL4MUBQYG14=;
        b=TIsH7J6p4CYPcfThPuZmnvKha+RD7r/G7ahC1suGPCPl/C28/YTeh/X3m/ae4P7yYk
         nSCxcgSPHqXMglRfjDuBkNoBGvvqk5KzsXrwlRBdUqtRiHzrn7TV20pUZEN6Nava2741
         Hyk5cJCqBvn6KVlex3XSqnlSwlKxRqyN/O5PfKOi0vBcOHV2ooej8/C1YMBOzAAlzs5A
         VE6zLrmLSGgm9/54iuplsjM+O4gY+Sbph1J7NUNQK15TOASm2Y/CNcMK9qGguzgRn5/h
         nOsGr2S2p1oRGFDJ3b/G6AWT2ZzU8w5D3UTulHSfxquGzubs7jpT0oM4u0AjEPL7F/eY
         75OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KC1mZXARGtkTctLye+KjyZ7VTAKnhcLVAL4MUBQYG14=;
        b=ac1NETT2qfXAoUF1QtYemJsPKKw6xIa/QY7DN60ACdF6Pd49TWK2vL+4l9p87LbzBF
         0kDQIyS3AfAPjvuBlFSJvl3k9+Q2MoCKnXEXW9nLmICYiM3QENSSobVWk4LvEw568xX0
         0jxETUzCXlCiL+oIdUsNA+fFjsVehqWg/Slbvc//HgND1rBrytSliXhn5GxFC66oXmzw
         R+Sv8bDoxbl9qGbVVw7WyTq7MHskVKimg9Q4OgB3LkjnNABeMB1IOFRNcIyof/WDILih
         qAAuX20AHN/dVvxGExwKu/vxFHm1uUGzyCM55ewyFlI0PPDaePPk0EGpdlcFehkpAerI
         L6VA==
X-Gm-Message-State: AOAM531zdAKVuNgD/S28SSjaIDrO/PH2JNEmNZ1OpVsN3+BitZeUtJ3C
        7tFNjfQo04bBIiv3bE/W0bK/DWvc+7xbRg==
X-Google-Smtp-Source: ABdhPJx8F9Pb55iM81nT0HhqfRJXGzQAeQqVAleRJTG7ItxJxmYbMT7yuiFRH1DxmoQbjGlIi//k3Q==
X-Received: by 2002:a19:344:: with SMTP id 65mr8762799lfd.393.1602572961301;
        Tue, 13 Oct 2020 00:09:21 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id y14sm3518370lfl.136.2020.10.13.00.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 00:09:20 -0700 (PDT)
Date:   Tue, 13 Oct 2020 09:09:18 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [GIT PULL] TEE fix for v5.10
Message-ID: <20201013070918.GA3328976@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small fix which reenables the kernel login method in the
kernel internal TEE client API. This fixes a problem introduced in v5.8.

Thanks,
Jens

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-fix-for-v5.10

for you to fetch changes up to 722939528a37aa0cb22d441e2045c0cf53e78fb0:

  tee: client UUID: Skip REE kernel login method as well (2020-10-13 08:42:11 +0200)

----------------------------------------------------------------
Reenable kernel login method for kernel TEE client API

The kernel TEE login method was accidentally disabled previously when
enabling a few other login methods, so fix that here.

----------------------------------------------------------------
Sumit Garg (1):
      tee: client UUID: Skip REE kernel login method as well

 drivers/tee/tee_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
