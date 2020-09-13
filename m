Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF75A267E22
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 08:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgIMGPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 02:15:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38043 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgIMGPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 02:15:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id y11so10033430lfl.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 23:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VIVA2HaGuHbJZKovmrROTl+HQozHCTJ5N0cUfUx1nfg=;
        b=h29vPg4WWfxo7WY35kNEGgue5GbOUCKEnUUTRqv5Fih2TlBETjSP8QroYIzGmG07VG
         bC1mdpsGVIYBcbe+CUDPAJCiF7MAiX4cBJTNfp7RK2ciGZCivwkRdlfppyHeS5isUV8q
         6EiE2rz0w1D9vEusk3JK4iDgqofBCoAIJIYmwoL2xBa9bTFqiL9yQvZC+I3+ULxGcJ0F
         Ejbtf86pPPaExfGSnWegR9RL1tlxlKXfX23B4x0adbVsYbNtnF4MpsokdBiFIvTqDPOd
         smvqHrlA6k/fNWqaAem0IiezJTMCQTgNr3GzBhp0n+/TNQ9/S0MXwr8hdo6NhoXn5Qvs
         LDpw==
X-Gm-Message-State: AOAM531ZYiKg7ju/nn+Bn2DGVnG/3YCY7ykFtqbgWyTapE0Jov2jw5S5
        bTzzJo5cq9+KGCZtSztcwtw=
X-Google-Smtp-Source: ABdhPJwjH7ptCUkCoTy2pV6UjoybHb3zAonsb7RgEuRKBhZkx+nQpSW3dH2K2ViPBYuAB1LpHhpf9Q==
X-Received: by 2002:a19:754:: with SMTP id 81mr2416069lfh.272.1599977706439;
        Sat, 12 Sep 2020 23:15:06 -0700 (PDT)
Received: from [192.168.1.184] ([213.87.159.180])
        by smtp.gmail.com with ESMTPSA id x5sm1939351lff.280.2020.09.12.23.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2020 23:15:05 -0700 (PDT)
Subject: Re: [PATCH v2] coccinelle: misc: add flexible_array.cocci script
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
References: <20200806220342.25426-1-efremov@linux.com>
 <20200809212655.58457-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2009121642070.2362@hadrien>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <c717ff19-73c3-2369-7b61-318b0a9662ab@linux.com>
Date:   Sun, 13 Sep 2020 09:15:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2009121642070.2362@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/12/20 5:43 PM, Julia Lawall wrote:
> 
> 
> On Mon, 10 Aug 2020, Denis Efremov wrote:
> 
>> Commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and one-element
>> arrays") marks one-element and zero-length arrays as deprecated. Kernel
>> code should always use "flexible array members" instead.
>>
>> The script warns about one-element and zero-length arrays in structs.
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
>> ---
>> Changes in v2:
>>  - all uapi headers are now filtered-out. Unfortunately, coccinelle
>>    doesn't provide structure names in Location.current_element.
>>    For structures the field is always "something_else". Thus, there is
>>    no easy way to create a list of existing structures in uapi headers
>>    and suppress the warning only for them, but not for the newly added
>>    uapi structures.
>>  - The pattern doesn't require 2+ fields in a structure/union anymore.
>>    Now it also checks single field structures/unions.
>>  - The pattern simplified and now uses disjuction in array elements
>>    (Thanks, Markus)
>>  - Unions are removed from patch mode
>>  - one-element arrays are removed from patch mode. Correct patch may
>>    involve turning the array to a simple field instead of a flexible
>>    array.
>>
>> On the current master branch, the rule generates:
>>  - context: https://gist.github.com/evdenis/e2b4323491f9eff35376372df07f723c
>>  - patch: https://gist.github.com/evdenis/46081da9d68ecefd07edc3769cebcf32
>>
>>  scripts/coccinelle/misc/flexible_array.cocci | 88 ++++++++++++++++++++
>>  1 file changed, 88 insertions(+)
>>  create mode 100644 scripts/coccinelle/misc/flexible_array.cocci
>>
>> diff --git a/scripts/coccinelle/misc/flexible_array.cocci b/scripts/coccinelle/misc/flexible_array.cocci
>> new file mode 100644
>> index 000000000000..bf6dcda1783e
>> --- /dev/null
>> +++ b/scripts/coccinelle/misc/flexible_array.cocci
>> @@ -0,0 +1,88 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +///
>> +/// Zero-length and one-element arrays are deprecated, see
>> +/// Documentation/process/deprecated.rst
>> +/// Flexible-array members should be used instead.
>> +///
>> +//
>> +// Confidence: High
>> +// Copyright: (C) 2020 Denis Efremov ISPRAS.
>> +// Comments:
>> +// Options: --no-includes --include-headers
>> +
>> +virtual context
>> +virtual report
>> +virtual org
>> +virtual patch
>> +
>> +@initialize:python@
>> +@@
>> +def relevant(positions):
>> +    for p in positions:
>> +        if "uapi" in p.file:
>> +             return False
>> +    return True
>> +
>> +@r depends on !patch@
>> +identifier name, array;
>> +type T;
>> +position p : script:python() { relevant(p) };
>> +@@
>> +
>> +(
>> +  struct name {
>> +    ...
>> +*   T array@p[\(0\|1\)];
>> +  };
>> +|
>> +  struct {
>> +    ...
>> +*   T array@p[\(0\|1\)];
>> +  };
>> +|
>> +  union name {
>> +    ...
>> +*   T array@p[\(0\|1\)];
>> +  };
>> +|
>> +  union {
>> +    ...
>> +*   T array@p[\(0\|1\)];
>> +  };
>> +)
>> +
>> +@depends on patch exists@
> 
> exists is not necessary here.  There are not multiple control-flow paths
> through a structure declaration.
> 
>> +identifier name, array;
>> +type T;
>> +position p : script:python() { relevant(p) };
>> +@@
>> +
>> +(
>> +  struct name {
>> +    ...
>> +    T array@p[
>> +-       0
>> +    ];
>> +  };
>> +|
>> +  struct {
>> +    ...
>> +    T array@p[
>> +-       0
>> +    ];
>> +  };
>> +)
>> +
>> +@script: python depends on report@
>> +p << r.p;
>> +@@
>> +
>> +msg = "WARNING: use flexible-array member instead"
>> +coccilib.report.print_report(p[0], msg)
>> +
>> +@script: python depends on org@
>> +p << r.p;
>> +@@
>> +
>> +msg = "WARNING: use flexible-array member instead"
>> +coccilib.org.print_todo(p, msg)
> 
> This should be coccilib.org.print_todo(p[0], msg)
> 


Thanks, I will send v3 with fixes and proper links to online documentation.

Regards,
Denis
