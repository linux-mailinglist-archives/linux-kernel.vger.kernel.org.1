Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C1B2A04AC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgJ3Lr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgJ3Lr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:47:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241A3C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:47:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v5so2579562wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/VyNGryLroT7qe3Pp9ybD5lnQfay5phLuhwNvbxhxYo=;
        b=WAUf3+d2JVTc2U3d/Gv0nJozocu951OOswUcD4xo4Epo9ZKRp2kywPmcI5+AU5Ugsz
         UBdOx//W7jjKZser0nHrjrHeBnt9qZTzPXTgOViuENyjBKVk+UCwFV57rong8tik9US7
         0vdI2MSbFnECyd+W32GDQdbCNM11iHJ49aIL7Pp96UzJg+rlbr9sVViA8uDktOwXOBtP
         t6KE1+BfjVuNIPaaqymUGIbXvZiljCwXch95AOP8EgnaOYgWxtDwowi+CBmV9S6/jWhk
         BHliUO4ci5VZ6iOI1sdxImSGdGpY8Pj588LX7bsBsdAQGIRtl7CfWi7FfQNO6XdkXx5q
         spfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/VyNGryLroT7qe3Pp9ybD5lnQfay5phLuhwNvbxhxYo=;
        b=G2/uuOzKYQXmfczeu/pRDAbnLl68k7gk/q8LgJorj0H+44W/dBof63g4Sdc/ouP5GC
         GIL9aV+Lc5gKlEveSd0KNRhDCMlpc7xT7XArtc9BIgATIjBIRNG+RYeAqYtUJv82coHb
         6W4YqteM9e3/mwfPvZmhIGTKzAX4/+8vC9AMl4p8aT9Ktz49yR+1AfRe7c9ngFbgpIXr
         ctXi7bFuV7nEK8/I81jpxNx2/xZ5T42L70bptW4Js/Aoggwe6i4nsMtZFdQPMEPYn/uY
         MMvYGI+wKwQegAou4Gp6h+GYS/F+291Vn4OJP9Gnb+8yc/LrFKuXXK9goU9LzJxdFiIV
         Lp3g==
X-Gm-Message-State: AOAM531yHWC/NhCrGJ4XIf46xVszPoZ6v11PkrVNrDj1gFa7i3pmW3N1
        RP/Xizr+MCdNkLX6bVjVrM6KyQ==
X-Google-Smtp-Source: ABdhPJzQqqcHNKkLNiq+QHTNOQAjhnt7BUATOLJhivtj8XRz7DO7X6ixIJae+JIM1g8qdueVyZWT1g==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr2242342wmp.187.1604058474636;
        Fri, 30 Oct 2020 04:47:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id g8sm4434811wma.36.2020.10.30.04.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:47:53 -0700 (PDT)
Date:   Fri, 30 Oct 2020 11:47:50 +0000
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, robh+dt@kernel.org, nm@ti.com,
        rafael@kernel.org, sboyd@kernel.org, daniel.lezcano@linaro.org,
        sudeep.holla@arm.com, Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 2/4] OPP: Add support for parsing the 'opp-sustainable'
 property
Message-ID: <20201030114750.GA636720@google.com>
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201028140847.1018-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028140847.1018-3-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Wednesday 28 Oct 2020 at 14:08:45 (+0000), Lukasz Luba wrote:
> +unsigned long dev_pm_opp_get_sustainable_opp_freq(struct device *dev)
> +{
> +	struct opp_table *opp_table;
> +	unsigned long freq = 0;
> +
> +	opp_table = _find_opp_table(dev);
> +	if (IS_ERR(opp_table))
> +		return 0;
> +
> +	if (opp_table->sustainable_opp && opp_table->sustainable_opp->available)
> +		freq = dev_pm_opp_get_freq(opp_table->sustainable_opp);
> +
> +	dev_pm_opp_put_opp_table(opp_table);
> +
> +	return freq;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_sustainable_opp_freq);

I'm guessing this is what IPA will use to find out what the sustainable
frequency is right?

Is PM_OPP the right place for that? It feels odd IPA will get the EM
from one place, which includes the performance state, and the sustained
OPP from another. Should we move that to PM_EM instead?

Thanks,
Quentin
