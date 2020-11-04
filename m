Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564DE2A62DD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgKDLGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDLGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:06:38 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DB1C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 03:06:38 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b8so21602993wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 03:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Jlg1mCcxzWyJ2SSHL4wcY3QBOJAIfKFSTaTOV76kAxU=;
        b=on94m12o7fyMspT/InUuHoXm/sj7NYhP2F1Sikm3KYkBVEHfCkok9SpRWyZpCAiCs5
         ETfmuPoq+RhPctDoa/oeJin9WohJ2KfZEeBs7sGl0CQ1CpB7AQq5LqijFazEOkB11FWJ
         wF5IiswbfOk1iaMbAKEKKuD+3m81LkN31O9pjrUADAxoPu5nAx4dbu4n0xj/38bD+IqA
         L8QVJEcORH+J7+d6nMXbj6Cv5AI3AnOyrFugtzoMytl//+VuvaWelB/ywJ5PJM2QMxyp
         e481hPC3ie+alWsyL8/PSxDY46a3ZMcYnNcixlyvJpc9eNC6hx0F98qvcLmgiguGv/jj
         EdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Jlg1mCcxzWyJ2SSHL4wcY3QBOJAIfKFSTaTOV76kAxU=;
        b=kcfFn2Lqw9PyECBo5JtZI581Yf1AxUhwjnD8l0EFmVfye6zJcpkHyDvrQcw/R8omdX
         uBYcoR7Vq3AcTVH4g2xb3kduSucRDatMmLjsDcGillKcji6iBPT/5x9yaG+VYStXBckl
         FB7/xhmaoOGZ5ARRyz5Fn7Lxdzzb/KKHTUZpTHEM2Si50Duc6cb51RbWUMIEFPQy1puj
         IWToi52UqkYe9cDF7YXyRPLmT6QoUyv+LYy2vVEazaHS57qYE3WbkigZpxR8O3LwXO7s
         mRw2QBmeOXtTXBEXfprTrsQ+ZHaiOZu9TI9q+mAgMz7291jKLCZyx81DprXyIJF2HJS6
         KE6w==
X-Gm-Message-State: AOAM531WYO4x6a67aKM5mWvx2Sf44Iopil8RXdEXaoecsGU4VUCqyNwk
        Fmx5E3fduovCQDOUx4IigI5Odw==
X-Google-Smtp-Source: ABdhPJwgUB9eFlFCuBC95J2Q8kDKQ1YvvO/j5at2FNEcYWob9hTg91otuv74+Qmty97HqneRoqaBtQ==
X-Received: by 2002:a5d:5344:: with SMTP id t4mr30847472wrv.267.1604487996889;
        Wed, 04 Nov 2020 03:06:36 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id n8sm1670683wmc.11.2020.11.04.03.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 03:06:36 -0800 (PST)
Date:   Wed, 4 Nov 2020 11:06:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: madera: Delete register field xxx_WIDTH defines
Message-ID: <20201104110634.GA4488@dell>
References: <20200925091446.7530-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200925091446.7530-1-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020, Richard Fitzgerald wrote:

> The register field xxx_WIDTH defined are not used in current code.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  include/linux/mfd/madera/registers.h | 635 ---------------------------
>  1 file changed, 635 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
