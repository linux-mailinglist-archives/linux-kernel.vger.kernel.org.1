Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36572DB124
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgLOQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbgLOQSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:18:34 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27D5C06179C;
        Tue, 15 Dec 2020 08:17:53 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id y19so40760986lfa.13;
        Tue, 15 Dec 2020 08:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JKu6z7NvvAuTLT8o5ljUyycVpd5OzgaPv+CEb+i0K+A=;
        b=bCSFK+tZpE0bdvLBfj/yd2zfR6T5Fc/sBcFZodedew5LNAwBM2pFToiw+M75lsHxAn
         63eFoOwQgyrCsA8TUTSg54bO6ZdkTKyz526lbi1mDThCai7FDwMU4mF0btegErHhQ2OD
         rIVsiB24fLW5GaI6rRIzuekhDVa+289aklCmHCrxnYkVzB0dkjlJZanAqeOozNnVcAy+
         hYGDtlH7IoHy87NOrYHsk2h8Sf4PLAW8vtmFFO0fnDlW7bKJNuTPwMqoQi6sxDuGpYzG
         n+IuCg9+DdTAjoo7WTnCmXqsQ1pUEW4SnClUmfe+obcRlNQVMH0rwY3l60jRbCt8wb2J
         Uysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JKu6z7NvvAuTLT8o5ljUyycVpd5OzgaPv+CEb+i0K+A=;
        b=liJBXdehqRTohg3bS5eVBiTyQXTQgYkBFqHZiqvvNdE4nTznlfUFXW8tGmk8jG//0Y
         qLNzZY3ZgZbPYWCmbCdO6FN4k805XczRgEuChdKx+hSCdsutqw2Kg7EjD4f+TZplixSq
         yzZhJmJpvi/xD30/5JmnOyoMHL+9Gqc9Knnzyx/4q3qrNFouS3sRuv+f0Yy1PjSKrhGQ
         wb8qGslkF13/0B5m4Dmq4KQD+ruMhXCiY3Eg7OLSvDr9gM0o0PeVEqVcSdRvHpmofeXb
         S84sOLI7BD9lt3o64C6FVLB4h7dndhIZSZMvCU7irP9+ClBdNPNGlEOp8/iqGWJ8bGLE
         musQ==
X-Gm-Message-State: AOAM530ubCZLGdxQN8JZ+9HfQ2XDNmtnNagmDgqUuiN6xwCfnC4QGWL1
        uy1fJ6sJLsYurnrM2At4VDKiu1v1IZ4=
X-Google-Smtp-Source: ABdhPJxmQMg6xPxUrGAAOy91XZzRwL2vYqnlHRJQ+1sMwHxmFIsRMxfehhnkhsPTkri9L+uOek7dDQ==
X-Received: by 2002:a19:4c84:: with SMTP id z126mr10856664lfa.69.1608049072238;
        Tue, 15 Dec 2020 08:17:52 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id b141sm253909lfd.148.2020.12.15.08.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 08:17:51 -0800 (PST)
Subject: Re: [PATCH v1] ARM: tegra: Fix misplaced tegra_uart_config in
 decompressor
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201215135222.6899-1-digetx@gmail.com>
 <980f70c6-8967-c110-1699-cb0da2f46cc0@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5b01ce96-5f8b-dfcb-accd-2ba29f34947f@gmail.com>
Date:   Tue, 15 Dec 2020 19:17:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <980f70c6-8967-c110-1699-cb0da2f46cc0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.12.2020 19:04, Florian Fainelli пишет:
> 
> 
> On 12/15/2020 5:52 AM, Dmitry Osipenko wrote:
>> The tegra_uart_config of the DEBUG_LL code is now placed right at the
>> start of the .text section after commit which enabled debug output in the
>> decompressor. Tegra devices are not booting anymore if DEBUG_LL is enabled
>> since tegra_uart_config data is executes as a code. Fix the misplaced
>> tegra_uart_config storage by embedding it into the code.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 2596a72d3384 ("ARM: 9009/1: uncompress: Enable debug in head.S")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/include/debug/tegra.S | 54 +++++++++++++++++-----------------
>>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> Looks like arch/arm/include/debug/brcmstb.S would need the same
> treatment since the implementation was copied from tegra.S.
> 

Good catch, will you be able to test the brcm and make a patch?
