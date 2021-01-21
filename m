Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067782FE1FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbhAUFqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbhAUFqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:46:06 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD964C061575;
        Wed, 20 Jan 2021 21:45:25 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id z22so791037qto.7;
        Wed, 20 Jan 2021 21:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YuenuPcIMSAFG1N1r41eV0meYVfjDDNayQuIYb1dHOA=;
        b=bGkystrN6DozAxdsd/ui49OciuzFQMMde0teysSzup/W2tswIvehRAcTqq1GQ9VCv5
         YzRYZICpTLHnVBuMdzH0Nr+LUZQU3R2pCa8htUSbXYNupwsLxXkwjBmytE4cIja+FU1n
         9xT0NYdU4juWrZT4RdcdiYI8624y4NIJSOfOivoBkD079imGXWiXxcw8iRHjgtN7kKx6
         T2iQil88BNyTD4vygvMlS4fM24SblRSZv5s0ssu+EIdyTsn0KU+Utamc5kmmFFdrelm4
         JZYSfZ9Ug8UzyH9xGcurs1kjh6btmv26Si4nD0k+rE++ZVAOmVGemizoD1CEuWiI02pV
         PCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YuenuPcIMSAFG1N1r41eV0meYVfjDDNayQuIYb1dHOA=;
        b=uRb2b5JbpOm0zWn1F243xrDn0GiO0mMFnHKU+tox8+/ysfdy+b8iHBxPbgl7D/2rz0
         od/EYMdv6jlkseexJd5XlGy7MNp6GhGw3+mqWqiKRzeDckefZKxh6vutPB3V6lYwooMf
         OnYZihyYNXAoLIK9Z9jEJsZTUkKqYMYu2DYXONLY9rrQCTY574GTmpP8C7WdpY0hWIiK
         Dc4tnTQ05qIzv57wUQSwCcDOXY7HEyAAtUcZDSEPxzFlfVPlkvJgY72w1X2TZtwCcHct
         fMMNsyyFe6JirXoBim5GcTKW/In4AJkB3U722Yso2KOoOsr8kT4N9jMqfWCLeoH5nE3x
         ZMcw==
X-Gm-Message-State: AOAM532vMzKw3wCNcySSxIvfJoGv/R8if59eD/qGSzaAsHdyeOGqHlwt
        sRmL5wV5O9JlBJv5ENZK1UABU4kgMsf2vA==
X-Google-Smtp-Source: ABdhPJzUJvZZVLZRw2gaUDP+9z9uGn7QdTJh6Fj+tI8FPAblytHtu46WIRXqYtnPMzLjgdU6u0a3Og==
X-Received: by 2002:ac8:7101:: with SMTP id z1mr12161237qto.210.1611207925194;
        Wed, 20 Jan 2021 21:45:25 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id v67sm3189649qkd.94.2021.01.20.21.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 21:45:24 -0800 (PST)
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
 <20210121053426.4dw5oqz7qb4y7hvm@vireshk-i7>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <1cbafa2a-fe9e-04ec-35cc-d675a781a5b6@gmail.com>
Date:   Wed, 20 Jan 2021 23:45:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121053426.4dw5oqz7qb4y7hvm@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 11:34 PM, Viresh Kumar wrote:
> On 20-01-21, 23:14, Frank Rowand wrote:
>> It is a convenient FDT to use because it provides the frame that the overlays
>> require to be applied.  It is fortunate that fdtoverlay does not reject the use
>> of an FDT with overlay metadata as the base blob.
> 
>> This is probably a good idea instead of depending on the leniency of fdtoverlay.
> 
> I believe fdtoverlay allows that intentionally, that would be required
> for the cases where we have a hierarchy of extension boards or
> overlays.
> 
> A platform can have a base dtb (with /plugin/;), then we can have an
> overlay (1) for an extension board (with /plugin/;) and then an
> overlay (2) for an extension board for the previous extension board.
> 
> In such a case overlay-(2) can't be applied directly to the base dtb
> as it may not find all the nodes it is trying to update. And so
> overlay-(2) needs to be applied to overlay-(1) and then the output of
> this can be applied to the base dtb.

I have only the most surface knowledge of fdtoverlay, mostly from
"fdtoverlay --help", but you can apply multiple overlays with a
single invocation of fdtoverlay.  My _assumption_ was that the
overlays would be applied in order, and after any given overlay
was applied, subsequent overlays could reference the previously
applied overlay.

Is my assumption incorrect?

> 
> This is very similar to what I tried with the intermediate.dtb
> earlier.
> 

