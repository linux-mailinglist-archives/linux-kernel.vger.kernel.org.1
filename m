Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E8227B7CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgI1XPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgI1XPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:15:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9CD22100A;
        Mon, 28 Sep 2020 21:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601330189;
        bh=lULlNsQDZL/smum8V+MwMDKmqTF7314n/PQhHN07CzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=18Z5Lxq1YqjbLwrA8Ye49kijflWy0NxlJDBX9LQMoldKOxrm8ZZ7bX6luPzuJSnwl
         3I7uEwQ7lS0EUJNKeTGrKJwibhNW8NJiXZnJO3Fil4fvo2Y0WSe4lhBy2l7Rgb8Xat
         Xl1qrwoRSC2sEamwOLr7qRnt/tUZmaIVtCI5/SUA=
Date:   Mon, 28 Sep 2020 22:56:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>, alexandru.elisei@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        alexandru.elisei@arm.com, swboyd@chromium.org,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: Enable perf events based hard lockup detector
Message-ID: <20200928215622.GA12677@willie-the-truck>
References: <1599204397-17596-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599204397-17596-1-git-send-email-sumit.garg@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:56:37PM +0530, Sumit Garg wrote:
> With the recent feature added to enable perf events to use pseudo NMIs
> as interrupts on platforms which support GICv3 or later, its now been
> possible to enable hard lockup detector (or NMI watchdog) on arm64
> platforms. So enable corresponding support.
> 
> One thing to note here is that normally lockup detector is initialized
> just after the early initcalls but PMU on arm64 comes up much later as
> device_initcall(). So we need to re-initialize lockup detection once
> PMU has been initialized.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
> 
> Changes in v3:
> - Rebased to latest pmu NMI patch-set [1].
> - Addressed misc. comments from Stephen.
> 
> [1] https://lkml.org/lkml/2020/8/19/671
> 
> Changes since RFC:
> - Rebased on top of Alex's WIP-pmu-nmi branch.
> - Add comment for safe max. CPU frequency.
> - Misc. cleanup.
> 
>  arch/arm64/Kconfig             |  2 ++
>  arch/arm64/kernel/perf_event.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  drivers/perf/arm_pmu.c         |  9 +++++++++
>  include/linux/perf/arm_pmu.h   |  2 ++
>  4 files changed, 52 insertions(+), 2 deletions(-)

It would be great to have Alexandru's ack on this, since it builds directly
on top of his code.

Will
