Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2CC255A43
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 14:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgH1MdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 08:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729362AbgH1Mbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:31:35 -0400
Received: from localhost.localdomain (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C11902078A;
        Fri, 28 Aug 2020 12:31:33 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        Frank van der Linden <fllinden@amazon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: vdso32: make vdso32 install conditional
Date:   Fri, 28 Aug 2020 13:31:31 +0100
Message-Id: <159861787904.27651.5104242927513392169.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827234012.19757-1-fllinden@amazon.com>
References: <20200827234012.19757-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 23:40:12 +0000, Frank van der Linden wrote:
> vdso32 should only be installed if CONFIG_COMPAT_VDSO is enabled,
> since it's not even supposed to be compiled otherwise, and arm64
> builds without a 32bit crosscompiler will fail.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: vdso32: make vdso32 install conditional
      https://git.kernel.org/arm64/c/5d28ba5f8a0c

-- 
Catalin

