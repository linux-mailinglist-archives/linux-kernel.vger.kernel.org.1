Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4FC2F4F91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbhAMQIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:08:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbhAMQIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:08:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75ABA2343B;
        Wed, 13 Jan 2021 16:06:59 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        hayashi.kunihiko@socionext.com, mark.rutland@arm.com,
        samitolvanen@google.com, broonie@kernel.org,
        vincenzo.frascino@arm.com, maz@kernel.org, keescook@chromium.org,
        ardb@kernel.org, will@kernel.org, Jianlin Lv <Jianlin.Lv@arm.com>,
        kristina.martsenko@arm.com, dbrazdil@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: rename S_FRAME_SIZE to PT_REGS_SIZE
Date:   Wed, 13 Jan 2021 16:06:57 +0000
Message-Id: <161055398865.21762.5669991377199953019.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210112015813.2340969-1-Jianlin.Lv@arm.com>
References: <20210112015813.2340969-1-Jianlin.Lv@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 09:58:13 +0800, Jianlin Lv wrote:
> S_FRAME_SIZE is the size of the pt_regs structure, no longer the size of
> the kernel stack frame, the name is misleading. In keeping with arm32,
> rename S_FRAME_SIZE to PT_REGS_SIZE.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: rename S_FRAME_SIZE to PT_REGS_SIZE
      https://git.kernel.org/arm64/c/71e70184f1d1

-- 
Catalin

