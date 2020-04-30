Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EFB1C08EA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 23:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgD3VMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 17:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgD3VMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:12:38 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA492070B;
        Thu, 30 Apr 2020 21:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588281158;
        bh=v9Lf0rrVZo5rNgO4FTMUCWiZC44pRfkJihz7+RCKImY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAUG6+W30h45pEb8N67PLRnG1u47+QtFHjY6eVBWzxwBmg/RqAYUr7mcYceljXtNV
         qIwuGqVJOQkCHRLrvw/SZNNsmzfdI7ByqbyxhVD+gWZhXJjGEdNDUsiddx2N48DYNn
         QCR7MSYSHVcEZ4VjMjDeTSRhG+rWW9VbBfswoA64=
From:   Will Deacon <will@kernel.org>
To:     Guixiong Wei <guixiongwei@gmail.com>, catalin.marinas@arm.com
Cc:     Will Deacon <will@kernel.org>, steve.capper@arm.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, guro@fb.com,
        rppt@linux.ibm.com, akpm@linux-foundation.org,
        nsaenzjulienne@suse.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm: mm: use __pfn_to_section() to get mem_section
Date:   Thu, 30 Apr 2020 22:12:24 +0100
Message-Id: <158827763886.6823.16995736264888732732.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430161858.11379-1-guixiongwei@gmail.com>
References: <20200430161858.11379-1-guixiongwei@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 May 2020 06:18:58 +1400, Guixiong Wei wrote:
> __pfn_to_section() helper which already wraps around
> __nr_to_section(pfn_to_section_nr(pfn)), should be used
> directly instead.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm: mm: use __pfn_to_section() to get mem_section
      https://git.kernel.org/arm64/c/037d9303a7e7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
