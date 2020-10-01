Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEFC2803FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbgJAQae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732046AbgJAQae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:30:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A486C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 09:30:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so6548624wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 09:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XtlmhI5MMBvdoOpCkyeGrgEGBRU6BMxnStn3nwkWSfU=;
        b=x0HM+xDewksbxdUYxycAr0jhOm9NOUt2M4ft+mq4eP+W+iqnRhoFrV/sAt2P+2GpJM
         wsTwE5/ua1YX7ixEvZ3VJ9l0uKOWkSL07fU0VBBovoBDZUsKWm/NJAxRRRweyfZ//eAk
         56D68CX+Pcsxw4VByQYCY9AHDdq7UfPPhx1SoluEFHnH8H0svKTp0CzboBvvZXR0rh2O
         pSK1zpaH1zywaLESSuDLjlcDWHLqgfVruhoaROn+MtV5AoR24LliPi0PG6x3l6mhYF4V
         MwLFSBlTenVUuW1kfn0ZaHQ7rnUCCthVUkm7/El7MjtrhKhZAqSg6267FzIXhmWHtGRH
         ZOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XtlmhI5MMBvdoOpCkyeGrgEGBRU6BMxnStn3nwkWSfU=;
        b=L5rE+z7F6EKSUyFAW0U4Pe7OeGxSe6xqs7BE0WdJyr7WNWXxzK2qIgShQaZ+eqvFBE
         uCimGXmR97xtVIcDdmgJMcoWixqdSGQxAXJINPMyvZMPpCA2lNiZvvs4vd8F2rIjMgjF
         emTVxqTrnd7njGyIZOEvnce+EPbMOlzQ2etNTjRHPnKVShSp/EH9gIfOcNQZ5GpbYbiI
         11PfnhoT0nGPSojaiOkGRkVDB4hwpVbnkuuvuk8NA0pU9XHpyTYx0GWv3L12BLCY5JiB
         t1iskUPbxa7LGdhdmpCN+5g0xuNvYkWm0J7wTDBulNomaKp14tE0sNAzT11d/tra8Oax
         RlrA==
X-Gm-Message-State: AOAM533u3cH2mWEuP7DKcw4sQoXikE38wCqmp103uMnIJtQ2aF4kpUoF
        O5BOTL6ufE5dWNSXTOtgGiTev2n+jqs33g==
X-Google-Smtp-Source: ABdhPJy8c6TkyP+pEsSziABm6brie5sLeN5zs4qUe6cnqbweAmadV3RQBhHxQbaO9LlCB841cM7R4g==
X-Received: by 2002:adf:9e05:: with SMTP id u5mr9898255wre.78.1601569832095;
        Thu, 01 Oct 2020 09:30:32 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id a5sm9899410wrp.37.2020.10.01.09.30.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 09:30:31 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvmem: qfprom: Don't touch certain fuses
To:     Evan Green <evgreen@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200929205807.2360405-1-evgreen@chromium.org>
 <20200929135741.3.I1bb1b0e94be3b792804e08831d6a55481e162d63@changeid>
 <8f467220-3ac8-c8fc-33fe-8d86904571fe@linaro.org>
 <CAE=gft5FoWpscS_9CfuCNSZxsq_CUu_AShQ=tLiW=NGL8YG5tQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d79de840-25cc-0e8e-15e6-3cc2fda2e38b@linaro.org>
Date:   Thu, 1 Oct 2020 17:30:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft5FoWpscS_9CfuCNSZxsq_CUu_AShQ=tLiW=NGL8YG5tQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/10/2020 17:27, Evan Green wrote:
> On Thu, Oct 1, 2020 at 7:17 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> Hi Evan,
>>
>> On 29/09/2020 21:58, Evan Green wrote:
>>> Some fuse ranges are protected by the XPU such that the AP cannot
>>> access them. Attempting to do so causes an SError. Use the newly
>>> introduced per-soc compatible string to attach the set of regions
>>> we should not access. Then tiptoe around those regions.
>>>
>>
>> This is a generic feature that can be used by any nvmem provider, can
>> you move this logic to nvmem core instead of having it in qfprom!
> 
> Sure! I'd prefer to keep this data in the driver for now rather than
Ofcourse these can come from driver directly based on compatible!

> trying to define DT bindings for the keepout zones. So then I'll pass
> in my keepout array via struct nvmem_config at registration time, and
> then the core can handle the keepout logic instead of qfprom.c.
> 

Yes, that is inline with what am thinking of as well!


00srini
> -Evan
> 
