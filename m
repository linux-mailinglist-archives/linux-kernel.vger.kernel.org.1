Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D22E98D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbhADPcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:32:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbhADPcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:32:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A832A22211;
        Mon,  4 Jan 2021 15:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609774280;
        bh=G30i02LL5QJ4gzJR3yp2wBKBWDcZwYh78upY9t1KDp0=;
        h=Date:From:To:Cc:Subject:From;
        b=s1Ac4KOQMA7bK/BGPEpFZyP6ZEksXzJvKtUYwcuEc5EKTxAimkbTBUW49/ZPOrDS6
         YiSAvswvbJVXgJhXU8jPQGYpoNphbQaorDfGdLeXUUiHn2u33YiTdaA6HCZAc20qk1
         T3PmgrNcDOByRyMwXGdgrAgLFf8QnywMsn5xb9qWKGY6Q87EYOjzofWj0aupnqIAxa
         3JaS4Ofia2uA5474C7y+Q60RXpoKp9xSdMfePYyu1zcMKuzu4yS5NCb49Kr1Zk5Bp+
         TcGB4b1aEMYHKa8mfHHwji6R5T0di2+ijCazRupUHzT/v8FcZF6NDPOtZFyOFlFZiT
         Wts/N7g2RV4dg==
Date:   Mon, 4 Jan 2021 16:31:06 +0100
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Compiler Attributes for v5.11
Message-ID: <20210104153026.GA26533@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This one is not a bug fix; but it is not a new feature either...
If you prefer changes like this one to be sent in the merge window,
I will re-send it later on.

If this gets into v5.11, then Masahiro is planning to try to make
the warning an error for v5.12. This commit has already triggered
the discussion/fix of a couple of likely mistakes (or at least
the addition of explanations for the omissions), which is a good thing.

I left it in -next for a few more weeks than planned to see if
(more) people complained about the warnings, but it has been quiet
since then.

Cheers,
Miguel

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.11

for you to fetch changes up to 1967939462641d8b36bcb3fcf06d48e66cd67a4f:

  Compiler Attributes: remove CONFIG_ENABLE_MUST_CHECK (2020-12-02 13:47:17 +0100)

----------------------------------------------------------------
An addition to compiler_attributes.h thanks to:

  - Remove CONFIG_ENABLE_MUST_CHECK (Masahiro Yamada)

----------------------------------------------------------------
Masahiro Yamada (1):
      Compiler Attributes: remove CONFIG_ENABLE_MUST_CHECK

 include/linux/compiler_attributes.h                 | 6 ++++++
 include/linux/compiler_types.h                      | 6 ------
 lib/Kconfig.debug                                   | 8 --------
 tools/testing/selftests/wireguard/qemu/debug.config | 1 -
 4 files changed, 6 insertions(+), 15 deletions(-)
