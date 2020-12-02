Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C1F2CCA2F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbgLBW7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 17:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbgLBW7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:59:50 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F83C061A48
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 14:59:10 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id b8so123610ila.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 14:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mseZ6HqpOaxIPoGJwt8mt2yChrOXFzD/3kFw06Juct4=;
        b=hfu1TJ5/FWuZCgIbvtJbzPxMZUMTTPpCYUSRixRQIbnINFXc+KpyD55xVuCveLb/td
         yej/IbMTjxZ/+aR2ZBJPoSU8Q8wtyCXRC+dBnJBZrqokm9Cqggv2UhGAdTaLRrKpLoCr
         MLWrXRhiiUthOFX06zAb50sRGusEmZ43pMd1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mseZ6HqpOaxIPoGJwt8mt2yChrOXFzD/3kFw06Juct4=;
        b=d6z1GCw0GtLoiwese05XOPhBNOG4xO4/hMvT+FuPKvHaD/NJ3GgtrOwvvYV4YfWMdb
         hax2MoPiwSDgF8yDPXZoLCUkNuf4/6upLVjmbn6tQ0V27g1TqfRuMPhKdSaj4jxuEmLX
         z3VuVV8apAjmyT4DT2Y5ibkWHp1l8khFU0J2MA9oqfYDKg6LqTQZaLKAD11DNW0rsaos
         UVgp2BXwfnfj5F8rIvMtLDood2hhuWXHWexgJJHdBEWFlYhfliVRgb/OVyJCHIZPXh6v
         LqVimqGAJ4lqwYjLMT3t8uk4huZ1xnIj6l6aJ5GdSyNGco3gGf9KytOr41ktu7ga+1xp
         as5A==
X-Gm-Message-State: AOAM533KdRM6Zw9DuaVfshgqdmCUkTDoXCXbG6bBxif6yO9RP+9k56dP
        cu6tZ+j7JnfwbkT/BEQwa/V9Jw==
X-Google-Smtp-Source: ABdhPJziJ8mfyelB2fg3kxZvhv+Eul+12x9D5wfaeHlaNRok6QkYABL8vvJerFHYvi2rxcNcHGQECQ==
X-Received: by 2002:a92:6410:: with SMTP id y16mr312945ilb.126.1606949949439;
        Wed, 02 Dec 2020 14:59:09 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n77sm98392iod.48.2020.12.02.14.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 14:59:08 -0800 (PST)
Subject: Re: [PATCH v9 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     brendanhiggins@google.com, elver@google.com, yzaikin@google.com,
        adilger.kernel@dilger.ca, Tim.Bird@sony.com, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201116054035.211498-1-98.arpi@gmail.com>
 <20201116054150.211562-1-98.arpi@gmail.com> <20201202160742.GB390058@mit.edu>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <161a322e-e7a0-1b2b-d321-4f2871c31e0a@linuxfoundation.org>
Date:   Wed, 2 Dec 2020 15:59:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202160742.GB390058@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/20 9:07 AM, Theodore Y. Ts'o wrote:
> On Mon, Nov 16, 2020 at 11:11:50AM +0530, Arpitha Raghunandan wrote:
>> Modify fs/ext4/inode-test.c to use the parameterized testing
>> feature of KUnit.
>>
>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
>> Signed-off-by: Marco Elver <elver@google.com>
> 
> Acked-by: Theodore Ts'o <tytso@mit.edu>
> 

Thanks Ted.

-- Shuah
