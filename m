Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE4927B823
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgI1Xac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgI1Xab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:30:31 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 035D8221F0;
        Mon, 28 Sep 2020 22:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601331209;
        bh=qdtguGj7ne+ICu2uA97EARbs+7YgMRGmUqPTIeWFLpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1tVa9SAf2kvB497uNwINCTVZX6ja6bSDcTjsV3A5sQFdphcV5rxWwGyRTBdrCMq2
         SrKZcFF9dD63kaqvBsxr8kIJXrUDNazcYgg24EBAHHhtmzHN/p/Mt0jD3ZeuoSK+Xd
         ynbZ7hRU3ZHKRh6PkIfr+btQRu0ibZfUyBJusRRk=
From:   Will Deacon <will@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, sumit.garg@linaro.org,
        swboyd@chromium.org, maz@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 0/7] arm_pmu: Use NMI for perf interrupt
Date:   Mon, 28 Sep 2020 23:13:20 +0100
Message-Id: <160131601790.1815118.3633273002766662278.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200924110706.254996-1-alexandru.elisei@arm.com>
References: <20200924110706.254996-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 12:06:59 +0100, Alexandru Elisei wrote:
> The series changes the arm_pmu driver to use NMIs for the perf interrupt
> when NMIs are available on the platform (currently, only arm64 + GICv3). To
> make it easier to play with the patches, I've pushed a branch at [1]:
> 
> $ git clone -b pmu-nmi-v7 git://linux-arm.org/linux-ae
> 
> The changes from v6 were minor, but I've still run the same tests on an
> espressobin v7*. These are the results of running perf record -a -- sleep
> 60 (all results show kernel symbols with overhead >= 1%):
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/7] arm64: perf: Add missing ISB in armv8pmu_enable_counter()
      https://git.kernel.org/will/c/490d7b7c0845
[2/7] arm64: perf: Avoid PMXEV* indirection
      https://git.kernel.org/will/c/0fdf1bb75953
[3/7] arm64: perf: Remove PMU locking
      https://git.kernel.org/will/c/2a0e2a02e4b7
[4/7] arm64: perf: Defer irq_work to IPI_IRQ_WORK
      https://git.kernel.org/will/c/05ab72813340
[5/7] KVM: arm64: pmu: Make overflow handler NMI safe
      https://git.kernel.org/will/c/95e92e45a454
[6/7] arm_pmu: Introduce pmu_irq_ops
      https://git.kernel.org/will/c/f76b130bdb89
[7/7] arm_pmu: arm64: Use NMIs for PMU
      https://git.kernel.org/will/c/d8f6267f7ce5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
