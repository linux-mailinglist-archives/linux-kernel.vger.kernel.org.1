Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F298F2FD27C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbhATOSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:18:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389369AbhATNCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:02:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D55023381;
        Wed, 20 Jan 2021 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611147687;
        bh=i+lFN987O9XPtWvu+F/oIVpXPV0tkZRr7Vs+/h7zk90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djMmY6G0dYRRxHnwMPayXuFyW42i8cUyTl6HpzxO0w1p3JKp0SHRPzOVc9zfZ2W3L
         CBB2myY/1PN7Ix+SfpHgc9Xf+be/9YYux9S1aRi0FPU2k9E37rVCidiCNjYEU03uGA
         XcqB4niPLBk2xnYidqrBu+Ng++yvsyh2yWw+xLsKB5X42/LiiRKVI7QK29G4a1cBJE
         aX37PCHDaAAXktBFmZKZJ7OhxzbH1KQMYqeYEYYd7siAHlVCO52gFLpQsOfC1GTcJ5
         cunzIi54QBJzR9/4vzCJqHGCV7Nkd1hJuik+FI8i+W5YRyTVIN8NOwg3/h7JqZfauk
         wW3fP8ptIt1kQ==
From:   Will Deacon <will@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4 0/3] arm64: topology: improvements
Date:   Wed, 20 Jan 2021 13:01:08 +0000
Message-Id: <161114698073.222302.6333959432282953596.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1610104461.git.viresh.kumar@linaro.org>
References: <cover.1610104461.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jan 2021 16:46:50 +0530, Viresh Kumar wrote:
> Here is the V4 with the general improvements for topology stuff. This
> cleans up the code and makes it work with cpufreq modules.
> 
> V4:
> - Added Rby from Ionela.
> - In 3/3, Print cpus instead of amu_fie_cpus and make it pr_debug
>   instead.
> 
> [...]

Applied to arm64 (for-next/topology), thanks!

[1/3] arm64: topology: Avoid the have_policy check
      https://git.kernel.org/arm64/c/384e5699e101
[2/3] arm64: topology: Reorder init_amu_fie() a bit
      https://git.kernel.org/arm64/c/47b10b737c07
[3/3] arm64: topology: Make AMUs work with modular cpufreq drivers
      https://git.kernel.org/arm64/c/a5f1b187cd24

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
