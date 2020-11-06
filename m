Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF12A946D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgKFKgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgKFKgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:36:09 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D4221707;
        Fri,  6 Nov 2020 10:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604658968;
        bh=6s2swW+ih/nkD0oztyE9x+Si8CEZNDUc882qvqpxuUU=;
        h=From:To:Cc:Subject:Date:From;
        b=JTb/Mydm7HRZQNQpKS7dDVYQQuUiJl1yx7VwgIugHSFrxu2jKQLcp9iIxNXyaMXbo
         Vod4AP8gMrsLHm/+YdIDKfDeL1pq8F07ZMjARZUUQvswfTFLmhaNpJ8TYZJzysYnS4
         el/3UIqv6/eAv1TyiTbiyPb45sQeXo1RcN1LipIA=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Qian Cai <cai@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 0/2] arm64: Fix issues with CPU hotplug and RCU
Date:   Fri,  6 Nov 2020 10:36:00 +0000
Message-Id: <20201106103602.9849-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Here are a couple of patches following on from:

https://lore.kernel.org/r/20201105222242.GA8842@willie-the-truck

which address issues when CPU onlining fails but RCU is left none the
wiser. Tested under QEMU.

If Paul is happy with the second patch, then I can take both of these
via arm64 as fixes for 5.11.

Cheers,

Will

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Qian Cai <cai@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>

--->8

Will Deacon (2):
  arm64: psci: Avoid printing in cpu_psci_cpu_die()
  arm64: smp: Tell RCU about CPUs that fail to come online

 arch/arm64/kernel/psci.c | 2 --
 arch/arm64/kernel/smp.c  | 1 +
 kernel/rcu/tree.c        | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.29.1.341.ge80a0c044ae-goog

