Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9549303ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392025AbhAZKzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAZDT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 22:19:26 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EF5C061786;
        Mon, 25 Jan 2021 19:18:46 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id e15so11336791qte.9;
        Mon, 25 Jan 2021 19:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R4zTw/KUHkZ7GxgA8tgI3QkL2W/1ErlRdJf6EwwBHlw=;
        b=QrCD5aZ73FhtIsV9YLOgpLpSHAbH8b6Px7otIvUV4e+WT+YaAHKlrLaSxKAHG+m3KZ
         wyGBJ4MMpNhrk8OIWuFTseECmuR1U3n+bgf0VseGWd803U3tMCm9LQufZdKo5NLxmgLP
         XiB3xpJGu+R0mJaGyE2sIUz1m+06kyyG4Mf2XqK7F7x405hK+zy7hYlmp3dVgsGVOjfh
         xwffkNMtQgrUsyOo9Yh9NN18kxinFul1APkjgfb1RJBkWzZb4hj6hjZfuuNeZHZo5ZPz
         jBhDy2LMZLidDUMpOY9F19BzgNz8sPkxaEP+WufNMkxSekSz6GLjTN+9przJgDqn7L6/
         a9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R4zTw/KUHkZ7GxgA8tgI3QkL2W/1ErlRdJf6EwwBHlw=;
        b=I7lpwPukQ+rd6pMhRZrq5uVRsP7XKXEm8Ijr859Sy8wypGuM8G+msb4/FUtrTAjaQ7
         AqpDrTLHxvJkKeNl6cPpEPdJMikTwwp2b5HUtOx2LG57hp+gOAanQZIEayZn/63q3vYo
         MjKJ3SSPqFJnNa1EgJsVA9Biyly8uk9F5R/GHVOFXo/V7my2/zTozF1j0LdDqaWyNmol
         z/U9EYVwzmCHz578dMTOdEHZkTtHTlUezFQvkbckmGL3lKl7Lm2XVaItMtoF3r6P6VBz
         uUaXUjoK6waMOuidyRGaDpn+5wasuywpcGmGhERiW+azQykBmge3MWis76tKxmAZOGWy
         JQkQ==
X-Gm-Message-State: AOAM533EXHAZveDtSLhE6q7cAue1B1c1yBAj2fQx7d1xeHOK+gxkRVmn
        HdcA0XuY64iYQWFBgATUvK4=
X-Google-Smtp-Source: ABdhPJzNtwCvwCwPmPm0z5mP3U59Mdd0j8MjrX4L1La8D/8b5ln2vc80HZfBkNBxnOcntbyOen9m2Q==
X-Received: by 2002:aed:2183:: with SMTP id l3mr3496136qtc.75.1611631125465;
        Mon, 25 Jan 2021 19:18:45 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id z5sm3348516qkc.61.2021.01.25.19.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 19:18:45 -0800 (PST)
Subject: Re: [PATCH V6 5/6] of: unittest: Create overlay_common.dtsi and
 testcases_common.dtsi
To:     David Gibson <david@gibson.dropbear.id.au>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>, devicetree@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
References: <cover.1611312122.git.viresh.kumar@linaro.org>
 <94180731aa4a17e4834458a979de7de782dc73d4.1611312122.git.viresh.kumar@linaro.org>
 <20210123030709.GI4400@yekko.fritz.box>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ff39a4ff-ee73-8f70-fddb-f869f5317c6a@gmail.com>
Date:   Mon, 25 Jan 2021 21:18:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210123030709.GI4400@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 9:07 PM, David Gibson wrote:
> On Fri, Jan 22, 2021 at 04:20:35PM +0530, Viresh Kumar wrote:
>> In order to build-test the same unit-test files using fdtoverlay tool,
>> move the device nodes from the existing overlay_base.dts and
>> testcases_common.dts files to .dtsi files. The .dts files now include
>> the new .dtsi files, resulting in exactly the same behavior as earlier.
>>
>> The .dtsi files can now be reused for compile time tests using
>> fdtoverlay (will be done in a later patch).
>>
>> This is required because the base files passed to fdtoverlay tool
>> shouldn't be overlays themselves (i.e. shouldn't have the /plugin/;
>> tag).
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/of/unittest-data/overlay_base.dts     | 90 +-----------------
>>  drivers/of/unittest-data/overlay_common.dtsi  | 91 +++++++++++++++++++
>>  drivers/of/unittest-data/testcases.dts        | 17 +---
>>  .../of/unittest-data/testcases_common.dtsi    | 18 ++++
>>  4 files changed, 111 insertions(+), 105 deletions(-)
>>  create mode 100644 drivers/of/unittest-data/overlay_common.dtsi
>>  create mode 100644 drivers/of/unittest-data/testcases_common.dtsi
>>
>> diff --git a/drivers/of/unittest-data/overlay_base.dts b/drivers/of/unittest-data/overlay_base.dts
>> index 99ab9d12d00b..ab9014589c5d 100644
>> --- a/drivers/of/unittest-data/overlay_base.dts
>> +++ b/drivers/of/unittest-data/overlay_base.dts
>> @@ -2,92 +2,4 @@
>>  /dts-v1/;
>>  /plugin/;
> 
> This still makes no sense to me.  Is this data intended as a base
> tree, or as an overlay?  If it's an overlay, what are the constraints
> on the base tree it's supposed to apply to.

I have already replied several times that this should not make sense to
anyone unless they read unittest.c and see in detail how these FDTs are
abused.  I have stated several times that the usage is bizarre and not
normal.

> 
> This patch is treating it as both in different places, but that's such
> a bizarre usecase it needs detailed justification.  It really looks
> like the unittest stuff is doing some very bogus stuff that should be
> fixed first, before trying to do this on top.
> 

The unittest stuff is bizarre, but it is correct.  This patch series does
not alter the current usage.

-Frank
