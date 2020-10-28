Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B1229D721
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbgJ1WVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731679AbgJ1WRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:40 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C324247B8;
        Wed, 28 Oct 2020 15:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603897971;
        bh=8iGPNX5mYrmkpLTtQPEoKM9Mrv7Wp+19ECeCXumcp1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9wjCTTLsRgnjUez6HKoVgCKQSVLHm42gQmk6yXmowWtIdXXjMwgX6YgTwJNemXJB
         AYEju9RYmA/J8B4NEawDUQBpKIz7y5N3X4ITTB+XGTXWOunesloPkKwaB+jj2QXhdm
         n1/n+ZgPmC/+M0wIIr7CLn06L0RTW9dLL0sN3nbU=
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: avoid -Woverride-init warning
Date:   Wed, 28 Oct 2020 15:12:35 +0000
Message-Id: <160389231707.1007448.15643849418199705587.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201026193807.3816388-1-arnd@kernel.org>
References: <20201026193807.3816388-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 20:37:46 +0100, Arnd Bergmann wrote:
> The icache_policy_str[] definition causes a warning when extra
> warning flags are enabled:
> 
> arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field overwritten [-Woverride-init]
>    38 |  [ICACHE_POLICY_VIPT]  = "VIPT",
>       |                          ^~~~~~
> arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for 'icache_policy_str[2]')
> arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field overwritten [-Woverride-init]
>    39 |  [ICACHE_POLICY_PIPT]  = "PIPT",
>       |                          ^~~~~~
> arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for 'icache_policy_str[3]')
> arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field overwritten [-Woverride-init]
>    40 |  [ICACHE_POLICY_VPIPT]  = "VPIPT",
>       |                           ^~~~~~~
> arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for 'icache_policy_str[0]')
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: avoid -Woverride-init warning
      https://git.kernel.org/arm64/c/332576e69a04

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
