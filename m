Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9CD2FF0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbhAUQnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:43:53 -0500
Received: from foss.arm.com ([217.140.110.172]:41184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388021AbhAUQm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:42:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30A9311D4;
        Thu, 21 Jan 2021 08:41:43 -0800 (PST)
Received: from [10.37.8.32] (unknown [10.37.8.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62CD3F68F;
        Thu, 21 Jan 2021 08:41:40 -0800 (PST)
Subject: Re: [PATCH v4 2/5] kasan: Add KASAN mode kernel parameter
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
 <20210118183033.41764-3-vincenzo.frascino@arm.com>
 <CAAeHK+xCkkqzwYW+Q7zUOjbhrDE0fFV2dH9sRAqrFcCP6Df0iQ@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <94819305-66e3-1873-c982-f043a341daed@arm.com>
Date:   Thu, 21 Jan 2021 16:45:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xCkkqzwYW+Q7zUOjbhrDE0fFV2dH9sRAqrFcCP6Df0iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 1/19/21 6:10 PM, Andrey Konovalov wrote:
> I'll later add a patch on top that forbids running the tests with the
> async mode.

Sorry, I misread this part, I thought you wanted me to do this. Anyway I added
the check to my last series.

Please have a look.

-- 
Regards,
Vincenzo
