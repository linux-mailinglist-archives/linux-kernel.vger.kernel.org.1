Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1928E2832D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgJEJMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJEJMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:12:36 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109A0C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 02:12:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so7974718wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 02:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6izeXoM0ljycw7P6ToTrkE6R0CPiIFhMYIDr3ZU/XTM=;
        b=r1eIBi6u4R71qNHnmPX4aS2VLe5lgH3XD7b5Ynk9QA7M3YPjhHnIqPH4vEPNXpIsxo
         zIChZz3b4hna6vx27bsLcZmlQx9u3YsJv4VGLjbWzGUWs6Zqe8SrU5I+Qi5eNmaz++jr
         /YyXlXf4Ump2vV7N+7heoG7hvFiKX0HptCED5j/f3enDSecIcTP/hFBE3zP889FJxzFE
         TaSA7COljVn5lHAkymJeokTAoNjQ98/wtLd+3ev7A7AKCyJAwpgsMXCeweXfJUYQuQMA
         uBYPnTQU/A+uyblCRfhmgDXVotNB++7l9mKHrV0nqwck8y5Ua0BUYPmLYL/rvCr9IuWb
         PSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6izeXoM0ljycw7P6ToTrkE6R0CPiIFhMYIDr3ZU/XTM=;
        b=aZKnIGN+Oy+NYYrFkLfF1bmLe03EA+j7zD5J0N2h6Tfz77Nv+ivN4o1e+EdU8Kr5/U
         EgbIrGanbgwpoTheYxxQL05XZOUSL/cufHkPjCqGqD5rNo/8rKKMEHLKEP0d+zyPub+1
         x3z4dHNEAaeshIKg3TsPcSYG9lOVEDYQTgsog3LNQD03TnVjsVOA6xNnwCmDiS2ZqgUd
         8oZgO/41DklY7HpKLmrzRHMptrR/jLHJyxCpsrTS65qVK8U97L4OL1buh1c9ws10P+XU
         M0wWUTxJaI+81+9KRmZsFX7GUrB/t0uL/9cg8yEYVNgB+MxMJeOefbozHAdKenNwMe6Q
         K/+w==
X-Gm-Message-State: AOAM531kkgk56AfXknR4aUNT0G9mM2UAlH657MATcXkXMYu1GQ0ZsCSL
        wBwXy0L9KgX5kh7PunqL26fyjdGFHdu6Og==
X-Google-Smtp-Source: ABdhPJz93/t0WL86Acn9stDrA0eTBzE1JCCCjWQysCBKgFc95AMBSul4CGySEyxsKvINZiaFPzLmTg==
X-Received: by 2002:a1c:e48b:: with SMTP id b133mr15590497wmh.0.1601889154497;
        Mon, 05 Oct 2020 02:12:34 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id x2sm12153651wrl.13.2020.10.05.02.12.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 02:12:33 -0700 (PDT)
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
 <d79de840-25cc-0e8e-15e6-3cc2fda2e38b@linaro.org>
 <CAE=gft4eDRBSuAQmiZQs3LegVyERWAJSmvmHKEY1N=z5HSViJQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <14b62a74-4b4f-42b9-6043-ab8445a3f627@linaro.org>
Date:   Mon, 5 Oct 2020 10:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft4eDRBSuAQmiZQs3LegVyERWAJSmvmHKEY1N=z5HSViJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/10/2020 22:49, Evan Green wrote:
> Oh no, I realized this isn't nearly as beautiful when I try to move it
> into the core. The low level read/write interface between the nvmem
> core and the driver is a range. So to move this into the core I'd have
> to implement all the overlap computation logic to potentially break up
> a read into several small reads in cases where there are many little
> keepout ranges. It was much simpler when I could just check each byte
> offset individually, and because I was doing it in this one
> rarely-used driver I could make that performance tradeoff without much
> penalty.
> 
> I could do all range/overlap handling if you want, but it'll be a
> bigger change, and I worry my driver would be the only one to end up
> using it. What do you think?

I still think this should go in to core. core should be able to avoid 
checking by the presence of any restricted range, so it should not be a 
overhead for other non-users. regmap has similar feature we can take 
some inspiration from that code!!


--srini


> -Evan
