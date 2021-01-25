Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34225301FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 02:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhAYBUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 20:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbhAYBTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 20:19:23 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39C4C061574
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 17:18:42 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t29so7456453pfg.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 17:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L3uVyIQXg315cYdcWFUi5kSuy10il/YWLytcRu3EvKU=;
        b=xCHC0TeW5olhFVBW6SBSDbklWOHvyAC/fgRBJFg+QV/Q5ZqvnsCzJQdIeYog/GvYA+
         1FlflAU+h5Sv3UjYx7/qSst5YpD15GQvU71pZYe8ePM3LHf7kFNHWOT5y04CDdLR40el
         ftJQkDLB68lSuut4+JZEiF6z7FuIH/dM3Q15Ph7Hhfp9c+8AIVpmuuNERcDOSUosAhYh
         zfAeeaQ4lQrqaiFKx/jTGMBbadTTU4ZqAmvR58IdNsMNUC5N4BD2hBSmaHQkC1jILm+V
         Xwrp9hcTiZZYP3qSSCC6mLpDW0vrHJlkuHab4dCkhhTnUT3g2j3Rp9oFXActZiDaXc2A
         DoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L3uVyIQXg315cYdcWFUi5kSuy10il/YWLytcRu3EvKU=;
        b=rNp0ZaIRtdq06vKji7sPS1zQ8bWjAA9WvTmqM1Je83Svc1Bp1jnuyb3jY6A3BOP9d8
         LmY6huHOLjFXLM5rG0aVXApGRHrZvSVrq+3TLDD+QyvzJ/1afftA41zyf9oKCUqBr7PW
         DWkncsmh4jY3YbcQbYhyYSUjyFAgGXzYiHXL0YXXCVbnOx5WPwwPdsLQ0BHDDBnvzTkY
         OuwBcxSnaYEGIWMo3G5i0NwTNFrCA3tchf36mg9PfLxp2cTt9hfhiO77l41Aws1cJTam
         XwE6JpAEwebRFR9vsMrXnpCsQ/wGUwWCOg9dm5TBpiBQHog04WyeENV1th5QELAHPako
         91aw==
X-Gm-Message-State: AOAM533m9oRaQCDiwhoDNYgEOhLiVkFhoNUY9il4PCc/ATY6Zp/cj6IN
        g3tVIorA54RYyjFMNKlkRWnwRFBXpSq8tw==
X-Google-Smtp-Source: ABdhPJxFWePCWmfNnsY9gw6UORyzTKjMRFWUXJ9grK/iqp7aHvcQXCH6VKSMOOKg59exGpxH5JsEmw==
X-Received: by 2002:a63:c702:: with SMTP id n2mr277682pgg.382.1611537522118;
        Sun, 24 Jan 2021 17:18:42 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id p13sm16036771pju.20.2021.01.24.17.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 17:18:41 -0800 (PST)
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/6] block, bfq: first bath of fixes
 and improvements
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210122181948.35660-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8e024512-992d-1f9f-2fba-5f51103b706a@kernel.dk>
Date:   Sun, 24 Jan 2021 18:18:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122181948.35660-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 11:19 AM, Paolo Valente wrote:
> Hi,
> 
> about nine months ago, Jan (Kara, SUSE) reported a throughput
> regression with BFQ. That was the beginning of a fruitful dev&testing
> collaboration, which led to 18 new commits. Part are fixes, part are
> actual performance improvements.

Applied, thanks.

-- 
Jens Axboe

