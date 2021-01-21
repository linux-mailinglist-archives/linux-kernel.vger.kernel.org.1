Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074FE2FE8DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbhAULdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:33:24 -0500
Received: from foss.arm.com ([217.140.110.172]:60942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730449AbhAULc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:32:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 795BD11B3;
        Thu, 21 Jan 2021 03:31:43 -0800 (PST)
Received: from [10.37.8.32] (unknown [10.37.8.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ABC03F719;
        Thu, 21 Jan 2021 03:31:41 -0800 (PST)
Subject: Re: [PATCH v4 0/5] arm64: ARMv8.5-A: MTE: Add async mode support
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
 <CAAeHK+xmmTs+T9WNagj0_f3yxT-juSiCDH+wjS-4J3vUviTFsQ@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <ed20df73-486d-db11-a1b9-4006a3a638a2@arm.com>
Date:   Thu, 21 Jan 2021 11:35:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xmmTs+T9WNagj0_f3yxT-juSiCDH+wjS-4J3vUviTFsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 1/19/21 6:09 PM, Andrey Konovalov wrote:
> Hi Vincenzo,
> 
> This change has multiple conflicts with the KASAN testing patches that
> are currently in the mm tree. If Andrew decides to send all of them
> during RC, then this should be good to go through arm64. Otherwise, I
> guess this will need to go through mm as well. So you probably need to
> rebase this on top of those patches in any case.
> 

Could you please let me know on which tree do you want me to rebase my patches?
I almost completed the requested changes.

Thank you!

> Thanks!

-- 
Regards,
Vincenzo
