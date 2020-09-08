Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA4B260FDD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 12:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgIHKbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 06:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbgIHKbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:31:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85157C061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 03:31:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so5439674pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 03:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hDRXaJuAS9TrZFMby+Qmnh+jZXgmePanO+HwLWR2Ouc=;
        b=JUNp1uaI61meRUQXI/pPS8i8XWPkyXDB/8gSgV8A6qz47wi+XYpf3wBpin+bMYWZ+t
         cXCoI7gS85mL2iuWpMmMF+lFwrFGoW0hbe4YosLpaeVuXE2RLuugSLCIA7tPVorN27BI
         EYViljfOFlpod2U5565AODj6f6FTpOjnyHYqSeXmWyWWWJpMB6kevRVVYFy12WT7Rmgx
         /v95pXPu7P0MldjXLXVywF7HMTqTu7WZHLvivAE6CLJU0OL0Khx930DKTDhi2Lj6LYF6
         L56r7Y6k+Set2fHI9vZ0VYUomxZqN4ldYmxifMT9Glxh2RFoDy1WmOQ/LBxWQAjR09Fg
         Ci/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hDRXaJuAS9TrZFMby+Qmnh+jZXgmePanO+HwLWR2Ouc=;
        b=YIcqzmLI67W55nE+vJYGXVt/rO1BfbEZflPqAR3Q4hozTvlYkFsI4+/VBPh7/DXhjG
         JlXQNx/cuj/U7+ZFgxGenWgB7N+5RJk3HG3Sn0Caqr3d3+pxdThQaOXkpeadVlYQzmPS
         uS6dTk6p78uK/LbBqzCZfMkn77IHz+GAL95FJpcN6PjcImIx83egoa+qB0DObNOy3LgN
         Xj1+D3eY2PHkngH1++YN4J/xPDA8fvtMV9pSVPS5ZgVK2S+jK1+fjh12xrIqndD+Vr9e
         OGk5z85xBmoiaOgM2Jk9oRdfgVLtTCwItc+0V1iw97NyluxrTDwc9EcSObTDZcksO/dB
         mWzQ==
X-Gm-Message-State: AOAM5336jSEeFTcbbnJyy81Al7m5gBbWYrRXC+hTktc2W4/e5+3Uty2C
        sUJiYnMu4bei4ElpU+4G5byLsQ==
X-Google-Smtp-Source: ABdhPJzNSCfBkbg+11agkjtxy3qwtXxyhK1sMEZKc5BFdUxTxh6wxYIwtLvqzDkOUFK7HlxQ+qQTKw==
X-Received: by 2002:a17:90a:db05:: with SMTP id g5mr3543257pjv.22.1599561065932;
        Tue, 08 Sep 2020 03:31:05 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id x3sm18002984pfo.95.2020.09.08.03.31.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 03:31:05 -0700 (PDT)
Date:   Tue, 8 Sep 2020 16:01:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmitry.baryshkov@linaro.org, tdas@codeaurora.org
Subject: Re: [PATCH 3/7] cpufreq: qcom-hw: Make use of cpufreq driver_data
 for passing pdev
Message-ID: <20200908103103.4mfewgmn5xl7mou6@vireshk-i7>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908075716.30357-4-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-09-20, 13:27, Manivannan Sadhasivam wrote:
> Get rid of global_pdev pointer and make use of cpufreq driver_data for
> passing the reference of pdev. This aligns with what other cpufreq drivers
> are doing.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied. Thanks.

-- 
viresh
