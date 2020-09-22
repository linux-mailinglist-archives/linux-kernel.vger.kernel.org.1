Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2CE273F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIVKNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:13:39 -0400
Received: from foss.arm.com ([217.140.110.172]:33098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgIVKNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:13:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90D4F1516;
        Tue, 22 Sep 2020 03:13:38 -0700 (PDT)
Received: from [10.37.8.152] (unknown [10.37.8.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE4853F718;
        Tue, 22 Sep 2020 03:13:35 -0700 (PDT)
Subject: Re: [PATCH v2 22/37] arm64: mte: Add in-kernel MTE helpers
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
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
References: <cover.1600204505.git.andreyknvl@google.com>
 <4ac1ed624dd1b0851d8cf2861b4f4aac4d2dbc83.1600204505.git.andreyknvl@google.com>
 <20200917134653.GB10662@gaia> <7904f7c2-cf3b-315f-8885-e8709c232718@arm.com>
 <20200918093656.GB6335@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <392180d4-95cf-fed9-5650-bbf52ec5c087@arm.com>
Date:   Tue, 22 Sep 2020 11:16:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918093656.GB6335@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/20 10:36 AM, Catalin Marinas wrote:
>> Same as above but I will use the orr in the next version.
> I wonder whether system_supports_mte() makes more sense here than the
> alternative:
> 
> 	if (!system_supports_mte())
> 		return 0xff;
> 
> 	... mte irg stuff ...
> 
> (you could do the same for the mte_get_mem_tag() function)
> 

This would have been my preference from the beginning but then you mentioned
alternatives ;)

Anyway, more then happy to change the code in this way, seems more clean and
easy to understand.

-- 
Regards,
Vincenzo
