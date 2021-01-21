Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FE42FE7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbhAUKhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:37:35 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47548 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbhAUKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:34:23 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210121103340euoutp01f0f760bdbe08e394d738f9f87b74ca26~cOM0yAaKS2352923529euoutp01Q
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:33:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210121103340euoutp01f0f760bdbe08e394d738f9f87b74ca26~cOM0yAaKS2352923529euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611225220;
        bh=XfBx/qNg23HWDQln5K2h5RVf0BLEFZCS/JUYWDf9KdY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hi2QoS7J5mkbCJfeGUyQ8kGHLK9vGCalMvQbHKoKyydVzy2qzET9hjeV+msdosUfh
         UnxRF2oz5EbPx8H7jUbz4LQM2N6/Yu6EfYiltHtV9BhtMx/2CxYihzBXuuMqdLA+eT
         MdKtpPO4REryVw/ZnrqejCc+ZylDCtQTHJ8UH9yc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210121103340eucas1p14d304879f8437735e0025777c0d191da~cOM0OWhux0159801598eucas1p1t;
        Thu, 21 Jan 2021 10:33:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 41.B9.45488.38859006; Thu, 21
        Jan 2021 10:33:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210121103339eucas1p13d54ddb6181c6a4932a97a40630dedb2~cOMzycrOs0559105591eucas1p1b;
        Thu, 21 Jan 2021 10:33:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210121103339eusmtrp1634fdab49bb5ecf11d963848fa94caba~cOMzx0OmH2339723397eusmtrp1U;
        Thu, 21 Jan 2021 10:33:39 +0000 (GMT)
X-AuditID: cbfec7f5-c77ff7000000b1b0-63-600958832626
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 11.35.16282.38859006; Thu, 21
        Jan 2021 10:33:39 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210121103338eusmtip2cc38cdaef03157d2b40b5a83919574d9~cOMzNojgT1051610516eusmtip2h;
        Thu, 21 Jan 2021 10:33:38 +0000 (GMT)
Subject: Re: [TEST PATCH v1] driver: core: Make fw_devlink=on more forgiving
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <80832719-85dc-c6ba-a7e9-5d53f4020e52@samsung.com>
Date:   Thu, 21 Jan 2021 11:33:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121082248.883253-1-saravanak@google.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87rNEZwJBrN+Wls8u7WXyaJ58Xo2
        ix3bRSwu75rDZrFzzklWi7lfpjJbdB36y+bA7rFt9zZWjwWbSj02repk8zh0uIPRY//cNewe
        nzfJBbBFcdmkpOZklqUW6dslcGWs/LuAtWAid8XO57sYGxj/cHQxcnJICJhIdC17wdjFyMUh
        JLCCUeLQ7dksEM4XRomFH/azQTifGSW6z0xnh2lZ2nKbFcQWEljOKPF0vyhE0UdGif5PV9hA
        EsICPhLrT01mAkmICLQxSjzc9xNsLrNAK6PE9d8zwNrZBAwlut52gXXwCthJfD4/ASzOIqAq
        serLK2YQW1QgSeLuncNMEDWCEidnPmEBsTkFrCWev/rJCGIzC8hLbH87hxnCFpe49WQ+2GYJ
        gSccEh9uzgVawAHkuEisnGYD8YKwxKvjW6DekZE4PbmHBaK+GejSc2vZIZweRonLTTMYIaqs
        Je6c+wU2iFlAU2L9Ln2IsKPE+T8PoObzSdx4KwhxA5/EpG3TmSHCvBIdbUIQ1WoSs46vg1t7
        8MIl5gmMSrOQfDYLyTezkHwzC2HvAkaWVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIHJ
        6PS/4193MK549VHvECMTB+MhRgkOZiUR3keWHAlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeXdt
        XRMvJJCeWJKanZpakFoEk2Xi4JRqYHJ4cYFduE+2heeaxqo0G1tNqZJTG1+mPc2tMDEVNdvk
        xq3kvuvxpw12qt0v9ntOPdCb9N219knL1O2i1Xp6a62+bRdKVVNcvyipIvX0zzdcbE/f+sT4
        iclLy9YyzJaYcnhC0622lu7wXKUNU5eqJSlnzeM3XHz03nuFi3Kx7x9J3y849PNEBT/Dv0UG
        Fs5p5zfcPdhdZmhtNHFeSejdM0n9Qr5v9ktKJt2OO5WjK/X5rtPMGn3FW/kn0v2850lt1tfY
        /oPH8GWO6YZJK/4eY9D/lXP8v7BUSMqK4oOtq1v/zCk/t+Cw3NFj/C1yvk/Eg3/khdnLCwm/
        8BbP5Z4WaHGCz3Lab98Nz0SdZdflKLEUZyQaajEXFScCAAkIAhi1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7rNEZwJBr+PSVs8u7WXyaJ58Xo2
        ix3bRSwu75rDZrFzzklWi7lfpjJbdB36y+bA7rFt9zZWjwWbSj02repk8zh0uIPRY//cNewe
        nzfJBbBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl
        6GWs/LuAtWAid8XO57sYGxj/cHQxcnJICJhILG25zdrFyMUhJLCUUeLs8eUsEAkZiZPTGlgh
        bGGJP9e62CCK3jNKXJ7YDpYQFvCRWH9qMhNIQkSgg1Hi29XrYFXMAq2MEs/XfGeBaDnAKDHv
        zW+wuWwChhJdb0FmcXLwCthJfD4/AWwUi4CqxKovr5hBbFGBJIkTsz4xQ9QISpyc+QSsl1PA
        WuL5q5+MIDazgJnEvM0PmSFseYntb+dA2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNI
        amlxbnpusZFecWJucWleul5yfu4mRmAEbjv2c8sOxpWvPuodYmTiYDzEKMHBrCTC+8iSI0GI
        NyWxsiq1KD++qDQntfgQoynQPxOZpUST84EpIK8k3tDMwNTQxMzSwNTSzFhJnNfkyJp4IYH0
        xJLU7NTUgtQimD4mDk6pBqbQGLcj7erZO/6f/Vi78CtLmLNOwv/4zccmd4bffSFyIpSn0n53
        50dlzwv1bGYPbz155yv+9+bis56vSiLaw7/wXzT9Kfeo/91Kn4mvM7tVBPPkrFOWqTxn3vFg
        1cJJR4/MYJUxfJdeqCOq8X0NzzFGNobtfVW1TY7lQhwv+m8Fvv5dMzvjsM3zWV8KIsPtOu2U
        /dq/djqUHC7VUFhV++zp+sM/LAN+Ty0+2iPPE6aW9/thzhq/efcUD/zRn6N75NZdTY+1tS0H
        G6cZf5JJ/hpz3DjZ6oajg/WR0D+L/0gsnez3c+f1LMfXpn1LF0uwsHzIU1uU63+Uc7/NY7Eq
        Pi8vpzMptUtWlsXUNU4qzFZiKc5INNRiLipOBADa6EbGSQMAAA==
X-CMS-MailID: 20210121103339eucas1p13d54ddb6181c6a4932a97a40630dedb2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210121082255eucas1p1b55474f1c6cc3fd30d058082597439b5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210121082255eucas1p1b55474f1c6cc3fd30d058082597439b5
References: <20201218031703.3053753-6-saravanak@google.com>
        <CGME20210121082255eucas1p1b55474f1c6cc3fd30d058082597439b5@eucas1p1.samsung.com>
        <20210121082248.883253-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 21.01.2021 09:22, Saravana Kannan wrote:
> This patch is for test purposes only and pretty experimental. Code might
> not be optimized, clean, formatted properly, etc.
>
> Please review it only for functional bugs like locking bugs, wrong
> logic, etc.
>
> It's basically trying to figure out which devices will never probe and
> ignore them. Might not always work.
>
> Marek, Geert, Marc,
>
> Can you please try this patch INSTEAD of the other workarounds we found?

I've checked the latest linux-next with this patch and commit 
c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platform 
driver") reverted. Sadly it doesn't help. All devices that belongs to 
the Exynos power domains are not probed at all ("supplier 
10023cXX.power-domain not ready").

> Jon, Michael,
>
> I'm explicitly not including you in the "To" because this patch won't
> work for your issues.
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>   drivers/base/base.h |   3 ++
>   drivers/base/core.c | 117 +++++++++++++++++++++++++++++++++++++++++++-
>   drivers/base/dd.c   |  24 +++++++++
>   3 files changed, 142 insertions(+), 2 deletions(-)
>
> > [...]

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

