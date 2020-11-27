Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB62C6BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgK0S7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbgK0S5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:57:49 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF29C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:57:43 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 64so6567260wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/aqzWfKAyZcFADuzDmYKakUb1PJhvmbjruHjYS0Occc=;
        b=ih8vraZG1vXAUFx2hRFOZ5rIXLALstaSd60XXbEPnNEObAiJpUoNcFNLws29clecY/
         6L2SgdyOSVIRG5ZIn/nHDAwEjwn2xE37bkPDpzoCPwXj108q4OukQ4lwjpxDI0y9v+ao
         1MJTLrDRE5zLzFRfPaPrt29PzXThuIAfFHfCywcCmPVg7IeFuu0XPIwArUXcHe5rk1NY
         mAYaW6ilg/ErRdbLbKvQuZOdrHeMUNfKh+q8NWwp71m3zyveas/5ijnzC3JI4lMgXz0J
         wkCl9r5027lWbRqKFQREty2dSE/SnHjy9kRbN/o9kqsW+5hOZ6uzAzHuTx6B8sLfUPh3
         rqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/aqzWfKAyZcFADuzDmYKakUb1PJhvmbjruHjYS0Occc=;
        b=pVnSqujhdJUDs6LbxN0XN9fmz/zYMnuFNveq4psinF2vdmLZTOYF+C5Li16tspWpXE
         mkw/S14WTPRUOGULZoI5qZzj0z8ijqclur/S/r0HxbC21cDj8mJNeAgI3jDp8sLd/eQG
         y6X7GMWQwxNTM7MvB+uE0ZOlQ3ULZf+8XEaCjzc+DV8l2HPSkm4IyvMX8XueVYIaCJ0r
         spj8sKVdDT/meI4k2vCHz2si60M1lB1rcfuuwUuiSawoUakpuyoN+9AL7gvrPeaelm3v
         JurhqZ2JrPkAu4+/O4TungWbXjrr/XjEuK0XmPKwDvObvOukK6Z8cHLzqLjuE7OfjN/I
         ejjw==
X-Gm-Message-State: AOAM530Yu9hxbCGoBdCO/E7vEbU4SUIqm6perz8/W66FQG3fJ2xnW0e8
        A0IyFLrQxkA/adXhZrp8qjFiYQ==
X-Google-Smtp-Source: ABdhPJx+duHZQPgeCnc5beDK7iVxL5nBamRt9QZ1E6W7obHe9ErS3aqVxolCuOOrGLrvs0CE36wddw==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr12679404wrb.132.1606503462658;
        Fri, 27 Nov 2020 10:57:42 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h4sm15769103wrq.3.2020.11.27.10.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 10:57:41 -0800 (PST)
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sudaraja@codeaurora.org, pratikp@codeaurora.org,
        lmark@codeaurora.org
References: <20201112184106.733-1-georgi.djakov@linaro.org>
 <20201112111436.c5deeadd3578877fc0b844a1@linux-foundation.org>
 <02f682e2-0e9b-76a8-04fa-487891e18bdf@suse.cz>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH] mm/page_owner: Record timestamp and pid
Message-ID: <3ef3d770-d74b-5588-6672-f092c1526461@linaro.org>
Date:   Fri, 27 Nov 2020 20:57:43 +0200
MIME-Version: 1.0
In-Reply-To: <02f682e2-0e9b-76a8-04fa-487891e18bdf@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil,

Thanks for the comment!

On 11/27/20 19:52, Vlastimil Babka wrote:
> On 11/12/20 8:14 PM, Andrew Morton wrote:
>> On Thu, 12 Nov 2020 20:41:06 +0200 Georgi Djakov <georgi.djakov@linaro.org> 
>> wrote:
>>
>>> From: Liam Mark <lmark@codeaurora.org>
>>>
>>> Collect the time for each allocation recorded in page owner so that
>>> allocation "surges" can be measured.
>>>
>>> Record the pid for each allocation recorded in page owner so that
>>> the source of allocation "surges" can be better identified.
>>
>> Please provide a description of why this is considered useful.  What
>> has it been used for, what problems has it been used to solve?
> 
> Worth noting that on x86_64 it doubles the size of struct page_owner
> from 16 bytes to 32, so it better be justified:

Well, that's true. But for debug options there is almost always some penalty.
The timestamp and pid information is very useful for me (and others, i believe)
when doing memory analysis. On a crash for example, we can get this information
from kdump (or RAM-dump) and look into it to catch memory allocation problems
more easily.

If you find the above argument not strong enough, how about a separate config 
option for this? Maybe something like CONFIG_PAGE_OWNER_EXTENDED, which could
be enabled in addition to CONFIG_PAGE_OWNER?

Thanks,
Georgi

> 
> struct page_owner {
>          short unsigned int         order;                /*     0     2 */
>          short int                  last_migrate_reason;  /*     2     2 */
>          gfp_t                      gfp_mask;             /*     4     4 */
>          depot_stack_handle_t       handle;               /*     8     4 */
>          depot_stack_handle_t       free_handle;          /*    12     4 */
>          u64                        ts_nsec;              /*    16     8 */
>          int                        pid;                  /*    24     4 */
> 
>          /* size: 32, cachelines: 1, members: 7 */
>          /* padding: 4 */
>          /* last cacheline: 32 bytes */
> };
> 
