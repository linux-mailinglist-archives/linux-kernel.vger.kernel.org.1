Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885822F01B2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 17:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbhAIQdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 11:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbhAIQde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 11:33:34 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78D7C061786;
        Sat,  9 Jan 2021 08:32:53 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id g20so18793905ejb.1;
        Sat, 09 Jan 2021 08:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v2XVnS8ztNajGPJmvpAHjx4FkY4pw8QExaQyyNzjhpo=;
        b=WjrHdbm//44Rsd7SKMKSW6nvwg/g0baienGkeiwF4X6sY4eTs1xgok6DmuMMthc4bq
         9zyX2eAMmphqK4uK+tP89S7JBOiDhZLolXgzamF4Ws8JaxBeC2ShyUyO5v7wj0U7+7mg
         CA95LVFVPktgTQzsb17N2bcAgBBNYwAfTWyouXD5JVXbgRGyiJ31pLJQNNl0qdzzHkX6
         LUPU0P+DN3nqv0e+jI7OvmCc7qh1kJiYVPqXJAgHrtPhhgTA1r3eBUQ0yFjFEVPI3Kys
         zALovUtaQBVW547F8f0spZDk3BKRsAPEwXrGOwCt2xctoM+9xyvRtrTz/Upg9FxMRy/7
         h0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v2XVnS8ztNajGPJmvpAHjx4FkY4pw8QExaQyyNzjhpo=;
        b=eNFnDw0xS4E55JDVmWMwRYBE7Ny66s3zJN5u2+lzef4r+gqFI9k76jnS14F7n2nSV9
         w0pxcDh3xX1Mp8n6sgfASUIpWcM6x0fX6EbPVPD6gCX6mgWXvEXC2OEPZYniiB5gE23B
         1WKAS2yPmiaXOHNYfX84q1uPAE0dkgLExPoIJsnpWcf0e8t5mc5SJh3Odq9NFFGzeolJ
         EiyT90I+NbeSBXdjFYwD06Xi5ha3xbx96RFfvGLEsbi0mi9QszucN5vPxpXkGLlG5f6X
         kLO3xseL97pZIDw/qnhxJCZT1/bH0pMYUt8ftT580Voxl9tEb5t04vYP2U2bs5ZdYmUC
         T+hA==
X-Gm-Message-State: AOAM530udgy06cVti5/T5FiAhDBys+JKBJu//YEaVrOnyWtH0WsocOXl
        z9r4kd/Ex2bngDNUN8MwdZ8=
X-Google-Smtp-Source: ABdhPJzinRGvACC+fEhtGI9deX5pGMBvBVO587hC53sGreyyUiThtFCQA4qn/mOV26WKA07jnYyfbA==
X-Received: by 2002:a17:906:3a55:: with SMTP id a21mr6084350ejf.516.1610209972501;
        Sat, 09 Jan 2021 08:32:52 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id s15sm4759364eja.36.2021.01.09.08.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 08:32:51 -0800 (PST)
Date:   Sat, 9 Jan 2021 18:32:49 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/13] arm: dts: owl-s500: Add Clock Management Unit
Message-ID: <20210109163249.GA462782@BV030612LT>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
 <d05d2d0907ffcd090b36e17918039867780b8355.1609263738.git.cristian.ciocaltea@gmail.com>
 <50c0be54-bcce-5c59-4749-a47d69271e6a@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c0be54-bcce-5c59-4749-a47d69271e6a@castello.eng.br>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 12:38:13AM -0300, Matheus Castello wrote:
> 
> 
> Em 12/29/2020 6:17 PM, Cristian Ciocaltea escreveu:
> > Add Clock Management Unit for Actions Semi S500 SoC.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[...]

> Tested-by: Matheus Castello <matheus@castello.eng.br>

Thanks for testing this patch series!

Regards,
Cristi
