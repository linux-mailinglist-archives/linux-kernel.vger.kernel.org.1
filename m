Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D52B2D34
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 13:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgKNMsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 07:48:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKNMsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 07:48:01 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 804B82222C;
        Sat, 14 Nov 2020 12:47:58 +0000 (UTC)
Date:   Sat, 14 Nov 2020 12:47:56 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm v10 28/42] arm64: kasan: Allow enabling in-kernel MTE
Message-ID: <20201114124755.GD2837@gaia>
References: <cover.1605305705.git.andreyknvl@google.com>
 <123c654a82018611d38af8c83d1e90c16558ce52.1605305705.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <123c654a82018611d38af8c83d1e90c16558ce52.1605305705.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:15:56PM +0100, Andrey Konovalov wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Hardware tag-based KASAN relies on Memory Tagging Extension (MTE)
> feature and requires it to be enabled. MTE supports
> 
> This patch adds a new mte_enable_kernel() helper, that enables MTE in
> Synchronous mode in EL1 and is intended to be called from KASAN runtime
> during initialization.
> 
> The Tag Checking operation causes a synchronous data abort as
> a consequence of a tag check fault when MTE is configured in
> synchronous mode.
> 
> As part of this change enable match-all tag for EL1 to allow the
> kernel to access user pages without faulting. This is required because
> the kernel does not have knowledge of the tags set by the user in a
> page.
> 
> Note: For MTE, the TCF bit field in SCTLR_EL1 affects only EL1 in a
> similar way as TCF0 affects EL0.
> 
> MTE that is built on top of the Top Byte Ignore (TBI) feature hence we
> enable it as part of this patch as well.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
