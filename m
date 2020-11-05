Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1482A7A3C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbgKEJOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:14:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45450 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgKEJOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:14:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id q3so468323edr.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eCmKNeal20xT6UjXgXkAcyGLMhgH7uIcT6Gt8ZX0CZk=;
        b=tLjePb1eQZxX+9PoPON40JFKETbuxg6YrrcEXKgM6rLNSyuxNzWw6XVq6uivboL885
         BGT7cf0xBviT3saqgQ+Inhqd51CtfT+stKr0xmWfcaNkG3LeogypodGG4CO/79dgZjGC
         jWW/WiHbEbARGLUPVrKYnqEIOor31z88gHdbbrFhH8QRSDLcXObxYdW69ZyoCDdS6RY0
         Dpg8LYhWXsgRjeXpH/gx2kvoGECFLiYBt1Kdd58kR/e26YtSW27BOPYISklIBu/CEIfY
         pqf3L9lc9sc6nrUTB2zO6RoKxrzA4QuJOMa33aYMbynHbRlO6N+J5J5G4VTIRFFVLuBr
         V5tA==
X-Gm-Message-State: AOAM531YBoiYmx+BhKAtDsmyd1UCrvys/LNnvr1dnYCLwQcjHjOwm8pU
        7Fw7RO7oyQiM5Y9hcAE3QOg=
X-Google-Smtp-Source: ABdhPJwr5sm+Txb965wE1cE+dZSbpKLM67GHsYuAGCsME5UlD/rlSfipqsBP4EkZ2Ew2MPg9EPkYXA==
X-Received: by 2002:a05:6402:c8d:: with SMTP id cm13mr1492192edb.340.1604567645480;
        Thu, 05 Nov 2020 01:14:05 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id a17sm519231eda.45.2020.11.05.01.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 01:14:04 -0800 (PST)
Subject: Re: [PATCH 12/36] tty: tty_io: Fix some kernel-doc issues
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Holloway <alfie@dcs.warwick.ac.uk>,
        -- <julian@uhunix.uhcc.hawaii.edu>,
        Marko Kohtala <Marko.Kohtala@hut.fi>,
        Bill Hawes <whawes@star.net>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        Russell King <rmk@arm.linux.org.uk>,
        Andrew Morton <andrewm@uow.edu.eu>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-13-lee.jones@linaro.org>
 <715cfe26-18d3-a035-0cf8-958f1235b4f7@kernel.org>
 <20201105085315.GA4488@dell>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <adf8732b-fc01-715b-ac05-61c4c4882103@kernel.org>
Date:   Thu, 5 Nov 2020 10:14:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201105085315.GA4488@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 11. 20, 9:53, Lee Jones wrote:
>> For example, alloc_tty_struct is among the
>> ones, I would like to see fixed instead of removed from kernel-doc.
> 
> There is nothing stopping anyone from providing said descriptions and
> promoting it back up to kernel-doc.  If you have good reasons for it
> to be properly documented with kernel-doc, then it should also be
> referenced from /Documentation using the kernel-doc:: notation.
> 
> Also see: scripts/find-unused-docs.sh

Thanks for this. I must admit, I haven't managed to get familiar with 
this stuff yet.

-- 
js
suse labs
