Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D28A2B0400
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgKLLfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:35:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbgKLLfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:35:48 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 194D5206FB;
        Thu, 12 Nov 2020 11:35:44 +0000 (UTC)
Date:   Thu, 12 Nov 2020 11:35:42 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/20] kasan: add and integrate kasan boot parameters
Message-ID: <20201112113541.GK29613@gaia>
References: <cover.1605046662.git.andreyknvl@google.com>
 <fdf9e3aec8f57ebb2795710195f8aaf79e3b45bd.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdf9e3aec8f57ebb2795710195f8aaf79e3b45bd.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20:15PM +0100, Andrey Konovalov wrote:
> Hardware tag-based KASAN mode is intended to eventually be used in
> production as a security mitigation. Therefore there's a need for finer
> control over KASAN features and for an existence of a kill switch.
> 
> This change adds a few boot parameters for hardware tag-based KASAN that
> allow to disable or otherwise control particular KASAN features.
> 
> The features that can be controlled are:
> 
> 1. Whether KASAN is enabled at all.
> 2. Whether KASAN collects and saves alloc/free stacks.
> 3. Whether KASAN panics on a detected bug or not.
> 
> With this change a new boot parameter kasan.mode allows to choose one of
> three main modes:
> 
> - kasan.mode=off - KASAN is disabled, no tag checks are performed
> - kasan.mode=prod - only essential production features are enabled
> - kasan.mode=full - all KASAN features are enabled

Alternative naming if we want to avoid "production" (in case someone
considers MTE to be expensive in a production system):

- kasan.mode=off
- kasan.mode=on
- kasan.mode=debug

Anyway, whatever you prefer is fine by me:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
