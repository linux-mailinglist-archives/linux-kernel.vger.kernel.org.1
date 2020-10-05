Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D18283BF6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgJEQEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgJEQD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:03:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58380C0613A9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 09:03:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f21so49704wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uo220a6rdlw3GxUuDIlr3sYYY1g7LV9qmd8uQhsVPEo=;
        b=lODvluOe5dzSF58N0UVpCpmhQlXLxHfuNm5BS1+EKic7A6XyT1oJPsMhXrt1qqTrWo
         Diixboxg6cBWwo8ja+D+F8Jx22w/6R9HZQ21BHmRuPiUNDILPeobf+WCj33QPLiUuuX0
         4Cl/PN/elZodhinZlIt4e+w4XerCOyJBDOE2gskXQXEzLtvdWOLF7TBNPFVvtwzWy6kL
         QYKKZsOchYFjQxM0jk/rp4AFMC2wfNOiD+IDxVeA9Q9drPI0QjaVe8rhPiQIMa8nvO2L
         RB339s7SY4jNKxrE8wqG4vhnYQv2zelgLErJxX/CgXkuJQhtpBK+TKV36fMeZJieC34t
         dSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uo220a6rdlw3GxUuDIlr3sYYY1g7LV9qmd8uQhsVPEo=;
        b=I4Rey3Jpesp5tzxTy0blDKI3/yD84mdWHkTpb2Cy0yeiLvW4lc92TimapfUGqEVBxE
         NpALAvmpaMIc+H23pEokJt8gGizzPxz/EwurQTDtNfBbxYMWf1L9sAAWjYQ4RL86RSuT
         UbYQSA0jiZNO9zpj7IRtsoNn4+Dy9nXUxat9T2g9FE+zdH1SGlIsNrNpnGI2WdQG/lum
         wN5PaYr8JVumbicwJHtEzRHfaZiHNxU0dqyHzi/336A0DpUc5ztk1Rt0yLeMLIGotC3u
         8+TTR3pbBx0sasbyaImGAaRX4QfmPX9ZAYBWt4dHwkYN02VFYkhLnYdz0ZeoguQcYNV7
         rm1A==
X-Gm-Message-State: AOAM533qHX9iozRjmL86Wb3EiKGOhmuM7m86Mq6mJBS73KLbBqOXDwTN
        rYrJHeugtmltdktrJXIZcCKWXGhzLfZG/A==
X-Google-Smtp-Source: ABdhPJx7oiNZNU8rPFOSk/6JrMpDhyGXaAHiJ+eFN04aZ5VckTnqfxasRJGGYPFyzij5GBhIHIklBg==
X-Received: by 2002:a7b:cb07:: with SMTP id u7mr62850wmj.57.1601913834561;
        Mon, 05 Oct 2020 09:03:54 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4892:2327:f1c5:e39c? ([2a01:e34:ed2f:f020:4892:2327:f1c5:e39c])
        by smtp.googlemail.com with ESMTPSA id m3sm433878wrs.83.2020.10.05.09.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 09:03:53 -0700 (PDT)
Subject: Re: [PATCH 03/11] arm64: dts: qcom: pm8994: Add thermal-zones for
 temp alarm
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201005150313.149754-1-konradybcio@gmail.com>
 <20201005150313.149754-4-konradybcio@gmail.com>
 <c03ace9d-d983-c1f8-ab74-ed585aeb2364@linaro.org>
 <CAMS8qEXBrF-j5ObahFVcJFMuC7=ucz+y7XBzTyuJAqejsE0F+g@mail.gmail.com>
 <0eb34c71-3e1c-9950-de30-6b163d7cca3a@linaro.org>
 <CAMS8qEW2rxYCc-7dQKPMBKQzbw0w1CtxNPVJYbeBPb2-1WvfDg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <12ee5c1b-66a7-22d5-29f1-31e25cfbe32e@linaro.org>
Date:   Mon, 5 Oct 2020 18:03:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMS8qEW2rxYCc-7dQKPMBKQzbw0w1CtxNPVJYbeBPb2-1WvfDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2020 17:49, Konrad Dybcio wrote:
>> What do you mean by they are not "online at once" ?
> 
> msm8992/4 are infamous for their thermal issues. Manufacturers have
> been known for straight up disabling some cores or tuning the kernel
> in such a way that some cores get disabled due to the thermal
> constraints.

Thanks for the clarification.
I was imagining some kind of hardware feature :)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
