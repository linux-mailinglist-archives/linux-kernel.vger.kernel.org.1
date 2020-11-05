Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FF02A8039
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgKEN7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbgKEN7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:59:40 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E0CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 05:59:40 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 184so2419641lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 05:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCrN31ShCh5kklAu2ybIlh671dbzV48lSFSfynZtC2g=;
        b=j6KSBm+wjUlygW1EdRVrx0blw6jsHzSB5/CgOkXRCqH/NcuFNb1htk1kDeF80U3QJK
         vSCEymduhh7Cley52uGQ6m4mfhRuSTyUdCQDwWmLU5QZLFNcN2hrsebkrNkSx34mTibg
         zog7uZxwmycHyHzro0eilsHPofHCjZWg83ydatCFTyFmWNEa82wIXlMxaykBLwYggeR5
         jdNsg5wwO1mjk7gc3QWwrO5R8Qo4l1uSQlIBi0Gvz+ShWTDfIRWIi553lxvFpf3m7FNN
         8N8uZXEzZLkKXcxNNrwLh94zQrE1bCPTIPgp/6JYcIGmbvoasQ6+0Z0x8STUwF+7QCqX
         Xr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCrN31ShCh5kklAu2ybIlh671dbzV48lSFSfynZtC2g=;
        b=ACZSwRs4CVa8/xaealjqKd3D+/lMTuC9vMiKbSp8hp6KYlOefL6UIDmOH2eVHWyzaP
         pJltvpBRhkhLzb46Wxu9xyDV7rtk+/lm2/u+tu63//jYEjPE2uOcazAcCiEQD09biLdU
         E9VrDx8on0/2cz3bumxL0Gf1xMvSOcl+TmMRy8RYQZgRi08c/m+ebW749It91wYKUv0r
         L8W0Uv050BS/dY3GiYw/o4ZXj0frwyDZLOLQ/QZw6lwoC3223ozgBgOycq3HJwdycsJT
         zlqerYn+bf8nqHXfoZzaqyr0MAsBlJNeoaPNa+wv2/fSI5dZiGMXU8r7VUOK+Mu5RabV
         NsRw==
X-Gm-Message-State: AOAM531Lfyo4tgGS7T32szHEOehktlrTvJPY/zmzipL9eA86e/LQ0POB
        SOOR28nNZPzQSSKzunYKNYeolVRpT+FWZF/xjDgoxA==
X-Google-Smtp-Source: ABdhPJw61W8PpYTmFeXsj72HbktXi8an2Ur5ijYtczp7vaWIvD5508dx6WXNwKxjaYVfl864h4lBwtpaJA4elHNr3dw=
X-Received: by 2002:a05:6512:3225:: with SMTP id f5mr992749lfe.441.1604584778531;
 Thu, 05 Nov 2020 05:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20201028043642.1141723-1-bjorn.andersson@linaro.org>
In-Reply-To: <20201028043642.1141723-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 14:59:27 +0100
Message-ID: <CACRpkdaBbdC5_6y=w5eL-jJ_Mk+toKWy8kj9t-UWx02wNfjo+g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sm8250: Specify PDC map
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 5:36 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> Specify the PDC mapping for SM8250, so that gpio interrupts are
> propertly mapped to the wakeup IRQs of the PDC.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Patch applied for next (v5.11).

If this is urgent and needs to go into fixes, just provide me
a Fixes: tag and I will move it to the fixes branch.

Yours,
Linus Walleij
