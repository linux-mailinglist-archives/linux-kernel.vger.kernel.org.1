Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8022ADF29
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbgKJTSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:18:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJTSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:18:01 -0500
Received: from localhost.localdomain (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFCA220809;
        Tue, 10 Nov 2020 19:17:59 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: consistently use reserved_pg_dir
Date:   Tue, 10 Nov 2020 19:17:56 +0000
Message-Id: <160503567612.1015740.6410821724474192857.b4-ty@arm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103102229.8542-1-mark.rutland@arm.com>
References: <20201103102229.8542-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Nov 2020 10:22:29 +0000, Mark Rutland wrote:
> Depending on configuration options and specific code paths, we either
> use the empty_zero_page or the configuration-dependent reserved_ttbr0
> as a reserved value for TTBR{0,1}_EL1.
> 
> To simplify this code, let's always allocate and use the same
> reserved_pg_dir, replacing reserved_ttbr0. Note that this is allocated
> (and hence pre-zeroed), and is also marked as read-only in the kernel
> Image mapping.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: consistently use reserved_pg_dir
      https://git.kernel.org/arm64/c/833be850f1ca

-- 
Catalin

