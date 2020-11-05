Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371B32A8242
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgKEPd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgKEPd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:33:29 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D43C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 07:33:27 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h22so2027896wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 07:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xhrjppuUR0U0zAdxI1i2VBSzdI0X93cvA2RDgoE5I/A=;
        b=zxZc3zaO6v6Ddh1V6Q4ZxA1WVv4sNQLzg41jV4okODDkGaLnh8Aq6DFsKM3pugZP8a
         N+yoonk4CK+3CPMqlQwutZPy1lRYYeuCjgCIfrBJXEVCzDgYIJV2crfu/S94tUSV8noG
         6d5xv/IYcYMq/ChWrWBPEq6oT6cTzgvkwyPgTrLQxhMV8nCS7kW1SqP7tkJKD8rrYrnv
         r5z8VfRXYix/lE9/ftDshpoq2ib1DqkbHjWEZyARa0eAt5sQRIzYec9LMbxcPHPd37kl
         Nq0zpHJhu1X5yVL0t4020ZfYn4bxSA3mamOgeajxDqfGBh44DGR69y2uOFuSplSXfNNv
         QAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xhrjppuUR0U0zAdxI1i2VBSzdI0X93cvA2RDgoE5I/A=;
        b=Ndv3u3z33qz+lDkDsWnJrnlzPsXREC0IBMPOlknPplPcstlsQxEYwxtkwchMEuYQCe
         fY7oRCT8TzCnnHqjNHdf5Py5LsHVWV3nRvzqFIR327dnKB0pvkLKRqG8iKA1dP+CrOmd
         bwW17psv9+2jKLYL//CnpEDo4ioniw/ePL9ZugNieru6v7K1OKt45pQilFh4fJCSxVAy
         LzItz2+jlLXJq6+Y5vIMvKT4AUg6TdUzvRw/f/ImCQaY4oTiuvtgt3BNLwrnFfTI8q5j
         Nd32YWlLfjhE2bSvGOllXahyQmbveSAK+vEfGhehRjUUJFC+wdIhB9q0DX0/9NhGkFZW
         P3bw==
X-Gm-Message-State: AOAM5328Al86X5SsQYTsuAsQAjYWSxxWdm5uhCplwj1WLXwpeemJ6G4p
        KLXzyRZG23XnGBL7du5MCgZue4sNWLCAxw==
X-Google-Smtp-Source: ABdhPJwrFY8AfEYapEVmWWqIKBxWdMhOheQYqFNnfrUWlekcEp5NQpECShJOrCNQ+4pvQY6zwY4q6g==
X-Received: by 2002:a7b:ce0e:: with SMTP id m14mr3494256wmc.17.1604590405844;
        Thu, 05 Nov 2020 07:33:25 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-142-252.adsl.proxad.net. [82.252.142.252])
        by smtp.googlemail.com with ESMTPSA id s202sm2809098wme.39.2020.11.05.07.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 07:33:25 -0800 (PST)
Subject: Re: [PATCH 1/5] cpuidle: Remove pointless stub
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20201015144431.9979-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gPYXhqP4CF+ep3tE7ov5zza0FW9_9cuDsiqznUX8CTCQ@mail.gmail.com>
 <8fef63ad-a081-e543-0c18-3797f3aaf1be@linaro.org>
 <CAJZ5v0g9d+Y2gGXaXiAiCFjJ=VmdCq+HBCkke4TbKqKkyXrsDw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <91e5b5ad-12e8-70a3-d476-f1d7ad734bb0@linaro.org>
Date:   Thu, 5 Nov 2020 16:31:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g9d+Y2gGXaXiAiCFjJ=VmdCq+HBCkke4TbKqKkyXrsDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

On 05/11/2020 15:14, Rafael J. Wysocki wrote:

[ ... ]

>> [ ... ]
>>
>>> Applied (this patch alone) as 5.10-rc material with some minor edits
>>> in the changelog, thanks!
>>
>> Does it mean you disagree the other patches? Or are you waiting for more
>> comments?
> 
> Actually, both.
> 
> My primary concern regarding the modularization of cpuidle governors
> is that they really belong to the core kernel.  They access the
> internals thereof and the behavior of the idle loop in general depends
> on what they do.
> 
> OTOH IMV a potential benefit resulting from allowing them to be
> modular is very small, at least from the mainline perspective.
> 
> IOW this case is very similar to the modularization of the schedutil
> cpufreq governor which we decided not to do for similar reasons.

Yes, I recall this discussion.

The purpose is to be more consistent with the governors in the other
frameworks which can be module. But as you mentioned it, the benefit is
small, so I'm fine to drop the series.

Thanks

  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
