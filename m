Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4412C233B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgKXKqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732249AbgKXKqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:46:36 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9629AC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:46:36 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id z7so5982504wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mY6oFyszQIfjsX+snBAXXOzQ/+55tC9XreosQxbSP0w=;
        b=m7qwfa5lAe1wF7BHNWr6BkwgFgqtZRyyXks6m6NwycCQwRRFi9o1MMnlsRQWTbPrPN
         C5YESKotEqsnENg/FT94JYar1tJSyvwOttzauaH03MHHubqwNzq9EFGJVfj145fn+U6P
         wJy70IqedSLsAis+4p/1U9GcFoRcn++VUogBtu1EEK5M9Hv7o6YEsZ81rtfQvHcviEdj
         9d+4Twlbe9SS5ZNJHSC1Gi9zDm18V29BXnctq+B+ixEDt/K94RPcPeQm9llWwumR+z7y
         /9TC+NKUMIEZWf8P0wnq84d1qC0UHfRQPIO8HjfDWPWWSP/TTroxANhRnop7iagdy7KL
         D36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mY6oFyszQIfjsX+snBAXXOzQ/+55tC9XreosQxbSP0w=;
        b=V6YTOjoKoey7+fpuDMt2eHxoMN2Ry1V3k3HC1DvaJx1C17HY1d60084YBF+/vPiYVH
         NhtzqiBOIDL+59PQVdsSnbNrONzFKzuZTwmwjYOENkslnLa8y4tzEdsX/DoDEiK1dfGR
         2WF1mVUKJh31SXH2tvV1lo4P2o5t/tRAU7OLZsIRht9JC0RUh2IGAUx+tXwarqJuJxT4
         a3NTwk59T1GBOmZAu0hINcAST4ApkUkd9Hf7jaGnOQmRo7XqsG5YmuhdnosCfBiA3nK1
         6k4sUvW/wucVUHtlteeEFGPBRZeNhLIA/DRsMfSAgQ4p/xbPJM9Rr7QNiNj4UiO7E8xY
         02ng==
X-Gm-Message-State: AOAM533L+5nE/M4ghrccIwzW+kjvzXxKJFir5V2gq9BJxTdTE+Dy4q+d
        fSO7HpeW8VTT7gNs4y9+yJZ5TpemH3pV6GgK
X-Google-Smtp-Source: ABdhPJy9wy9XCIVai3yDDcQ4313iVALrhHqxhJJXEQfKGMnkK2Rcx1MU7GaMNQ+S9lhfklrLdFac5w==
X-Received: by 2002:a5d:560e:: with SMTP id l14mr4674436wrv.191.1606214795065;
        Tue, 24 Nov 2020 02:46:35 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id a9sm25155168wrp.21.2020.11.24.02.46.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 02:46:34 -0800 (PST)
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: Constify static structs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20201122234253.34047-1-rikard.falkeborn@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a79662bc-be6a-ed22-76be-c492d4cfd600@linaro.org>
Date:   Tue, 24 Nov 2020 10:46:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201122234253.34047-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/2020 23:42, Rikard Falkeborn wrote:
> qcom_slim_qmi_msg_handlers[] and qcom_slim_ngd_qmi_svc_event_ops are
> only used as input arguments to qmi_handle_init() which accepts const
> pointers to both qmi_ops and qmi_msg_handler. Make them const to allow
> the compiler to put them in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---

Applied thanks,

--srini
