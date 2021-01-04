Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1C12E9141
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbhADHl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 02:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbhADHlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 02:41:55 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02923C06179A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 23:40:34 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id t6so14117768plq.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 23:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gkO4wZs2FgdAnD1CSmbghKQqG0ttWfnbDgOBZn/+SK0=;
        b=D6+RF/PzRVYdDbp9mVXRZkgt05lZoa0HdRGJaUPrO11l6JEOewUo9sGrnKJp0JNgxX
         4POzjUouMSaEkJq2p27xDPvg+5ijWyEmdf5pnItczrPqK51OZNq7N5eq6OIoVluRZbjF
         creiG91y37GlocoV+MNhmAx4dcHTrwnsIEG6/A6vysRbuchsfHe7/gGt/dBIgmpS2Wzw
         /e70y98Vovryj6fJVpAteYFt6iBaZlm3OKQOKIEBLSkkk515hA6eKIcl+kncJbYdnATE
         DVyx+eTJWdSzWYY1JNH1ppkIdH3q1uEt2C2YgSlh24A3+oyYw+8NCHxgIKFT1XAj/Cxz
         BZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gkO4wZs2FgdAnD1CSmbghKQqG0ttWfnbDgOBZn/+SK0=;
        b=dnBkde8MrQtBwo9T90+j1ujdabHqWXcaQMBxm+m7MLXPNDFxScjZ3906GGekG6yxMy
         Kgx9ylLFcNl8FUfH5U9HFcZByFvmY6qO78MrGTMsNcjmj5lDfgeKTVJtrVmohrvYxqkk
         og1k7w8l75ngu08fYt8gPDTJsPAQPyVE6RS1qt+Z9pliz8azSo6yStzP548+agStR9v3
         KujCtK0dgGbsKP74IaW4+j40bLar0zPhkpy3YLNOtSrmfEJU0AO08fneqnT6cTMZHlJL
         0q6A0Z1wXkeQYjqdD9zb/z+hrtUTKOqjukTJQG7x5NqMyvgVADJfwL4wH5aiRfEBPtvH
         8ZZQ==
X-Gm-Message-State: AOAM5315ywg7pV3nhQIGBL6bREd90Soo5H8RpxkhU8aMGvoTApOkKRsf
        8qocXFogiWBgHMbv28fH9eNJDA==
X-Google-Smtp-Source: ABdhPJyzODUMq/AyS4aF5tDIj0lxzfRVSiJgpUf3lUkc6Hi0IU7ZVuxe+GHkfVxWnfCCseGDVj9amA==
X-Received: by 2002:a17:90a:4817:: with SMTP id a23mr28191220pjh.16.1609746034333;
        Sun, 03 Jan 2021 23:40:34 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id b18sm55749806pfi.173.2021.01.03.23.40.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:40:33 -0800 (PST)
Date:   Mon, 4 Jan 2021 13:10:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 31/31] PM / devfreq: convert to
 devm_pm_opp_register_notifier and remove unused API
Message-ID: <20210104074031.k7njtbjot4r22flb@vireshk-i7>
References: <20210103035706.24168-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103035706.24168-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-01-21, 03:57, Yangtao Li wrote:
>  Use devm_pm_opp_* API to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 66 +--------------------------------------
>  include/linux/devfreq.h   | 23 --------------
>  2 files changed, 1 insertion(+), 88 deletions(-)

Remove the unused stuff in a separate patch and let this layer keep
doing the devm thing, I don't think others would need it.

-- 
viresh
