Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96D32543FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 12:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgH0Kpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 06:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH0KpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:45:24 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF46207F7;
        Thu, 27 Aug 2020 10:45:20 +0000 (UTC)
Date:   Thu, 27 Aug 2020 11:45:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/35] kasan, arm64: implement HW_TAGS runtime
Message-ID: <20200827104517.GH29264@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <4e86d422f930831666137e06a71dff4a7a16a5cd.1597425745.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e86d422f930831666137e06a71dff4a7a16a5cd.1597425745.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 07:27:13PM +0200, Andrey Konovalov wrote:
> diff --git a/mm/kasan/mte.c b/mm/kasan/mte.c
> new file mode 100644
> index 000000000000..43b7d74161e5
> --- /dev/null
> +++ b/mm/kasan/mte.c

Since this is an arm64-specific kasan backend, I wonder whether it makes
more sense to keep it under arch/arm64 (mte-kasan.c).

> diff --git a/mm/kasan/report_mte.c b/mm/kasan/report_mte.c
> new file mode 100644
> index 000000000000..dbbf3aaa8798
> --- /dev/null
> +++ b/mm/kasan/report_mte.c

Same for this one.

-- 
Catalin
