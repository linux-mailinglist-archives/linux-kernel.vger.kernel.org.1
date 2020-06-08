Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795E21F1BDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 17:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgFHPRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 11:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729843AbgFHPRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:17:38 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAFF92074B;
        Mon,  8 Jun 2020 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591629458;
        bh=Ny5i86JNHb2JrfgvoHzy6RFfNKJ3tbWvSq/XAKgkm08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PvI3QXx8W2L0h8pF0A8QH45i43twi6umaI2taBWcBNgfeyrWFUp1y4QNznuyGNAAA
         EqNYyBmpeHlUFxziOpaZeUH4Vvgcq9DN9bGvs6LhWrbagwIZx5qvFGjwqyPjCWtUfE
         9RL+2w7SJQbnYPz3mcB/qhro8Yvk658sjG2IPX7g=
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Possible PATCH]arm64: ftrace: Change CONFIG_FTRACE_WITH_REGS to CONFIG_DYNAMIC_FTRACE_WITH_REGS
Date:   Mon,  8 Jun 2020 16:17:30 +0100
Message-Id: <159162750580.200319.6583744463210432522.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <b9b27f2233bd1fa31d72ff937beefdae0e2104e5.camel@perches.com>
References: <b9b27f2233bd1fa31d72ff937beefdae0e2104e5.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jun 2020 12:25:50 -0700, Joe Perches wrote:
> CONFIG_FTRACE_WITH_REGS does not exist as a Kconfig symbol.

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: ftrace: Change CONFIG_FTRACE_WITH_REGS to CONFIG_DYNAMIC_FTRACE_WITH_REGS
      https://git.kernel.org/arm64/c/91970bef48d6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
