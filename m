Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E526C125
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIPJwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgIPJwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:52:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB80BC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:52:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so3578590pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sJeQpySpr2/Cg7PhopRLYFwLmukLvBLeAiNxpR8vIw8=;
        b=ZBC033qR/zJT4vCGMRQTH1LWGsTCF9TB8cEQHJXwHZuSONSUItbX+VLqtRA3Vhngem
         pFtScUlyKVWRSxANtli1MfeIjPYB64qklAPpysZQ3IjEeob/jADBx4JUWCWaaoXFAfAA
         Kyjr1PPVotHWPMt21luVQNqc532NUHDI95RbUi27FSxvKCUJhmpl6KBQTz61fjmPMlyE
         4782j1Xwb41P4BGDDORNXPHjL/InNboeZbmRMmn1s0WYT0MVWem37k/H8g0jI9PTSQ38
         du67ll0dojCMp+eoMtnQyRR4zVHAoOOpJuW59VVtciRv3NOWT7QFY3o/T0GAbjw80RLN
         Ix0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sJeQpySpr2/Cg7PhopRLYFwLmukLvBLeAiNxpR8vIw8=;
        b=lzPr+jOOIaIddInDjJ8hBkdbhSGsDWzSmIcFo7h74aFHg/m1+5g1Y3v2FYeWeqXOq+
         u4jHjLwKiRP6F62W2HO6o4FyEk2UWPnmQA4YIRZVQ6IP0uR+3PZbrTK8g1Uq6+J3xjs0
         FGvHMLiJKSyyCDcV8ASp9bJSxBJtpBmFdWxiBkAua1YKa85esqRGMzSDon/XvOQo7uRg
         L/aOUgnNG7LpWWrP8Fed/4q+X9MdSeAAEO9LUJ/vma+V17FplgSOqUFXkzODGUBF8k9O
         EpNrqed9bmBDPmka3H5ZOm9G2VHa4BBpHIkNPjh5SsbY3f6eWL+RH2XjXM5gQ0Qz5Cyg
         EZyQ==
X-Gm-Message-State: AOAM5326r8swmBYEjrOpQs4ODx9tH1+9xRHjiPgAR0pEf7betwPIDtKg
        MFUug5jfDSSQbcKQhSCrs5PWGg==
X-Google-Smtp-Source: ABdhPJwzZFOwCUCV3nhWvQGjFOjBueE4nd5EViKbUhIu3xcHb87/vja/HKPEVo/JJBpn+EZRQtdobg==
X-Received: by 2002:a63:e057:: with SMTP id n23mr16800523pgj.87.1600249959118;
        Wed, 16 Sep 2020 02:52:39 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id t24sm16538902pfq.37.2020.09.16.02.52.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 02:52:38 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:22:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] cpufreq: qcom: Don't add frequencies without an OPP
Message-ID: <20200916095235.gixejqmyt6ajj5as@vireshk-i7>
References: <20200915101007.1.Iebcd373535de8eb0aa304ad22b062a5bbc88a665@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915101007.1.Iebcd373535de8eb0aa304ad22b062a5bbc88a665@changeid>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-09-20, 10:10, Matthias Kaehlcke wrote:
> The driver currently adds all frequencies from the hardware LUT to
> the cpufreq table, regardless of whether the corresponding OPP
> exists. This prevents devices from disabling certain OPPs through
> the device tree and can result in CPU frequencies for which the
> interconnect bandwidth can't be adjusted. Only add frequencies
> with an OPP entry.
> 
> Fixes: 55538fbc79e9 ("cpufreq: qcom: Read voltage LUT and populate OPP")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Applied. Thanks.

-- 
viresh
