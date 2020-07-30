Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9C123372C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 18:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgG3QwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 12:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3QwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:52:16 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AAE1208A9;
        Thu, 30 Jul 2020 16:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596127935;
        bh=pruxR91FbChCurmTTFjSq2Lcwzsisy3ZUemTio1ffa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDxtCfue/IPf5/7OjlWudZo4WIR/lz+elw9aBfwdhl2Du9wMI/gpIrSWlXvi3s59q
         5d7S9/rs/kQoZuck40UmuWWdgdsIUYeZH8JEzAgEDE9cD7PRkUvFy79L8+A7U3A/25
         GwpeAS7/MgCT09cPT8m3qjbxIgSDZzrcURrmA/0U=
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/alternatives: move length validation inside the subsection
Date:   Thu, 30 Jul 2020 17:52:08 +0100
Message-Id: <159612421491.1041762.16502562347274669841.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200730153701.3892953-1-samitolvanen@google.com>
References: <20200729215152.662225-1-samitolvanen@google.com> <20200730153701.3892953-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 08:37:01 -0700, Sami Tolvanen wrote:
> Commit f7b93d42945c ("arm64/alternatives: use subsections for replacement
> sequences") breaks LLVM's integrated assembler, because due to its
> one-pass design, it cannot compute instruction sequence lengths before the
> layout for the subsection has been finalized. This change fixes the build
> by moving the .org directives inside the subsection, so they are processed
> after the subsection layout is known.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/alternatives: move length validation inside the subsection
      https://git.kernel.org/arm64/c/966a0acce2fc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
