Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B8026030A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgIGRmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 13:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731452AbgIGRmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:42:06 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8967721532;
        Mon,  7 Sep 2020 17:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599500526;
        bh=iQ6qU+p1kul7XA65aVrIsOjiv+KvNamQwNm54D34ArA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMKtX/2/EqCq/p/njnJ73yIEEOQ7MEdyZmvdFZH5ep1GSIAHSgsu64t57C/B3qODX
         1DKPapYGG2UdYIrpfmObw+l61KKE3oE8WnoVCh+HaAEK2HRWAkzF0xTSPFfM8C9SGN
         CUxe+3kTLc+35y48s7kdTDv9VQjGuE/0EvInL80c=
From:   Will Deacon <will@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>, zhangshaokun@hisilicon.com,
        mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: perf: Remove unnecessary event_idx check
Date:   Mon,  7 Sep 2020 18:42:00 +0100
Message-Id: <159950013966.2897464.5010503730019666369.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1599213458-28394-1-git-send-email-liuqi115@huawei.com>
References: <1599213458-28394-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 17:57:38 +0800, Qi Liu wrote:
> event_idx is obtained from armv8pmu_get_event_idx(), and this idx must be
> between ARMV8_IDX_CYCLE_COUNTER and cpu_pmu->num_events. So it's unnecessary
> to do this check. Let's remove it.

Applied to will (for-next/perf), thanks!

[1/1] arm64: perf: Remove unnecessary event_idx check
      https://git.kernel.org/will/c/44fdf4ed2693

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
