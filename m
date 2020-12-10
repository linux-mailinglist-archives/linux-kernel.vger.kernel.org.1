Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424A82D69AB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394005AbgLJVXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 16:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390134AbgLJVXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:23:02 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7DBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:22:22 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id q1so6759401ilt.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+I9vIixYSp7G9odythIxvF/+NYvkHgUFd3haAtFCe9I=;
        b=V0OuV9ojpvrpmYJf2e248jYUWvmoYrRRCxwMVutVYbTdp9GluFdGWW49ZzQvYRnQNX
         Y6kXK8bn/O4Z1cLNXFNpjADUcGuaIgYvcoojkmSPCo7slxCpX0hMCSkibjioJrFMbgWQ
         +NviTOue5IQPkx00rQNOnCyRQ/S8K51GMQha0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+I9vIixYSp7G9odythIxvF/+NYvkHgUFd3haAtFCe9I=;
        b=n0ZXw5VcQcylewSE1PZd7jRkztHDc94afVbhkH81XkMml/5PZ/VhXIjIl/lZCnuBjT
         1P5e3T6IthlYtWlpiebiTth251lU0oKKRbBlD8sgI1WuUzh42uCl1mZl4zNip3AmuE5W
         KnvQtasOvbD6eRn85pWOiouW4t++ZkhcwEWVMfk7uzC5jn5DdKNPTot/v+6uS9jlPQKa
         g5qqbtRE+5gIfi7BQRP1NO0CbCCas24FJW6U8RSLgrJ7AKoAfjQ/7yLbgcoUcgsmyZ1p
         7eBTOMFRIIkfZk8h/beq+zV4DHOS4bYVcionXQbpkB0UuuHK2BCtgVW7Og1fhKpzWXfu
         eLtQ==
X-Gm-Message-State: AOAM531A6eaxtpCMllz7ycWKn6GRThjbBgFCDNpqZR5fxYF2JHkL7BPk
        biPq6gjI9f23jb3uPG3xws3fnw==
X-Google-Smtp-Source: ABdhPJxhKjZeu4jV1KBpNbRzlMtbJ0bV4pXOlcUX9W6aQ8QYeWViKdWOcfJXoc0tbuiG9kplM8kiqQ==
X-Received: by 2002:a92:9a42:: with SMTP id t63mr11316412ili.176.1607635341519;
        Thu, 10 Dec 2020 13:22:21 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v22sm4060849ila.84.2020.12.10.13.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 13:22:21 -0800 (PST)
Subject: Re: [PATCH 5.4 00/54] 5.4.83-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201210164728.074574869@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8844e067-57c9-fbef-d986-890645bd5eac@linuxfoundation.org>
Date:   Thu, 10 Dec 2020 14:22:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201210164728.074574869@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/20 9:47 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.83 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 12 Dec 2020 16:47:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.83-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
