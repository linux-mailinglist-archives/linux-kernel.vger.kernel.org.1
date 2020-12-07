Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D9C2D0EA0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgLGLGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:06:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgLGLGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:06:10 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, brijesh.singh@amd.com,
        Jon.Grimm@amd.com
Subject: Re: [PATCH] iommu/amd: Set DTE[IntTabLen] to represent 512 IRTEs
Date:   Mon,  7 Dec 2020 11:05:23 +0000
Message-Id: <160733882472.3526398.13030595786733592233.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201207091920.3052-1-suravee.suthikulpanit@amd.com>
References: <20201207091920.3052-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 03:19:20 -0600, Suravee Suthikulpanit wrote:
> According to the AMD IOMMU spec, the commit 73db2fc595f3
> ("iommu/amd: Increase interrupt remapping table limit to 512 entries")
> also requires the interrupt table length (IntTabLen) to be set to 9
> (power of 2) in the device table mapping entry (DTE).

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] iommu/amd: Set DTE[IntTabLen] to represent 512 IRTEs
      https://git.kernel.org/arm64/c/4165bf015ba9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
