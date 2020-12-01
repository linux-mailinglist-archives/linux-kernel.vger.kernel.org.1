Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250F42CA1AD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbgLALlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgLALlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:41:36 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F6E2080A;
        Tue,  1 Dec 2020 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606822855;
        bh=06KRYzYgxevsD8pxBUSE0ch2KT7AVg7xO2mVgpgBvIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S28EAgAxkfM9okJDBXPHFYFTAhHmXmiGG5EUm4ekKYOTPIEcXqAigkwMSafKaTBHq
         6itKvBWUy3aRSYROz6Qrn0pTOi8L8LUwhrSdEvciClKPQORBZcOX2XQiIohOw8wh1u
         6ISp+1CoHOJAJrnoWYFqmMiRxNUahTjIdPNdfNVQ=
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 0/2] scs: switch to vmapped shadow stacks
Date:   Tue,  1 Dec 2020 11:40:49 +0000
Message-Id: <160681862873.1496993.150824561732453035.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201130233442.2562064-1-samitolvanen@google.com>
References: <20201130233442.2562064-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 15:34:40 -0800, Sami Tolvanen wrote:
> As discussed a few months ago [1][2], virtually mapped shadow call stacks
> are better for safety and robustness. This series dusts off the VMAP
> option from the original SCS patch series and switches the kernel to use
> virtually mapped shadow stacks unconditionally when SCS is enabled.
> 
>  [1] https://lore.kernel.org/lkml/20200515172355.GD23334@willie-the-truck/
>  [2] https://lore.kernel.org/lkml/20200427220942.GB80713@google.com/
> 
> [...]

Applied to arm64 (for-next/scs), thanks!

[1/2] scs: switch to vmapped shadow stacks
      https://git.kernel.org/arm64/c/a2abe7cbd8fe
[2/2] arm64: scs: use vmapped IRQ and SDEI shadow stacks
      https://git.kernel.org/arm64/c/ac20ffbb0279

I also threw a patch on top implementing the suggestion I made on v2, so
please take a look if you get a chance.

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
