Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB41426636C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgIKQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgIKPbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:31:55 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6E3206E9;
        Fri, 11 Sep 2020 15:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599838315;
        bh=FHvyb4YZgNi7A1rAW27pN0TMAcoCOgzJV9MBqHtD1zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9YTBNGFbO526oLa7IxaFS1Ac6jLa/MRtq8fur3NAQ9nzzpgqcW//ucF3ax75U3Fo
         EAdWKWfzTSWv0Pd4B2XSRPYpBPMCY2xyqgJ14zNed48Q+Jv8u37fR5XNFTu9rhVSCn
         BAIBYlEKFViWDAvtVa80jOzvzjUTuCvZEBkAEU3M=
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        rcampbell@nvidia.com, akpm@linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan.Cameron@Huawei.com, linux-kernel@vger.kernel.org,
        Suzuki Poulose <suzuki.poulose@arm.com>, ziy@nvidia.com
Subject: Re: [PATCH V2 0/2] arm64/mm: Enable THP migration
Date:   Fri, 11 Sep 2020 16:31:48 +0100
Message-Id: <159983265112.1321153.11672723276282744978.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1599627183-14453-1-git-send-email-anshuman.khandual@arm.com>
References: <1599627183-14453-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Sep 2020 10:23:01 +0530, Anshuman Khandual wrote:
> This series enables THP migration on arm64 via ARCH_ENABLE_THP_MIGRATION.
> But first this modifies all existing THP helpers like pmd_present() and
> pmd_trans_huge() etc per expected generic memory semantics as concluded
> from a previous discussion here.
> 
> https://lkml.org/lkml/2018/10/9/220
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/2] arm64/mm: Change THP helpers to comply with generic MM semantics
      https://git.kernel.org/arm64/c/b65399f6111b
[2/2] arm64/mm: Enable THP migration
      https://git.kernel.org/arm64/c/53fa117bb33c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
