Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ECA2EB52E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbhAEWHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:07:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729419AbhAEWHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:07:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6515622EBE;
        Tue,  5 Jan 2021 22:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609884434;
        bh=6X9xh0B9e7jk8zQM37gLnc6Rfvt46/YI3ULCrl4E+0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExbI2M6Ui3QyfRBhdrUi7GpiKAJoN6lx5R4MfJLgOWjxo94nPJ2V6ghl3wUF/luK7
         Y0Q6HsQvwtYkanU46yCVavoHUnH5sOBwbPdiVrKV2KqLeq+jPejkwETiOqTJFFYUGR
         n77h+H235XHE9447prM8u7AkJflwIH/tp1Xvr/lhDRUjb8WI1y1kqU0gb0DUOWmmLp
         otXxR6PDgOlhl3n7yom/QPeXzid6FSzwyZKoajluUI1Zvm6uyrY5TZPPb7nKIREldm
         NHuVs4IhlmtOgs/wOgCntK7Gr/o9Z9uE/NSJvYaX07Wn0a/KHW3hHCyqmhxZYM4VAu
         PNsHZdQiXlrVg==
From:   Will Deacon <will@kernel.org>
To:     Johnathan Smithinovic <johnathan.smithinovic@gmx.at>,
        mingo@redhat.com, David Woodhouse <dwmw2@infradead.org>,
        tglx@linutronix.de, bp@alien8.de
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        iommu <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] iommu/amd: Stop irq_remapping_select() matching when remapping is disabled
Date:   Tue,  5 Jan 2021 22:07:02 +0000
Message-Id: <160987465284.30865.16684216909917986687.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <04bbe8bca87f81a3cfa93ec4299e53f47e00e5b3.camel@infradead.org>
References: <ed4be9b4-24ac-7128-c522-7ef359e8185d@gmx.at> <04bbe8bca87f81a3cfa93ec4299e53f47e00e5b3.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jan 2021 01:36:13 +0000, David Woodhouse wrote:
> The AMD IOMMU initialisation registers the IRQ remapping domain for
> each IOMMU before doing the final sanity check that every I/OAPIC is
> covered.
> 
> This means that the AMD irq_remapping_select() function gets invoked
> even when IRQ remapping has been disabled, eventually leading to a NULL
> pointer dereference in alloc_irq_table().
> 
> [...]

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] iommu/amd: Stop irq_remapping_select() matching when remapping is disabled
      https://git.kernel.org/arm64/c/b34f10c2dc59

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
