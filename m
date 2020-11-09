Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDF32AC50D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbgKITd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbgKITd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:33:59 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5159BC0613D4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 11:33:59 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c66so3394792pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 11:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sl29wqUIKXUufuIQiygXdmzoEm6rqS29bZj53/PfalY=;
        b=ZcZO2PLLz2GIuM/Eud3LPbVrSNLtOdJ6x/yz6u+n9QiQ0mnRhrGr/rFgXxpO1GkXbu
         vobfG0GW89ymrR+c6coo2RMdqDAV3/vwJAD/og1rsjk5wJdgdiwCa0kYKT6rqy9bBhCY
         BGTDfJTGNwzsKlGpznZDiYYR6nDdXWLE/2CNqyG7XD+23wl5rwrD3N30fLGfSGfanltX
         psZ71ITbly183FD3/4o0LSXZ2F/P/4rOt3tRH1EdrDlAYrqOKDLl59BuPDeJhhztOMm4
         0K46cWMO7mEndgzy9NoNSB7itaf0dBS1fuMbLCMp7/p6JLgbLcyBFL3J6ufsz6oKkYR2
         FwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=sl29wqUIKXUufuIQiygXdmzoEm6rqS29bZj53/PfalY=;
        b=owTidfFA0gOpayYHmKyvcnrwK4w1070Vl8bq4dvz2MN3kqaTlUBvRtr4frH6WuzC+o
         TrUsSXupK/R4kRgC3gN3iD+2vAi+mPapVnbNcbsp25tYJcvor7i+91rQrS4mvN468TX6
         thSg0DU4hVTLjnKg4h6uJoMJVKvFHRm14fluzc9Z+GID7yyRnJkcdw4TLZL39yAfaWEg
         01t0GLRc0p038j1LPIofHhU4cdAmAcj3EjWs3IvisMAIkTZFphGFB3dO8f3ATqWq+hfA
         UQrsxfNX/1RHEQL803HXTtExQKsj+TrDsGCQxrVWXmvfkVrbp7URln+GQg2INM1uiUZL
         6qxg==
X-Gm-Message-State: AOAM5300Af2/z9WNc4SJQ+xESMLvoDOd6BFrUu8LGKjXfOkQzBQrFdtW
        2KPHHTrXW1TRJR2q9fj7Y24/Ub3c2sNEgOsd
X-Google-Smtp-Source: ABdhPJwmm9Ci6gGF1rDiD72aOfp2oku2i0dQAi/79ykvrQtaD0eJ2vGX5mEf4L2GK/OJ30YNN14wQA==
X-Received: by 2002:a62:52d7:0:b029:18b:7093:fb88 with SMTP id g206-20020a6252d70000b029018b7093fb88mr15225978pfb.76.1604950438878;
        Mon, 09 Nov 2020 11:33:58 -0800 (PST)
Received: from debian ([122.174.251.176])
        by smtp.gmail.com with ESMTPSA id v7sm11643247pfu.39.2020.11.09.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 11:33:58 -0800 (PST)
Message-ID: <72209d415e20d2453e57100d246c659e8f44f0d9.camel@rajagiritech.edu.in>
Subject: Re: [PATCH 5.9 000/133] 5.9.7-rc1 review
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, stable@vger.kernel.org
Date:   Tue, 10 Nov 2020 01:03:53 +0530
In-Reply-To: <20201109125030.706496283@linuxfoundation.org>
References: <20201109125030.706496283@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-09 at 13:54 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.9.7 release.
> There are 133 patches in this series, all will be posted as a
> response
> to this one.  If anyone has any issues with these being applied,
> please
> let me know.
> 
> Responses should be made by Wed, 11 Nov 2020 12:50:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	
> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.9.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
> stable-rc.git linux-5.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Compiled and  booted  5.9.7-rc1+. No typical dmesg regressions.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

-- 
software engineer
rajagiri school of engineering and technology  - autonomous

