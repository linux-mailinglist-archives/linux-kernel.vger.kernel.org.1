Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24A1F5307
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 13:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgFJLVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 07:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbgFJLVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:21:17 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCA02078C;
        Wed, 10 Jun 2020 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591788077;
        bh=9fKKwsQG+ae0h8ivgqvpkqBV3pK8Ukj9focnXx4zajc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bth/F3nXjeNt4SgkC/ZRFpXEHsVWDZed8ygE5hwx80F1Nw1Dyr/CkiNtfJcmvzfg5
         gqaR8OYTFFoHDZTTVrQgL8hQWKCDC9ZwsZu81O4mDBIOfLp42uNPuxmsI31DEA/fK+
         cawp48O2k2BCXQ8YOez5JPGYtsYOi+eTe0zUSUaU=
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dave Martin <Dave.Martin@arm.com>,
        Stephen Boyd <swboyd@google.com>,
        clang-built-linux@googlegroups.com,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>
Subject: Re: [PATCH v2] arm64: vdso32: add CONFIG_THUMB2_COMPAT_VDSO
Date:   Wed, 10 Jun 2020 12:21:09 +0100
Message-Id: <159178553820.37708.12308914886514191769.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200608205711.109418-1-ndesaulniers@google.com>
References: <20200528072031.GA22156@willie-the-truck> <20200608205711.109418-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020 13:57:08 -0700, Nick Desaulniers wrote:
> Allow the compat vdso (32b) to be compiled as either THUMB2 (default) or
> ARM.
> 
> For THUMB2, the register r7 is reserved for the frame pointer, but
> code in arch/arm64/include/asm/vdso/compat_gettimeofday.h
> uses r7. Explicitly set -fomit-frame-pointer, since unwinding through
> interworked THUMB2 and ARM is unreliable anyways. See also how
> CONFIG_UNWINDER_FRAME_POINTER cannot be selected for
> CONFIG_THUMB2_KERNEL for ARCH=arm.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: vdso32: add CONFIG_THUMB2_COMPAT_VDSO
      https://git.kernel.org/arm64/c/625412c210fb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
