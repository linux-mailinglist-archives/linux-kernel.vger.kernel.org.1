Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A202D2E25B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 10:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgLXJoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 04:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgLXJoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 04:44:24 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE235C06179C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 01:43:43 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n25so1297050pgb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 01:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PqsIw5G8hr5Ym14mfhHS3mfmrGehuuwns2Nlz6+ZZao=;
        b=Xl6C31EyHbh4nUjtcdYf2EpK+z+MvtJWGa1j5Z9x6qEIdZTyzdINfNVrbEwcSwJAbP
         eRIX1PCOI00rvKf7HVU3+Huf347upAkSvZbpxBkm4l0FzXImZBS9BpQhtGE53cPKimeM
         b8fDXqS8LFkBJZDijkgNzw4mqP2zZ66lmR5PWsUDmrKpazbcTP8zRnDoLxe91qI6YZXn
         z9YMF75q4jgABI8La/R10KGM9fT7KxN7oGen2RY13zqUr59/SwnCkr3N1sChaLk3KlCj
         XQrKDG65g82QtK6mHG3Zp4MBK8RTxvCmjAcF6YztLecScLwPXouatg1ZMANtva3S+nn5
         YkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PqsIw5G8hr5Ym14mfhHS3mfmrGehuuwns2Nlz6+ZZao=;
        b=ObE7vV45Xyn9hhAAIef9al69C4/1eCQtJSd4e5TyjRyawFeKBSYVtS7TLh9gE+6aJL
         3VmAC/iXsbIV2GheH8pf12tyrkXLbsjiZz6dPScQ0UUlprDi1NeD//DpXSOaIEREOhtG
         3oF/l0rz3CBLnMDa+WOCHi5APdBIinyKrZeg8wifZ4XpCbAp3n2oEJH/2Y4a1td10jlg
         UBuXiHuxLnVyi4lLmtJQ6TE9D9hrxEtgYAoKFGVN56aoyj4Dzm1czHEtpZx8OJTp1Wl7
         p1rLa7rQGW2vtr3V1/SjjSEUiQS7rno9q1PTj3dwfcf/rDWFrvcVLXxi0wDpdvX/KzvL
         gGNA==
X-Gm-Message-State: AOAM533en4MDpap/8KA8z2xdzyed00QUMD5LXbSa1ETtnKxX6wHdfdH8
        K+IFZbnbRlguQmJ8ignL1Er/mw==
X-Google-Smtp-Source: ABdhPJwwQo9p0np5J0hX42QfncgOzn5RZJoa3aO9N40PIt5EfsTCqomPX6OlUUAP3JOPLg3oaxGcZg==
X-Received: by 2002:a63:220b:: with SMTP id i11mr28288817pgi.2.1608803023436;
        Thu, 24 Dec 2020 01:43:43 -0800 (PST)
Received: from [192.168.0.4] ([171.49.219.196])
        by smtp.gmail.com with ESMTPSA id 17sm25264017pfj.91.2020.12.24.01.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 01:43:42 -0800 (PST)
Message-ID: <1b12b1311e5f0ff7e96d444bf258facc6b0c6ae4.camel@rajagiritech.edu.in>
Subject: Re: [PATCH 5.10 00/40] 5.10.3-rc1 review
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, stable@vger.kernel.org
Date:   Thu, 24 Dec 2020 15:13:38 +0530
In-Reply-To: <20201223150515.553836647@linuxfoundation.org>
References: <20201223150515.553836647@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-23 at 16:33 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.3 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied,
> please
> let me know.
> 
> Responses should be made by Fri, 25 Dec 2020 15:05:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
> stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

hello ,
Compiled and booted 5.10.3-rc1+.

dmesg -l err gives...
--------------x-------------x------------------->
   43.190922] Bluetooth: hci0: don't support firmware rome 0x31010100
--------------x---------------x----------------->

My Bluetooth is Off.


Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
-- 
software engineer
rajagiri school of engineering and technology - autonomous


