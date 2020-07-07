Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8582172A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 17:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgGGPls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 11:41:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgGGPlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:41:47 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D6EE206F6;
        Tue,  7 Jul 2020 15:41:45 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] arm64/cpufeature: Validate feature bits spacing in arm64_ftr_regs[]
Date:   Tue,  7 Jul 2020 16:41:42 +0100
Message-Id: <159413427852.3933.8454502691183086307.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1594131793-9498-1-git-send-email-anshuman.khandual@arm.com>
References: <1594131793-9498-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 19:53:13 +0530, Anshuman Khandual wrote:
> arm64_feature_bits for a register in arm64_ftr_regs[] are in a descending
> order as per their shift values. Validate that these features bits are
> defined correctly and do not overlap with each other. This check protects
> against any inadvertent erroneous changes to the register definitions.

Applied to arm64 (for-next/cpufeature), thanks!

[1/1] arm64/cpufeature: Validate feature bits spacing in arm64_ftr_regs[]
      https://git.kernel.org/arm64/c/c6c83d757a13

Useful patch, found a misplaced field in the MTE series ;).

-- 
Catalin

