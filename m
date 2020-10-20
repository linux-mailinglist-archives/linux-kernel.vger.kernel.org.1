Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBDE281F64
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgJBXwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBXwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:52:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635B1C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 16:52:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d9so2466070pfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 16:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0DJfVPYB+sVtt5O1Oa8Zekpgikluk6DkPQtGUjAgJlA=;
        b=ks+IR8q3r+6/HLVgizvYpFbU+qnF/X4yPlu/67dItSrGoLaiBgypQx8xGSk2y3QL3C
         g/wn8tvlFnwHQNBn3lU7NupfGmOfXUy64ZKyNzVqMJVPAohEKvDvFHEqB58LQVLV0IZc
         GsR+MGvfzF7asnMMZb7iOhar7Zf9fFubiXddL6lODcZIA4PXw2XhWow70F4rhQcQvnDD
         47mGZcUXyMQS7z1KQpVXY3EnR+G9q4p3byrjW+MMqJ4hf4uOVPmG6b//o0P9EIQYuwqw
         wmqjNz7nW9F7eIKdo2aEuIK0zINsb+qSP6VZdp2lJ5TRTJucT/he1mA3td/PZJtX1VeF
         N+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0DJfVPYB+sVtt5O1Oa8Zekpgikluk6DkPQtGUjAgJlA=;
        b=IVzPxF+R9YQsCrH64bFI0v3rRGoEYIyq44dFzk8N6hiVB6tBKBW+zk5is7GQ3XqgLI
         1LgNdIyRDVqqodMkDXvkr3vNXIXmSqbA2h169LyRBsfOpLFkbUJk8LSN705Dy/zUI4U9
         x/yNmDMnUuQ/NuRzkIwyohw857IaaTCK35Rs9KDB9zwFaAs8uwyyCkVh5EybH7qPRvHe
         1/OlF+7SmGaVxH1cp8wpS+eC5L/zQ0/iUB76YJvc5yKf7VT0Yu+ZsxLVXmyHNp5kN2Z+
         LPH4yGSPk6wxbgU7zPrMsMS+Yk+6+SqCxQkbDM1BOuZv7yBGdQTiYpc5iFfSW3ExwMTp
         9R/A==
X-Gm-Message-State: AOAM533OjSXazztB3k0DnPiju5IZ6c0q7N5g3DWejztbdQCH+dWEdq4X
        OeV6F0l8PwaEVqjbPAN8/K5Z3g==
X-Google-Smtp-Source: ABdhPJy7K+Q8r0RzR7rSAzeX3kKVhmlq4kUYPcbn7wh1uB/vDrsgSEnR4qhfNLKOa5/U01XewwtSSg==
X-Received: by 2002:aa7:9ac9:0:b029:13e:d13d:a133 with SMTP id x9-20020aa79ac90000b029013ed13da133mr5067023pfp.27.1601682753874;
        Fri, 02 Oct 2020 16:52:33 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x140sm3270606pfc.211.2020.10.02.16.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 16:52:33 -0700 (PDT)
Subject: Re: [PATCH][next] pata_cmd64x: Use fallthrough pseudo-keyword
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20201002224852.GA463@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8cad7d36-b5d5-41bb-0f40-502720dc2e53@kernel.dk>
Date:   Fri, 2 Oct 2020 17:52:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002224852.GA463@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 4:48 PM, Gustavo A. R. Silva wrote:
> Replace /* FALL THRU */ comment with the new pseudo-keyword macro
> fallthrough[1].
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Applied, thanks.

-- 
Jens Axboe

