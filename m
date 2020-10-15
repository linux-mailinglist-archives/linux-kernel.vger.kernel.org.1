Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1B28E9E0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbgJOBUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387988AbgJOBTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:19:37 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422E7C045704
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:11:42 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so2259925ioo.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hO+73zRBZmvlFSARPmbkCtTnkzNzcyrT9mGUQL2+wZw=;
        b=Qi9JlIuyAS7n/TRBZaH7U0b9vx5y5FwN/2TndbJHpKQgnRvdTbIk91myLinuVDCaP+
         he82mNXj0cbti6XAnsOSZLSIgeS4qImjQoBVOk0LzXIHfnoAJMS6D9jJr6j9Mu3oFVEg
         jm6+aNgJ5V5ONy3X0Y1unCPIUl/qMvjuLxkew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hO+73zRBZmvlFSARPmbkCtTnkzNzcyrT9mGUQL2+wZw=;
        b=LKSjWuxs4Cr/EYdKAyU084lMW68bZ1iiTjShZFeoz4bhRGCYDFXOr3U5NMZCspwdWc
         xRzSfnjKjlYcTGxgH41PSWgo/3P+KS8/yDz661o5mwyXbHgLoCq4uOHlC2HlaBfgUWfM
         rKIEETDfWrcLQUk2or43N0ZRlWHwRJdWfBOmIz0n9njNpInYUQII2hfl+r9xp01EuZKY
         StU79j03a0/WgTVtRaa/J2wEe5d3e+YCWN0p2lS83O4hmFc2CRWcLe2g774yc4bBnDZ0
         SNQ82RMbSTxsU5r5n3n+pj34WKppoK1MNuTqFsiQR87vbPeWM43tx93+y5K5FJMtfWo/
         OyCA==
X-Gm-Message-State: AOAM5315cIEDm8VoLekYzEq+6UB/FZfNdr2uiYDeIbgdA1QBu3bNVD4B
        2dUb+e3oTLp6Vjjn78QqU3jkGyKahD+N/w==
X-Google-Smtp-Source: ABdhPJyhzVxTDlqeIgiBEOFmsb9fVKDYEWV0nyEnlhjiG03jZya2innIvESvcTeH9HRjNocy6nYEiA==
X-Received: by 2002:a6b:6610:: with SMTP id a16mr1551613ioc.108.1602724301489;
        Wed, 14 Oct 2020 18:11:41 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x13sm1236908iob.8.2020.10.14.18.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 18:11:40 -0700 (PDT)
Subject: Re: [PATCH v3 01/11] counters: Introduce counter_atomic* counters
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
 <baede266cc0c69da61142b467ff386c6b31a70b7.1602209970.git.skhan@linuxfoundation.org>
 <20201013132709.5740cd35@coco.lan>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <09bd23cc-56fe-3d88-4e73-31151bf76cc5@linuxfoundation.org>
Date:   Wed, 14 Oct 2020 19:11:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013132709.5740cd35@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/20 5:27 AM, Mauro Carvalho Chehab wrote:
> Em Fri,  9 Oct 2020 09:55:56 -0600
> Shuah Khan <skhan@linuxfoundation.org> escreveu:
> 
>> Introduce Simple atomic counters.
>>
>> There are a number of atomic_t usages in the kernel where atomic_t api
>> is used strictly for counting and not for managing object lifetime. In
>> some cases, atomic_t might not even be needed.
>>
>> The purpose of these counters is to clearly differentiate atomic_t
>> counters from atomic_t usages that guard object lifetimes, hence prone
>> to overflow and underflow errors. It allows tools that scan for underflow
>> and overflow on atomic_t usages to detect overflow and underflows to scan
>> just the cases that are prone to errors.
>>
>> Simple atomic counters api provides interfaces for simple atomic counters
>> that just count, and don't guard resource lifetimes. The interfaces are
>> built on top of atomic_t api, providing a smaller subset of atomic_t
>> interfaces necessary to support simple counters.
>>
>> Counter wraps around to INT_MIN when it overflows and should not be used
>> to guard resource lifetimes, device usage and open counts that control
>> state changes, and pm states. Overflowing to INT_MIN is consistent with
>> the atomic_t api, which it is built on top of.
>>
>> Using counter_atomic* to guard lifetimes could lead to use-after free
>> when it overflows and undefined behavior when used to manage state
>> changes and device usage/open states.
>>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Did you try building this with htmldocs? It produces 3 new warnings
> due to wrong usage of the "ref" tag:
> 
> 	.../Documentation/core-api/counters.rst:46: WARNING: undefined label: test counters module (if the link has no caption the label must precede a section header)
> 	.../Documentation/core-api/counters.rst:49: WARNING: undefined label: selftest for counters (if the link has no caption the label must precede a section header)
> 	.../Documentation/core-api/counters.rst:62: WARNING: undefined label: atomic_ops (if the link has no caption the label must precede a section header)
> 

I added the document to patch 1/11 and the referenced file gets added
in 2/11. Poor planning on my part.

I will fix it.

> (plus another one that I'll be sending a fixup patch anytime soon)
> 

Thanks for the fix.

> Are those referring to some documents that don't exist yet uptream?
> Or are you trying to force Sphinx to generate a cross-reference for
> a C file at the tree? If it is the latter, then this won't work,
> as it will only generate cross-references for files that are placed
> inside the documentation output dir (Documentation/output, by default).
> 

Th first two aren't in upstream. atomic_ops exists - I will double check
the link.

thanks,
-- Shuah
