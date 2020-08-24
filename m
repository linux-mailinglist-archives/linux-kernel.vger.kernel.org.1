Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8189324F303
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 09:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHXHUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 03:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgHXHUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:20:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F95C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 00:20:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so7142401wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 00:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=reqXcMDpBFa4nYd/sRCzxWGTMfaKofdqaoTHA8YL5jU=;
        b=R2IO1/rKgB4kevOAzme8tKBDShJcSDt3s354Sl/aYMiiQkkEbFngHXV7bUEVikyzUF
         kfUGgAWuY9JP0Mik/ylx/4RS42BcCKxgjbk/jf3rP+8B6vQaTXWBeJbnV+KPxj4MmVQ5
         wqt1PnXow8A4CrJAfKUcDNHK+i6UhM6KzaCCi9CJpwCWzwohwSk9OK9YuGsizV/ogB7J
         u9DO0DuctP22OdNw7V0HAyw13uIVhmVS6HjpfL41CehkKiXoDxgW5Z9SHBsFjEhCNSJP
         HNNbXEZivAx3m00yThAPmIT0tUMk3vCbq8KYB+hJL5z4c+SLxQyn2PrxXfkrgYglQCMW
         lUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=reqXcMDpBFa4nYd/sRCzxWGTMfaKofdqaoTHA8YL5jU=;
        b=LIzjB13n6iJ0tSd/Vj3DO9JrKtvf8zDfa/0/oxP2FdDQukOfuvCu4JfZMBf9rWb03C
         0mZzv4iksTrYCodumaEFvujFIfXU3DFCJWosiV2SnjMVdnHDth8Ehlr39dTtGocWIlK4
         SBt4dB8FB+VOeQ3lJExakQM46Km0wkCEb84oRXwlr6ZK4t+xZAaOw6fLodjryGfo6xXN
         2MZn8EE94W38vdH+I/UjT+vKkajCATUF0yLqSctqidFAkuI++BFoVfA65FRV2utw96m8
         OI2XdV7hL3GtMVnbc1D10DkfNjrdYY9nlykdL24z1GJ3opT2bTC7fXho3HxOAs4W56MA
         RF2Q==
X-Gm-Message-State: AOAM533BVFmHudswKr5stjJ7hU7XH06tu+tSff1YQyotFHotN5QwuL0U
        cMlbrTQvrfhQc1zc4n5rwN/5VQ==
X-Google-Smtp-Source: ABdhPJxsam8YumJPfMFvbtMrlrypSkgydBai0hoxrJg5BlpWVl5jjht7CzJFZRBoaf5S3Wzo+//Y/g==
X-Received: by 2002:a1c:2dcc:: with SMTP id t195mr4089190wmt.166.1598253599962;
        Mon, 24 Aug 2020 00:19:59 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0? ([2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0])
        by smtp.googlemail.com with ESMTPSA id t13sm21234923wru.65.2020.08.24.00.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 00:19:59 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: imx: Use dev_err_probe() to simplify error
 handling
To:     Anson Huang <Anson.Huang@nxp.com>, rui.zhang@intel.com,
        amitk@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1597114715-1073-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <340444ab-a360-f1e5-2d69-9c4ae9cbbf57@linaro.org>
Date:   Mon, 24 Aug 2020 09:19:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597114715-1073-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2020 04:58, Anson Huang wrote:
> dev_err_probe() can reduce code size, uniform error handling and record the
> defer probe reason etc., use it to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
