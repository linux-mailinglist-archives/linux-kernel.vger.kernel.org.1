Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB0723436A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 11:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732182AbgGaJlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732088AbgGaJlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:41:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3725C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:41:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a5so17423116wrm.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=blK2S6cH6qikd/XbUA6HFppZyi5UmFkTzQjVm4HqLu8=;
        b=qYJcKTPWZ/tbOoxgiSar9u8OlLsqIHNM2w7j0r/MKDA9uWzeRrLmOrBQMNLyThxO8+
         WdjRAwWDyig9Pe2KYm7WTkfn16dgYWGhGWWJJpdNH3oVhT54Hhbn5MA04BN3B4Vfcxx7
         BGQwJZkoPmj/pniMy9VKUAG5drnY86/yjhvW5zMMZejVLSbJbn36KxPMwtVQ31om84DV
         7gP3+QlT/SHSP0gwvagI6Oo/WOlba0fNglBmXUk1QuET0uUBN41VwqZeBVk+9L57rGGc
         Dl00XU9ZPofnh/BPtIbyJtimImNfx6bzbN1rjoegQyLThRCRMlX2/DLKVIWBDTXFDUaW
         tcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=blK2S6cH6qikd/XbUA6HFppZyi5UmFkTzQjVm4HqLu8=;
        b=mS01hdnvwRIABgponSFDEixGQL7z5Wc68/5DwmcQDvTCwDB4RP0i1BxOwCQo9pfe3x
         mNrnjrUhJGSgbveoP2v5NyFNCyAoDU/JUa5QqcPQVKFd0EYFpbBE+iA3mIXRoKCj/n50
         CCeS8JC/X9gwc+/rLVGB4SQPYkqqReO2LGA11b+rAl2/TT9pLO/ktYtVueqqtyys1wJ5
         LF9bW2u/KfJZxwempdLcN1zy2PMRUmGCjgHCyH2nnojuCGH6fcVPaP87q9+Fd75Ptc2K
         JggdusiPxhC+7J0PHTYNknsgVLzuKJ/MJKBh4caFw/hNYBxESKE5AMwefV5g5IOs345x
         yDMA==
X-Gm-Message-State: AOAM53380lMed0Z/2mXLqIfieJZYYZXS7AIxnHqDX+PneahQFRD8sxYd
        fTvw233BvZQxvaUK3n2gvvbHJw==
X-Google-Smtp-Source: ABdhPJwNSLofjJwuFuHlU7XMv9pf4+e12egPsBdGARtG7JOGdvQEnjlxZrj7kRD3mLXivOz+KUA1JA==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr2772718wrt.67.1596188477304;
        Fri, 31 Jul 2020 02:41:17 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e484:a7d1:6931:9059? ([2a01:e34:ed2f:f020:e484:a7d1:6931:9059])
        by smtp.googlemail.com with ESMTPSA id t202sm11904350wmt.20.2020.07.31.02.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 02:41:16 -0700 (PDT)
Subject: Re: Aw: Re: [PATCH v2 2/2] thermal: mediatek: add tsensor support for
 V2 thermal system
To:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Henry Yen <henry.yen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Steven Liu <steven.liu@mediatek.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Kao <michael.kao@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1588238074-19338-1-git-send-email-henry.yen@mediatek.com>
 <1588238074-19338-3-git-send-email-henry.yen@mediatek.com>
 <f086c86e-7d7b-50c4-baf2-66022301adc7@gmail.com>
 <trinity-a82d184c-1a5a-4f73-84c7-bcba3d84d5a4-1596131147519@3c-app-gmx-bs42>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ccfa7b46-1663-3891-a7fe-76759c708a6d@linaro.org>
Date:   Fri, 31 Jul 2020 11:41:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <trinity-a82d184c-1a5a-4f73-84c7-bcba3d84d5a4-1596131147519@3c-app-gmx-bs42>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2020 19:45, Frank Wunderlich wrote:
> Tested on bpi-r64 and r2, i hope this can be merged to next / 5.9
> 
> Tested-By: Frank Wunderlich <frank-w@public-files.de>


Thanks for testing, applied for v5.9


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
