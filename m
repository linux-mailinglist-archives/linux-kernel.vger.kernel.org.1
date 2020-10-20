Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CE72850D3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgJFRbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFRbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:31:19 -0400
Received: from localhost.localdomain (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5A820674;
        Tue,  6 Oct 2020 17:31:17 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     Will Deacon <will@kernel.org>, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        dave.martin@arm.com, ardb@kernel.org, linux-crypto@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v3] crypto: arm64: Use x16 with indirect branch to bti_c
Date:   Tue,  6 Oct 2020 18:31:15 +0100
Message-Id: <160200545502.18883.1273632867328038422.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201006163326.2780619-1-jeremy.linton@arm.com>
References: <20201006163326.2780619-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020 11:33:26 -0500, Jeremy Linton wrote:
> The AES code uses a 'br x7' as part of a function called by
> a macro. That branch needs a bti_j as a target. This results
> in a panic as seen below. Using x16 (or x17) with an indirect
> branch keeps the target bti_c.
> 
>   Bad mode in Synchronous Abort handler detected on CPU1, code 0x34000003 -- BTI
>   CPU: 1 PID: 265 Comm: cryptomgr_test Not tainted 5.8.11-300.fc33.aarch64 #1
>   pstate: 20400c05 (nzCv daif +PAN -UAO BTYPE=j-)
>   pc : aesbs_encrypt8+0x0/0x5f0 [aes_neon_bs]
>   lr : aesbs_xts_encrypt+0x48/0xe0 [aes_neon_bs]
>   sp : ffff80001052b730
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] crypto: arm64: Use x16 with indirect branch to bti_c
      https://git.kernel.org/arm64/c/39e4716caa59

-- 
Catalin

