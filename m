Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169C826636A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgIKQPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgIKPb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:31:59 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A442B221EB;
        Fri, 11 Sep 2020 15:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599838317;
        bh=pnr+KrdHtt/fH3wF75oJarZDsiMbxqG9tfzitZPzg8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=InakMd/Cg43FCBJCQfqfmzrJM5frJWjVHYplr4j2J9EmgQ1ATT4usy1uDp2E2uh6v
         BF1Y2778HCu4JJdHNCAk0LRdlyIo8hAI8bHioZ15YupxJ8gdIh+jkwXXsLwkgJAWPh
         tIKn6ZUZiRFKs3ALZhkuLHook1AQ0Pk1LR/XL6d4=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH V4] arm64/cpuinfo: Define HWCAP name arrays per their actual bit definitions
Date:   Fri, 11 Sep 2020 16:31:49 +0100
Message-Id: <159983818680.1465915.16143462979896283824.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1599630535-29337-1-git-send-email-anshuman.khandual@arm.com>
References: <1599630535-29337-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Sep 2020 11:18:55 +0530, Anshuman Khandual wrote:
> HWCAP name arrays (hwcap_str, compat_hwcap_str, compat_hwcap2_str) that are
> scanned for /proc/cpuinfo are detached from their bit definitions making it
> vulnerable and difficult to correlate. It is also bit problematic because
> during /proc/cpuinfo dump these arrays get traversed sequentially assuming
> they reflect and match actual HWCAP bit sequence, to test various features
> for a given CPU. This redefines name arrays per their HWCAP bit definitions
> . It also warns after detecting any feature which is not expected on arm64.

Applied to arm64 (for-next/cpuinfo), thanks!

[1/1] arm64/cpuinfo: Define HWCAP name arrays per their actual bit definitions
      https://git.kernel.org/arm64/c/4e56de82d4ec

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
