Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B1222B8BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 23:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgGWVbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 17:31:31 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:41354 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGWVbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:31:31 -0400
Received: by mail-il1-f196.google.com with SMTP id q3so5593249ilt.8;
        Thu, 23 Jul 2020 14:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BIw6m41bEFoOKz4cgGIlpAZHm+JvVBbNbLNDcXn0BJE=;
        b=DYOlVt3E4OUn6MVmEveVmhzJ9LgEmSVeI/V4tWM8mJ8o/ttQtZLqhBsU/rINVuV8N1
         rykbbQZ3pk+bZwRiuekmkXyeW/htt2it5BAeYlngoXfd7ATYjTGjwcrkDTty7iGAFXAA
         KOEHSplrUqWz/SbpdFiYw1XQ0Xz9zi3HzFTSuYyaMWrgGNAfBTVwJAzE9f8xG8/L5Vix
         F0m5wOtPQ/piluPXnNP5ogk6rhwW1BNqKprkglpjBSL1MbMEPvdnhtuauv96SWeQLSYW
         GsMyzvhJsfLmdbV1CFhiKG+83g793lyzqIA7ikqvjSf5n+Auqa0c7hFc1z3PSb4QLBE5
         jUxA==
X-Gm-Message-State: AOAM532pFZEt/BXrHPiIZ9l44X2+cb9Q3dveXMl2XhPvTFDN85QZ0KNj
        smLsHe+94nd5A9AP6mUn9wtyHA2LNghq
X-Google-Smtp-Source: ABdhPJy5nDdiGLJMan1qtQeNQE1tFghS/VAw2SDr5DSd0X01/uox2cHJXZa8Oq1fFecjqwJV15WgGA==
X-Received: by 2002:a05:6e02:e89:: with SMTP id t9mr3438231ilj.292.1595539890313;
        Thu, 23 Jul 2020 14:31:30 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l13sm2023466iob.28.2020.07.23.14.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:31:29 -0700 (PDT)
Received: (nullmailer pid 894261 invoked by uid 1000);
        Thu, 23 Jul 2020 21:31:27 -0000
Date:   Thu, 23 Jul 2020 15:31:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: mfd: Add compatible for the MediaTek
 MT6359 PMIC
Message-ID: <20200723213127.GA894209@bogus>
References: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1595509133-5358-3-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595509133-5358-3-git-send-email-hsin-hsiung.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 20:58:47 +0800, Hsin-Hsiung Wang wrote:
> This adds compatible for the MediaTek MT6359 PMIC.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
