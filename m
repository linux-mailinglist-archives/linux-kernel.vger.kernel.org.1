Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40DC2794BB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgIYX2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgIYX2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:28:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEBFC0613CE;
        Fri, 25 Sep 2020 16:28:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so5671020wrp.8;
        Fri, 25 Sep 2020 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jd47j1+vGN6OIJO/6iA19FE0KaxRE5A5CnfIKpoQkIQ=;
        b=e0cvkNaMlbUX2F2XwkFA4O2XZ1gNve3Ojv9lXdCwbijiJoDMN3hnIYCOhxRzZSKUoi
         6TSrKgLebJAZoaisEhYGNYAkwhSfxITLRQX62EPKxnIhc4cO6J7KdEGtxMB7WJJmdo+U
         HieVElZiIaskvsSJ/vPbI8Pc2BMtQiqgfJ37wbWEwChKSub/wwRk8vLfrZiROI6SL6QR
         8FQQtaWLkC87LqyrKcM+eVLCQhxdLwBve2q/5aNnFKMF+La7rH9EHiQHNvBvTxpjax+3
         GtFsD8J3X3d0ti6cvdvvyjRirm0JsDpaAZp0eYPNaTrwWsd6upKVP1e23cD7zK3bFbbG
         +T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jd47j1+vGN6OIJO/6iA19FE0KaxRE5A5CnfIKpoQkIQ=;
        b=iclbn3FrA6dyEkS+DABJ7L+1QFb4DLLVPxK3TiPRHElH/676HKjlFP6Y0NNWeG3EB+
         nEIAKzADgtoOfj++gJ6mtYIXl50vGoiziScCP/m5dcGnzLDb2eimi2cwDgIHjLCuBZB+
         Cf7MP18QTGdWpdkTBCrAcOSuUJAL742sC7NClW40FvFDNLqnJYu/Tdh6dkdKk+R4GdFN
         IH6gpRs9leUAVf4arcvwaolXqUr26yBy4M2ajCV3mpRJN3zDD+0EKkK/h3O9W8DQupSz
         hV9xbEGFdaAzTpMPhNdQWxGPVJ2PdW9bTXVhPoefcZj3fqOf/+zVWBY0KDvUTMEGmEIf
         3tVw==
X-Gm-Message-State: AOAM532nc18SKyaD0I2cxVyslHTbOG2sxALl5Oz3rsovx8l9P7juVybF
        AuE+fQ9W0Rk3Gp+wG6tNdDnyI/U3QkOO6Osy
X-Google-Smtp-Source: ABdhPJxmiVQO4JVB3ctsSfBW+PcoODSIgWVw8c+BQzM7TOtebjMW/fPmPX3kva7fEZARFVBTu6LCjA==
X-Received: by 2002:a5d:6552:: with SMTP id z18mr6601067wrv.32.1601076483385;
        Fri, 25 Sep 2020 16:28:03 -0700 (PDT)
Received: from a-VirtualBox ([103.120.71.253])
        by smtp.gmail.com with ESMTPSA id c205sm551758wmd.33.2020.09.25.16.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:28:02 -0700 (PDT)
Date:   Sat, 26 Sep 2020 04:27:55 +0500
From:   Bilal Wasim <bilalwasim676@gmail.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        drinkcat@chromium.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        matthias.bgg@gmail.com, Collabora Kernel ML <kernel@collabora.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: mt8173-elm: Remove ddc property from panel
Message-ID: <20200926042755.78b8e013@a-VirtualBox>
In-Reply-To: <20200826090218.682931-1-enric.balletbo@collabora.com>
References: <20200826090218.682931-1-enric.balletbo@collabora.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Aug 2020 11:02:17 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> The elm and hana devices uses an Embedded DisplayPort (eDP) as
> interface for its panel, so the DDC channel specified in the binding
> is useless.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi index
> a5a12b2599a4..1fe5dac24ba1 100644 ---
> a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi +++
> b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi @@ -86,7 +86,6 @@
> volume_up { panel: panel {
>  		compatible = "lg,lp120up1";
>  		power-supply = <&panel_fixed_3v3>;
> -		ddc-i2c-bus = <&i2c0>;
>  		backlight = <&backlight>;
>  
>  		port {

Tested-by: Bilal Wasim <bilal.wasim@imgtec.com>

Thanks,
Bilal
