Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9642EB065
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbhAEQpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbhAEQpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:45:09 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4933C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 08:44:28 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id w18so28817977iot.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 08:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tJqOn+TnHD7GEt1ab93AXMEnw/3xo0O1fNmQ2j0lheI=;
        b=KtCY0ci1sis2/nTY/zGNHCF3FdiEt8ElmtUy0rqdJYGIphMEqfXvL0eHmT1YvH8Jf+
         DoZPI6JvYNOY84UXS+/Y+32Hb43uW6pVbiMMnyR8/8M1O5UqBNcfh1Dj01WM9pXqzUvo
         LPSmvS9iwpv8hY1K4ZD3Qqg4IByfd4URJPnTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tJqOn+TnHD7GEt1ab93AXMEnw/3xo0O1fNmQ2j0lheI=;
        b=YKxVej7AgJY5NPf9PcEEpzn2Ykx3afWQcF4YKUnXmTcOb0Q63MxmqeZ+p1qwxQwIQY
         34Zj+19plXIHzufVUQrAHyQqf2rDFgCljUvOsLk/x2op9C7AhmTyNYOF5Sm8mEu+4X8v
         hlKh7tUxhFJ6RF+5zfZcwTO8SBFXzihLkpbBVTjNNqpVokF+u5CTL6qx6KiOS6lOI7HI
         YAL68UtXSuFfPKWBhNTf5+jibe8oUzlIJ1I2glIeGqvAUEhNA/ANbEfJXrr+7dOLEm4n
         caxFYY00ElNjods0SdU7Pn+Fos0JbzmTcQtQcAGmDcKN/z4PfivQnsVQJMPliLFJ6w7C
         TcAg==
X-Gm-Message-State: AOAM5300fO9fdx3SGEIualFPZPgoq9Wo9Sjeo2F2p3OJ2PmMV36ZP5Sh
        oNX7xl41ynck/r1J3MdHx2rVGg==
X-Google-Smtp-Source: ABdhPJzF8mxEQ3d82KsQTgcFSxd2NLokPD6udZD/GbxXkEzb/7AYfGetY63k2Gv90FjUM9hr+BtRjQ==
X-Received: by 2002:a5e:dd0d:: with SMTP id t13mr30426iop.132.1609865068253;
        Tue, 05 Jan 2021 08:44:28 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 15sm44806ilx.84.2021.01.05.08.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 08:44:27 -0800 (PST)
Subject: Re: [PATCH 4.19 00/35] 4.19.165-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210104155703.375788488@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <46249e9b-218f-0a7f-24fc-23854e8ab7df@linuxfoundation.org>
Date:   Tue, 5 Jan 2021 09:44:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210104155703.375788488@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/21 8:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.165 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Jan 2021 15:56:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.165-rc1.gz
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
