Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3313C2EF667
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbhAHRXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:23:18 -0500
Received: from foss.arm.com ([217.140.110.172]:54500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbhAHRXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:23:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 662B111FB;
        Fri,  8 Jan 2021 09:22:32 -0800 (PST)
Received: from [10.37.8.22] (unknown [10.37.8.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16B6F3F70D;
        Fri,  8 Jan 2021 09:22:29 -0800 (PST)
Subject: Re: [PATCH 2/4] arm64: mte: Add asynchronous mode support
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
References: <20210106115519.32222-1-vincenzo.frascino@arm.com>
 <20210106115519.32222-3-vincenzo.frascino@arm.com>
 <CAAeHK+xuGRzkLdrfGZVo-RVfkH31qUrNdBaPd4k5ffMKHWGfTQ@mail.gmail.com>
 <c4f04127-a682-d809-1dad-5ee1f51d3e0a@arm.com>
 <CAAeHK+xBrCX1Ly0RU-=ySEU8SsyyRkMdOYrN52ONc4DeRJA5eg@mail.gmail.com>
 <c3efaa8d-cb3a-0c2a-457e-bfba60551d80@arm.com>
 <CAAeHK+zjwr0M92zqUjseJmRmhHb=4GjevEft-mahfx5DOkq==w@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1e1e9d66-32da-6bb8-b4cf-91c03ea90180@arm.com>
Date:   Fri, 8 Jan 2021 17:26:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+zjwr0M92zqUjseJmRmhHb=4GjevEft-mahfx5DOkq==w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 1/8/21 1:36 PM, Andrey Konovalov wrote:
> Perhaps we could add a generic arch-agnostic enum to
> include/linux/kasan.h and use it in both arm64 and KASAN code?
> 
> enum kasan_hw_tags_mode {
>   KASAN_HW_TAGS_SYNC,
>   KASAN_HW_TAGS_ASYNC
> }
> 
> Assuming other architectures that support memory tagging will end up
> with sync/async mode separation as well, this should work. But even if
> that doesn't happen, this interface can be adjusted later.

I am fine with this solution, I will add it in my v3.
As part of the enumeration I will add READ_SYNC mode as well, so we have all the
possible combinations.

-- 
Regards,
Vincenzo
