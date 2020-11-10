Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429642ADF28
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgKJTR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:17:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJTR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:17:59 -0500
Received: from localhost.localdomain (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFAFD2054F;
        Tue, 10 Nov 2020 19:17:57 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/smp: Drop the macro S(x,s)
Date:   Tue, 10 Nov 2020 19:17:55 +0000
Message-Id: <160503567612.1015740.4856785286154882634.b4-ty@arm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1604921916-23368-1-git-send-email-anshuman.khandual@arm.com>
References: <1604921916-23368-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Nov 2020 17:08:36 +0530, Anshuman Khandual wrote:
> Mapping between IPI type index and its string is direct without requiring
> an additional offset. Hence the existing macro S(x, s) is now redundant
> and can just be dropped. This also makes the code clean and simple.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/smp: Drop the macro S(x,s)
      https://git.kernel.org/arm64/c/0edaee42eb8c

-- 
Catalin

