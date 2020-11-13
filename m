Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E062B293D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 00:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgKMXfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 18:35:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKMXfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:35:51 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE40D22256;
        Fri, 13 Nov 2020 23:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605310551;
        bh=yCYKhD16gKX5xxn92nGzvJxUg2BQXXSqYsh+H+ozt0M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NReDqobeKJiLMaP96HWCBDgcA6mhV0+tOdewQYEQkUAxERv4gaAUzVKwCiServWNO
         YcRJlYrcwz+O82B9HVJV1z7CFY+FbUIl0iQaPRdwAiUs9HilNLucXRTVz4E9I5Wdse
         3m7wfL9a0uA4QRRzO6Tl4VCreqzzqh+ZmhoRmKiQ=
Date:   Fri, 13 Nov 2020 15:35:50 -0800
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
Subject: Re: [PATCH mm v10 00/42] kasan: add hardware tag-based mode for
 arm64
Message-Id: <20201113153550.5ab0f21942ef7331935fecc4@linux-foundation.org>
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 23:15:28 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:

> This patchset adds a new hardware tag-based mode to KASAN [1]. The new mode
> is similar to the existing software tag-based KASAN, but relies on arm64
> Memory Tagging Extension (MTE) [2] to perform memory and pointer tagging
> (instead of shadow memory and compiler instrumentation).
> 
> ...
>
> ====== History
> 
> Change v9->v10:

I'll drop v9 from -mm and shall go into hiding for a few days, see how
the ongoing review is proceeding.

