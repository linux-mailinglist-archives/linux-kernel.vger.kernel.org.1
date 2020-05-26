Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1DC1C5D2C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbgEEQN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 12:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbgEEQNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:13:51 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75F6D206A4;
        Tue,  5 May 2020 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588695230;
        bh=dpXPFwKuVMrPa7413QY+1yJ7/pkzBpNiSnMEv+1die4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMruXtbwRLDiFtaSuq49ZBOGAUPM520/Z9wz5f24Zvyj55NVRs57wCT7bIIr9epPJ
         MN6iiyCoC+MWBt+bCoJImrZ5O06KJ9UN5+NBbB+5xYeQ0a2RtMSXZUCXHXGNrYM+Im
         QUSZiMN0CryEfhf6eFAFwD5DGN046UE6m+oBJFlI=
From:   Will Deacon <will@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        patches@linaro.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH v2] arm64: cacheflush: Fix KGDB trap detection
Date:   Tue,  5 May 2020 17:13:45 +0100
Message-Id: <158869137087.244424.4260224460496540281.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504170518.2959478-1-daniel.thompson@linaro.org>
References: <20200504170518.2959478-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020 18:05:18 +0100, Daniel Thompson wrote:
> flush_icache_range() contains a bodge to avoid issuing IPIs when the kgdb
> trap handler is running because issuing IPIs is unsafe (and not needed)
> in this execution context. However the current test, based on
> kgdb_connected is flawed: it both over-matches and under-matches.
> 
> The over match occurs because kgdb_connected is set when gdb attaches
> to the stub and remains set during normal running. This is relatively
> harmelss because in almost all cases irq_disabled() will be false.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: cacheflush: Fix KGDB trap detection
      https://git.kernel.org/arm64/c/ab8ad279ceac

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
