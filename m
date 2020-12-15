Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56932DB2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 18:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgLORpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 12:45:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731363AbgLORo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 12:44:57 -0500
From:   Catalin Marinas <catalin.marinas@arm.com>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Drop the useless update to per-cpu cycles
Date:   Tue, 15 Dec 2020 17:44:11 +0000
Message-Id: <160805420015.10795.13254308141169883776.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <7a171f710cdc0f808a2bfbd7db839c0d265527e7.1607579234.git.viresh.kumar@linaro.org>
References: <7a171f710cdc0f808a2bfbd7db839c0d265527e7.1607579234.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 11:17:40 +0530, Viresh Kumar wrote:
> The previous call to update_freq_counters_refs() has already updated the
> per-cpu variables, don't overwrite them with the same value again.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: topology: Drop the useless update to per-cpu cycles
      https://git.kernel.org/arm64/c/51550a483606

-- 
Catalin

