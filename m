Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B152AC94C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbgKIXZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgKIXZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:25:28 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80098C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 15:25:28 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id p7so11682726ioo.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 15:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nf3mRDpyEOynOSmNGp9sYu8KqwIKtaQmGESkR2WUiRE=;
        b=Hi6lkIChZaDjrJw4FgFpQDFh9jMsJEwMdHIYtpLqg+iyx2pMI3LN2NzITiW0rtNxcd
         5wzLt+4NkB+Pfqtox0YpNTxL7QIxs17RBvH+V7DtW36MHKkBbTfguDc7Ju+yphSO7PED
         hkCXIrk8VB3V90pAsj5d2cGD8evm1LBmwz/XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nf3mRDpyEOynOSmNGp9sYu8KqwIKtaQmGESkR2WUiRE=;
        b=IlrbyB0tu2gbzRbZJXkrVF5ovIs+y78Lia9nJQOQLwlvLvaUEvr6FeCjjfS5/n2DFe
         M6fUHI7Gx/LvKxRG3QI9VsTb7zpvAKF+X7EBTDsGLvTm8lhTCGlLrNpIcZLpCG+Wojdm
         Qn3Knn9PrgkF6RVRX708v9un+pqMRV2Ozc+W19XzKHGReY0S8PdF67XPEE3XddBtWr+a
         jmPA5jNQeOe0lZ/k+9dvGVZngFJmisUKC6PD42wESSbPIJPut1aKptdmVeROR0ofIdtc
         bx8xme0LRcYmiYE2nOg6Z8phQoKSaU8+Etyp3HSBaPKXSvgFjBaZ/oKqKzgfJVf1pdUP
         4d4A==
X-Gm-Message-State: AOAM530wD7OHgXTTzk8Mc/ndDoFh0GEdPRXDXUohdfvVviNJ5Cpd8Vwx
        CtWzTrlA6DkCUdtbEEmhr08z0w==
X-Google-Smtp-Source: ABdhPJxYZ9ckOojCpTk3SNwXYUEQpEu1vKNfqph5fsDHTbvBDao+B8RVIDqGHLd+CboRCXlWuug6Ig==
X-Received: by 2002:a02:7112:: with SMTP id n18mr13057986jac.34.1604964327935;
        Mon, 09 Nov 2020 15:25:27 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t15sm6812887ili.64.2020.11.09.15.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 15:25:27 -0800 (PST)
Subject: Re: [PATCH 4.9 000/117] 4.9.242-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201109125025.630721781@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <97f42ec5-502c-33ee-5c46-eef1b90fc6cf@linuxfoundation.org>
Date:   Mon, 9 Nov 2020 16:25:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201109125025.630721781@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 5:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.242 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Nov 2020 12:50:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.242-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my new AMD Ryzen 7 4700G test system. No major
errors/warns to report. This is the baseline for this release.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
