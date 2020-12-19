Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB352DF01E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 16:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgLSPEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 10:04:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46315 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726578AbgLSPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 10:04:54 -0500
X-UUID: 6534e6a8078f4023a85528671528bead-20201219
X-UUID: 6534e6a8078f4023a85528671528bead-20201219
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 955308409; Sat, 19 Dec 2020 23:04:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 19 Dec 2020 23:04:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 19 Dec 2020 23:04:04 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <oliver.sang@intel.com>
CC:     <alexandru.elisei@arm.com>, <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <lkp@intel.com>,
        <lkp@lists.01.org>, <matthias.bgg@gmail.com>,
        <sumit.garg@linaro.org>, <will@kernel.org>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] kernel/watchdog_hld.c: Fix access percpu in preemptible context  
Date:   Sat, 19 Dec 2020 23:04:06 +0800
Message-ID: <20201219150406.16925-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201219135917.GA26344@xsang-OptiPlex-9020>
References: <20201219135917.GA26344@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks a lot, I'll try to fix this in anthoer way(patch v2) to avoid
regreesion other than arm64

BRs,
Lecopzer


> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 6e37d53a67753bcb12a0b9102cac85d98f8a0453 ("[PATCH] kernel/watchdog_hld.c: Fix access percpu in preemptible context")
> url: https://github.com/0day-ci/linux/commits/Lecopzer-Chen/kernel-watchdog_hld-c-Fix-access-percpu-in-preemptible-context/20201217-211549
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git accefff5b547a9a1d959c7e76ad539bf2480e78b
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
