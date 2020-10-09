Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CCD288119
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 06:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgJIETR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 00:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgJIETR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 00:19:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59CDC0613D4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 21:19:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so6117973pgf.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 21:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+2sSjHIG8dOPiZAXe+oXr0N+ieiRQzjEGoSV/P6Yznw=;
        b=MOnbeaq1cy1kAz5S/jKS4LOB5ahZWaJg+qQvOwJnOIb83e8inibG+ODF2HH7uDVP5i
         fplFUgs4IWxPuRzurmPhJcqSqvAq46+3tSQZjV/qrVul3Q00g0k1zYXsPbDvx3wucYrb
         tVNVNBzoEa+h6c1oZuDDrzBX2fZ2tlrbPrhCn/29POB7XdFWOmSe9/Ytiloiq2MpLGKk
         kWx2xTFyGdqoDk6M50to7YNY3GbgkjrdvOwLZ2JS1dBq6/kfwYtGKZSOJRKzuFI1GCVg
         dK5yPDcbmNBpE0xTtocEXCCf3to9O9V6Ba87s9PjMdiylDce6zUCPz1ZJcj2QtT5Aid7
         Mrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+2sSjHIG8dOPiZAXe+oXr0N+ieiRQzjEGoSV/P6Yznw=;
        b=fTLV0Jkpo0/OuzR73RCmXv3buiFVcMdFwQTzK1PWBO0d95DqjdW+xfOv0ARqg36IWY
         WKMl1cxBi7PdxcMZBHbIgOXH4Hj3j1COvzQu+vAh15cQoLGpf5MLcNIRhIAIYdyQvUCo
         IqqFhmML4G7iG09BLMmruswvvGDFJE2w8R7L9Zwe8EEsLy1qALC1oy3tFRlurdVIF3gY
         dxcWt5frjpf81W9QCeNHVpA/XillKtKsoDNF8d88DsXI4KJLuszxtPDVcQ9ABpU2QhlW
         NoXc8YVTZupEUFtRgqwXE59LK6j8X0WiJgoAPwclGxbDQCJ0OftKemqDXoHFOncOeMcD
         LFxg==
X-Gm-Message-State: AOAM5306KyBu4P3af429orF+25ZRj5griPRk+H/StrYM6alITnDF85q7
        Kk2uQ3cBuZaJUJPcoX4ScKnDvg==
X-Google-Smtp-Source: ABdhPJyEnLl6570MW2KAL+ArDB+3JofV5hbzqNgTbWceck5uYpjyF/d6pt5DalGfwkLIx00gqPMl1w==
X-Received: by 2002:a63:5914:: with SMTP id n20mr881066pgb.69.1602217155135;
        Thu, 08 Oct 2020 21:19:15 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id o2sm9023889pgg.3.2020.10.08.21.19.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2020 21:19:14 -0700 (PDT)
Date:   Fri, 9 Oct 2020 09:49:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v1 1/1] cpufreq: mediatek-hw: Register EM power table
Message-ID: <20201009041912.nzhvubzmfox2twxg@vireshk-i7>
References: <1602159204-13756-1-git-send-email-hector.yuan@mediatek.com>
 <1602159204-13756-2-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602159204-13756-2-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-10-20, 20:13, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Register CPU power table to energy model framework
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq-hw.c |   50 +++++++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 12 deletions(-)

I don't see this file in mainline. What am I missing ?

-- 
viresh
