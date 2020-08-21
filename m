Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197FA24DF2B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 20:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHUSPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 14:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgHUSPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:15:10 -0400
Received: from localhost.localdomain (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2034207DF;
        Fri, 21 Aug 2020 18:15:07 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     dianders@google.com, kernel-team@android.com,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: vdso32: Install vdso32 from vdso_install
Date:   Fri, 21 Aug 2020 19:15:01 +0100
Message-Id: <159803353178.13439.5168715858763526885.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818014950.42492-1-swboyd@chromium.org>
References: <20200818014950.42492-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 18:49:50 -0700, Stephen Boyd wrote:
> Add the 32-bit vdso Makefile to the vdso_install rule so that 'make
> vdso_install' installs the 32-bit compat vdso when it is compiled.

Applied to arm64 (for-next/fixes), thanks!

[1/1] ARM64: vdso32: Install vdso32 from vdso_install
      https://git.kernel.org/arm64/c/8d75785a8142

-- 
Catalin

