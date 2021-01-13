Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0612F4442
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbhAMGFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:05:25 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37087 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhAMGFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:05:24 -0500
Received: by mail-wm1-f49.google.com with SMTP id g10so484621wmh.2;
        Tue, 12 Jan 2021 22:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M6RP7/pPMMjBYm8VlmfmSTLWwW3y/ULVDt749IgZo84=;
        b=pCbVjxiAxzdX1czu8Vbu8OBYa9Mv3A1mBs2CtZHiuL4QhNLw/7YJUbhflOzSCb0jjJ
         /6ti/YLLMC8OYf6aONLGknvlqDgJ/pP6lYBRAlyLLKuDadTTStQGeAd5gez4Hod/DrMt
         HVwxgdYhFjzb4/BqlvZMFXGdFontF/NqN2R0NkCZqqy8RZtvNRqEOF5m7gymrRE4cC+L
         zV/RyiWlEC2CtT0JMgG9qusk058mZidaSquXr+m2RiZv5npIw2XnOQolyYX2VgVYxo0e
         ZCibtPAvCcFWOLW1Wcf4PIpsRStr1qoi9BlmSnuJssQZD/WkQ5G0cEArvuiXqCUATSjr
         S1+g==
X-Gm-Message-State: AOAM53078h3G2xlpr7dfy0jWW3dVztNGDNLkSl7AfAua4iiHulT/JIZo
        4Ot+P0W8Yp+G7r+oegj18kU=
X-Google-Smtp-Source: ABdhPJxMDZDmiAGJUgo2x7GtI57MCobXYrci+N5hoWi7tgULDOR3UijGwA6sQn1pbKXvqmavpcdMMg==
X-Received: by 2002:a1c:1f54:: with SMTP id f81mr530796wmf.44.1610517883110;
        Tue, 12 Jan 2021 22:04:43 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id u17sm1173602wmj.35.2021.01.12.22.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 22:04:42 -0800 (PST)
Date:   Wed, 13 Jan 2021 07:04:40 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon: add more pinctrl states for
 usdhc1
Message-ID: <20210113060440.GB12275@kozik-lap>
References: <20210110113826.1257293-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210110113826.1257293-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 05:38:26AM -0600, Adam Ford wrote:
> The WiFi chip is capable of communication at SDR104 speeds.
> Enable 100Mhz and 200MHz pinmux to support this.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
