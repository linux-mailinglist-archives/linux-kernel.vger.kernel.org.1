Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BD525A6E1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 09:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIBHhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 03:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgIBHhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:37:07 -0400
Received: from localhost.localdomain (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02F3E20826;
        Wed,  2 Sep 2020 07:37:04 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] arm64/module: set trampoline section flags regardless of CONFIG_DYNAMIC_FTRACE
Date:   Wed,  2 Sep 2020 08:37:02 +0100
Message-Id: <159903220030.29783.15985807326722906910.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901160016.3646-1-jeyu@kernel.org>
References: <20200901160016.3646-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 18:00:16 +0200, Jessica Yu wrote:
> In the arm64 module linker script, the section .text.ftrace_trampoline
> is specified unconditionally regardless of whether CONFIG_DYNAMIC_FTRACE
> is enabled (this is simply due to the limitation that module linker
> scripts are not preprocessed like the vmlinux one).
> 
> Normally, for .plt and .text.ftrace_trampoline, the section flags
> present in the module binary wouldn't matter since module_frob_arch_sections()
> would assign them manually anyway. However, the arm64 module loader only
> sets the section flags for .text.ftrace_trampoline when CONFIG_DYNAMIC_FTRACE=y.
> That's only become problematic recently due to a recent change in
> binutils-2.35, where the .text.ftrace_trampoline section (along with the
> .plt section) is now marked writable and executable (WAX).
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/module: set trampoline section flags regardless of CONFIG_DYNAMIC_FTRACE
      https://git.kernel.org/arm64/c/e0328feda79d

-- 
Catalin

