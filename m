Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635C52F7746
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbhAOLN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbhAOLN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:13:26 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A9CC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 03:12:46 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g10so7261333wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 03:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8hOPqiKxYh57wkKCGDlQE85ouMI8Pjq2OXu/MBK/GBo=;
        b=ETWqj32EUC/lVfGcEnrERegA0IfyyyfTQBugipiNDz9oezr2FUyXSgNjERTQhyzitT
         5zXV13jV2QfbErvJHqnJXkiPYsBMkih9apQHrrKK5OK+P2cn+nFP+Ujs56tF/3J76dwn
         keVommed8cXFUXxwKiyD162/yJ7T2BFhSzJjfZe3D2cGa/KQRowm71sEduN6Iv7WOasG
         YTMzC/kSxrOXgZqq9HUGrcg/gKygcFJ5m/Qoig8NtSgjLnr+xtM+RSMJwkjBGdQK5Bzn
         cCOQaIHk6N7aTrEH9W75pdoX+e69sE1IfFRjCJiB2kaTalfRhTLmS02MsZN+F2WBV+C5
         Hndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8hOPqiKxYh57wkKCGDlQE85ouMI8Pjq2OXu/MBK/GBo=;
        b=mC8mUEZ+TIFTgOeiPqAo4QjjwWhK1AWV7yLIu4Fih9bADTfuVg241Rjqe2CNxjPui3
         l7nKr3BIjW2QC/QkE130cPzHpWjnkTgmOIwxCzhw+WjIMTDJRkgH0QKuDt4XouVBwVW9
         WwUQLlsEkdvUYQEqX6knn8/FYUWmHDz/hxod43f35BYpBRP7HwbSSwSuHIYAwbDV/Bf7
         YdUGXiJEcmdY0V+jRNOVJyKICRG8u6xX3g1ZoVhhMGFj1wsKWmaXS79eLjJR/FOVxE/k
         o9m7QOkWEDxXk4Pk5Qk6v+Cm/h5p2FkbrkYk4Hq02xxgOeGZZ0yu8wyLvSodoU0oAHjn
         7vYA==
X-Gm-Message-State: AOAM531BH9XzSYXw3Awlu5r7DWGSCpk92AG8bM41/ctps+XkKnNoXvGN
        oRZ2JUjupe88aIHCzrKsFH9SLw==
X-Google-Smtp-Source: ABdhPJxZxPpbEPACV3JGhyB3zfkvu0YT51nxUVRM08/3jMLDRr4l2mATYKPVXAsaURWiMAg+h9NBGQ==
X-Received: by 2002:a1c:9ad5:: with SMTP id c204mr5322138wme.65.1610709164628;
        Fri, 15 Jan 2021 03:12:44 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id f68sm1305763wmf.6.2021.01.15.03.12.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2021 03:12:43 -0800 (PST)
Subject: Re: [PATCH 0/4] ASoC: qcom: Minor code cleanups for lpass-cpu
To:     Stephen Boyd <swboyd@chromium.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
        alsa-devel@alsa-project.org,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
        Srinivasa Rao <srivasam@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
References: <20210115034327.617223-1-swboyd@chromium.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f60d2cf1-7952-3e85-e988-53e6b91ae75a@linaro.org>
Date:   Fri, 15 Jan 2021 11:12:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210115034327.617223-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen for the cleanup patches.

All of them look good to me!

On 15/01/2021 03:43, Stephen Boyd wrote:
> Here's some minor code cleanups for the lpass-cpu driver. I noticed that
> it casts away const from the driver data from DT. That's not great but
> fixing it is a little more involved. I'll get to it later. There's also
> some questionable clk_get() usage that should probably be
> clk_get_optional(). For now this should help a little.
> 
> Cc: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Cc: Srinivasa Rao <srivasam@codeaurora.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Cheng-Yi Chiang <cychiang@chromium.org>
> 
> Stephen Boyd (4):
>    ASoC: qcom: Remove useless debug print
>    ASoC: qcom: Add some names to regmap configs
>    ASoC: qcom: Stop casting away __iomem for error pointers
>    ASoC: qcom: Remove duplicate error messages on ioremap
> 
>   sound/soc/qcom/lpass-cpu.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> 
