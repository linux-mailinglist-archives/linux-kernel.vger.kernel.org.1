Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51B22C1126
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389949AbgKWQ55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:57:57 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36353 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbgKWQ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:57:57 -0500
Received: by mail-ej1-f68.google.com with SMTP id o21so24288366ejb.3;
        Mon, 23 Nov 2020 08:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u+GuuFPQRaPyq7XGG3ctPdJg1VzAE2HhoabXY71PAd4=;
        b=AuDnqZ5znKP3DMRQS3Deul/PTt77gpLEiR2/03NEhMTXXLPus8W1kZOgaJKprWMHou
         BAkmgQN4LXx3HCIIibtGEbsEYuxmFgwgw7h+5Qh64z/Wc8nfn7pwpdEcOQHPoMvp0gZA
         WUEII++gsM+nja7zCWaZllM5cSYf3uVOyKCwZdGDiQHFu7FpnkAcSVH4x989rIICaSmR
         BUjVEo0CoSiJ8OYrnRSBN0VBr4+k/gRdNq4i3BOWaSSCbeB1iK4KJar7pG7OvsUk0HrR
         A8mMz9xywa9vvyCVEXD5ZoXe95EfZR/1YqDtOmBmKraznaQcL3PTzs3o78DA2kKVIQz4
         9NWw==
X-Gm-Message-State: AOAM530m8QNDTiIfUm4L1pm0HIsGAyL2Y65rjuTukxdZm4ng5i4/WeKw
        x+oZC+ldT1sYPHpmGHoYXWc=
X-Google-Smtp-Source: ABdhPJz0tysWwT13ob+iZmeyME81Yg6pEDfgr4LdVWFOJMOMkGgZOormMyEVd+5a9S4xKDkcg3GW+w==
X-Received: by 2002:a17:906:2b06:: with SMTP id a6mr470698ejg.283.1606150673985;
        Mon, 23 Nov 2020 08:57:53 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id rs9sm4577335ejb.81.2020.11.23.08.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:57:52 -0800 (PST)
Date:   Mon, 23 Nov 2020 17:57:51 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/4] arm64: dts: imx8m: add NVMEM provider and
 consumer to read soc unique ID
Message-ID: <20201123165751.GC214677@kozik-lap>
References: <20201123095108.19724-1-alice.guo@nxp.com>
 <20201123095108.19724-3-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201123095108.19724-3-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 05:51:07PM +0800, Alice Guo wrote:
> In order to be able to use NVMEM APIs to read soc unique ID, add the
> nvmem data cell and name for nvmem-cells to the "soc" node, and add a
> nvmem node which provides soc unique ID to efuse@30350000.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
