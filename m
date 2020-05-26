Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3431E303B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 22:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403891AbgEZUpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 16:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389486AbgEZUpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:45:13 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3BF7207CB;
        Tue, 26 May 2020 20:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590525913;
        bh=KSSDjXavc4Cfkda/YtwTNNTYhwmx7H7cHFjcR7WMiM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p56PlHM9Ux3eBLXiMitWDjCOX3x2l3RjHhy0jti/3zxxyc0uyd/jM9Skc42ZjzsfK
         ZC8xnZ5C0I1Q8exv5+co6FBVZQbyQMG02U3fQgN9hAGMhNUEZcNkyIep/EvRF06qJj
         kju0MB5feQ7fSPec8l+SyhwoCLVOBWlZNUl8apwQ=
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Manoj Gupta <manojgupta@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Luis Lozano <llozano@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@google.com>
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
Date:   Tue, 26 May 2020 21:45:05 +0100
Message-Id: <159052247565.23781.7800427985507723263.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526173117.155339-1-ndesaulniers@google.com>
References: <20200526173117.155339-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 10:31:14 -0700, Nick Desaulniers wrote:
> Custom toolchains that modify the default target to -mthumb cannot
> compile the arm64 compat vdso32, as
> arch/arm64/include/asm/vdso/compat_gettimeofday.h
> contains assembly that's invalid in -mthumb.  Force the use of -marm,
> always.

Applied to arm64 (for-next/vdso), thanks!

[1/1] arm64: vdso32: force vdso32 to be compiled as -marm
      https://git.kernel.org/arm64/c/20363b59ad4f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
