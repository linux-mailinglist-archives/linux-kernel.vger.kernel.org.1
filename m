Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B7B2A0B32
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgJ3Qdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgJ3Qdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:33:31 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B0520727;
        Fri, 30 Oct 2020 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604075611;
        bh=GHasvaoA/YIBwMT0l4avY/GTrYzzdWpoqx0j6MMRCrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPNolX+9lnWZpaGeB9ku9gPkM/SvePUgM5vHPWrYdA7ULevn3HKYOhVRL8Laj3jIU
         s81pI0htDr+lmu89keR5vG7ezVBPtqWm8oPxssgtTVyM5yDghxB+qo5DYXeEY6eHLY
         vCeUI2n0mhhreD8JG3Co13bguFGtrQCe1IyrZN/I=
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>, Qian Cai <cai@redhat.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/smp: Move rcu_cpu_starting() earlier
Date:   Fri, 30 Oct 2020 16:33:25 +0000
Message-Id: <160404559895.1777248.8248643695413627642.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201028182614.13655-1-cai@redhat.com>
References: <20201028182614.13655-1-cai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 14:26:14 -0400, Qian Cai wrote:
> The call to rcu_cpu_starting() in secondary_start_kernel() is not early
> enough in the CPU-hotplug onlining process, which results in lockdep
> splats as follows:
> 
>  WARNING: suspicious RCU usage
>  -----------------------------
>  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/smp: Move rcu_cpu_starting() earlier
      https://git.kernel.org/arm64/c/ce3d31ad3cac

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
