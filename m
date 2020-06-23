Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B6420683F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 01:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgFWXX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 19:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387495AbgFWXX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:23:28 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0C2C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:23:27 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e15so80695edr.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E93JIavOGTymfWi69bZB0mVpc8Naz5TwEjq7NsjH/HY=;
        b=ePHYyISGgbits4FG/+t9c9eWGv+urBv01Ufj+BX3EUBWp1RMElasVgMuGH/JZmGIcV
         hlASpRKMvqQHp6lrw/EEwekXDrLGBOjbtEPlrfhPs+k6mAP5M8IJ15Qd4TLepo4jiKlc
         7jkHvrduQjiyFSrr9sOJtR6zp2+Kne47aXUuE62gW62eWX0PBwiZjXpQrJb+lb2dj8Q2
         pk2DvruLWJZhinJzP8luiH6fss/vRtxecUsd9llPmB56AOi+lxfBPn5HpsOEQw/qI3LQ
         My44WnXo/774gEOcc51ID6arjYtL1g2pXidX32EpvsjPIem2y3LTVZd/+OOnljsdWd2b
         0lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E93JIavOGTymfWi69bZB0mVpc8Naz5TwEjq7NsjH/HY=;
        b=t85ESJAbxzosILtvDCxppcbATk71lzyiTQhbJHaWaf9C2tcLVS315QieBB/i6hoOYK
         6ZB1vZdUmYny40BQZcitg81bPPvbpT6b1UJ+ouFxFkDboP7dtzZhYMlCmnV/m8OGa8HV
         PEW44FGRGy30w4KzD6Ubdc1KjtlSqP4HMef5DcJv20ZkaqNUCMkkrn0XwXrg3sorY4XR
         Bg+mHyXTdAseIigCikVL3Ybxy/wuYBpDb9SQ1xzTgvnbzY7ZCDcESgRe5E+3NLtUbhus
         zcM0Dhe0SDO2Vi+2v/wDAw+NfuhJPG3V2xzcUzQkEKWN5PwdXhjKjpTawaVh5igPM8Qo
         jdaw==
X-Gm-Message-State: AOAM532TUD3nXuqChyO94WC/4eQiEr7UQx4JCze+YtC76eoCwFCtmsqz
        VeQDiLlFheL99T1VdsakRJJqzDplCqfrpzJPjrM5Kw==
X-Google-Smtp-Source: ABdhPJw+LVAkusei34cElnzB20nwoX0nOSHY5/n/GJFPW7npG7YJpM2Jp3Teeg1ZpVbvaNuBwGjY0q6v2FhNlSNnqwE=
X-Received: by 2002:a50:9dc4:: with SMTP id l4mr24828188edk.52.1592954605727;
 Tue, 23 Jun 2020 16:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200531172804.256335-1-konradybcio@gmail.com> <20200531172804.256335-5-konradybcio@gmail.com>
In-Reply-To: <20200531172804.256335-5-konradybcio@gmail.com>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Tue, 23 Jun 2020 16:20:34 -0700
Message-ID: <CAOCOHw7ZhDPOxOG4dy91JEQ9U7y=3tabd60THj8NUcZE1fCgtQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] firmware: qcom_scm: Add msm8992 compatible
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 10:28 AM Konrad Dybcio <konradybcio@gmail.com> wrote:
>
> This change adds a compatible for msm8992,
> which requires no additional clocks for
> scm to probe correctly.
>
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  drivers/firmware/qcom_scm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 059bb0fbae9e..4ee94c2ff5c0 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1154,6 +1154,7 @@ static const struct of_device_id qcom_scm_dt_match[] = {
>                                                              SCM_HAS_IFACE_CLK |
>                                                              SCM_HAS_BUS_CLK)
>         },
> +       { .compatible = "qcom,scm-msm8992" },

As this is equivalent to "qcom,scm" use the form:
compatible = "qcom,scm-msm8992", "qcom,scm";

I do however believe you still need to post a patch for the DT
binding, to allow the checkers to accept "qcom,scm-msm8992".

Regards,
Bjorn

>         { .compatible = "qcom,scm-msm8996" },
>         { .compatible = "qcom,scm" },
>         {}
> --
> 2.26.2
>
