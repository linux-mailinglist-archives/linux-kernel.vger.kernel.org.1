Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC082B6F68
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbgKQTyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbgKQTyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:54:14 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF56DC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:54:12 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id a18so18015879pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pctb8DZxtQNRAIgFwGxL6HThY7Qo5czv9hhFdmCOUCU=;
        b=O5mWd20Xs/3dcQrzF6J14yQTnLVWSgPokP3F+wo9dwngYEYRGJ3r8rUZHq5vDLINw6
         kebTyskd9CYy5zMYhpq+oHOflmLG/WU7CUA2Dtj2xQwiU/OOWNcPbmgxevqArjMsM4+A
         V5AwPU1tliR/N9xq832QBcmXdn8wkQWTWWugDYYnForohG0nbIub1V3wCrKF2v9D7pDA
         zT6CE5WsRU5mvST8DvqZPvZQf+6vM2DsJYPEko64h4jxxqQn5pwv2fQ1svE/aFTrFMog
         R68DMjQxjf2aBzQY1JxXaBR965IxcgKssK6wUW9DPZokQP7S4uY4X4AEfbqdz+MI6JmX
         lqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pctb8DZxtQNRAIgFwGxL6HThY7Qo5czv9hhFdmCOUCU=;
        b=ZeGf4kfuYh6FN/jEhyEgY0hccq11Mqv2cvTxFmAthj/hnx3L4K5pW3pgMmjwt7ebN4
         rjrgUbXBguhWo3ssaNhCeYHSABfTDZKjHCGVjSInJFAHtxEftE+iOLZQD3lOhsZSH1oS
         Nlv6vZsOeZyx8g62i5vV++7Y1kziA3DNOUiMw7nykJjT6cUmgLpJNWxUrwQoLwJFWT3v
         uUWi4g2veVo6x4jPQzqr16D+6nSq4M7NZc1CmETTy0wWzEAs3oQZV0xbRdolnav5pJcW
         QJZ7nRWd5fZY5OmZP1UptpJBufHln8odcvA7ifEtU9fB6Xcuz6ziX3bOF7Q1c/cnO3w+
         Njbw==
X-Gm-Message-State: AOAM532Y4wuL0U2dMbuRv1VY8y6emURxiwglTEoaOF9S6ZF7oXr687QX
        Ahd69+vmDNyta7hIv/dzaKPT9w==
X-Google-Smtp-Source: ABdhPJy9OH48Odlyss7DdMCAM9w2Jdni4HQHC/m0mph+4FeA1BQ5rY3yEAx0pUxCeFPXAaszNHU37w==
X-Received: by 2002:a63:658:: with SMTP id 85mr1994791pgg.315.1605642852429;
        Tue, 17 Nov 2020 11:54:12 -0800 (PST)
Received: from debian ([122.174.173.2])
        by smtp.gmail.com with ESMTPSA id d9sm22050057pfn.191.2020.11.17.11.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:54:12 -0800 (PST)
Message-ID: <9c06482d12ca652f14e142409cae727bb3425485.camel@rajagiritech.edu.in>
Subject: Re: [PATCH 5.9 000/255] 5.9.9-rc1 review
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, stable@vger.kernel.org
Date:   Wed, 18 Nov 2020 01:24:07 +0530
In-Reply-To: <20201117122138.925150709@linuxfoundation.org>
References: <20201117122138.925150709@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-17 at 14:02 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.9.9 release.
> There are 255 patches in this series, all will be posted as a
> response
> to this one.  If anyone has any issues with these being applied,
> please
> let me know.
> 
> Responses should be made by Thu, 19 Nov 2020 12:20:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	
> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.9.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
> stable-rc.git linux-5.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> 
Compiled and booted 5.9.9-rc1+. No typical dmesg regression or
regressions.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
-- 
software engineer
rajagiri school of engineering and technology - autonomous

