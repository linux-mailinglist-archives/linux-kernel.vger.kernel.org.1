Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E620F26E46B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgIQSqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:46:20 -0400
Received: from foss.arm.com ([217.140.110.172]:50650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgIQSpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:45:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D847011D4;
        Thu, 17 Sep 2020 11:45:35 -0700 (PDT)
Received: from [10.37.8.97] (unknown [10.37.8.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A75B33F718;
        Thu, 17 Sep 2020 11:45:32 -0700 (PDT)
Subject: Re: [PATCH v2 27/37] arm64: mte: Switch GCR_EL1 in kernel entry and
 exit
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
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
 <c801517c8c6c0b14ac2f5d9e189ff86fdbf1d495.1600204505.git.andreyknvl@google.com>
 <20200917165221.GF10662@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c7cb0642-8e20-b478-96bf-87807a29fc71@arm.com>
Date:   Thu, 17 Sep 2020 19:47:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917165221.GF10662@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/20 5:52 PM, Catalin Marinas wrote:
>> +void mte_init_tags(u64 max_tag)
>> +{
>> +	u64 incl = GENMASK(max_tag & MTE_TAG_MAX, 0);
>> +
>> +	gcr_kernel_excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
>> +}
> Do we need to set the actual GCR_EL1 register here? We may not get an
> exception by the time KASAN starts using it.

It is ok not setting it here because to get exceptions cpuframework mte enable
needs to be executed first. In that context we set even the register.

-- 
Regards,
Vincenzo
