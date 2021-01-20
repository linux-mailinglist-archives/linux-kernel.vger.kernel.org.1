Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA32FD27F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbhATOTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:19:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389352AbhATNCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:02:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B78223383;
        Wed, 20 Jan 2021 13:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611147683;
        bh=vEVVkVFtV70lv9L+719xvU8gbnItebFr2gkLNdO/LHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sm6ljrNftvxwjYy58xSQRWKhZN3CFP/PX13EaNZZez/DBgv9dC/UEnLMD2PZNou0V
         7VFJy3+oiH5ojWmPd4LllH0VvAagQVeCT/vwJ/saai4taodS18XbRzTSub0vwI7cK3
         kj3drfPSH9SlOZl7CiCty3pPF9xxuAZ9Byk1OzJ5GXTb2d7ngKoqKnnZR5DXcoB+hq
         s9Lg3tg2fIhlOigmDw5lNMGA5GxLaQDxkXblG4VD8JNcKsHAjkZ3vr54JkVXi5HSay
         zFA7agDXteOwntNbCWXy8Igexc35VEqPAz5zQKG3C8ESHIr/UdrQQXefirc0JNti9R
         X422jmbQBNbjg==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: do not descend to vdso directories twice
Date:   Wed, 20 Jan 2021 13:01:06 +0000
Message-Id: <161114512647.215684.4495482205207888409.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201218024540.1102650-1-masahiroy@kernel.org>
References: <20201218024540.1102650-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Dec 2020 11:45:40 +0900, Masahiro Yamada wrote:
> arm64 descends into each vdso directory twice; first in vdso_prepare,
> second during the ordinary build process.
> 
> PPC mimicked it and uncovered a problem [1]. In the first descend,
> Kbuild directly visits the vdso directories, therefore it does not
> inherit subdir-ccflags-y from upper directories.
> 
> [...]

Applied to arm64 (for-next/vdso), thanks!

[1/1] arm64: do not descend to vdso directories twice
      https://git.kernel.org/arm64/c/a5b8ca97fbf8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
