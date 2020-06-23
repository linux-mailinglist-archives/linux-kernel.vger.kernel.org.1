Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630E4205510
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 16:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbgFWOpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 10:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732781AbgFWOpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:45:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5C120720;
        Tue, 23 Jun 2020 14:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592923504;
        bh=3RlLN5lT2nQ73rV/tlB3xndz3Xyrb7h8xQykZg1SQk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FceOm854Kl1RfoRNX8TDdy5lVPdKfGtcSpQn60BfUwuLB4i5qHwdm24UHvJYokqeL
         6Z2G75YJ21/BPGhStfTnX5CnwpYpebU9/8x+xD67G2BxN9c9HuFDQZJdOcCd560zme
         mt3nTWRoSaOnmfmOWnqU1cpUoYMWEZ+SbFdeqmTI=
Date:   Tue, 23 Jun 2020 15:44:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Chiawei Wang <chiaweiwang@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v2]: arch: arm64: vdso: export the symbols for time()
Message-ID: <20200623144459.GB4336@willie-the-truck>
References: <20200615143838.143137-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615143838.143137-1-salyzyn@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 07:38:24AM -0700, Mark Salyzyn wrote:
> From: Chiawei Wang <chiaweiwang@google.com>
> 
> __cvdso_time() can be found in vDSO implementation,
> but the symbols for time() are not exported.
> 
> Export the symbols and run bionic-benchmarks.
> 
> BEFORE:
> bionic-benchmarks32 --bionic_extra BM_time_time
> -----------------------------------------------------
> Benchmark           Time             CPU   Iterations
> -----------------------------------------------------
> BM_time_time     83.6 ns         83.5 ns      8385964
> 
> bionic-benchmarks64 --bionic_extra BM_time_time
> -----------------------------------------------------
> Benchmark           Time             CPU   Iterations
> -----------------------------------------------------
> BM_time_time     63.5 ns         63.4 ns     11037509
> 
> AFTER:
> bionic-benchmarks32 --bionic_extra BM_time_time
> -----------------------------------------------------
> Benchmark           Time             CPU   Iterations
> -----------------------------------------------------
> BM_time_time     8.57 ns         8.56 ns     81887312
> 
> bionic-benchmarks64 --bionic_extra BM_time_time
> -----------------------------------------------------
> Benchmark           Time             CPU   Iterations
> -----------------------------------------------------
> BM_time_time     7.52 ns         7.51 ns     93253809
> 
> Signed-off-by: Chiawei Wang <chiaweiwang@google.com>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@android.com
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Enrico Weigelt <info@metux.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alexios Zavras <alexios.zavras@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org

I don't understand this: neither arm nor arm64 offer the time() syscall
afaict, so the C library should be implementing it in terms of
clock_gettime() anyway, which _is_ implemented in the vDSO.

What's am I missing?

Will
