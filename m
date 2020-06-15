Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55E51F8CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 05:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgFODrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 23:47:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48192 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgFODrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 23:47:05 -0400
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1jkg5O-0004u4-NX
        for linux-kernel@vger.kernel.org; Mon, 15 Jun 2020 03:47:02 +0000
Received: by mail-oi1-f198.google.com with SMTP id q65so4515243oig.15
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 20:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gLj1m6P/PsBOj+/yO4bax2TzGsrqf3sQFXrDZYfsUSU=;
        b=T0EDTXVKF64BuOkHLkeVRdebioWm0x9COc/0iE5PCLjBYyq6XII4TOKgLdcjA1hfPl
         s04aWM3pV+g1+xHvYqRTd/Xa8IbxxzbE8Sngdkw56X9LnXhizqg7QFET6A+CfN4gsYRW
         QpoirK/vzOjeqqBn3dwB5/yI1Qed/ji1NbAWCyhe2zSSPfOy2dJakE4EePOTRGCLqmiH
         n0dDTxUAqkO6M0y3bS6iwPxmTW+kHjLR2HN/qd3f+/mDkeEFfvMlc5JnqNOw5FHeh4uo
         /OuefI4rxeM3G1SHNk7lvsu8Rn3OkgiZS8tPfsmNxKAF4itbd9dpI8E3a0UKcQFS0z2A
         A8oA==
X-Gm-Message-State: AOAM5317V/S+ZqLkj9xhcNSRqNSOQ1tbHNyBY8fKc+p2DA0wbbJfS91F
        fZujvIi8hngW5GE9SOvuAbVGQwZBB1g68nNAyCChtkA4Z605cu+eG+1bJ1M4ocP2xqULsazEFsl
        /6Dl6KdgdXelqc9KtLwFKHGo+yinKsyuFhMLoLBmWQ8/rz+BfgH9Sa41Baw==
X-Received: by 2002:aca:4dc3:: with SMTP id a186mr7707136oib.17.1592192821756;
        Sun, 14 Jun 2020 20:47:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1eA2syoGY3ouBbg27yDaHoLb0qZMhWd1yZDnOXkdZehKjxXYqlXFUvzm7HmbNlQZfkgvjNqKaQWVhUIHQOZw=
X-Received: by 2002:aca:4dc3:: with SMTP id a186mr7707130oib.17.1592192821489;
 Sun, 14 Jun 2020 20:47:01 -0700 (PDT)
MIME-Version: 1.0
From:   Koba Ko <koba.ko@canonical.com>
Date:   Mon, 15 Jun 2020 11:46:50 +0800
Message-ID: <CAJB-X+VcHvYWngtMVHw5f_XaqA4i4T61yt=h7YvuD=eo3y7Rog@mail.gmail.com>
Subject: [Issue]platform/x86: iommu: System can't shutdown because iommu
 driver keeps checking the status of DMA_GSTS_TES
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi All,
I have a machine and there's only intel gpu.
the secureboot and vt-d is enabled in BIOS.
On the Ubuntu desktop, I do s2idle first and restart the machine.
The machine can't restart successfully, so I need to press the power
button to shutdown.
I tried  each of the following and the issue can't be triggered.
1. disable secure boot in BIOS.
2. intel_iommu=off.
3. intel_iomm=igfx_off.
4. nomodeset
5. i915.modeset=0.

After I investigate further, find inte_iommu keeps checking the status
of DMA_GSTS_TES.
During the procedure of restart, the driver would disable iommu translation and
check the status of DMA_GSTS_TES until status of DMA_GSTS_TES is 0.

If you need more information, I can provide it.

Thanks
Koba Ko
