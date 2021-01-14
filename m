Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD302F61FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbhANN2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbhANN2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:28:51 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4822C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:28:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d26so5747593wrb.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dlcz7oRn2yaQTqvuHBDSXrktv8ILXcA2nR44UFm0ZcI=;
        b=rsh00TpiE4oLzBqWSh7ccwDvLeX0X61gVe+od40kGrmW6UG3ZLM8GGXAIqphpNhiRS
         8wTDbLz7QVdCu1p9Md642s7HT3LOMf9tkkKTrD9Sm5IX6RrnoT6/dR18nEO4+/glrsD6
         qJbx+woz5zMoB/gAFsxvHfVa79sb+V8H0wnuMiqyrzvaSrhoBfg6gXCPrFRPvW4124rc
         ZWDGdmFpZ1nMCnHJQzt2xSdfDUtNkT6Pa6ov+ivsq73tj5NUE/BIDz7+0jeVr1Dm7rwo
         yX28gukG73v9nAaQpTqdfsVgWuDpb1yw3gtrAqYZJPMkVBueQlwruB7kd4/QekKm8Akm
         jVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dlcz7oRn2yaQTqvuHBDSXrktv8ILXcA2nR44UFm0ZcI=;
        b=DJpu5yMIGPko1+U6qHOtAX7uCeoCifEitK+Smt/eTSkFvGmvg65aZywtf/x0uqAcnM
         ALLmIVSLJ8SVVXYd/VxlqKn5JYEcigesIvZrgqk17U77mVcNMru4N3Zj4n87lBD6Mt0Y
         7YGesJB4QcrFPXQa8exIGVkHVWQ7HZme8vjk7qqTAXwhppFl4vWgPuCz7csZL35Z1GNn
         CAmGzXoXihUmaQMngNfiVJ2GD22BW761ZV13MAMeQ6mnKv0EXKGUfUsXqsPu+i9+g2pv
         JP7hqT8p7b14NGu/ezENByOaSuRjELxtMFFMvf6unMT+RvTV91dXrLbcdWA9A2plomto
         TU0A==
X-Gm-Message-State: AOAM532ZrTuABei4gGBpxxT7OceriLztld2yT/ffjeZxbTvyJ8pKPbKi
        1TDIbyf9gCY7G6ws2HDmaRyDxg==
X-Google-Smtp-Source: ABdhPJxlj7+hO1id7PH/koLlxYaZ/bWvUGu5JPGMcwurs3OkFnOErAadchHhsBTj64KFJq5paFBVpQ==
X-Received: by 2002:adf:b343:: with SMTP id k3mr7844050wrd.202.1610630889619;
        Thu, 14 Jan 2021 05:28:09 -0800 (PST)
Received: from dell ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id b19sm8116213wmj.37.2021.01.14.05.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 05:28:09 -0800 (PST)
Date:   Thu, 14 Jan 2021 13:28:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: mfd: gateworks-gsc: Add fan-tach mode
Message-ID: <20210114132807.GW3975472@dell>
References: <1609183716-26529-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1609183716-26529-1-git-send-email-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Dec 2020, Tim Harvey wrote:

> In 7497d4a66c59 ("hwmon: (gsc-hwmon) add fan sensor") a mode
> was added to report RPM's from a fan tach input.
> 
> Add this mode to the dt-bindings for the Gateworks System Controller.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
