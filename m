Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7272F713F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 04:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbhAODy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 22:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731101AbhAODyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 22:54:55 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A4AC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:54:14 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id d203so8323601oia.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KilXjYXgOknxPMpyJrFa/IXBlfSwILUA268Eh87hM2k=;
        b=WY+GmoR5C4tCejAMKcYNEFtJsEPci4lS0os/Pow8I7WHHaodrxltpjg+M2ySQM65IQ
         M7VpFGKCO1Xe28pZJ07Ete7AF17vcyrm3Ok+UPmnojhT6uaVVtsW7fbjJ1xB3PLpxaeV
         8wtXq7T+tLM8GHD3LgzrRS5iiiKRVx76e7TWke2ex33YsoUdFsin2olon3DhKKMyj3ml
         BOSNepbAxIilUNQdMgP6vyqWl0IwZjCSlq7vU9EkbMDoB9xU2qUgmrhzICFcjBK1JBsi
         Gu5TFetNatiWUuIPYgHaHPr87UKI7QSNZH/e38/1WvahXSrYW6C8jktzmsRVN2JM5qbT
         9+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KilXjYXgOknxPMpyJrFa/IXBlfSwILUA268Eh87hM2k=;
        b=QUNhaVYvPZBLeQfNihDoEHF3Q6JzVasqn1YaBjGPbsnj9OUlueN23jmbpgRyke4byE
         c1lTr4vdXanvZKv9HGw1OImmDS+YqAo7sS4d08y3CcuC5xpQY54QZHu+Jl3/5vQhIdnO
         I0VAEw6v3Lqvs6QRwXhA8Jik5/RjwPZbmEI/dqzM9zNGJS+kBTIOp9JKUoc7IJGOL2xK
         u1Z4qNA5R49hXwIJ39y7/k2fx3Dt34f4mOqvLZqgFkqkyeN2/sZhomfbrdCIkpLTwm29
         OlM/AFrjGzdwoH5rW6xLgCgNUhnoOFlM7PzldU7hwjWfQZ04MriQfSMKVoQK+7z/AJW3
         OgaA==
X-Gm-Message-State: AOAM533Tn/YMkj+3B6nyg6Jh1xmYl4Ne3ayXiz8x8oETjuUawIQghfPT
        DCp389WdJDeTTyxBB8a/Nha1FA==
X-Google-Smtp-Source: ABdhPJyCqlLx7gt3hFbyb3n/njPbfgC8H6Bn8X8UIe7UFehW4jaB7yn5kkxwPfNsyR42pmXmt1TN/w==
X-Received: by 2002:a05:6808:16:: with SMTP id u22mr4504901oic.1.1610682854286;
        Thu, 14 Jan 2021 19:54:14 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 73sm1546888otv.26.2021.01.14.19.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 19:54:13 -0800 (PST)
Date:   Thu, 14 Jan 2021 21:54:11 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arm64: dts: sdm845: add oneplus6/6t devices
Message-ID: <YAER4xpcq0Rn9UgD@builder.lan>
References: <20210114185227.25265-1-caleb@connolly.tech>
 <20210114185227.25265-2-caleb@connolly.tech>
 <17d49d19-7672-520c-12d3-c6ed8c12ae47@somainline.org>
 <4db0807e-c33e-5913-1818-1fc055e35acb@connolly.tech>
 <1b023774-d091-e7fd-8eaf-dedeff5feac2@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b023774-d091-e7fd-8eaf-dedeff5feac2@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14 Jan 14:33 CST 2021, Konrad Dybcio wrote:

> 
> > The device definitely doesn't support USB3, although downstream does 
> > leave the USB3 phy enabled the hardware doesn't support it. So it made 
> > sense to disable it here.
> 
> 
> Sure.
> 
> 
> > OnePlus' bootloader doesn't seem to care about these values so I left 
> > them out for simplicity.
> 
> Sounds strange, but it's not the first time vendors surprise us.
> 

This particular requirement seems to be rather random. Some board loads
a single dtb without these properties, others require them even for the
single, appended, case.

Regards,
Bjorn
