Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9002A8421
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgKEQ5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgKEQ5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:57:32 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63169206F9;
        Thu,  5 Nov 2020 16:57:28 +0000 (UTC)
Date:   Thu, 5 Nov 2020 16:57:25 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 29/43] arm64: mte: Add in-kernel tag fault handler
Message-ID: <20201105165724.GD30030@gaia>
References: <cover.1604531793.git.andreyknvl@google.com>
 <a540ab7b9e3b908e0f4cd94c963a0cc6bb4e7d3f.1604531793.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a540ab7b9e3b908e0f4cd94c963a0cc6bb4e7d3f.1604531793.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 12:18:44AM +0100, Andrey Konovalov wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Add the implementation of the in-kernel fault handler.
> 
> When a tag fault happens on a kernel address:
> * MTE is disabled on the current CPU,
> * the execution continues.
> 
> When a tag fault happens on a user address:
> * the kernel executes do_bad_area() and panics.
> 
> The tag fault handler for kernel addresses is currently empty and will be
> filled in by a future commit.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
