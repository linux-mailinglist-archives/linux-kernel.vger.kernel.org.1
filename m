Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A5C1BC1C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgD1OuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 10:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbgD1OuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:50:01 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B38206E2;
        Tue, 28 Apr 2020 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588085401;
        bh=e/u/y83r4b6dQYbm2bYsUESEcgF7p+NJaD1GBfOZ/bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDNopLfuEC2n3bNquAlGpjAebJnR8gu5JGBLmMoZzP//GEQpJ/RRnfz/HHUn1QWvd
         JXhFAaSxZdTkre+InrRaWUcfN5TLln7R/dAHgenSsXICUnElZdWdc9NmWvyhj9YWvm
         l421DurWARY+50SlgdrMq7j3isfB4q4RZV1vHPzE=
From:   Will Deacon <will@kernel.org>
To:     james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, Jason Yan <yanaijie@huawei.com>,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] arm64: entry: remove unneeded semicolon in el1_sync_handler()
Date:   Tue, 28 Apr 2020 15:49:40 +0100
Message-Id: <158807933790.210168.13352385084206867237.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418081909.41471-1-yanaijie@huawei.com>
References: <20200418081909.41471-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Apr 2020 16:19:09 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> arch/arm64/kernel/entry-common.c:97:2-3: Unneeded semicolon

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: entry: remove unneeded semicolon in el1_sync_handler()
      https://git.kernel.org/arm64/c/0dd2334fd5b9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
