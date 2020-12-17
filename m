Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A892DC9CA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 01:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgLQACg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 19:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbgLQACf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 19:02:35 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D64DC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 16:01:55 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id v3so24291898ilo.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 16:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+4x3NjyoFEeEOeWfvLPZlFIbPplM7FPrIZMjgt7U85M=;
        b=W6i/7MrhlZAUl9ZJV7zBSzFBWOxIYaE9sekPzAQgL+QIVAqkWcv52OcFEhi+cG3y39
         93On1MjSMVGxmyAXU6tdY43dEHbsNai6OnAbvLoErEgjS7ARDWy8odYrvrBQSA4aDxHs
         81xB2Ns7Cnba8ktHh/BMoJTzr6jOw0eIlN9rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+4x3NjyoFEeEOeWfvLPZlFIbPplM7FPrIZMjgt7U85M=;
        b=dctzCkjLluo3nQWeJBgeDcxLIxZW+49duqFQS3rspRftVqkqMllWq7JOr0e+ghw7OW
         dyHcHXFL1i9hwqV2HG5yXdD8bhbK0VmA10xKe3Tp/G/icPeeVwceUKZFnzmDV+VHUBBH
         VeqV4JdJx+y+Yy5AqnyyzTVtZK0t/dbz+Twq5fyvAypDiM4tJ1mXJffH3NmzKfJZWh/Z
         3oup+gy7e665M8qClzbo3H+r175D30Z1JeLI50OWK/gOAuu2iO4mkBL+mNjJfIt3mRj3
         H6bFfLx/DsMTrE6B1FIUK0UCK2YldFYAGQtIHlpFPshv/0XspkwRq+ZJ4IgJUbnCd30N
         ilgQ==
X-Gm-Message-State: AOAM5316SSCy9npLy3IhR9AvQrlLM0wrgxoP5EkVZBZqCP3gisB6X/1W
        2YqAfYyxryChLzAROSuK6H2zfw==
X-Google-Smtp-Source: ABdhPJwIgmNdGKhYr7/34SvD5dO4lSb2jRPrpUygupniNVmnNv0qlyAL/VwIqcyHFgXnEQlbA9Zyeg==
X-Received: by 2002:a92:9153:: with SMTP id t80mr10789891ild.216.1608163314583;
        Wed, 16 Dec 2020 16:01:54 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r8sm1943738ilb.75.2020.12.16.16.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 16:01:53 -0800 (PST)
Subject: Re: [PATCH v4] kcov, usbip: collect coverage from vhci_rx_loop
To:     Andrey Konovalov <andreyknvl@google.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <f8114050f8d65aa0bc801318b1db532d9f432447.1606175386.git.andreyknvl@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8ec4268d-7124-20dc-2a8e-175b5e64d06f@linuxfoundation.org>
Date:   Wed, 16 Dec 2020 17:01:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <f8114050f8d65aa0bc801318b1db532d9f432447.1606175386.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/20 4:50 PM, Andrey Konovalov wrote:
> From: Nazime Hande Harputluoglu <handeharputlu@google.com>
> 
> Add kcov_remote_start()/kcov_remote_stop() annotations to the
> vhci_rx_loop() function, which is responsible for parsing USB/IP packets
> coming into USB/IP client.
> 
> Since vhci_rx_loop() threads are spawned per vhci_hcd device instance, the
> common kcov handle is used for kcov_remote_start()/stop() annotations
> (see Documentation/dev-tools/kcov.rst for details). As the result kcov
> can now be used to collect coverage from vhci_rx_loop() threads.
> 
> Signed-off-by: Nazime Hande Harputluoglu <handeharputlu@google.com>
> Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
> 
> Changes in v4:
> - Add USB/IP specific wrappers around kcov functions to avoid having a lot
>    of ifdef CONFIG_KCOV in the USB/IP code.
> 

Looks good to me. Sorry for the delay on this. It just got lost in my Inbox.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

