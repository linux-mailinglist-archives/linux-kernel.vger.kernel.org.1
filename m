Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E912ED226
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbhAGOay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbhAGOay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:30:54 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F285AC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 06:30:13 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id x15so6925305ilq.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 06:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lZ360d7dY3x4Jmcj9v1OSvGTbH537K+ABkcsuSU72C8=;
        b=rcvZNaCpiXJk5A0gg5iqqkJ8wwepUifSO4ZxnGjp+xbhpY4yvG0P0RAtM6v68zgFOG
         botTIOkAFdn7V0zMOYz145VF5DUKbky4pJeobP8BUDcQND/V744pvmDeoFuHjy6PtLfO
         A2icfEv0QkCuvv59EhNmnXNwxwjZBr8aiNdrNdc/A4mhDUk08WvbBr8L3Cz0XWujnI1A
         KnoKHhMEvzvqgyoEfzcLlpH3Mg2WGBRapFJV7yA85fmNSHEnLSKcT0ghauwoOEmS4x02
         7wMzU0eSo/WyciehLKr+OsZi/mjn2/506eEcDtEZMsJO+DFH/Ozp8+UVei8CEjabJQ98
         zd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lZ360d7dY3x4Jmcj9v1OSvGTbH537K+ABkcsuSU72C8=;
        b=S8YutVUXOzS0TZa7lZqs+J1Cc8lwkrFUXuMMmewmx1fiDSOZmay/9AMrh31sUfYOT2
         D5vL18YaO+mzUWLz3eyOGjILxIODGUw3KQA6D7XDyip0l9T4fOc1ShLh0gbtq4kkFSuX
         iukEoqxatFAvuVKCsos/esNikbpquSx78GBHHdksv/90HYod4WzpnzBGIgFRs+laKdyc
         Oy5xX2/rtGKyhHQwGIjxIsf0r2WFX4dejKoua8EYpV0omDswhy4pMhS3Of/uWgzRdQsJ
         TLh4VIVC1ez4qXnTBMUqDO57x6Hk1YGCZhvFp9UoVvMhptngDqEMIGiQnmdra49fgm7o
         nvvw==
X-Gm-Message-State: AOAM530i55okdy3EJiNqAKZ9CVpUIj23ERrYqtDk4PFgrECI/CcxLOlj
        pqL/YgPUKZxilqwt5RIl/fNO8Q==
X-Google-Smtp-Source: ABdhPJwm3VK3HntHK43XEXoAPkYpbM5dOSeaU4Wlzzh7ajTQcVlU6zolWFBvGElXenJm+wfSEkhO1w==
X-Received: by 2002:a92:bbc1:: with SMTP id x62mr7112810ilk.73.1610029813451;
        Thu, 07 Jan 2021 06:30:13 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id f3sm4527282ilu.74.2021.01.07.06.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 06:30:12 -0800 (PST)
Subject: Re: [PATCH v4 04/37] [RFC] firmware: arm_scmi: introduce bare get/put
 protocols ops
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210106201610.26538-1-cristian.marussi@arm.com>
 <20210106201610.26538-5-cristian.marussi@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <25d2e1ca-52dc-69a2-636e-211a21884f92@linaro.org>
Date:   Thu, 7 Jan 2021 09:30:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210106201610.26538-5-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/6/21 3:15 PM, Cristian Marussi wrote:
> Expose to the SCMI drivers a non managed version of a common protocols API
> based on generic get/put methods and protocol handles.
> 
> All drivers still keep using the old API, no functional change.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> These non devres methods are probably not needed, given the devm_ ones are
> already provided and any SCMI driver (user of the API) has surely available
> an scmi_device reference to use in the devm_ flavour...so the RFC

I agree. The protocol devices can use the devm_ flavor.


-- 
Warm Regards
Thara
