Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3B42A45C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgKCM6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:58:53 -0500
Received: from foss.arm.com ([217.140.110.172]:48582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbgKCM6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:58:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44276106F;
        Tue,  3 Nov 2020 04:58:50 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.57.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C3B13F718;
        Tue,  3 Nov 2020 04:58:48 -0800 (PST)
Date:   Tue, 3 Nov 2020 12:58:45 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: lto: Strengthen READ_ONCE() to acquire
 when CONFIG_LTO=y
Message-ID: <20201103125845.GD40454@C02TD0UTHF1T.local>
References: <20201103121721.5166-1-will@kernel.org>
 <20201103121721.5166-5-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103121721.5166-5-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 12:17:21PM +0000, Will Deacon wrote:
> When building with LTO, there is an increased risk of the compiler
> converting an address dependency headed by a READ_ONCE() invocation
> into a control dependency and consequently allowing for harmful
> reordering by the CPU.
> 
> Ensure that such transformations are harmless by overriding the generic
> READ_ONCE() definition with one that provides acquire semantics when
> building with LTO.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

[...]

Could we add a note above __READ_ONCE() along the lines of the commit
message, e.g.

/*
 * With LTO a compiler might convert an address dependency headed by a
 * READ_ONCE() into a control dependency, allowing for harmful
 * reordering by the CPU.
 *
 * To prevent this, upgrade READ_OONCE() to provide acquire semantics
 * when building with LTO.
 */

Either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark

> +#define __READ_ONCE(x)							\
> +({									\
> +	typeof(&(x)) __x = &(x);					\
> +	int atomic = 1;							\
> +	union { __unqual_scalar_typeof(*__x) __val; char __c[1]; } __u;	\
> +	switch (sizeof(x)) {						\
> +	case 1:								\
> +		asm volatile(__LOAD_RCPC(b, %w0, %1)			\
> +			: "=r" (*(__u8 *)__u.__c)			\
> +			: "Q" (*__x) : "memory");			\
> +		break;							\
> +	case 2:								\
> +		asm volatile(__LOAD_RCPC(h, %w0, %1)			\
> +			: "=r" (*(__u16 *)__u.__c)			\
> +			: "Q" (*__x) : "memory");			\
> +		break;							\
> +	case 4:								\
> +		asm volatile(__LOAD_RCPC(, %w0, %1)			\
> +			: "=r" (*(__u32 *)__u.__c)			\
> +			: "Q" (*__x) : "memory");			\
> +		break;							\
> +	case 8:								\
> +		asm volatile(__LOAD_RCPC(, %0, %1)			\
> +			: "=r" (*(__u64 *)__u.__c)			\
> +			: "Q" (*__x) : "memory");			\
> +		break;							\
> +	default:							\
> +		atomic = 0;						\
> +	}								\
> +	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(__x))__x);\
> +})
