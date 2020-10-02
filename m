Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F3228167D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388214AbgJBPYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBPYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:24:00 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB1AC0613D0;
        Fri,  2 Oct 2020 08:23:59 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u8so2345542lff.1;
        Fri, 02 Oct 2020 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MSrh6TVrP5tjbZRP3wOawqsedCy4/6jgDlznJFjxZpA=;
        b=Egnu4kM8pdngjG2biRwFBsznwAhlJVKkhvbUMpB86EGAGiE1k/p/+c2246lApinAG5
         LKvZtO7JJMcoW7zVcQiujJjwDdQEdIF9/Et/TPnwNOnoq0//E76nLjdIoR7KisA0BuLo
         IHRwOoAb0s/jyuAHUD6E5cJtgiRU4B9r4FHYrIAhwlaU3nxzXAjgZmKC0uUkpZFMxQk2
         K9UMl/EFpZKgdAuGIz9vmXMWhxPnAma7tU3q8pFA8G9HFBZYh7qHxt5joiphRu2JiPAP
         0K8BTEOoS/II2xLr/e+VkCoep2UyGycFepbr6eGtS0Lr8OG0rST1nzJdKHlEZLS3ZvHh
         IThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MSrh6TVrP5tjbZRP3wOawqsedCy4/6jgDlznJFjxZpA=;
        b=HfWLRJcOOJfFGGfHzEM+5oTympM6AdafTObiZ7JUMJxbGjAnL8/uwhg5PadIbzyuky
         OVLRnKIn8dn02+pLaGSBa/afNfOtzGO0bqI3FZR6mhdjjSofhLGZwxmU/nndvSZ0RPH7
         ahZZfWWcpUO7PKmNgzP9Lcvtw/rvlgc2+rgIl2otRKonJfB75KkCZ9gskYDfUn+/z2mP
         W7+98iEyJ6j8Y5sz5TAbSyiXfcQwNS9TbQFMn/uiRXDy6HRQWWbV/kGSpu0wAmfhHCGW
         baqrT4CYlJT7AxGX6t154rE0wTeQYRkzCho2l8e5o4BhTJuiiTFZLK0tPPxI+KLUi20q
         Kqsw==
X-Gm-Message-State: AOAM532zWAV7OZf2YU06hBe50ly85LMJSWR//xjo2f9k7ZwnRN1BZ4Y6
        NHah1KUGmrJRjDaG4u5i6DTnuFh2+io=
X-Google-Smtp-Source: ABdhPJz6W46BSYbtAIlIOTal4LqY8k9XMcth11LIarEEiXpeTlM8dq7+/UWZgY6PHKg4GIdDun+fEQ==
X-Received: by 2002:a19:915d:: with SMTP id y29mr1163560lfj.371.1601652237604;
        Fri, 02 Oct 2020 08:23:57 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru. [109.252.91.252])
        by smtp.googlemail.com with ESMTPSA id g26sm268538ljl.116.2020.10.02.08.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 08:23:56 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
To:     Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
        joro@8bytes.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <99d322d0-efb5-8a34-ee83-b907b785ced3@gmail.com>
Date:   Fri, 2 Oct 2020 18:23:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002060807.32138-3-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.10.2020 09:08, Nicolin Chen пишет:
> Then when a client gets probed, of_iommu_configure() in
> iommu core will search DTB for swgroup ID and call ->of_xlate()
> to prepare an fwspec, similar to tegra_smmu_probe_device() and
> tegra_smmu_configure(). Then it'll call tegra_smmu_probe_device()
> again, and this time we shall return smmu->iommu pointer properly.

I don't quite see where IOMMU core calls of_xlate().

Have tried to at least boot-test this patch?
