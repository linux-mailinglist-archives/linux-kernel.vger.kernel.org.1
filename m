Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED352B72C4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgKQX7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgKQX7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:59:14 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6E5C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:59:12 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s30so367145lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/y6a0UK3u/dNwIIUVoM+pGUdquknoe0CJWf8D3EhbNM=;
        b=w7JLq8fuu+cq9tlIBxHb/U3gwmaupnSlw2tbtyZQ9w5zrie6ATVlGmaGV8G33DrM37
         wbzMcf5uk9+FBgQUkaD/4VxVrA7rsAPrCNTgu1aRmjJOQhJc6Rxrz7G0xYibt5rDBRJP
         gYW6oWxYCLB9+NXxxmn+qLZPJR/e201o1XH8IGulMxDBgrADc2FJIApx1UIX8uXYcWue
         mC/OWGad88GiDLLCKEyzZXkLaLKLa6grP+69lI5FfTc2IbzcSnP276NdcRgSHQi93a/R
         zLO2LCqOiVD+EOcp+3mDaN0UE8ikhqqsxm48m8FOEwXRIiHyyPqxuk9eLrKj9GgPaYqK
         jLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/y6a0UK3u/dNwIIUVoM+pGUdquknoe0CJWf8D3EhbNM=;
        b=DTzEjaByB+afPhkhPFvE2hptbCv+tBwwfhITpmlYUM7lq0NLK7aznzJB41kFLuXJ/e
         168a30beOi0jlckbzJInwzGv7KOFT1JM1i2m4o6Mvfxv+cIJ9g0lMscG0fl69yUO1N6J
         /eIxAa7CNqaPa3zC36HfRLrgs/7rk1NAS32km9l2smIBHGdYF2/gxSTHnvDKuMkP92W1
         HigaLj21R+sW2/s+m0SrSlldtsuqfyqLtM6+bizODpH8DalL6fwfbENDt2dCHNdOwwaJ
         yKmHhN7+YIOxduJ1udGTEGv6JMYo4fsjiMR+adu5P/9tx/XLQSJT+sYoOdLhfxWVY1rX
         MYpw==
X-Gm-Message-State: AOAM533zfUN6g96gwRloweaNt7+iqPAIV9n7n9FmbXv152jnjowUkuuh
        wYU2Ydni1qJltQEChy26HKzHF+UekpK12yZriDKQZt+ui5dtNw==
X-Google-Smtp-Source: ABdhPJwK9Ixwv/tppQznfvmu58gyl0YDfKJ+6di/ww2S3OkPk1ns1eiFy40oW34QRdzZscTOmor/Kw5lf7mTT72oS0c=
X-Received: by 2002:ac2:4ac7:: with SMTP id m7mr2475918lfp.572.1605657551020;
 Tue, 17 Nov 2020 15:59:11 -0800 (PST)
MIME-Version: 1.0
References: <1605201148-4508-1-git-send-email-srinivas.neeli@xilinx.com> <1605201148-4508-3-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1605201148-4508-3-git-send-email-srinivas.neeli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Nov 2020 00:59:00 +0100
Message-ID: <CACRpkdYxp6StaY86MC4E-Mh=b5rm6QxB1vjHTC7Nhhd-76YU0A@mail.gmail.com>
Subject: Re: [LINUX PATCH V3 2/9] dt-bindings: gpio: gpio-xilinx: Add clk
 support to xilinx soft gpio IP
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        sgoud@xilinx.com, Robert Hancock <hancock@sedsystems.ca>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 6:12 PM Srinivas Neeli
<srinivas.neeli@xilinx.com> wrote:

> Specify clock property in binding.
>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>

Patch applied, consider rewriting this binding in YAML.

Yours,
Linus Walleij
