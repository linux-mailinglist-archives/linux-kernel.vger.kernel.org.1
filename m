Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D305A2558BD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 12:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgH1KmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 06:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbgH1KmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:42:02 -0400
Received: from localhost.localdomain (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 300B220B80;
        Fri, 28 Aug 2020 10:42:00 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>, Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] arm64: use a common .arch preamble for inline assembly
Date:   Fri, 28 Aug 2020 11:41:58 +0100
Message-Id: <159861130822.26090.515756118612731592.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827203608.1225689-1-samitolvanen@google.com>
References: <20200805181920.4013059-1-samitolvanen@google.com> <20200827203608.1225689-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 13:36:08 -0700, Sami Tolvanen wrote:
> Commit 7c78f67e9bd9 ("arm64: enable tlbi range instructions") breaks
> LLVM's integrated assembler, because -Wa,-march is only passed to
> external assemblers and therefore, the new instructions are not enabled
> when IAS is used.
> 
> This change adds a common architecture version preamble, which can be
> used in inline assembly blocks that contain instructions that require
> a newer architecture version, and uses it to fix __TLBI_0 and __TLBI_1
> with ARM64_TLB_RANGE.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: use a common .arch preamble for inline assembly
      https://git.kernel.org/arm64/c/1764c3edc668

-- 
Catalin

