Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7691227DFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 07:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgI3FKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 01:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3FK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 01:10:29 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DA7C061755;
        Tue, 29 Sep 2020 22:10:29 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n25so461905ljj.4;
        Tue, 29 Sep 2020 22:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sWOUEivvyjwmKnS+1gQtbQM1CGBMZHxOAZcgTC+sr0k=;
        b=qDDAYamCSLuu5G9Imm4M9PhE04cyV1A351HM9B+dCti2usr49Ra4TOrG+Hw8inwJGv
         i9B3ExDnbNRWAJgSVmcZ6/F/CmkhrY4OkdhtmBBahSJsO9Sd20hggoJsbUCPUrhN73Ai
         wo+aSXQObBcNLAQVAJ0VtWifWREYxwIn5uHU5fGRYQNXYrqgFI6bDnyxe8LjoUbhQQKf
         X825089DwAyPy880m3K+dbNpRt+qtI2QHN7IgEPJ3Gv3Us/fKTPO35lQ722CYuxaTMv+
         LOjHPy1fWERCrDWIWTz+V8yA9Zi0Dr0NMwV54KJo2Gjg+gRnzapkEiqM54LzAQX2uHoe
         VKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sWOUEivvyjwmKnS+1gQtbQM1CGBMZHxOAZcgTC+sr0k=;
        b=JkY7Q8a8GXGEKn5FHqPHIuYoknRInnZXVc2mMCd+THGpo4TDJis3H0sEbLfJ3CSvyb
         5WXEkWSrGdP5vJ/8noBqybZTQQOqWbtUp1RcJzlxybzkMG1TlfCFCxkM/P5jL5l+kkTm
         87QHo4wL/E+CZgFuE594XM5uLR8ZgeaN2po5WKzl2g/KejH5QiP4xy8GlXF6Z0IFOOfd
         Uu2z9ZwEDfuOWrk0cQM1EN4U5nLP7h1ZV1YzUFys68nbtAWGJ4DrgkM5V5MZ5dSvtthk
         sQnw1jDliK1Xz3dZBslENs5XC3MNhfsNZVz5myy8ikgI9agW9W3Dfvbawj0apqQ5kj1K
         ELaw==
X-Gm-Message-State: AOAM531S4g2pxpbw29rQBzmH9karGGYqaY17O8a9ew9ew3ivGDS38Kdw
        fluruuT9ygTHUFrQZpoq5ETgdLv9QJ0=
X-Google-Smtp-Source: ABdhPJwZLrAmlZX8sHApt+XwfMXLnDrPg53KHCMKCT1/t5az43Q3OJoEbDBwOJT9bOfGmFxvJNRG2g==
X-Received: by 2002:a2e:9755:: with SMTP id f21mr345885ljj.50.1601442627611;
        Tue, 29 Sep 2020 22:10:27 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id u1sm55367lfu.24.2020.09.29.22.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 22:10:26 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To:     Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
        joro@8bytes.org, krzk@kernel.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <db183fdf-d566-599a-94ff-cfab0e08aa7a@gmail.com>
Date:   Wed, 30 Sep 2020 08:10:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930003013.31289-3-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.09.2020 03:30, Nicolin Chen пишет:
>  static void tegra_smmu_release_device(struct device *dev)

The tegra_get_memory_controller() uses of_find_device_by_node(), hence
tegra_smmu_release_device() should put_device(mc) in order to balance
back the refcounting.
