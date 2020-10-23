Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1CC296C50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461689AbgJWJq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:46:29 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:38993 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461680AbgJWJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:46:25 -0400
Received: by mail-ej1-f65.google.com with SMTP id qh17so1502004ejb.6;
        Fri, 23 Oct 2020 02:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C0sis39lZPDXmI65sJZd44FX9UwUIGI+RCVDZyJulyM=;
        b=P2J9khLV3i1P4IMEhSfRvuczH71VOUdMPwcEFHwbKEPCE6MnHVG1D9Fq0Hsh+8WmT4
         X/RtzykR3k8R2W5Gier45YcPdgbDrKaLg+QRaLV2e/z8fLCEwmB+HpmjbZnt2oQYGUkn
         iCugKbiukLAb4NAaeKBUO+1cS/1K5fkp1deky5l5QLdK5sSIYUSggKyjbycYXsGQNQ8g
         RDb4m8LVkd8QW6tTfoNVr9fjcxF7ItcUijujVYK7+uqeisd7ZF5E3OUXS8xkTrxI9yRA
         u7kB3fJNdq1VBIy5ruZyQTOn5Vp9Vo0yGbyzygsMD6aAbsEgS+EqPkaOMaWf8jM0B5i5
         scLg==
X-Gm-Message-State: AOAM531tKe9mzF4jderIxKGdlz/eT0Lk0au+LZJQkYKsZoquq24lASwM
        qwLTfpSszK//GSLjZj5GXpY=
X-Google-Smtp-Source: ABdhPJxF0g/UyOcs70u49EwVdfCjgAwtFkHOn7pxCWIAmoheDEVIYVdM0y0Qrg4maI6sfU0sW79gkg==
X-Received: by 2002:a17:906:4dc7:: with SMTP id f7mr1083777ejw.73.1603446383730;
        Fri, 23 Oct 2020 02:46:23 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id bc24sm492960edb.44.2020.10.23.02.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:46:22 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:46:19 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, marex@denx.de,
        l.stach@pengutronix.de, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: add defines for i.MX8MN power domains
Message-ID: <20201023094619.GC42872@kozik-lap>
References: <20201022150808.763082-1-aford173@gmail.com>
 <20201022150808.763082-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022150808.763082-2-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 10:08:04AM -0500, Adam Ford wrote:
> The i.MX8M Nano has a similar power domain controller to that of the
> mini, but it isn't fully compatible, so it needs a separate binding
> and power domain tables.
> 
> Add the bindings and tables.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
