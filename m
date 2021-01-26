Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145EC303A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391963AbhAZK3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbhAZBb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:31:59 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA1C0698CE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:22:21 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x21so30605790iog.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dlpRJM3I+4DPOrAE8u678/FfQCJG2zfnjie74y4spew=;
        b=h4OvjVgPx9HhMh8kZ+Af7g/wzchZIQeaoVsoZZwrc13tmZ1P1b7cyymbeKfXfecsI6
         68v8mEOZugNeDK4ChYVJc46W8uQ1uzY0OJ91Zn5Mlh2sQKaGUrYYjFpeKhpIS2LU5nyU
         34caxyNlL3Vt8VUqc+fa/oia3SwZ3GgpV6X+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dlpRJM3I+4DPOrAE8u678/FfQCJG2zfnjie74y4spew=;
        b=JUdKjlr2VDv8rFsYxdkY4nwyXIMtgKAEkAB7WzBl0xnoZTsMk5n/ptEwqSlg1q/Ct2
         3BpqzoYx/RunzxFqTl6me/lnej6tfpbmyU/g7URmk+s/3UpOmTp+RiLs8ZV2GKyCAEeH
         MFevhPGAoVZ3gZl3DtckK45/WJnKw7/sXXD0QKV6/FCtdMxgG7F8fjOGAVb0GySTuP3e
         I888YQLf1snHB88SE3qldlgaqsp5OXLHfks2r2O3+HJARzMmtGe8iWI+LFwheD2HFss4
         szPkT1k3WoSSKJzNsI2nFgxi8pk+mpIBXz04yPOhpTeFyNe1wZ7924fA47AUQQGAm1re
         HAxg==
X-Gm-Message-State: AOAM5309u5z8CNUnFfr/Jy12A793oztsf02CkBc+v/e5odQepO3LbWx7
        +hAh6agojPyYFXO0q+Dhr4ndkPN/hCZ8CQ==
X-Google-Smtp-Source: ABdhPJwFaxf13pKy7qhwTRsw3PVetTSqZuRz3NLkcNKrbLVT2lq18zevUbQ/jMqmfIeCcmgWmYydFA==
X-Received: by 2002:a92:bbcb:: with SMTP id x72mr2612632ilk.104.1611624140939;
        Mon, 25 Jan 2021 17:22:20 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x64sm12895265ilk.47.2021.01.25.17.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 17:22:20 -0800 (PST)
Subject: Re: [PATCH v4 00/17] Miscellaneous fixes for resctrl selftests
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        David Binderman <dcb314@hotmail.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9df84c6a-3113-1f3d-5e61-cd68bc6f2d62@linuxfoundation.org>
Date:   Mon, 25 Jan 2021 18:22:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 1:19 PM, Fenghua Yu wrote:
> This patch set has several miscellaneous fixes to resctrl selftest tool
> that are easily visible to user. V1 had fixes to CAT test and CMT test
> but they were dropped in V2 because having them here made the patchset
> humongous. So, changes to CAT test and CMT test will be posted in another
> patchset.
> 
> Change Log:
> v4:
> - Address various comments from Shuah Khan:
>    1. Combine a few patches e.g. a couple of fixing typos patches into one
>       and a couple of unmounting patches into one etc.
>    2. Add config file.
>    3. Remove "Fixes" tags.
>    4. Change strcmp() to strncmp().
>    5. Move the global variable fixing patch to the patch 1 so that the
>       compilation issue is fixed first.
> 

Sorry for the delay. Please cc linux-kselftest in your next version.
I have a few comments on the patches.

thanks,
-- Shuah

