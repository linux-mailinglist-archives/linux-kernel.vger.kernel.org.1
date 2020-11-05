Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32122A893A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbgKEVro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:47:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731508AbgKEVro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:47:44 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55BEB20728;
        Thu,  5 Nov 2020 21:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604612864;
        bh=znG1McHlXKsc+T0O+cMefkqwbjAjnXOe7uh3LT84mrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xc5b+MQEFC+wBRMULK1bywdHPkKN8s3nE0edSny2zmi5tirdNSLojIF2u7KIE4Woe
         PasIVscW5Whn+WS3PkGWt8EFpGUW5JONvmlnV9s5PGlkB6CXIZ/I0EtdIQrKKIXsP8
         0JsDfOgVR7xoQbOVAhVWqngbN+HLqG/10tesNOAw=
Date:   Thu, 5 Nov 2020 21:47:38 +0000
From:   Will Deacon <will@kernel.org>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, ardb@kernel.org
Subject: Re: [PATCH] arm64: Change the location of DISCARDS
Message-ID: <20201105214738.GB8600@willie-the-truck>
References: <1604486932-18889-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604486932-18889-1-git-send-email-tangyouling@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 06:48:52PM +0800, Youling Tang wrote:
> In the include/asm-generic/vmlinux.lds.h file, the "must be the last"
> comment indicates that DISCARDS should be placed in the last position
> of SECTIONS, like x86, mips, riscv, etc.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Why does this section need to be last?

Will
