Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73204278E55
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgIYQYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgIYQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:24:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75323C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:24:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so4212380wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I5b2yYA2H4VM6u2qVjxGaHJdOStB2ElKEN8vnfRBiuU=;
        b=JC2GZgiwESKVcRillVvGHypsWw7t/2fF4DPXUTEW1axdMbkJJOXfI05bjVGjDiUchJ
         FNa3MdOl8MLfgYDy3U17p92epChx/2ZABKw3rMrOPld/YpwHr9Duf5u5u4vu+bWXrav1
         tZYTHQCl9s6qZuOLyAKZPD+LQfywXIWli/RPNvPvgXwV2yBF8kpe7266fU1xunt82o2F
         Mgb7v6cpFtlb9kwVAHGWaiYkq/t18t8ZmK8QCCCVhtjLi22+ByrgD4pdLoln5kH0FpDM
         iM6QgonnXBzrvR0yC4ay8Ir4ewF7FrTJyHzj0bUTGcB/Yu5zEjGFc8H26pgxYB30PX7U
         vwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5b2yYA2H4VM6u2qVjxGaHJdOStB2ElKEN8vnfRBiuU=;
        b=CsgMbfomYhr4mh9FDqwhy4kP50Ecz+swhDFWRRn0cxhCr7ZTATTw3jlKhDp9ousuo5
         7E3Ge5/bNaSl9xwedI0GYpQ6vm8RS5ilOLeuZyCR941LFaJw2bSkwPO1R4Zz30H3eEUn
         jrDV6fpD7lYDWSv0m7ZXjAVTjQObK5nIcQIrWzwdgtlYOcct/6sAnpW9yooezhIe4bVO
         VBrLc9YFZRLDJOWm1qyImQuzrmKlEe2/C6noUmFX5ypk8yExrD5e4kB8ko6qZ5oG5tVx
         Ovamtga/HjGxr0/1RtN4eeee14k+pnLjjON9QCf1DubV9xGmNThsZZA7c3DGgh8BdGQg
         xLdg==
X-Gm-Message-State: AOAM531HMLZiy9bp44bnK+/DkaxKKLDoEEo+nRPDfZgJ+BPBENjU7Dp9
        +T5vX6gGhHKueTGgIOvZfnk9sg==
X-Google-Smtp-Source: ABdhPJznA5uI0Mqe7T4SzwF0kpNwQkFcevBQ/k+9mJVhy2ipxF0AfU2ypVRZ7ErBn3iG0ItkIvgCPA==
X-Received: by 2002:adf:9b8b:: with SMTP id d11mr5723869wrc.71.1601051069083;
        Fri, 25 Sep 2020 09:24:29 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id k6sm3296080wmi.1.2020.09.25.09.24.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 09:24:28 -0700 (PDT)
Subject: Re: [PATCH 1/2] ASoC: qdsp6: Drop of_match_ptr to fix
 -Wunused-const-variable
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20200925084925.26926-1-srinivas.kandagatla@linaro.org>
 <20200925084925.26926-2-srinivas.kandagatla@linaro.org>
 <20200925161736.GE4841@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <04e564b5-2345-2e44-72f3-9a388e76b4ab@linaro.org>
Date:   Fri, 25 Sep 2020 17:24:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200925161736.GE4841@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/09/2020 17:17, Mark Brown wrote:
> On Fri, Sep 25, 2020 at 09:49:24AM +0100, Srinivas Kandagatla wrote:
>> The of_device_id is included unconditionally by of.h header and used
>> in the driver as well.  Remove of_match_ptr to fix W=1 compile test
>> warning with !CONFIG_OF:
> 
> It's better to fix this by adding #ifdefs around the table so that we
> don't have unneeded bloat from the match table in !OF cases.
> 
sure, I will respin series with that change!

--srini
