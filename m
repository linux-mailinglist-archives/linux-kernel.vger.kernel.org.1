Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9592ADF23
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbgKJTO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:14:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730770AbgKJTOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:14:25 -0500
Received: from localhost.localdomain (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC5D20870;
        Tue, 10 Nov 2020 19:14:22 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        gshan@redhat.com, Robin Murphy <robin.murphy@arm.com>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] arm64: mm: account for hotplug memory when randomizing the linear region
Date:   Tue, 10 Nov 2020 19:14:18 +0000
Message-Id: <160503561804.1015659.16599672230432576934.b4-ty@arm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201014081857.3288-1-ardb@kernel.org>
References: <20201014081857.3288-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 10:18:57 +0200, Ard Biesheuvel wrote:
> As a hardening measure, we currently randomize the placement of
> physical memory inside the linear region when KASLR is in effect.
> Since the random offset at which to place the available physical
> memory inside the linear region is chosen early at boot, it is
> based on the memblock description of memory, which does not cover
> hotplug memory. The consequence of this is that the randomization
> offset may be chosen such that any hotplugged memory located above
> memblock_end_of_DRAM() that appears later is pushed off the end of
> the linear region, where it cannot be accessed.
> 
> [...]

Applied to arm64 (for-next/mem-hotplug), thanks!

[1/1] arm64: mm: account for hotplug memory when randomizing the linear region
      https://git.kernel.org/arm64/c/97d6786e0669

-- 
Catalin

