Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E591C2F9A39
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbhARGz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731777AbhARGzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:55:05 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98C6C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 22:54:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x20so3748909pjh.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 22:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a61NDNRzrCDZjz9aAYnQH4fNU8BSU7I4o70F6b9RjWQ=;
        b=ZBp40ApONg5hlyM8Nk7lAci6DW4m+WmlSRC9QlC6GDBguXEjpMxSGY8CcXyGnRNU8m
         HgC08/FNRTgxB2Z/WVwSmVjPLsT1dWeGNvj6lM7qWlGj862MZrj9U0A04sNvjVO+Jbzx
         DVuY2fgRsHt63/AWb8q0p2YL0PkeDK6ZYgH4aHf5h89FHxGI+6e9feRBanMik5hnZTOz
         CGK/kYsOx8L8HpwdII9250VeS7/TqOKv3l5zcHVtP7ldcnFLs5o2xJQEjQne0NzKsMra
         Hve3vixCiO3CZ0mm1qr7PMXgSVBX+TLgX0OkflxfdhgbQ3UAesJS3C4VQQVJxN4r27o6
         MMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a61NDNRzrCDZjz9aAYnQH4fNU8BSU7I4o70F6b9RjWQ=;
        b=MVK69WlCtFnC5jcbDNq2dqtKptzYkMj+SUEzAKFCu+GOjSAW0LPrJ0dvy8HqHyLtoM
         uxrO6MCVwZm8svtG65TM53ozTwxMAvZjGV3XYERqpHonTNvGX5LTvGc5/9PG6R2qZ0WD
         5HuuaeaJ/bq1CyfqGGKuaJTT494PSbpisqBxeyj5IOnerwOU38NmyKbRMC7qlqHIsZr5
         7Jo7pFh8fQOR0FxEiLZwWeLsuJEvyjxWREUgM8tDXiZblSMKfDFLOK0+s5goDe7noBop
         9RqjvPSZAGsUBG9lLrWqXpL3hcIcisF/D3ykpEDmbqQdKLcSWU9O5Zl/BREYC7JOQCr4
         iBlA==
X-Gm-Message-State: AOAM533ZDgl1eLh0L5WSPqS/WgBHkwvj8mqykbIglXoRY0AAnkGtXBkC
        WqXX6C7VMpYSjyLpld/9ZqmqVA==
X-Google-Smtp-Source: ABdhPJwYtAGso1N2TmtCrggR0shnn3HjmPjH73YcgokUM5OA+NDMCJ0zZVt6nNgCaedNZkTsPsumBQ==
X-Received: by 2002:a17:902:c106:b029:de:af88:80ed with SMTP id 6-20020a170902c106b02900deaf8880edmr3614590pli.35.1610952864312;
        Sun, 17 Jan 2021 22:54:24 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id p13sm14049072pju.20.2021.01.17.22.54.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 22:54:23 -0800 (PST)
Date:   Mon, 18 Jan 2021 12:24:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rjw@rjwysocki.net, f.fainelli@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpufreq: brcmstb-avs-cpufreq: Fix some resource
 leaks in the error handling path of the probe function
Message-ID: <20210118065421.x5s54evpafq73ouk@vireshk-i7>
References: <20210117142635.568686-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117142635.568686-1-christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-21, 15:26, Christophe JAILLET wrote:
> If 'cpufreq_register_driver()' fails, we must release the resources
> allocated in 'brcm_avs_prepare_init()' as already done in the remove
> function.
> 
> To do that, introduce a new function 'brcm_avs_prepare_uninit()' in order
> to avoid code duplication. This also makes the code more readable (IMHO).
> 
> Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v1->v2: be less verbose when writing the error handling path of the probe
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Applied both patches. Thanks.

-- 
viresh
