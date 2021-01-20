Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB45B2FD280
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbhATOUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389307AbhATNB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:01:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C480323380;
        Wed, 20 Jan 2021 13:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611147679;
        bh=xekDUOsdP1mRM5AZqMuYSS92fneYc+x6Ce2gxjs/9dE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qDuNUbUyPdgYo8s/Vl3muJ2N2wV10wLRISgTn5Di4JxbVwxQBrZavp1w/A1gELfSp
         uLbaIiZawHFYHMbY3O3/CpbBIFMgfuTtYoWMVb88UoE5sZbz+Ro+nSm6HjWPn/CIkZ
         pGISCX1xNOVS0Ntvb1P+ZbLNuhrbXk7ouwlL4pbkLKpg6hyH04+9bRE2QX5gafO8U2
         XJTFIU01zu9X2TwgoR+acADdwh1YmqfrXdT4KUKmAInQvCtNsy2RgVcE7nMPB044fL
         twKuhOpaCZV5ExvJZiwAdOjiHQENrqZ8VkAbYtQUgZ+uhfvK1aq6JBMsanVZ512w3y
         2nnuyHx3roLeg==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Add warning for outside range requests in vmemmap_populate()
Date:   Wed, 20 Jan 2021 13:01:03 +0000
Message-Id: <161114567725.217634.54341340334446178.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1609845851-25064-1-git-send-email-anshuman.khandual@arm.com>
References: <1609845851-25064-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jan 2021 16:54:11 +0530, Anshuman Khandual wrote:
> vmemmap_populate() does not validate the requested vmemmap address range to
> be inside the platform assigned space i.e [VMEMMAP_START..VMEMMAP_END] for
> vmemmap. Instead it would just go ahead and create the mapping which might
> then overlap with other sections in the kernel virtual address space.
> 
> Just adding an warning here for range overrun which would help detect the
> problem earlier on, before a potential struct page corruption. This also
> makes vmemmap_populate() symmetrical with vmemmap_free() which already has
> a similar warning.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Add warning for outside range requests in vmemmap_populate()
      https://git.kernel.org/arm64/c/edb739eed8f3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
