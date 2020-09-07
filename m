Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18326061B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 23:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgIGVRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 17:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIGVRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 17:17:14 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CF352145D;
        Mon,  7 Sep 2020 21:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599513433;
        bh=BEe8Hg1nQQakfRqqaWVZYwWtfSMQg1VV24e16mX7NUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xvxS4z+XU5iApb0nusPKcPwaFNsDlzBs+fbAc8SntCP0X6MEqRqY92xSKoR0ApKIu
         w8UDaOIVV2z1oU7FqHIKuB2c+wD4LDnnd/Rbv3H6aY4/alij2U55SebZSIViiuMbFq
         oTcJnDePJIZhLu14ZoT9s2fZ/U7Xlzd6Lk19zKTY=
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] arm64/mm/ptdump: Add address markers for BPF regions
Date:   Mon,  7 Sep 2020 22:17:08 +0100
Message-Id: <159951266812.2988869.10740934941923948664.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1599208259-11191-1-git-send-email-anshuman.khandual@arm.com>
References: <1599208259-11191-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 14:00:59 +0530, Anshuman Khandual wrote:
> Kernel virtual region [BPF_JIT_REGION_START..BPF_JIT_REGION_END] is missing
> from address_markers[], hence relevant page table entries are not displayed
> with /sys/kernel/debug/kernel_page_tables. This adds those missing markers.
> While here, also rename arch/arm64/mm/dump.c which sounds bit ambiguous, as
> arch/arm64/mm/ptdump.c instead.

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm/ptdump: Add address markers for BPF regions
      https://git.kernel.org/arm64/c/c048ddf86cdd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
