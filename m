Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADDE2C4454
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbgKYPo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:44:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730304AbgKYPoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:44:25 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0B4D21D91;
        Wed, 25 Nov 2020 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606319064;
        bh=lW0MnH6le+/02MV7CQX+3Bb0Mmu7uIzimlKvLWLHEOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsPn85AjeMB0/tuutmDsLFFzCHfjnnUR4dLN/P/kFd2PRCpWXrWxecCPcT6+v82sM
         6bQHEWoSr2DhRYwmhwnaEtl9rf9PslpKRfmObl07UcI9YH2H4U1tIhJNmfNgcmKxA+
         BuhcPrsUEpBFaOEeudm4bz2cZYqqkkQ4+LUcyioc=
From:   Will Deacon <will@kernel.org>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, patches@amperecomputing.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6] driver/perf: Add PMU driver for the ARM DMC-620 memory controller
Date:   Wed, 25 Nov 2020 15:44:09 +0000
Message-Id: <160631588213.1506382.10150338922271278043.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1604518246-6198-1-git-send-email-tuanphan@os.amperecomputing.com>
References: <1604518246-6198-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 11:30:43 -0800, Tuan Phan wrote:
> DMC-620 PMU supports total 10 counters which each is
> independently programmable to different events and can
> be started and stopped individually.
> 
> Currently, it only supports ACPI. Other platforms feel free to test and add
> support for device tree.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] driver/perf: Add PMU driver for the ARM DMC-620 memory controller
      https://git.kernel.org/will/c/53c218da220c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
