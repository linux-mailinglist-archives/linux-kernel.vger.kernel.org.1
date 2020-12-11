Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AB22D7652
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436706AbgLKNMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:12:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbgLKNLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:11:45 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, thomas.lendacky@amd.com,
        Jon.Grimm@amd.com
Subject: Re: [PATCH] iommu/amd: Add sanity check for interrupt remapping table length macros
Date:   Fri, 11 Dec 2020 13:10:59 +0000
Message-Id: <160769084268.2390072.5659488750209026923.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201210162436.126321-1-suravee.suthikulpanit@amd.com>
References: <20201210162436.126321-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 10:24:36 -0600, Suravee Suthikulpanit wrote:
> Currently, macros related to the interrupt remapping table length are
> defined separately. This has resulted in an oversight in which one of
> the macros were missed when changing the length. To prevent this,
> redefine the macros to add built-in sanity check.
> 
> Also, rename macros to use the name of the DTE[IntTabLen] field as
> specified in the AMD IOMMU specification. There is no functional change.

Applied to arm64 (for-next/iommu/core), thanks!

[1/1] iommu/amd: Add sanity check for interrupt remapping table length macros
      https://git.kernel.org/arm64/c/5ae9a046a452

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
