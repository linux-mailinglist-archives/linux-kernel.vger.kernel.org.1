Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895702FE36B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbhAUHGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbhAUHF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:05:28 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE9EC061575;
        Wed, 20 Jan 2021 23:04:48 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 22so760079qkf.9;
        Wed, 20 Jan 2021 23:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oxDbQ/54fAhCExwIW5/YmM24WoovfXT68AQRbrcMvdo=;
        b=hgsgrltvJfV3ubxQtawLIjionKbBF6SAB2jmXQdwU85lqMtSSnMHfvr2LW2HsgW2RK
         ZRHjeB9nDMDdRlJIrEC66SJrUalmpncABUb/3UQOynFfeaXVxff7/5mYfk5peiyzYadX
         k44LJ11Jx5DN1V3XzYALB8aq3dueJhxfuga9I5bD+ZODSIoPT978Q1qyXyKc3MmhjDlM
         vOS7+b4xcH3fs2s9USLNlFtmYW7iraadsIHMSCp1Vc+eb6Rn75D5bEkQgwvrfJJvz00H
         N/9dJ84cRv3cVxH25gaD/KsG427YRQL6BkWnQzZK5e/cZJrkdeARKY/gSbZ68R89K6vd
         7lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oxDbQ/54fAhCExwIW5/YmM24WoovfXT68AQRbrcMvdo=;
        b=bbn4DEuyasQTB9gGBBX6K9oPM8/P8rhopdAdHUtEYrq2zO+BEkAQSmvcI+Xi9rHlJc
         Wh6RYy+ycYpVqIpjQ54qntIwAGlGYrs8weBIpm+l6bukYY+k2GXkC9lwf+odTTF1ZL7U
         Fws8jgrwrlUyS4eGFLM/Cz1aJvZalIYzRF/nUtAtv8TIt20ClS5ZxW/MzHOtkMKDWETY
         GHdSfykc4dW2IOLiGCv+Sj5FmdJNeIME61EGiXVIQaIR/R+PzEu8IfBNlYJCa8YRqz+v
         NoFyQ4FOgmV7ufRz1xfL+KaSwelt4hJn/m+a5F//nYAQ9lNkkdsZ1qNTTCqZRyy8hnp7
         9Mrw==
X-Gm-Message-State: AOAM531ZKAaFXWbBo3zgzvuW5s1ElDUXekNovgiClD6FWO6mDXz7QMBO
        phFldmIm0Xj2SvcRFyibAc0=
X-Google-Smtp-Source: ABdhPJwmzbcTWJDET4ZSWT2pwW2wl8sQj97YMaTddPBx9MPN1s0Jhs7rkrYCMkvXWH1mwUjv39eL7g==
X-Received: by 2002:a37:ba06:: with SMTP id k6mr13433855qkf.470.1611212687402;
        Wed, 20 Jan 2021 23:04:47 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id i41sm2997632qtc.33.2021.01.20.23.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 23:04:47 -0800 (PST)
Subject: Re: [PATCH V5 5/5] of: unittest: Statically apply overlays using
 fdtoverlay
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
 <20210121005145.GF5174@yekko.fritz.box>
 <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
 <a6b5e6ac-90ec-9571-4fce-de7344bfcee9@gmail.com>
 <20210121054340.e4do45uvdns5bl5f@vireshk-i7>
 <91dadafc-26e1-13c1-37a2-d05ebd7b151f@gmail.com>
 <20210121055820.e5z3uykfttvxffhe@vireshk-i7>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <3431c306-a62c-76c6-f236-fef35fa7ebc7@gmail.com>
Date:   Thu, 21 Jan 2021 01:04:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121055820.e5z3uykfttvxffhe@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 11:58 PM, Viresh Kumar wrote:
> On 20-01-21, 23:55, Frank Rowand wrote:
>> yes, but using the modified versions ("/plugin/;" removed) of
>> testcases.dtb and overlay_base.dtb.
> 
> Okay, that would work fine I guess. I will try to implement this in
> the new version.
> 
>> I apologize in advance if I get confused in these threads or cause confusion.
>> I find myself going in circles and losing track of how things fit together as
>> I move through the various pieces of unittest.
> 
> Me too :)
> 
> Today is the first time where we have some overlap in our work hours
> (probably you working late :)), and we are able to get this sorted out
> quickly enough.

Working quite late.  I swear I stopped working 3 hours ago and that was
already late.

I reacted quite negatively to the attempt to restructure the unittest
.dts file in the original patch.  Now after walking around the problem
space a bit, and reviewing the ugly things that unittest.c does, and
coming up with the approach of sed to copy and modify the two base
.dts files, I think I finally have my head wrapped around an easier
and cleaner approach than sed.

I'll describe it for just one of the two base files, but the same
concept would apply to the other.  Don't take my file names as
good suggestions, I am avoiding using the brain power to come up
with good names at the moment.

1) rename overlay_base.dts to overlay_base.dtsi

2) remove "/dtgs-v1/" and "/plugin/:" from overlay_base.dtsi

3) create a new overlay_base.dts:
   // SPDX-License-Identifier: GPL-2.0
   /dts-v1/;
   /plugin/;
   #include overlay_base_dtsi

4) create a new file overlay_base_static.dts:
   // SPDX-License-Identifier: GPL-2.0
   /dts-v1/;
   #include overlay_base_dtsi

5) then use overlay_base_static.dtb as the base blob for ftdoverlay
   applying overlay.dtb

Untested, hand typed, hopefully no typos.

-Frank

> 
> Thanks for your feedback Frank.
> 

