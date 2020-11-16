Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594A72B3F14
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgKPIro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgKPIrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:47:43 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D515C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 00:47:43 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so10523957wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 00:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OsnG4mJxixMmqoja2ZiERpS6WkJff4Kqd2+JTXgyJVw=;
        b=amyRH2k57LBNDiMfoEDf9cUK96XLI02mlUQ4CSpGcXEFCzDqXM4BZwkwuhCESSc3fu
         jTl4i8EZ0V0CXjMNSENMYP8eoXi78bNG2DaPImNGhu03HbJc07u8eXXJf/ZuCevH0Up3
         byLVs0MuYLevzsycJu7RjtF72DNT/s8/f97CBR5ejcWIvLjzArdLUy3CX1388XOHrbjd
         5JArGzJES3mzncKLwGC9Qac/bi3v2hoCkl/0a654lsG8fLxExxZP7KSBONt4Q11Eh6wf
         s6aySg80+cRJbmDRFBZbIZ+DlZ4drmA+62IMTIjevQodRNrV53PBqk7wCbzneSXW3yOJ
         qu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OsnG4mJxixMmqoja2ZiERpS6WkJff4Kqd2+JTXgyJVw=;
        b=CRlxOUXitS0SrCqTmNF+VH2Xp/3+hvxDi4RWcDNIYPKgArq5lncTTYYSxAwQ5MwS6N
         FTS+Men+7p/KF/3ui605axTalNVH+65/Di6D1StXEmGbsLbSUXM8yPO9V+70IGdmN0aB
         9aP98GMaZDiZcd60i5+bTmHSHBW9w1AEPVNKlQ4duCDgv0LrAglysEZy5AYL0OlVs2mU
         e7OgeJDeKiUI1MjO7wj/H27vtXjiwL4FNUTpBLHbRuAS9K1iCQJ0Jc2GVVxejCAE77Oa
         bERLcdb5Iy5nA43Iq4hcGYL0iTgGDKzPJNRyxpUHv2/v8TV/1R/gZiE7OwUffv3tDx6g
         yQ3g==
X-Gm-Message-State: AOAM530LwtsGyOXObevWPLoXbRPGN6hChd+JUrf0njIBF2+IL9a9yUbG
        rrEX4XBaABh9wxlKuU6TBu1KF9497UX8Rvob
X-Google-Smtp-Source: ABdhPJzThPcQV9xvgpnfb6SgQv9vBr/EntqW7d563O+ypTTr4341Io//4QfySQQnBAuAOo1cDmP8CA==
X-Received: by 2002:a05:6000:345:: with SMTP id e5mr17274337wre.333.1605516461527;
        Mon, 16 Nov 2020 00:47:41 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:edb9:72a:9e35:6eb? ([2a01:e35:2ec0:82b0:edb9:72a:9e35:6eb])
        by smtp.gmail.com with ESMTPSA id u14sm18701424wrq.93.2020.11.16.00.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 00:47:40 -0800 (PST)
Subject: Re: [PATCH v3 0/3] phy: amlogic: add MIPI DSI function to analog
 MIPI+PCIe PHY
To:     kishon@ti.com, repk@triplefau.lt, Vinod Koul <vkoul@kernel.org>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201104135631.1550125-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <e42ce82e-7db1-a35b-c6f4-b8a8a184e43d@baylibre.com>
Date:   Mon, 16 Nov 2020 09:47:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104135631.1550125-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod, Kishon,

On 04/11/2020 14:56, Neil Armstrong wrote:
> The AXG Analog MIPI-DSI PHY also provides functions to the PCIe PHY,
> thus we need to have inclusive support for both interfaces at runtime.
> 
> This fixes the regmap get from parent node, removes cell param
> to select a mode and implement runtime configuration & power on/off
> for both functions since they are not exclusive.
> 
> Changes since v2 at [2]:
> - Add DT review tags
> - Rebase on 5.10-rc1
> 
> Changes since v1 at [1]:
> - added description to binding as requested parent
> - updated commit log of patch 1
> - also update example of patch 1
> 
> [1] https://lkml.kernel.org/r/20200907073402.26674-1-narmstrong@baylibre.com
> [2] https://lkml.kernel.org/r/20200915130339.11079-1-narmstrong@baylibre.com
> 
> Neil Armstrong (3):
>   dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove reg
>     attribute
>   dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove phy cell
>     parameter
>   phy: amlogic: phy-meson-axg-mipi-pcie-analog: add support for MIPI DSI
>     analog
> 
>  .../amlogic,meson-axg-mipi-pcie-analog.yaml   |  21 +-
>  drivers/phy/amlogic/Kconfig                   |   1 +
>  .../amlogic/phy-meson-axg-mipi-pcie-analog.c  | 204 ++++++++++++------
>  3 files changed, 149 insertions(+), 77 deletions(-)
> 

Could you review this serie ?

Neil
