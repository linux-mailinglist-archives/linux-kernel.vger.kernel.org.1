Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEC42C8BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbgK3Rqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:46:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387437AbgK3Rqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:46:52 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 170D7206E3;
        Mon, 30 Nov 2020 17:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606758371;
        bh=fZ/2/YPURKF15Ju6TMRd3pKQZ8YWvGAr5cP7+/h10Y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hL2uDGfgRL4p+OT3c2F4GeXP7WbYv+zgTTekDWqNRj/6o/ehfUeA/urod04WmN68M
         34fhVz70dJlUUD+AgDzaV5t04H/K2t5RvIxaiwvZ0kFZOS/cIF/TPeYcT9D/T8xWzf
         vvi5BtM/qPyPl778olN9e120ekB9EhoSgpu+hJOQ=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] arm64: mte: Fix typo in macro definition
Date:   Mon, 30 Nov 2020 17:46:05 +0000
Message-Id: <160675781246.1059114.15264398791864566541.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201130170709.22309-1-vincenzo.frascino@arm.com>
References: <20201130170709.22309-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 17:07:09 +0000, Vincenzo Frascino wrote:
> UL in the definition of SYS_TFSR_EL1_TF1 was misspelled causing
> compilation issues when trying to implement in kernel MTE async
> mode.
> 
> Fix the macro correcting the typo.
> 
> Note: MTE async mode will be introduced with a future series.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mte: Fix typo in macro definition
      https://git.kernel.org/arm64/c/9e5344e0ffc3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
