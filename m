Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AFA2FE21E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbhAUFz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbhAUFzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:55:50 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8493AC061757;
        Wed, 20 Jan 2021 21:55:10 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id e15so790836qte.9;
        Wed, 20 Jan 2021 21:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ECbad6edDTFAYBLU29SefD+NwZ0sYS+iJ0qpBYKvNIY=;
        b=f7cs0/Nq0T2XCEc7FlSvqB5csSoie8SaHrOuINYNTgUFAG3DmvSaT4nLE1sOc+NiAh
         uHs/gR/s8+DxnvhQLwJ1yETSohmfEvRx5QfZskfLSORlLiC7fy9LzqLY3fKYJ5kMsUNn
         yjlflavV3wYeiIWNW5UZOE8C4ob81JpNV59S4zPXJp0keyeYQWbowpeD6rkQ0o2/aR98
         ggkOQJroewzVIj8akOAHRgZcv7FzwbbrKfR7ReU+R1vYg4POzDLFKPditrl4MZigS7us
         7Sjl2zI1djAL6+eVX49EPNMSGEQwtjnaGwrBtCTNXt6UmPTKi6fz7WV06puXlwrdGFFZ
         QTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ECbad6edDTFAYBLU29SefD+NwZ0sYS+iJ0qpBYKvNIY=;
        b=Wje+YFtOD6qDi14zbbRkrKV9Wv1dUrDcJr63pf+RaQgLZij1zkqaXNDLnOSjEIb9v0
         7eIDRvYO3Y9rz4UnSBSG/jiTTuQaAlpTOUjzgBvyz0PexcoTe9fnD9xHCpx6X3lyanr8
         Z54q6UP1Fgl10trNrfNe7/qlcJMfaKwevmu9RwLF7pJU80U32Eo4Sth9sEJutwvutjfT
         IOgN94TZxVQ4a2NMe7QMP3uN/KhajUD2rT3DKR2z+2JSkXFE1ADk6jk530YyJKVFSh99
         uT+53CrOdiXY7Re/3KZr2eIsgcwFz0qdgCN5QSnjbKyGITdi45Pjn0ReoH01ZJ6DXrL1
         pTlQ==
X-Gm-Message-State: AOAM532R7hkNKNcp0rg0FR6X67DT4aXJroWFIPohOdBFix3+iVkAMN7I
        zq4ZQ1MQxnvygypEyvFDSFk=
X-Google-Smtp-Source: ABdhPJyf+M21Ndr5rPtxvMLCHSgA2RMiF0uL3Nf1Gl51nTsk7zX/ozgWa2R9mDzCNeGGGqXUMx3Plw==
X-Received: by 2002:ac8:6d0a:: with SMTP id o10mr11993157qtt.113.1611208509804;
        Wed, 20 Jan 2021 21:55:09 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id k73sm3136382qke.63.2021.01.20.21.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 21:55:09 -0800 (PST)
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
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <91dadafc-26e1-13c1-37a2-d05ebd7b151f@gmail.com>
Date:   Wed, 20 Jan 2021 23:55:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121054340.e4do45uvdns5bl5f@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 11:43 PM, Viresh Kumar wrote:
> Hi Frank,
> 
> On 20-01-21, 23:34, Frank Rowand wrote:
>> It should be possible to apply this same concept to copying overlay_base.dts
>> to overlay_base_base.dts, removing the "/plugin/;" from overlay_base_base.dts
>> and using an additional rule to use fdtoverlay to apply overlay.dtb on top
>> of overlay_base_base.dtb.
> 
> Are you suggesting to then merge this with testcases.dtb to get
> static_test.dtb

no

> or keep two output files (static_test.dtb from
> testcases.dtb + overlays and static_test2.dtb from overlay_base.dtb
> and overlay.dtb) ?

yes, but using the modified versions ("/plugin/;" removed) of
testcases.dtb and overlay_base.dtb.

> 
> Asking because as I mentioned earlier, overlay_base.dtb doesn't have
> __overlay__ property for its nodes and we can't apply that to
> testcases.dtb using fdtoverlay.

Correct.

I apologize in advance if I get confused in these threads or cause confusion.
I find myself going in circles and losing track of how things fit together as
I move through the various pieces of unittest.

-Frank

> 
>> Yes, overlay_base_base is a terrible name.  Just used to illustrate the point.
>>
>> I tried this by hand and am failing miserably.  But I am not using the proper
>> environment (just a quick hack to see if the method might work).  So I would
>> have to set things up properly to really test this.
>>
>> If this does work, it would remove my objections to you trying to transform
>> the existing unittest .dts test data files (because you would not have to
>> actually modify the existing .dts files).
> 

