Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB0229DEF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403928AbgJ2A6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731587AbgJ1WRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:32 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE64247B4;
        Wed, 28 Oct 2020 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603897968;
        bh=G+a9tAqKfo1FKngndd1wk/6n9OaUyZGsZA67OwoudG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqaV11gbUEV4zvNXiGpLI51CWpkthZ3eLlf/UK+rqHMVIQdd7836W3aMcVJEDUn4O
         anOuCYwDkUXDOpbLFVxImekHbJ/q1bzMz8j7Fh/k2EiUj8xw7IfaI54bfHElMNmZxD
         nwldbbREuijDa/Si90aWB+aAFtbbED3tbxzlP0rw=
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH] module: use hidden visibility for weak symbol references
Date:   Wed, 28 Oct 2020 15:12:34 +0000
Message-Id: <160389413619.1112960.12611093041695506337.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027151132.14066-1-ardb@kernel.org>
References: <20201027151132.14066-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 16:11:32 +0100, Ard Biesheuvel wrote:
> Geert reports that commit be2881824ae9eb92 ("arm64/build: Assert for
> unwanted sections") results in build errors on arm64 for configurations
> that have CONFIG_MODULES disabled.
> 
> The commit in question added ASSERT()s to the arm64 linker script to
> ensure that linker generated sections such as .got, .plt etc are empty,
> but as it turns out, there are corner cases where the linker does emit
> content into those sections. More specifically, weak references to
> function symbols (which can remain unsatisfied, and can therefore not
> be emitted as relative references) will be emitted as GOT and PLT
> entries when linking the kernel in PIE mode (which is the case when
> CONFIG_RELOCATABLE is enabled, which is on by default).
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] module: use hidden visibility for weak symbol references
      https://git.kernel.org/arm64/c/13150bc5416f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
