Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DB52F24AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404921AbhALAZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404152AbhAKXkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:40:06 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91239C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:39:25 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id x13so467085oic.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KjG1Sy5DGIGMhaJWoDMhvyzUwCtltJcn/E7syhXfhCM=;
        b=HNLYTJUcmlKkb2Ns7tpPcNwwDs3CLb9mqKcOz5UkGyNih9/e/C/3xmGTqmVwOKiLXK
         JyYkpJjTsGYRDwqEtID18PMjJdjkJx+p5Dl506iaGiCxlYUQ9lpPiOHwE5pJrvTQB7d9
         v3kdsdTxbNhUiM+XybztZWr9WXpD5jyiKYHXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KjG1Sy5DGIGMhaJWoDMhvyzUwCtltJcn/E7syhXfhCM=;
        b=gK3lsf0f7rXrNTh0vmy5c3cMy78YesUnciL3QIUCA98ZoSRbTNb5hChYEdPfCdBR1T
         57Pr4pjIgY7MK115MC5kts6i51kUjra4gbPdY8GDonTnKl0JgxD9aKnJHWn2Cl/xyYoc
         J+XG7qXkJpupla2JuZVVxMnkuXrsPG2smSe2RkZwCTolv1HK6a54Re3kV0ybTciWLqQf
         RRlf/6IiP8dtGuz/ZleZuktskePH9t1VI2TKfElQDojZmxBd7AUKV5nAp5e79xphGwao
         3pS9KkF10Bq3xw9JZxGw88HDmhllNh6f73yEMYvEhaYMZ8mIEXdYkqfE16EIcMUXAo+U
         acLw==
X-Gm-Message-State: AOAM530Rl1/1HeKDEBVQ/ZmlXtPLkDlMv2tXLaPtG10h5LetkFFuzmZz
        GUMt4zSoyxCsrLJwRXCw4Br9KQ==
X-Google-Smtp-Source: ABdhPJxmNHjEFmInwgM3YqTtEJDLh+XfwXSBHB7wY+IQCEbAKVKgEVg8U3AFIkpF53WCWO3EzoWzig==
X-Received: by 2002:a05:6808:b18:: with SMTP id s24mr753506oij.72.1610408365057;
        Mon, 11 Jan 2021 15:39:25 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s66sm226762ooa.37.2021.01.11.15.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 15:39:24 -0800 (PST)
Subject: Re: [PATCH 4.19 00/77] 4.19.167-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210111130036.414620026@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3086d659-61bb-b40b-a8cb-dc5433462025@linuxfoundation.org>
Date:   Mon, 11 Jan 2021 16:39:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210111130036.414620026@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 6:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.167 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Jan 2021 13:00:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.167-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

