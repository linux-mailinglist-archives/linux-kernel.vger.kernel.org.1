Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09E72B73A4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 02:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgKRBRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 20:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgKRBRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 20:17:23 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BFDC061A4F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 17:17:22 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s30so574736lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 17:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upNhDSD7uK2ZOVQ0hHkzhR+LnuCA5mLVwy01zUvUhgY=;
        b=bh+8rQxwa7EjqGdcGJ0qNVsUM0Efy0UbTffNihX5hvdZWSCg13yXcuLVT/XQ+mL3y8
         j3YsVmlBs2K2YkpaHT7okR68fq7dIIoLfLJFfUod/C+v6O0fHrxUPaYU6WvirJjsdGaT
         m5iuhQ0cBW3zH1BevrETby2ATSldsXill6yhSradv2bCdNneCQdasMPdNavDdsDRXbwH
         o5i39TSLtvB1PYLKz4dhv38Xvz8w3kyQcVJa+hDXFJpeGC1uRk55rxjd2WQ8Xb1bPqAt
         k8eetWzgpY6smlLohuJC67AP4sHcQEju41rmUl+whR00O9X00ObqbUmEUq57rqPR26i+
         TwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upNhDSD7uK2ZOVQ0hHkzhR+LnuCA5mLVwy01zUvUhgY=;
        b=Nn6vCuoZojhzdb6GRyPc+cD6VFlRIULai0b45amcu6IDELXCo2ZCF1NinL6K9HIp6A
         2vtGYmJ9gl0wsjdMCnd3FfQjvi40My8sstI1/yZq5F33H+mBHvg3QFf5tkPuj7sPV3c7
         fWIsWVf9+0befj7O9BtEUSNllhnBpitVDaAzUdPmQDGu18x5xseKQS6LlHkrrA6eJ5th
         LMtwPxQFXTh2w+qFVfhM/bA/ovCpt0xuJZmF6H1zjt/HgLM3vrxoCcuR/ODB8hRQHOJ+
         g/maHjwFYb/Ber1+lCIlKtJjXVwJgegZ/AD5WRbKvTvJW5v0zRfpJvdRk1SdNV7RjdSX
         YSYw==
X-Gm-Message-State: AOAM5308jX3kxfvPTcusSWHUwc6F4eVenJzp2qoGkihsp2vXflrzX+Y3
        y4Y5Ii97InRuHLwcG1X+JIc6zy1nUcPBCIDZEH9qKg==
X-Google-Smtp-Source: ABdhPJxFHQAIQRDKhTcuTDcK2nXR2ixM+rGNxNiVeK8ytP7bxNblPyvGZGafF5gPs+1iohaXMatPtKjbDdSfBnvUCG0=
X-Received: by 2002:a19:546:: with SMTP id 67mr2520411lff.502.1605662241004;
 Tue, 17 Nov 2020 17:17:21 -0800 (PST)
MIME-Version: 1.0
References: <20201117174845.28684-1-manivannan.sadhasivam@linaro.org> <20201117174845.28684-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20201117174845.28684-5-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Nov 2020 02:17:09 +0100
Message-ID: <CACRpkdbaAJdH6FebbpiAV7wmoTA8Rb_vqKyrDNLX9sy4Jv9RjQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mtd: parsers: afs: Fix freeing the part name
 memory in failure
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-mtd@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 6:49 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> In the case of failure while parsing the partitions, the iterator should
> be pre decremented by one before starting to free the memory allocated
> by kstrdup(). Because in the failure case, kstrdup() will not succeed
> and thus no memory will be allocated for the current iteration.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Fixes: 1fca1f6abb38 ("mtd: afs: simplify partition parsing")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Good find!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
