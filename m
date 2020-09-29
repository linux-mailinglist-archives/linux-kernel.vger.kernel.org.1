Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FEE27CF15
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgI2N1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgI2N1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:27:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF23C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:27:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y11so5510276lfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3ONy2UEfURniD/LDED8tr1xeJcvKDrV1FhcEDlZN1c=;
        b=i8HkhsevGRuO/1O5qc6zqJQJMWeWJ6YjXtnrcAkQaKBLLMU9r5g9/CFT8Lf1byQ9vD
         MBkpuW3yyx2cjmDVpWQyjQPTWcun2lPWm/FtUmeIrvDXD7wnwRCX8Oxac4u3ZGMI0JlQ
         rS3dnHTK2iOzyTFe7HgXA8RJa2eR6VyNe3YJ8NdSNb6C94kWKkxAFU167ySxmTHc6/8y
         oegxD3xbulxRIa2ZbJAFrmj/2q0TN/tgkt74ZJvlf2r/EvTSu3b+rtOUar6Kz00oAyz2
         P7wvIDy5FXWW2BrxTO20lFy30cEd0B5M/cNExQkabBbKU3w9vS5WpGrQg3wN80XTojFu
         txSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3ONy2UEfURniD/LDED8tr1xeJcvKDrV1FhcEDlZN1c=;
        b=CfVjPmchDJ45w1y43jGJCAOcisSGV/nmPcVIzqI9IfreP1EKCv/1Vt3mewC08ZiXBc
         h1f0M9f8s3qD0MwPGOS3Xmm0ewMBV0Rt+sOHHSt/7soYeMzuSaB1PsGylGWdVpjRsdrl
         J2GLXRxlw1okszrlvnnOCAqaPKo8s2JpfX9OisAqOKpdOH4dwwVIyztOgbN5DMOnFqKs
         eaPhPHs1ktY1p0bbHQvFO027Y17NswxgeBM2gfo7VzcYL4bZ0NBoogcHxdVPdAnCAmeU
         jPL5OfLdAI2V8a/SyuFiCGpTg+XJe9KOPzCW8y5OlTRendvokXU0x82n8bxschIJD9JL
         QvQQ==
X-Gm-Message-State: AOAM531TDrNjPGoT3/rqaCcIHgTuoIKumnLqK7hR45sICxV+GakpkCWy
        zXcowJ7I2wfYr4ee83pMJnLx+oWuie2He1tqqWiIqTaSLFjMJw==
X-Google-Smtp-Source: ABdhPJxYZWGx2BlnL51M4o0KtLt6jFMMUDac9OLNYrtc9O+5E+GkaUjkVK+ISl76t+r5900wTgOVE87xLeymBxW9JHY=
X-Received: by 2002:a05:6512:20c3:: with SMTP id u3mr1126095lfr.572.1601386019274;
 Tue, 29 Sep 2020 06:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200921131058.92941-1-miaoqinglang@huawei.com>
In-Reply-To: <20200921131058.92941-1-miaoqinglang@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 15:26:48 +0200
Message-ID: <CACRpkdY3OzSLugezpB3KMatvo+5WFNEP7cRSKJprGUSeEY7UEA@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: spear: simplify the return expression of tvc_connect()
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 3:10 PM Qinglang Miao <miaoqinglang@huawei.com> wrote:

> Simplify the return expression.
>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Patch applied.

Yours,
Linus Walleij
