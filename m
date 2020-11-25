Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E39E2C4453
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgKYPoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:44:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730000AbgKYPoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:44:22 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 202282087C;
        Wed, 25 Nov 2020 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606319062;
        bh=bp+vYNl6WZ3SAbX3JYkMERucj/YM4YhziPAZI2AMKmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MzhLqkJ7KWQ9IVB9FB3pjg0OcBHkKBMLIejryAhHo7/gbgRxv5SK+0rZyTHzjun/v
         /hGAT9X85sY3EWJY2+cp+bo17i2KF9RqecwaKStKPTOApvyworbtXR5MezzDlAWIq+
         R1cznro9RFnghPBWEpIx02CKIixmDziiOpfn82hM=
From:   Will Deacon <will@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>, alexandru.elisei@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, mark.rutland@arm.com, peterz@infradead.org,
        dianders@chromium.org, acme@kernel.org, swboyd@chromium.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, julien.thierry.kdev@gmail.com,
        daniel.thompson@linaro.org
Subject: Re: [PATCH v4] arm64: Enable perf events based hard lockup detector
Date:   Wed, 25 Nov 2020 15:44:08 +0000
Message-Id: <160631752004.2333389.970698439984795478.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1602060704-10921-1-git-send-email-sumit.garg@linaro.org>
References: <1602060704-10921-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Oct 2020 14:21:43 +0530, Sumit Garg wrote:
> With the recent feature added to enable perf events to use pseudo NMIs
> as interrupts on platforms which support GICv3 or later, its now been
> possible to enable hard lockup detector (or NMI watchdog) on arm64
> platforms. So enable corresponding support.
> 
> One thing to note here is that normally lockup detector is initialized
> just after the early initcalls but PMU on arm64 comes up much later as
> device_initcall(). So we need to re-initialize lockup detection once
> PMU has been initialized.

Applied to will (for-next/perf), thanks!

[1/1] arm64: Enable perf events based hard lockup detector
      https://git.kernel.org/will/c/367c820ef080

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
