Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E882527D4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgI2Rm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgI2Rmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:42:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E05C061755;
        Tue, 29 Sep 2020 10:42:55 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c2so4717516ljj.12;
        Tue, 29 Sep 2020 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DwNtPpUEmgv0ELsT/GqVFAjoTGKCyKCMhl5EuEZOqf4=;
        b=a74V0z1zlws1Etorsyv0teGeF7Ww3xR72S0PqC1EmOP5h/Lk4aOr/FhYBm0+5AxlCZ
         prB6QnA+MMHs6wrpZugs6dMf4e9tAR2mwDBsUvg1p8COupXMSCpdeCS++oAd0VJvYpGc
         CX0zbaO3VQA3YSMwWwsNCyQnDoY6IvB1igj1cVEqEjRiLq+dfJp6SQxI3LmzGwcjVFLj
         AyYodil/IujXs1Go4DTxg0ir37eylXa6WWDD4nYV8oblkjXrkQOq2kFB4DmmH7VXkebx
         FOjm73Gu+0OhpSswGj8uJ0DXvkBsPM+/iNXwUk6ZI3pFpxEGrz9ZZ96jUXMJv35Oe/Kp
         LawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DwNtPpUEmgv0ELsT/GqVFAjoTGKCyKCMhl5EuEZOqf4=;
        b=pfJabFHDZWaE9s0rpswEiwL5HmjzTJgI1mx5y8Gc1E/VXJopx4yzoXHpQysKW2Gcic
         sj4kdWVWzqv9aqjulF1le0FEXBQzIp4bQrzfMvBslfqRICQuW38hErZcUr69N2VvhQK4
         Y1zQB4uW/EPixTiUw8ZjZRc2exs4rKh8yYWnddgrU8ZEI3k2UAXOn44ikDgb1iP5FwWA
         FqRcaFc0y104YSHYUqgRnbWhxiB/zoD/ce55eoGF0ZxrKllx6lknJER6hBlobxLvgIHi
         rsaTRVtVJidN6ukgSx++3RPFkzEEhFbaUTgFA7HQh/o+d+slFdmvUKOzbj+W6lcgkdZi
         8aVQ==
X-Gm-Message-State: AOAM533ijI6rkwxpjKfFqY3vDqSIHMKWzl5j1atR9BHScxAI7l95yWFl
        DOKUjTdj5Dbdwm+UFCxHmKQ=
X-Google-Smtp-Source: ABdhPJzsDCimFDVDMHaNwlvDskQRdaVTUV8i1sA1CVb2qNn1JAlvxWTfMO0og2S/0kxElaiynX1j0Q==
X-Received: by 2002:a2e:895a:: with SMTP id b26mr1577495ljk.468.1601401373499;
        Tue, 29 Sep 2020 10:42:53 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id n8sm418776ljj.69.2020.09.29.10.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 10:42:53 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] iommu/tegra-smmu: Expand mutex protection range
To:     Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
        joro@8bytes.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@infradead.org
References: <20200929061325.10197-1-nicoleotsuka@gmail.com>
 <20200929061325.10197-3-nicoleotsuka@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <184163e9-01d4-dcc5-0adf-a3d175e56f16@gmail.com>
Date:   Tue, 29 Sep 2020 20:42:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929061325.10197-3-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.09.2020 09:13, Nicolin Chen пишет:
> This is used to protect potential race condition at use_count.
> since probes of client drivers, calling attach_dev(), may run
> concurrently.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---

It's always better not to mix success and error code paths in order to
keep code readable, but not a big deal in the case of this particular
patch since the changed code is quite simple. Please try to avoid doing
this in the future patches.

Also, please note that in general it's better to use locked/unlocked
versions for the functions like it's already done for
tegra_smmu_map/unmap, this will remove the need to maintain lockings in
the code. The code touched by this patch doesn't have complicated code
paths, so it's good enough to me.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
