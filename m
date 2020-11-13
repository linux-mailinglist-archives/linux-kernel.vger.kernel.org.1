Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D793D2B1AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgKMMFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:05:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgKML1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:27:46 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4352224C;
        Fri, 13 Nov 2020 11:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605266864;
        bh=BQ5vuTVOn43rBxAnk4/nLf/ku8ZvJLFxqB5/ej6AnZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aD1dKNH2Jm/JiJdkQH5+5Rw5r8X0BKUVsHr9Mo4ePgY+8Lv/UJHxsC3YKRnOYVWps
         +r2Hrr7nniHVamn/B4KiSst9QjiCbEQL9UxWllbCVZ2vBJuyAXFNi1V7nVlBeYmgUr
         jEk0Z2aoIBX7SzR1QWRZJ1uZ5su+gdQ4j4STPKMg=
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Steven Price <steven.price@arm.com>,
        David Hildenbrand <david@redhat.com>, ardb@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V3] arm64/mm: Validate hotplug range before creating linear mapping
Date:   Fri, 13 Nov 2020 11:27:35 +0000
Message-Id: <160526070909.1978780.9007672953232342231.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1605252614-761-1-git-send-email-anshuman.khandual@arm.com>
References: <1605252614-761-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 13:00:14 +0530, Anshuman Khandual wrote:
> During memory hotplug process, the linear mapping should not be created for
> a given memory range if that would fall outside the maximum allowed linear
> range. Else it might cause memory corruption in the kernel virtual space.
> 
> Maximum linear mapping region is [PAGE_OFFSET..(PAGE_END -1)] accommodating
> both its ends but excluding PAGE_END. Max physical range that can be mapped
> inside this linear mapping range, must also be derived from its end points.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/mm: Validate hotplug range before creating linear mapping
      https://git.kernel.org/arm64/c/58284a901b42

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
