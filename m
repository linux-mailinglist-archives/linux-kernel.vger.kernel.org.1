Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0E2A48C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgKCO4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:56:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgKCOzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:55:04 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7190223EA;
        Tue,  3 Nov 2020 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604415303;
        bh=qbfxBieownkCAG2H1cJlnxfBKecOOT4MnsnXDzLjJVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxuPDZtAN55F4/4h6zD3Qp92igX5zZS4nw+S5r0H3/0axJ6X9EsyQlxa2By5Q6b8G
         uzyQK38K5xCGmEVS1d4aWKHfRfygAzcLseTAlcLwW1NFLFHzrPGmQep1kyO3gCTGok
         7j2aE8ojk6xUcePovUoZ8kJQKrEpdwPxcS5bvxro=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Valentin.Schneider@arm.com, Anshuman.Khandual@arm.com,
        patches@amperecomputing.com
Subject: Re: [PATCH v3] arm64: NUMA: Kconfig: Increase NODES_SHIFT to 4
Date:   Tue,  3 Nov 2020 14:54:52 +0000
Message-Id: <160439588576.1151017.825552867492752498.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201030173050.1182876-1-vanshikonda@os.amperecomputing.com>
References: <20201030173050.1182876-1-vanshikonda@os.amperecomputing.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 10:30:50 -0700, Vanshidhar Konda wrote:
> The current arm64 default config limits max NUMA nodes available on
> system to 4 (NODES_SHIFT = 2). Today's arm64 systems can reach or
> exceed 16 NUMA nodes. To accomodate current hardware and to fit
> NODES_SHIFT within page flags on arm64, increase NODES_SHIFT to 4.
> 
> Discussion on v1 of the patch:
> https://lore.kernel.org/linux-arm-kernel/20201020173409.1266576-1-vanshikonda@os.amperecomputing.com/
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: NUMA: Kconfig: Increase NODES_SHIFT to 4
      https://git.kernel.org/arm64/c/2a13c13b39a8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
