Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5252636A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 21:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgIITdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 15:33:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34274 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:33:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id q21so3896357edv.1;
        Wed, 09 Sep 2020 12:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sw9jWXv7ueCKGASAg1xofj4dYvmEqJQsQ3PAFeaA6O0=;
        b=AV5xyckKHQgGkQthB96Gvf23xoKfirCsw0Nhx5zdmzc9R0x+MzYBeOSUrmpCYszHdW
         cX/0Fk9fTlUvxxt6mGRJPo7mjyEq7Gm/jAr3bPcWQQbOJDRmEEwZT1gGLCDB6pbrZ757
         AjaQTGshT1fqUyEgtSoBzTX1+r1qPBatA8LDzIdtskZ5VNJ3uEw2ySI3bxTqijCbdA1H
         ea3K4O9NbYluf90aZWDoFWNt+HLhV5LXmlBYw550gGd0zTLy8S2lonoysy7YFxB8UIwZ
         KOdG++S0JNx3lWVqrGt6m4C4+GPjvAEPT+4oAMMbDPDdjBUhBVGDqpufByiCjw3vPALl
         +bWA==
X-Gm-Message-State: AOAM532wAcnM3jYWNUKYe70RxFJnv8O0grDP2EM0QWNaalEZy5SWj6Dn
        2YzMgJvpYtLze70zdTLUWh8=
X-Google-Smtp-Source: ABdhPJydL+n5p7BlcUySs/kCrMXSVaq5M88wRrv1kwZpvcNlByzDTl2rURnTEE6Whm6aV3V+mEf4Bw==
X-Received: by 2002:a05:6402:1353:: with SMTP id y19mr5861188edw.71.1599680028975;
        Wed, 09 Sep 2020 12:33:48 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id f10sm3805180edk.34.2020.09.09.12.33.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Sep 2020 12:33:48 -0700 (PDT)
Date:   Wed, 9 Sep 2020 21:33:43 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org
Subject: Re: [PATCH 2/2] memory: mtk-smi: add support for MT8167
Message-ID: <20200909193343.GB15293@kozik-lap>
References: <20200906180938.1117526-1-fparent@baylibre.com>
 <20200906180938.1117526-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200906180938.1117526-2-fparent@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 08:09:38PM +0200, Fabien Parent wrote:
> Add support for the SMI IP on MT8167
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/memory/mtk-smi.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

