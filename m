Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CBF23F79D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Aug 2020 14:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHHMma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Aug 2020 08:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgHHMma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 08:42:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54DC820759;
        Sat,  8 Aug 2020 12:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596890549;
        bh=SWr7mbgb0LFTY8eo82wTQXIfIFfCF0eRMwNZ30VVbVA=;
        h=Date:From:To:Cc:Subject:From;
        b=XN27fBtTc/zRu+oFp+flnBx27QxSxMm8GizjgfhM6RlFBt0lXMmRdZ0uQQQo2fOUE
         TojQNUD7xxkMr/quX1HuoizejakJcNLt/Lp8wUCIXvGM9FcuF33gJvH/e0SO+FW/LZ
         3GwpeDk24v3VfuMK/D5EHBUz3nehhTnwmVDjNkAk=
Date:   Sat, 8 Aug 2020 14:42:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Gavin Shan <gshan@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [PATCH] fix arm64 build with lack of __cpu_logical_map exported
Message-ID: <20200808124242.GA352821@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently Linus's tree fails with the following build error on arm64
makeallmodconfig:
	ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!

Seems that kernel.ci also notices this for the past 2 days:
	https://lore.kernel.org/r/5f2c97ab.1c69fb81.160f4.0196@mx.google.com
	https://lore.kernel.org/r/5f2ab734.1c69fb81.24b16.8537@mx.google.com

Fix this up by just exporting the symbol.  Don't know if it's the
"right" fix, but it solves the build error for my machines.

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 87e81d29e6fb..b421a4756793 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -275,6 +275,7 @@ static int __init reserve_memblock_reserved_regions(void)
 arch_initcall(reserve_memblock_reserved_regions);
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
+EXPORT_SYMBOL_GPL(__cpu_logical_map);
 
 void __init __no_sanitize_address setup_arch(char **cmdline_p)
 {

