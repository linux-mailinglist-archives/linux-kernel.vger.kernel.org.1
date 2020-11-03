Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2982A4532
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgKCMbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgKCMbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:31:34 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B98C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 04:31:33 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id g12so18333103wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 04:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E4q0UVRWHDw6iml+4AQxHUz2AjltU3NCXpBdYF0ga1k=;
        b=iXLvMN+XhQHAMsuAXuGCRdjjvoIuaaf1quA0mO+SCktQa3VzZIwYhBGiEhUfIbP1Q3
         mmTixznUa42MmG+ZO/uU5/onQ3JZNEW/zS0hoyMY/YGm7rPRLvxNwjB5yFChPpPut2Os
         9MKiYQ0N/ABae2iLkt01R6FnSqz7GBKF4HpaF6Kg/lX2ZUnLCbi0UosL/E8x1NnJ+0jt
         p4lRKsZitZXJTGUfMkTcExJyTGKdCNL0SWqeuqHKxovSvFyp2bf3topBR9ep1SPtajEW
         z29dYz1i+YeY/TpWuDSmrehaUkhQPFGAsitqiT6TxBa76I0QeFTY8aVUP5VioCyhNldM
         pQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E4q0UVRWHDw6iml+4AQxHUz2AjltU3NCXpBdYF0ga1k=;
        b=Ye2FQ4TjLVZIH45iYcIvek9eGIfTXx5wuS7jDdSoG3eABlTMWp2K5VkRFRfezRun30
         zPRhWo/Zsm2PYdUjzJsCCiSGqtVqEZnm2INM68seXcZ4mursrcSGjQAY6Uwn+n+5kX7j
         0n1nGkU3u6WMzUUbqk09nRe9ZjBiuBaejyo3RqclWra5z7L2Nz5FGcp5ptNKHeIK7YoU
         fYgCbCXLKD83TMO6oJhEKPvIkaJyy+TkLs9SWkD6n0eFPxuzeYcpihPdaGfk/d/rm1Fm
         uMYXp1PsvrHY1QUVXQtBa/QHItpSrb8QOWQ5so86ACG+lZhWzl0/kKzlydfrtgGRmNrg
         lZ+A==
X-Gm-Message-State: AOAM533vIRWas9N4q51fc8g/xBraV6Jb+kMKaxY30uYuKXHIIjZrio/i
        fnxS90PS65D+bznPC7CPMFRZ1g==
X-Google-Smtp-Source: ABdhPJzSPSDGa9kUi5UYxDLAC5pDt5KhWo2oU1jT26ssFfWZvBuXgFCXhFfMDz2Aox0CzBUWSkVFSw==
X-Received: by 2002:a5d:5548:: with SMTP id g8mr25866831wrw.364.1604406691783;
        Tue, 03 Nov 2020 04:31:31 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id z5sm26202673wrw.87.2020.11.03.04.31.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 04:31:31 -0800 (PST)
Subject: Re: [PATCH v2 5/6] ASoC: codecs: lpass-va-macro: Add support to VA
 Macro
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
 <20201029110829.16425-6-srinivas.kandagatla@linaro.org>
 <8f33aac3-7a41-1482-ae8b-e24d13ba8f13@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <da9658c1-8ebb-9501-0226-613d18a3efa6@linaro.org>
Date:   Tue, 3 Nov 2020 12:31:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8f33aac3-7a41-1482-ae8b-e24d13ba8f13@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for review,

On 29/10/2020 15:56, Pierre-Louis Bossart wrote:
> 
>> diff --git a/sound/soc/codecs/lpass-va-macro.c 
>> b/sound/soc/codecs/lpass-va-macro.c
>> new file mode 100644
>> index 000000000000..8cb23c32631d
>> --- /dev/null
>> +++ b/sound/soc/codecs/lpass-va-macro.c
>> @@ -0,0 +1,882 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
> 
> Missing copyright information?
> 

I will recheck this on all files and fix it before sending next version!

--srini
> [...]
> 
>> +module_platform_driver(va_macro_driver);
>> +MODULE_DESCRIPTION("VA macro driver");
>> +MODULE_LICENSE("GPL v2");
> 
> "GPL" ? The v2 adds no information.
> 
> https://www.kernel.org/doc/html/latest/process/license-rules.html
> 
> “GPL”    Module is licensed under GPL version 2. This does not express 
> any distinction between GPL-2.0-only or GPL-2.0-or-later. The exact 
> license information can only be determined via the license information 
> in the corresponding source files.
> 
> “GPL v2”    Same as “GPL”. It exists for historic reasons.
