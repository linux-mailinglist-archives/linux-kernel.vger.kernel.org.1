Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87AE202650
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 22:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgFTUHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 16:07:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33548 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgFTUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 16:07:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id s1so15224497ljo.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1R7JEXYt1HHp0CouB56E5bM/YXS+//KerD1pgri198Q=;
        b=exK01JTMxni0en+KItqNJ0S/BfGAPNjBrBkcfB7Qnu+PLg0J4jMv6aWnfCkdhgrBu0
         ne58bXR8G3LHaUT8e0XF9nair46sDthB0i2X9HWcJ502Lx/juYSHn7DPkab0IgCZhpGX
         c9VDCgCcm5jC+bDdvyDlI5LG2uJJsoCVVJJXPIOEWshrmFjWwy8XiAJWxQmjPqK7yo2j
         7NHl9WbhHTrjwc7qU+3paM9Q/csXlKDrOprcW0/MDEst4+MXTTuMmCL6FBxUlSv4k47w
         sEQhNC4JII/GFIIf6dcwdkEQtc9uvmFuhlFlx6NcDp8uGBcIgSDMYWar4ZT2pLirYXWS
         Gg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1R7JEXYt1HHp0CouB56E5bM/YXS+//KerD1pgri198Q=;
        b=pDcUQLvPnYjndcvm8AgZeMvk94H+wHwitVsD3u2fW09MtVtz8Den8lsiMjLCF84+mm
         SXB0+XLtlL5ToRTgRIsr90H7EFAvOudPaDJElnf5OCmg55PYaOBIJeRqbgfZTVsLIxEq
         Hf8/b/v5Dk9JM761JcOOe3yX6eqnGfEG+Bch1kN9jyF1HE67tXLgIYos8xTdqL1ruKwo
         BkaZZCotD4s/oicQt54mOCNbRwp4bCASNchCZDndoOOWvzQwmxZ19mrxZagCj7zbAemZ
         HdpDuZmkL2V8A5nsmXPNfe1IKdUECcet/v4nOfsWJhxROM8obL2mju0z3BJrMqHN+RRt
         ZYiQ==
X-Gm-Message-State: AOAM531YbaUKKfqPuZs5/iuiJhZdZOm70BQTlzmJE/HaQtLF2ISpYKxf
        O/wU7tFUFGykOSGciQiX9mFrT+PqcNpA3SgFxKazIA==
X-Google-Smtp-Source: ABdhPJzqDDpCQUw4ihD2vuoiRAREP7goOEw2oLtKfp/TxCBlQSwp8k6nqeRhq2YRi0eIN0urkrX5o+i5kyqwG2hGVM8=
X-Received: by 2002:a2e:7303:: with SMTP id o3mr5119361ljc.100.1592683566426;
 Sat, 20 Jun 2020 13:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <1592541089-17700-1-git-send-email-sivaprak@codeaurora.org>
In-Reply-To: <1592541089-17700-1-git-send-email-sivaprak@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 22:05:55 +0200
Message-ID: <CACRpkdbnQZX7RJ3+rgu2Yfg4Q3O2X2dFzgmA7f6ej7N-yh1d9Q@mail.gmail.com>
Subject: Re: [PATCH V2] pinctrl: qcom: ipq6018 Add missing pins in qpic pin group
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rajkumar Ayyasamy <arajkuma@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 6:31 AM Sivaprakash Murugesan
<sivaprak@codeaurora.org> wrote:

> The patch adds missing qpic data pins to qpic pingroup. These pins are
> necessary for the qpic nand to work.
>
> Fixes: ef1ea54eab0e ("pinctrl: qcom: Add ipq6018 pinctrl driver")
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
> [V2]
>  * Corrected Fixes tag

Applied this instead of the previous patch.

Thanks,
Linus Walleij
