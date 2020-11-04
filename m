Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E1D2A6E72
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbgKDUCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKDUCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:02:00 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E36AC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 12:02:00 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x13so18201561pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 12:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HHg6h1ERO0ScMr8situW2RPYUOFCcCJTf0E9ld3a4hM=;
        b=xd2RynXfViVLdrYELeLgJAHfCDrUSWXuu2W2XQtxfKC+ssLRpixaQZ/Ubdkf8olmM9
         7u5Im6pdBwwYBYFcOyDDBFn18wFyTodVl7YFM2EZ4DBFAHB0bjtYZBOW2gA7ZLRdP/gW
         aYMHXS4MWhmRzGP5mAr6+rTBfdnlXnODocl6SkcSmzTwiHor+u5rPd0lacY6JNeRG+Cc
         rIDdZ8LVeJPLz01wzadXXBu5fM/yACvTMxHgYdHizlp2nDM0CMwl5J8CToOc7I1q8MGm
         k1QGTMNcR0WCdHI04z6Dw8mi7ZxOjrrMIuyhCUy/0IOXbxxebXejcBpcTfOS3kthDsPB
         izlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HHg6h1ERO0ScMr8situW2RPYUOFCcCJTf0E9ld3a4hM=;
        b=iekDRcp9CRbDNQiBQuxxVCctGmSd+Zc6+jvFyAksbUTXsVodd84Ys16YCuY2sI9HsB
         2soOl6qdg5N5SMlV8irr5+mEU1/y/6xfu4CmsXMBuoULO6Mimzi25FoOiBP2RROmLxJS
         XRKfeuMLfJVTN7CozsWZjl4rYeg30nUxNgy2F/s1eGrVFCF1Epy0RXaF+0uhjdPvRfMk
         4t3LkqDcatWBS0Kr6WLnMf6Ve4w69jJogMioNlrT8GWnExGvY0rVOXOdWgaALzCj7uTH
         tV5ZMYbTUjCM+V22AbbyTRWoaL4fXzLT/fzQN35T4qOm77GeACnSuhnceb0+GE3IvZc7
         tdSQ==
X-Gm-Message-State: AOAM531lONZ39Qd5qPuqib/w+L5J+0PiqOCX2V68FEmBl7h8yHoBJQCr
        iBjFUkgPmguDTE21TSbBuw/3HOGFXTl8Q6M+
X-Google-Smtp-Source: ABdhPJwkU50qSyiBRlsGklQLZ1nWj9sW9Ne2CdsjCQFLHULeoJAmQzGXz22Pg2MPGxdc05stn8bsaQ==
X-Received: by 2002:a63:1805:: with SMTP id y5mr22302367pgl.174.1604520120080;
        Wed, 04 Nov 2020 12:02:00 -0800 (PST)
Received: from debian ([171.61.236.158])
        by smtp.gmail.com with ESMTPSA id k26sm3272276pfg.8.2020.11.04.12.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:01:59 -0800 (PST)
Message-ID: <9669c90b893a548f4cdb0fd29f1385f20a488024.camel@rajagiritech.edu.in>
Subject: Re: [PATCH 5.9 000/391] 5.9.4-rc1 review
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, stable@vger.kernel.org
Date:   Thu, 05 Nov 2020 01:31:50 +0530
In-Reply-To: <20201103203348.153465465@linuxfoundation.org>
References: <20201103203348.153465465@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-03 at 21:30 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.9.4 release.
> There are 391 patches in this series, all will be posted as a
> response
> to this one.  If anyone has any issues with these being applied,
> please
> let me know.
> 
> Responses should be made by Thu, 05 Nov 2020 20:29:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	
> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.9.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
> stable-rc.git linux-5.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Compiled and booted 5.9.4-rc1+ . No typical dmesg regressions.


Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

-- 
software engineer
rajagiri school of engineering and technology  - autonomous


