Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5645B2331F1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 14:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgG3MXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 08:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgG3MXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:23:17 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09CBD2082E;
        Thu, 30 Jul 2020 12:23:15 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64: delete duplicated words
Date:   Thu, 30 Jul 2020 13:23:14 +0100
Message-Id: <159611178452.13689.4392512277054335405.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200726003207.20253-1-rdunlap@infradead.org>
References: <20200726003207.20253-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 17:32:04 -0700, Randy Dunlap wrote:
> Delete duplicated words in arch/arm64/ header files.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> 
>  arch/arm64/include/asm/pgtable-hwdef.h   |    4 ++--
>  arch/arm64/include/asm/ptrace.h          |    2 +-
>  arch/arm64/include/uapi/asm/sigcontext.h |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> [...]

Applied to arm64 (for-next/trivial), thanks!

[1/3] arm64: pgtable-hwdef.h: delete duplicated words
      https://git.kernel.org/arm64/c/c4334d576cf4
[2/3] arm64: ptrace.h: delete duplicated word
      https://git.kernel.org/arm64/c/c4b5abba0083
[3/3] arm64: sigcontext.h: delete duplicated word
      https://git.kernel.org/arm64/c/1a9ea25d1874

-- 
Catalin

