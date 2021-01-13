Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6972F42F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbhAMEQA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jan 2021 23:16:00 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43]:35422 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAMEP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:15:59 -0500
Received: by mail-ej1-f43.google.com with SMTP id q22so1157931eja.2;
        Tue, 12 Jan 2021 20:15:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PJipf0YRALSW9xdVpl4mhp1qmgYG/lBNfQyemCUFgyg=;
        b=O4QyPzHWnymyGUqJtUTRO1rEcObVwADVq8uHxT028Z85dTFp+OD7thg3Xm8Wwjjd+p
         LmHb3lbg4oUIt2+SrYSUni+5/eTyBnRG74cf7GimnrSU69sEIrRz3oCLHv7DFcAtuFE6
         oyrpFoHE3qcmKYPw64EsexDgQAuVGn6VmY5QI2+D6mf0+lwHWySvpLec0BibFl2fJDmg
         9b7cDgp+vd2LPK6rCt+Xkl1t8uFe52OSAr6O7ham1ynvCKcHUA/WVuCeBnp1VHF6Tr6+
         eYgQBR2BJC3brxgmf5w9INReCRogsw7fp8ZIDpF8fC99GAyN9tn52TbxvuSZHJadq3zb
         9UMg==
X-Gm-Message-State: AOAM532xXJ/bHh32vfVYDRVg+0fQf2Ltt4Wpt18aD/7FDv0d16GMsFUW
        sHVMhIhJ4Z4rdrxqBfmHibI=
X-Google-Smtp-Source: ABdhPJwQmRJisIJphTdMCJWSoi8/xg4TtnqG+foXNWhxc3YxIxB5bh0flErv+bX43rBwozXHTFay3g==
X-Received: by 2002:a17:906:1488:: with SMTP id x8mr175314ejc.124.1610511318285;
        Tue, 12 Jan 2021 20:15:18 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id hb18sm191535ejb.86.2021.01.12.20.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 20:15:17 -0800 (PST)
Date:   Wed, 13 Jan 2021 05:15:16 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH 1/9] arm64: defconfig: Enable vibra-pwm
Message-ID: <20210113041516.GB5974@kozik-lap>
References: <20210112095151.4995-1-martin.kepplinger@puri.sm>
 <20210112095151.4995-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210112095151.4995-2-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:51:43AM +0100, Martin Kepplinger wrote:
> From: Guido Günther <agx@sigxcpu.org>
> 
> The haptic motor for the Librem 5 uses this.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
