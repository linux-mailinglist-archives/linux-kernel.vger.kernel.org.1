Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38FC2CAF15
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbgLAVpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:45:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388715AbgLAVpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:45:53 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C277B2086A;
        Tue,  1 Dec 2020 21:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606859112;
        bh=igMPQDgWyk4OwUBpic5849I/GvbC4s/vhJKvmdqlYrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDmejFDMD/rtDxapX57p0nYlMv6KRDODRxhn/cQLkReBNsTnxtuL89r9ztwdXILT0
         WwI28A4U/Gw4oJJbRR0ZGWmN2D4jY50psn8XxB84lhuFskgJyfEbMiB/E7okPp7UKa
         7qFvnNYMsVTkWeRY8QMQpvrnstKBbXCtQPyYYhjo=
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        robin.murphy@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, xiyou.wangcong@gmail.com,
        linuxarm@huawei.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 0/4] iommu/iova: Solve longterm IOVA issue
Date:   Tue,  1 Dec 2020 21:45:05 +0000
Message-Id: <160685669713.992935.17438167536143205811.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 18:25:30 +0800, John Garry wrote:
> This series contains a patch to solve the longterm IOVA issue which
> leizhen originally tried to address at [0].
> 
> A sieved kernel log is at the following, showing periodic dumps of IOVA
> sizes, per CPU and per depot bin, per IOVA size granule:
> https://raw.githubusercontent.com/hisilicon/kernel-dev/topic-iommu-5.10-iova-debug-v3/aging_test
> 
> [...]

Applied the final patch to arm64 (for-next/iommu/iova), thanks!

[4/4] iommu: avoid taking iova_rbtree_lock twice
      https://git.kernel.org/arm64/c/3a651b3a27a1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
