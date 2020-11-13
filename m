Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C3B2B19C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKMLOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:14:31 -0500
Received: from foss.arm.com ([217.140.110.172]:36290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgKMLOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:14:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B40081042;
        Fri, 13 Nov 2020 03:14:12 -0800 (PST)
Received: from [10.37.12.45] (unknown [10.37.12.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 568CB3F6CF;
        Fri, 13 Nov 2020 03:14:10 -0800 (PST)
Subject: Re: [PATCH v9 30/44] arm64: kasan: Allow enabling in-kernel MTE
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1605046192.git.andreyknvl@google.com>
 <5ce2fc45920e59623a4a9d8d39b6c96792f1e055.1605046192.git.andreyknvl@google.com>
 <20201112094354.GF29613@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <66ef4957-f399-4af1-eec5-d5782551e995@arm.com>
Date:   Fri, 13 Nov 2020 11:17:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112094354.GF29613@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 11/12/20 9:43 AM, Catalin Marinas wrote:
> On Tue, Nov 10, 2020 at 11:10:27PM +0100, Andrey Konovalov wrote:
>> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>
>> Hardware tag-based KASAN relies on Memory Tagging Extension (MTE)
>> feature and requires it to be enabled. MTE supports
>>
>> This patch adds a new mte_init_tags() helper, that enables MTE in
>> Synchronous mode in EL1 and is intended to be called from KASAN runtime
>> during initialization.
> 
> There's no mte_init_tags() in this function.
> 

During the rework, I realized that the description of mte_init_tags() in this
patch refers to mte_enable_kernel(). In fact the only thing that mte_init_tags()
does is to configure the GCR_EL1 register, hence my preference would be to keep
all the code that deals with such a register in one patch.

What is your preference?

-- 
Regards,
Vincenzo
