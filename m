Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD6283C2B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgJEQOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgJEQOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:14:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A90C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 09:14:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a4so3400983lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9E85LeUC9fzbhN9VYe9QKN0L+FRAAc0JnAQy3SaRq1U=;
        b=h5hIFeEWqehMLSP98uk9ISfHhL6GdIc+qwL/W4YrngM/qqApbLJdUNkf4sYgqGifdK
         PxUc8fKIGJsB8YchL+lwB1IX+VXMczTYCjzbQBJNG14Kateh/hnmF7+ZxxSt26+McNe5
         Gx0FpCcxJknySjfQZHZPyeTCnSRvXsum8wZcQP1/rqgkXIcYEcXKBTNZQDSFkiAUElHx
         Bb04ZpP9MchbsaUYXuvzoa8AHRvjYfJ1pC6s9PIpK4gmWYNxhEJgYgQOWhmskj/QoFUm
         OFMu730wmF8ZeCiOkorKnKMF6zFSOfIHMeILWLb+UCE6l7472wV7sEQDG7UuPrYpn7YK
         EZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9E85LeUC9fzbhN9VYe9QKN0L+FRAAc0JnAQy3SaRq1U=;
        b=JPJUyxNWt5uHUDfXWzRFvtp75PYUQIxfXFfUJ28BGB18IbzQfd0sVC37tnJ0Aq/Khc
         eEKErvarq7w6HHLCKjkbe258hO77vczAQBF58o7OwfoWFu0zKbLB1gE/OT0FOQ33zR/q
         aa5lItyEDCQ9Do2D+PDqm1RYnKPuSgiL7on8oR3/4bp1sG70FrR/mPHnP++dG7RbwMQy
         1vvVTybQYeRfpny2Aj5apgOZPwBS1m1DrEnBpHrK6EiDLp34fkNB58LGVfef0sNXEvwb
         5vAOGbaafFlIfdqczgDbXEJFsuuv782z4qTA7rb/S0EtHQLXZHbggChDh/qcmhixZSGY
         2cXQ==
X-Gm-Message-State: AOAM532iTknIHrMn0BZ5bArbJZTSZIwqYahbrVheOLC6oyyY7u+IauDZ
        JIXf19nc6JzcubYxc9TdfMQ/Mr5vl2s=
X-Google-Smtp-Source: ABdhPJyQ/Ie38THkxAFBH0y63mBvh945vThW0vHMrA0RDa4g+2lYSOXp0Up8ocabS9Thu09krQ84lg==
X-Received: by 2002:a2e:8904:: with SMTP id d4mr173008lji.322.1601914457962;
        Mon, 05 Oct 2020 09:14:17 -0700 (PDT)
Received: from [192.168.1.97] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id a25sm50731lfi.267.2020.10.05.09.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 09:14:16 -0700 (PDT)
Subject: Re: [PATCH] mm: optionally disable brk()
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201002171921.3053-1-toiwoton@gmail.com>
 <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
 <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
 <20201005061248.GN4555@dhcp22.suse.cz>
 <7d7b1ac5-d6a7-5e43-8fb8-12b844d7f501@gmail.com>
 <20201005081210.2231e552@lwn.net>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <f0947a6e-8110-99bb-4fb3-f730aaaa4b72@gmail.com>
Date:   Mon, 5 Oct 2020 19:14:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005081210.2231e552@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.10.2020 17.12, Jonathan Corbet wrote:
> On Mon, 5 Oct 2020 11:11:35 +0300
> Topi Miettinen <toiwoton@gmail.com> wrote:
> 
>> The point is not to shrink the kernel (it will shrink by one small
>> function) or get rid of complexity. The point is to disable an inferior
>> interface. Memory returned by mmap() is at a random location but with
>> brk() it is located near the data segment, so the address is more easily
>> predictable.
> 
> So if your true objective is to get glibc to allocate memory differently,
> perhaps the right thing to do is to patch glibc?

Of course:
https://sourceware.org/pipermail/libc-alpha/2020-October/118319.html

But since glibc is pretty much the only user of brk(), it also makes 
sense to disable it in the kernel if nothing uses it anymore.

-Topi
