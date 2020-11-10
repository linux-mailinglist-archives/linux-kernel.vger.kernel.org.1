Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615092AE3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbgKJWyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730254AbgKJWyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:54:32 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C691205CA;
        Tue, 10 Nov 2020 22:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605048872;
        bh=gsDtrEo/+4VxZ0lzAA/UbiyTAEoGDS7zICfT710MOJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PMMtGRTiQw6LrxiauVSJv7kDsCfSrfZpwm3o2p8MOLy3Yet+GKJp7JttqW6HOKnxA
         SiA9IlhVAj3WCPPPjK8a+Xw8xQmQ5D82W+Q4HPRKcrErSQeroIuiFctZGp6dshOys+
         oI79pcHx2EBfWhbmWqBPV4+dRUlvsMDzDF2eJYI0=
Date:   Tue, 10 Nov 2020 14:54:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v9 00/44] kasan: add hardware tag-based mode for arm64
Message-Id: <20201110145430.e15cb0e0d51498d961206be9@linux-foundation.org>
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 23:09:57 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:

> This patchset adds a new hardware tag-based mode to KASAN [1]. The new mode
> is similar to the existing software tag-based KASAN, but relies on arm64
> Memory Tagging Extension (MTE) [2] to perform memory and pointer tagging
> (instead of shadow memory and compiler instrumentation).

I have that all merged up on top of linux-next.  Numerous minor
conflicts, mainly in arch/arm/Kconfig.  Also the changes in
https://lkml.kernel.org/r/20201103175841.3495947-7-elver@google.com had
to be fed into "kasan: split out shadow.c from common.c".

I staged it after linux-next to provide visibility into potentially
conflicting changes in the arm tree as things move forward.

