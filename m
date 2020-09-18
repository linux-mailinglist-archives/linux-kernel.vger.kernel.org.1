Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0322701EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgIRQRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgIRQRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:17:30 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC98D2399A;
        Fri, 18 Sep 2020 16:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600445849;
        bh=bWaWgHlCKMnkQSTd3ojiyjNYs3adbyti+RhPmbW9poU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kz6OOmw2MYEH+26paB6sFtgioEOr+o9bWhd8Hk/loIzFQV/MfuUma89LmTwb6jCkG
         83dVSwAlxAn2b21NZhpSVbtvB8hkRG1CFa5vGT9MMTkSfVGLmy3d6qDu2o4omVlQVb
         iaSdLIX59AOlTom67T1akysOR0wvLcr+Bvp7BCGg=
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: Convert to ARCH_STACKWALK
Date:   Fri, 18 Sep 2020 17:17:14 +0100
Message-Id: <160043545717.3786361.8451395410243102783.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914153409.25097-1-broonie@kernel.org>
References: <20200914153409.25097-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 16:34:06 +0100, Mark Brown wrote:
> This series updates the arm64 stacktrace code to use the newer and much
> simpler arch_stack_walk() interface, the main benefit being a single
> entry point to the arch code with no need for the arch code to worry
> about skipping frames. Along the way I noticed that the reliable
> parameter to the arch_stack_walk() callback appears to be redundant
> so there's also a patch here removing that from the existing code to
> simplify the interface.
> 
> [...]

Applied to arm64 (for-next/stacktrace), thanks!

[1/3] stacktrace: Remove reliable argument from arch_stack_walk() callback
      https://git.kernel.org/arm64/c/264c03a245de
[2/3] arm64: stacktrace: Make stack walk callback consistent with generic code
      https://git.kernel.org/arm64/c/baa2cd417053
[3/3] arm64: stacktrace: Convert to ARCH_STACKWALK
      https://git.kernel.org/arm64/c/5fc57df2f6fd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
