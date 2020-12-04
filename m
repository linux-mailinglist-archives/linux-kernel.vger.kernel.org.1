Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C632CE96F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgLDIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:21:24 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46841 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgLDIVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:21:23 -0500
Received: by mail-ej1-f67.google.com with SMTP id bo9so7370728ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lwG0ftBGc9YT4BkPML1c/FgdULEvijbRA+KoosqZ3xk=;
        b=XO+a5RC8FGOG53Gn87rT5LVkiGznUOtouN5scN+X2jDfZlll/WJ7AujMz8kxdR2ikA
         KPLbcWtB/AvUxz9KjdV6j8at07IledSTpk2Rlj1qa/vuEtHE2T4fFoRwu6/TIYJfFZNf
         Ur4oybGvs+zLV8DI7ydGt1qMIhMaZB7r8zhfmiUf34h93nK4fCOQ9n+Fu78K11V/o+ti
         ryxOWt/ujwdyYHOnAceDuS7lGV5MAFTKc7tce6UT6EQyoD/Z8V+wlUIvw+Z2XyMVU3Me
         mCSStWLfuBjohPPCvJ4VOtm6uwQeCmZW+bCtR3N10Tk+JKp1Gd+YCPmW399ufBcPxW/d
         eiBw==
X-Gm-Message-State: AOAM530p2G1k/fuRtH5TGrB5qfaf1uwMTcikBNx68twRMDuO15NGCayo
        vcOCggMAv/jwTUCW2IGkj4X/0R/pvqktWA==
X-Google-Smtp-Source: ABdhPJyUgiy354TEWYzopkg3ERps8mI5I4iUyXSKtR38hU6h9b+IUPNwGvkgjYZ+uHmFcoQR7WA8Ig==
X-Received: by 2002:a17:906:6987:: with SMTP id i7mr6058949ejr.18.1607070041455;
        Fri, 04 Dec 2020 00:20:41 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id h16sm2601812eji.110.2020.12.04.00.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 00:20:40 -0800 (PST)
Subject: Re: [PATCH] tty: Remove dead termiox code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
References: <20201203020331.2394754-1-jannh@google.com>
 <5cca5126-60ba-d123-0f7d-47fdbac4c4db@kernel.org>
 <X8nwnXQKOYWBWBZ+@kroah.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <93834a92-b342-aaee-c400-2883d5df0cdc@kernel.org>
Date:   Fri, 4 Dec 2020 09:20:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X8nwnXQKOYWBWBZ+@kroah.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 12. 20, 9:17, Greg Kroah-Hartman wrote:
> On Fri, Dec 04, 2020 at 08:22:41AM +0100, Jiri Slaby wrote:
>> On 03. 12. 20, 3:03, Jann Horn wrote:
>>> set_termiox() and the TCGETX handler bail out with -EINVAL immediately
>>> if ->termiox is NULL, but there are no code paths that can set
>>> ->termiox to a non-NULL pointer; and no such code paths seem to have
>>> existed since the termiox mechanism was introduced back in
>>> commit 1d65b4a088de ("tty: Add termiox") in v2.6.28.
>>> Similarly, no driver actually implements .set_termiox; and it looks like
>>> no driver ever has.
>>
>> Nice!
>>
>>> Delete this dead code; but leave the definition of struct termiox in the
>>> UAPI headers intact.
>>
>> I am thinking -- can/should we mark the structure as deprecated so that
>> userspace stops using it eventually?
> 
> If it doesn't do anything, how can userspace even use it today?  :)

Well, right. I am in favor to remove it, BUT: what if someone tries that 
ioctl and bails out if EINVAL is returned. I mean: if they define a 
local var of that struct type and pass it to the ioctl, we would break 
the build by removing the struct completely. Even if the code didn't do 
anything useful, it still could be built. So is this very potential 
breakage OK?

thanks,
-- 
js
