Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E225D27CEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgI2NLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI2NLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:11:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E5DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:11:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so5375670wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Zoo7sR5M5htbvHNu3bicEUq1AAqj0gs6k4W5/ci+9Q=;
        b=RNHLBk7i6XR1zMD1p4N6ZqYbYyWG4mssQ7O+gFffzxxHmle0A5/U9YEwjGVqZWhUxh
         DQIl7RGT3z8N78DcH5EToKU6xktWeegW2yJKIm4P5N6M21o0mJ3HRdLVZAjWadYujsYm
         XFeSekc+TLgmk0Qxu95Y4U0aXOcie3bPgpcwTA+g/292Vx3HkNq2xn1D2jnkpVDS8d+7
         DBl/WzKaHleY9+rrQpEls6TZBtK9635dKBhL5g0rX+RSs7NLDM3660UnFWAT71UVVLdH
         GrqoUwjZAa6ubaJFcQETRsYLcVH5q22Dnp0s8CQSTEGcZx103ImXkF5fZc7VFh85HATD
         +eSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Zoo7sR5M5htbvHNu3bicEUq1AAqj0gs6k4W5/ci+9Q=;
        b=Knfi4mUV8rBTzamofGRiEk8WoXom1U2MRFfc/cqUuLK29i77Sswwm/uZXyRDl9DcuJ
         EUcQdObKq1LmcA8nB4fluGZtyLRdFDn7mVoHUVfeoXQnjFHpw6ZYL87yMPBT5urD/Q23
         0qGtAZ+WlD6GU9qJ4yx9RCYGR4s7pXCioIs8A7DoTbO2e6eo6sg0cN/uk97ntGNgyVFV
         yHoUR91G5TywOY30lGTJAANnQyiYo1HZCKg8InueZYeN2Jcmn7uw6zQPTWaZ/+/V2Bex
         +4N7CeZzxPs9cqqhdbDZI4eFKui7mxzi4kwoSoz3jceZ7ygYnPqrcv8P4qwjkw9WI6Bw
         5T0w==
X-Gm-Message-State: AOAM530O0UN1aGl7pMkR8FK2WMAxxeuNtjmdik/5FeuP5f/cgom9L6cr
        bYYmUp6iABnX0070Rm1bWZBMgw==
X-Google-Smtp-Source: ABdhPJy/x6OJ9PkFKsanJQaxmyzHovoF3ynu7/cmwlQcwnjBTZ7zNLjMOnQyomIwVrgGeAQcVFMTzw==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr4452655wrn.2.1601385102792;
        Tue, 29 Sep 2020 06:11:42 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id s12sm5024777wmd.20.2020.09.29.06.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:11:41 -0700 (PDT)
Date:   Tue, 29 Sep 2020 15:11:35 +0200
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan.Cameron@huawei.com, Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, sjpark@amazon.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v3 01/10] mm: add Kernel Electric-Fence infrastructure
Message-ID: <20200929131135.GA2822082@elver.google.com>
References: <20200921132611.1700350-1-elver@google.com>
 <20200921132611.1700350-2-elver@google.com>
 <CAAeHK+zYP6xhAEcv75zdSt03V2wAOTed6vNBYReV_U7EsRmUBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zYP6xhAEcv75zdSt03V2wAOTed6vNBYReV_U7EsRmUBw@mail.gmail.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 02:42PM +0200, Andrey Konovalov wrote:
[...]
> > +        */
> > +       index = (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2) - 1;
> 
> Why do we subtract 1 here? We do have the metadata entry reserved for something?

Above the declaration of __kfence_pool it says:

	* We allocate an even number of pages, as it simplifies calculations to map
	* address to metadata indices; effectively, the very first page serves as an
	* extended guard page, but otherwise has no special purpose.

Hopefully that clarifies the `- 1` here.

[...]
> > +       /* Allocation and free stack information. */
> > +       int num_alloc_stack;
> > +       int num_free_stack;
> > +       unsigned long alloc_stack[KFENCE_STACK_DEPTH];
> > +       unsigned long free_stack[KFENCE_STACK_DEPTH];
> 
> It was a concious decision to not use stackdepot, right? Perhaps it
> makes sense to document the reason somewhere.

Yes; we want to avoid the dynamic allocations that stackdepot does.

[...]

Thanks,
-- Marco
