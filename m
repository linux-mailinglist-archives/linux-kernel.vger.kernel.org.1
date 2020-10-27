Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CC829C2F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1821297AbgJ0Rl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:41:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44956 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1821284AbgJ0Rl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:41:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id o3so1193736pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0CO1zeTWUysqgAKdJuZ6Y9RdJac7Bbof6WX21/2NFNE=;
        b=0Z28RaPwcWIO4K9FcoLxNq6dbeEZ5R2dF6DT4oTBLzSLuDuUjwpWvrpk6KSDigymXJ
         vRuqQ5FfcFXEsgSjgqtyk95NbR3R4ZM8MD0tGw/jTH6O+v2xX0xk28xtvrnUSkw+lQZe
         mgK9uE0zqyvaIDxvNv1HLkskdEsLCxYGOuf3v49thzCD6ZGH4uDzWIq92788X7CucRND
         bpUkL7byN19+6jxUAREvKcGzGcOHKLn4x9E7MHLv/1AqhYOe/LNTGAY8hO+o9MZhdHxs
         oGD8WMlw978m5WhD0Ew/X6Rdr+/AdvFzG8Q+8bGZkyv1toQQrYRwq7PWHxhLb5TaezTO
         G5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0CO1zeTWUysqgAKdJuZ6Y9RdJac7Bbof6WX21/2NFNE=;
        b=ftuTfhiKUNshAMY4M1afntcX21+lvbSTn2m1IfQQbmS5CVrXGckxj0M4440itiBDOT
         eQ1dOzV3netLkwPpvF3NNGdJNiqV0P0bOtQVHgD52N1Dp5LJ0Aask01egPde3T/SlYB3
         Ctm9cQTTP5bY2gpAolajBsxwCQJ0y0b9VXpT94VTLlcc/mmVTmYlrRQrQlxAuIcIQAuh
         JRElSJ5HJbZQw45+b557FR44nLrPKWfVkX8cCpIvrnF/wgQ211MHwOI36tHIKSCh+9nv
         j1iU1EsryBOkt4y0KhLQbB5VHzd3+ZCXJq1GX8cp93H2w7XpMFEHdpwcPMZ22t2qbvsY
         g1yw==
X-Gm-Message-State: AOAM530MDhk3WnhCnbw7R07J8JKqOHuwUoHvxIFmSn4PQsY1s50nnurt
        N9INj7j6rzuG3yQv6GA9G6tU+Q==
X-Google-Smtp-Source: ABdhPJxiufQxV0ZKD/20TC+CmwbDIPysEcCylvSAWjyRbhrQaQo4Augl/p4OlYdKIHrBuFrzuthMhw==
X-Received: by 2002:aa7:96b9:0:b029:155:6332:e1c7 with SMTP id g25-20020aa796b90000b02901556332e1c7mr3275225pfk.35.1603820515592;
        Tue, 27 Oct 2020 10:41:55 -0700 (PDT)
Received: from debian ([122.164.48.88])
        by smtp.gmail.com with ESMTPSA id b67sm2710808pfa.151.2020.10.27.10.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:41:55 -0700 (PDT)
Message-ID: <36462d17b9db3698015b5d28474f9ee5218a9cdd.camel@rajagiritech.edu.in>
Subject: Re: [PATCH 5.9 000/757] 5.9.2-rc1 review
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, stable@vger.kernel.org
Date:   Tue, 27 Oct 2020 23:11:50 +0530
In-Reply-To: <20201027135450.497324313@linuxfoundation.org>
References: <20201027135450.497324313@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-27 at 14:44 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.9.2 release.
> There are 757 patches in this series, all will be posted as a
> response
> to this one.  If anyone has any issues with these being applied,
> please
> let me know.
> 
> Responses should be made by Thu, 29 Oct 2020 13:52:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	
> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.9.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
> stable-rc.git linux-5.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> 

hello,

Compiled and booted  5.9.2-rc1+.
Looks like no typical regression or regressions.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

-- 
software engineer
rajagiri school of engineering and technology  -  autonomous

