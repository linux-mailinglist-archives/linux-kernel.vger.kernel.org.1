Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A442B2E45
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 16:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgKNP51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 10:57:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35474 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgKNP51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 10:57:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id k2so13701914wrx.2;
        Sat, 14 Nov 2020 07:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o5pULFzrBxebCyNeuswbbXy3JZLZANoFgfhRIrZd2bs=;
        b=azWu9l8dx+wUHPWv0fctGDgEbNq2EW3DC4PB6VlhGsZkALEC5NerfIh7VQpeYfntAK
         S+/rQBG4vyF+Mydqu7Mtk0s3MNFuPkN/0YZKrMsSSifZdRABqzOjCr/wNH52wQmMmCeE
         K7kDxslU3hbJ/JxJ0x9DU8VS2Dakqaz77TuxCfwggcHNf1iQAE2o4SCJIYoBOrxjMMBS
         bPOUENX3xVVkFCXYHKc6dJGshsqAnss9Bd47uX/jjETJTBRcO2T3nTRDDPUf4ztdJOKL
         zv4SaBZTtYo1zhlrNnjFxiGt7cAk2aK/GHdrd76gRUQ5rOvuztYi1ADj74TnkJvVz138
         rcUQ==
X-Gm-Message-State: AOAM5332lOwpyK2FzA2hB4DYGGylv0vMph9kXEA6Sd5NInzEvrC/C6Ql
        wUHrcqJe/haH/Do1HuKPW58=
X-Google-Smtp-Source: ABdhPJwUpszgiceBSDF3QvVtyJckqMGzOiR5fFz2s7CyjkN7rivKnu90Z0+4eFvZ1sT5lKHdMwp/SA==
X-Received: by 2002:adf:f9c6:: with SMTP id w6mr9995320wrr.273.1605369445673;
        Sat, 14 Nov 2020 07:57:25 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id u5sm13177623wml.13.2020.11.14.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 07:57:24 -0800 (PST)
Date:   Sat, 14 Nov 2020 16:57:23 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] arm64: dts: imx8m: add compatible string to .dtsi
 file
Message-ID: <20201114155723.GB14989@kozik-lap>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201113110409.13546-2-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113110409.13546-2-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 07:04:07PM +0800, Alice Guo wrote:

Where is the changelog against v2?

Change the subject to: "arm64: dts: imx8m: add SoC ID compatible". It is
kind of obvious that you add it to DTSI files, so no need to put it into
the subject.

> Add compatible string to .dtsi file for binding of imx8_soc_init_driver
> and device.

s/file/files/

With above changes:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
