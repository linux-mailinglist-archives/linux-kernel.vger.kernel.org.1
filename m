Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352A81C08ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 23:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgD3VMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 17:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgD3VMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:12:45 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8077208D6;
        Thu, 30 Apr 2020 21:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588281164;
        bh=BY3Hgo5t4BTs38VcTzig7+9uhGShsbCQBADRcW8MfS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzGmNngEM9g0/HwISElCO250AL+9P/5KZvtcVwjFIitnPlFlPOZX0Tz239VASq2k5
         LfaBZfkUMeFGlvMhbk1vGNY+7P6Pixmjc3OCL037Cm1vb+mF+X9zS+U8FqncNJlEq3
         LiySUpgQjPhWCwD7p23SqUFXZ8vhTrD18b4kJ9Zs=
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf:Avoid duplicate printouts
Date:   Thu, 30 Apr 2020 22:12:27 +0100
Message-Id: <158827969499.122898.13692306035235615025.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402115940.4928-1-tangbin@cmss.chinamobile.com>
References: <20200402115940.4928-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020 19:59:40 +0800, Tang Bin wrote:
> Because platform_get_irq() has dev_err(),so this place
> should be removed.

Applied to arm64 (for-next/perf), thanks!

[1/1] drivers/perf: arm_dsu_pmu: Avoid duplicate printouts
      https://git.kernel.org/arm64/c/5810f00ade49

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
