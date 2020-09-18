Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5000A2701F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgIRQRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgIRQRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:17:34 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6144A2388B;
        Fri, 18 Sep 2020 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600445853;
        bh=ho1VWQbLbOtje9GQ7Qn1/lVsBLoS2i28TOVmW5ta3O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sDj3KDgcPb5LJ5pH3kczeSnO1teCPz/HTPdRCHpnUmVGdSRolSriWVM5i0E03dBMa
         QBRn0pScTnySu84yhqjzjUAYgdP38TRLWuFymPELyHxw72gHaVlBzwc6vfLDEEFpdf
         +ZQmejX6u7sCI7VA/dJeHQSeqZY2oSrOO4rchje4=
From:   Will Deacon <will@kernel.org>
To:     Mark Salter <msalter@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] drivers/perf: xgene_pmu: Fix uninitialized resource struct
Date:   Fri, 18 Sep 2020 17:17:16 +0100
Message-Id: <160043609212.3788171.12089834011515299398.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200915204110.326138-1-msalter@redhat.com>
References: <20200915204110.326138-1-msalter@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 16:41:09 -0400, Mark Salter wrote:
> This splat was reported on newer Fedora kernels booting on certain
> X-gene based machines:
> 
>  xgene-pmu APMC0D83:00: X-Gene PMU version 3
>  Unable to handle kernel read from unreadable memory at virtual \
>  address 0000000000004006
>  ...
>  Call trace:
>   string+0x50/0x100
>   vsnprintf+0x160/0x750
>   devm_kvasprintf+0x5c/0xb4
>   devm_kasprintf+0x54/0x60
>   __devm_ioremap_resource+0xdc/0x1a0
>   devm_ioremap_resource+0x14/0x20
>   acpi_get_pmu_hw_inf.isra.0+0x84/0x15c
>   acpi_pmu_dev_add+0xbc/0x21c
>   acpi_ns_walk_namespace+0x16c/0x1e4
>   acpi_walk_namespace+0xb4/0xfc
>   xgene_pmu_probe_pmu_dev+0x7c/0xe0
>   xgene_pmu_probe.part.0+0x2c0/0x310
>   xgene_pmu_probe+0x54/0x64
>   platform_drv_probe+0x60/0xb4
>   really_probe+0xe8/0x4a0
>   driver_probe_device+0xe4/0x100
>   device_driver_attach+0xcc/0xd4
>   __driver_attach+0xb0/0x17c
>   bus_for_each_dev+0x6c/0xb0
>   driver_attach+0x30/0x40
>   bus_add_driver+0x154/0x250
>   driver_register+0x84/0x140
>   __platform_driver_register+0x54/0x60
>   xgene_pmu_driver_init+0x28/0x34
>   do_one_initcall+0x40/0x204
>   do_initcalls+0x104/0x144
>   kernel_init_freeable+0x198/0x210
>   kernel_init+0x20/0x12c
>   ret_from_fork+0x10/0x18
>  Code: 91000400 110004e1 eb08009f 540000c0 (38646846)
>  ---[ end trace f08c10566496a703 ]---
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] drivers/perf: xgene_pmu: Fix uninitialized resource struct
      https://git.kernel.org/will/c/a76b8236edcf
[2/2] drivers/perf: thunderx2_pmu: Fix memory resource error handling
      https://git.kernel.org/will/c/688494a407d1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
