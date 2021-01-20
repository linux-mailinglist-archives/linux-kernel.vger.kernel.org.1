Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD762FD87E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404585AbhATSXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:23:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391831AbhATSN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:13:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0C5B233F6;
        Wed, 20 Jan 2021 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611166392;
        bh=3nR8FJx6B6+I6ezGDsjWc8JAjA9ul6cJOWEofQvBUIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRkpDRJ06YXmKL62hqmTwtZdbHPzy4Kbe3mHMhU+BTUSu6SgTlud0Q1vDwKw/GAEz
         0pBNtOV+gfAEWpqLHGx/OVrxUUh5+IYjqeQT7cHFUHLjHPM4pNsRz/bxqtQGeFpYTD
         fdqlsg0IAElQP2yQOo/uTmRjaMhj5lrKOn34gDFiiLD62n4ANuAyCCHfXaiVasGocI
         /vEqdKdLGdhchYOGhN7bD4vW+pYRMdKs7oTjqLr8ZgX5UAKnaJn5psoLkRKVYzQdBu
         aB3cQHnsKsHEuhwZF57qbuax21JnaEhJpBxQe/LKmOK1JiIcojDp0Ap7H9KfqB/Wo8
         epyFNngVXSUvA==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, Wei Li <liwei391@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drivers/perf: Add support for ARMv8.3-SPE
Date:   Wed, 20 Jan 2021 18:13:00 +0000
Message-Id: <161116486445.2646464.6398654899152259166.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201203141609.14148-1-liwei391@huawei.com>
References: <20201203141609.14148-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 22:16:09 +0800, Wei Li wrote:
> Armv8.3 extends the SPE by adding:
> - Alignment field in the Events packet, and filtering on this event
>   using PMSEVFR_EL1.
> - Support for the Scalable Vector Extension (SVE).
> 
> The main additions for SVE are:
> - Recording the vector length for SVE operations in the Operation Type
>   packet. It is not possible to filter on vector length.
> - Incomplete predicate and empty predicate fields in the Events packet,
>   and filtering on these events using PMSEVFR_EL1.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: Add support for ARMv8.3-SPE
      https://git.kernel.org/will/c/4a669e2432fc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
