Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221E824C8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 02:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgHTX74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 19:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgHTX7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:59:52 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2169EC061357
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:51:17 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id a24so98929oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bWH45KSsjMDtcB36FJCwfAf8uMmznGsZVuQtNo0KJIE=;
        b=FJhaosUCodFEAJRj3zyKrxXgw2KLeOB71sGFq8MfhnXDSf8Bqgv5tiOEVsVRbdaWtm
         sBtxKlzlUFEfaXZ2k4E8RqXrG4xu21TF6H5bOjCVZKU08xOy07giksduSxkQ9wNaOoEN
         g27quDxW1zmdIxE5kcnTuOinwv1GutFAb+Lfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bWH45KSsjMDtcB36FJCwfAf8uMmznGsZVuQtNo0KJIE=;
        b=k1IoNBs/37hwajjh6wVvE1NF49xvfb1+3OyMgli5sCykRqZB7pEvsbEJ6qTNKhPyfF
         xmpKW/4rQluEZS9+dmPCz+Xge7SWluYXdJ9p3JI061v6PvbxY2D58pzG+btVQbH1IQYw
         LOkniWu+F2YAaQtXIqjWGH1GopTS6ItySi0omyl3AE7ZwgeA/60gr+OBiELZOwpX+mED
         0VlhVtMPF+xrtZ8FIYge+zeiZvIv99LgGsduqsPrpZtbBNun23fFbMEJZ5SQSJzTZzbH
         HHgg+4kc19Cj5IAJ4nJOHHfEcx6mEbVwzIHpOQ1tAAEaSZKYWhKDLcnsxzokcX/j5l7M
         gWag==
X-Gm-Message-State: AOAM531DrepM0I6z+OqkxK4F9Rx2WPncqGeqREIUnJp4JlpMIX5FnYCk
        1GGNFtUohCaMwd3kL4LaICkUhg==
X-Google-Smtp-Source: ABdhPJwGsqbYR42hZnuQpFyt9MFGKV1Ti4RcBLS4mOzHG5sgOkbEdSNJY/JGxUJ0lAVPZLAEyJJSXw==
X-Received: by 2002:a05:6808:8e5:: with SMTP id d5mr265149oic.64.1597967476593;
        Thu, 20 Aug 2020 16:51:16 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o22sm31838ota.49.2020.08.20.16.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 16:51:15 -0700 (PDT)
Subject: Re: [PATCH 4.4 000/149] 4.4.233-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <70ff8ddf-810c-6636-2ab8-fd15027f7140@linuxfoundation.org>
Date:   Thu, 20 Aug 2020 17:51:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 3:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.233 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2020 09:21:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.233-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
>

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

