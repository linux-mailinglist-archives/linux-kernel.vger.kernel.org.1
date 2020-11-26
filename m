Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07DE2C58E8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391314AbgKZP7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390021AbgKZP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:58:59 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4900C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:58:59 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id bj5so1332195plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArsWYhh7f+27HV9EfUhP0m1tD+zYaD7GlznzldJ9F4I=;
        b=qkgO/YHM9SJ9lb/WijGe2BdY1DVH88O5AtF3faucYDQ8TYkcbqOzQTCWxifYWLa3q1
         6Ki5v41y79OfUaSurPWtuMlyNawO1kAIFm/60YRU75MxNagNMuW500eS1Hrg6yzArMms
         7Wsl4cCoPZ1v+qYGDsv4qQv990QZf/ueTK8pcvuafTWBJAlY/qSvcvWjJixfroANpQ2R
         zd/YKErGVmu+T8hYfp0KrohuaEsDzGfkC+dweKZBfYwlcwATvLxeOn1UY/zXTzB/0+eZ
         ca2fqQ7adxN9DjMSyyau1HxA5dj3kuAKj9T7tYLqftRciAK8OobxSGLVDhu+zxotrKew
         ST3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArsWYhh7f+27HV9EfUhP0m1tD+zYaD7GlznzldJ9F4I=;
        b=rCgVSxO1YW5r/7SBwANxghJD6u1QueECJSFjqqjvEFxNwIb/pCPbPF7n39HRnidJXq
         160FrS7xyKTIqZOSjoaNwZKwasotbUVPK8XsqQWNrMQhBjvzlQB5XKNQcntkrVxlTu2H
         aNOu4u5oO+3/EmZo31ZGPySilhfdCTJkIu6dQUbGabyZAeLpOg1DBzEwXMOFguY51u8e
         bR4LJa7Lq5rlm9uKI5saYiBqXM7PI7blpoU79hb8vPhI04OXtnxxfntmxuof/G7cXd1H
         uTIDgVCZsh6z4yV/F41xjOakxfb2tDSCwojUvmcY2bi02xvAjtPfdXfPSoLPHL84BqfJ
         w5xg==
X-Gm-Message-State: AOAM533tyKx/zTAb722WYj5snND+my00kxQlTz47GSo3zI7iQ/xes4Ai
        GhkdfVQYH5LXy4Xn8D3gxqb9CGHVO66CJVSL0reMAu/vNPuG8g==
X-Google-Smtp-Source: ABdhPJx9f4dK6XH0f++SfF0aQFUZVMuGEnw8DvRJTuLbgcRd+HWd2/f9IMdxZl832s0RNv5AiGw1lIt75eMZumYH9c4=
X-Received: by 2002:a17:902:7d94:b029:da:53c:f7cb with SMTP id
 a20-20020a1709027d94b02900da053cf7cbmr3153103plm.69.1606406339266; Thu, 26
 Nov 2020 07:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20201126145321.18269-1-robert.foss@linaro.org> <20201126150334.GC51288@thinkpad>
In-Reply-To: <20201126150334.GC51288@thinkpad>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 26 Nov 2020 16:58:48 +0100
Message-ID: <CAG3jFysosSVGfLzAvERS=GaEz8J8SJwh7roS5twG6-7meErKdw@mail.gmail.com>
Subject: Re: [PATCH v1] i2c: qcom: Fix IRQ error misassignement
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Mani.

On Thu, 26 Nov 2020 at 16:03, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Nov 26, 2020 at 03:53:21PM +0100, Robert Foss wrote:
> > During cci_isr() errors read from register fields belonging to
> > i2c master1 are currently assigned to the status field belonging to
>
> s/correctly/incorrectly

I don't think there actually is an error in the comment.

>
> > i2c master0. This patch corrects this error, and always assigns
> > master1 errors to the status field of master1.
> >
>
> This patch fixes a legitimate bug. So there should be a fixes tag!

On it, fixed in v2

>
> > Suggested-by: Loic Poulain <loic.poulain@linaro.org>
>
> Reported-by?

I'll add both in v2
