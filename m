Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A91F2EFDC0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 05:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhAIEho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 23:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbhAIEhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 23:37:43 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4A4C061573
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 20:37:03 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id m23so12059827ioy.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 20:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJA+TK24YdhY5m+moA7nWTM5dOw8XllBPwctO4rl/tE=;
        b=Ce5ZQWthiKjpDkEWWTY/leuunvjoHdmCkcVN42ECmvO/UsmWJARlC0DcEOnMszT1dS
         giFpgKPiL6LzhQH3EuEwHHKOElJCDZiQvqvM+YbhyM8t0prDXVW1g3AA4i0UrupSUOk6
         WcFJeoazq6fLbK9VE24PpaBl148t/iZVd+X8/rvDKHdG+37lCZc538DSZnxZoNVZsAPA
         BEJi+5OTF7XO+hD5WI9ExCRuxrX2xgN7o08RE8raS7auE/WJ2vmbYL9GxOICQ19fUiMH
         F/BCSGtR766xWJXOcI+25lGOR7IgpV+r96s9F+KaFAtSUWW3hfP2p7nQ4IvSBw9ok7eh
         gquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJA+TK24YdhY5m+moA7nWTM5dOw8XllBPwctO4rl/tE=;
        b=ClVQP0IPzFsqtUcylaAoc37gOIAaLOQ01tvA1ov3jyiIrf/AONwQURuMDaxb8bMkFl
         1i61tWNP3s2nwhtq7z+ePkVzPZE3Sx34RJm4Fnn0FSDzgScW4GEYzb76dgr5CdXhkdOv
         QEv9UBzHrAvzVKy2PPCwJn0jEPq3LuKddSa4Ep3b0vPDGNcv/E9AvOqJ8SrM7FTRnn0f
         8IktuFGL+eIQleLwapDXNjJMHtEo6tliXEmXoGjorWV9zrUlpIfuouKwoz3SW7fvoQDk
         dHUi/BdN5dq3tsj1dybH31SNm0HAzokeiQ0fex3M70eYDvYrqL9mnnqSIXcFC8+FwlXl
         LdMQ==
X-Gm-Message-State: AOAM532qMB3xaiHlhsVdJQZUkGeEgcmRSCWuVr8lKhDPMWqPl8zBrA/4
        7OzU1IwU/QbIkKMei0YyRtWM0tzfxnfNXbPjBTA=
X-Google-Smtp-Source: ABdhPJzNE97q/B8vlMY89l0GzL+YgLOdpThEs9oX6xQRv1+2nAWKryunHwSoMs7voAZ5B9NcMLeyP9lPeXdD+wjwZQg=
X-Received: by 2002:a6b:6608:: with SMTP id a8mr7884626ioc.168.1610167022556;
 Fri, 08 Jan 2021 20:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20210107123249.36964-1-linmiaohe@huawei.com>
In-Reply-To: <20210107123249.36964-1-linmiaohe@huawei.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Sat, 9 Jan 2021 12:36:24 +0800
Message-ID: <CAPSr9jGE_vYAdnWDMskywtp3B_qpC_caZ0_azecTnmZuJ-A1=w@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: Fix potential double free in
 hugetlb_register_node() error path
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 8:36 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> In hugetlb_sysfs_add_hstate(), we would do kobject_put() on hstate_kobjs
> when failed to create sysfs group but forget to set hstate_kobjs to NULL.
> Then in hugetlb_register_node() error path, we may free it again via
> hugetlb_unregister_node().
>
> Fixes: a3437870160c ("hugetlb: new sysfs interface")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/hugetlb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Muchun Song <smuchun@gmail.com>

>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e249bffa0e75..91a2a2025a2c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2947,8 +2947,10 @@ static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
>                 return -ENOMEM;
>
>         retval = sysfs_create_group(hstate_kobjs[hi], hstate_attr_group);
> -       if (retval)
> +       if (retval) {
>                 kobject_put(hstate_kobjs[hi]);
> +               hstate_kobjs[hi] = NULL;
> +       }
>
>         return retval;
>  }
> --
> 2.19.1
>
