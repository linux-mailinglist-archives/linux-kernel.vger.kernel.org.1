Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA4F2F425A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 04:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbhAMDW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 22:22:28 -0500
Received: from mail-oo1-f50.google.com ([209.85.161.50]:34372 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbhAMDW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 22:22:27 -0500
Received: by mail-oo1-f50.google.com with SMTP id x23so186788oop.1;
        Tue, 12 Jan 2021 19:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dCuXFamHqL8Ku2Wo/6BW1bsP8VAIVco/Vi8snebYSdw=;
        b=QVA2JAEfLe9BnLHZvicMSOCtAOWvfxwfyfgGmXfiXoUljFDpNiRBddpz4TV1ex6DAI
         QumcdpGFAQ7+/MvNdMwv0O1vqMHtGGZ+iBG2t/ZlW5aUL5qAC0e8s6ABXp3+btehAmgN
         YzULweY3Hyk4JoPTnk9i0UXHd2q3wYxybzCZAF6fZZmuN+eBBgr1WS5LjT+xPPS4bYG4
         +3ZcS3ZAi57hUJ2vPpG6Uf/trRpAwGOpWIQengva/8qXxwABka6+9HIkFQV9f42LJU2Z
         ceTK+UB2XKE1rzklz+H3M0VjExFnkC9nB2Kdd6M3U59tsa4R5tnhZCsUNSrKXUi3dpOK
         6Fxg==
X-Gm-Message-State: AOAM53039cX9VPP0RTNEmle/rz35Fx0NJpNqnwo7a121tmyiwx56adA6
        Qr+tT3czRFdbKwXVznXEg/l4HpqSjA==
X-Google-Smtp-Source: ABdhPJxvPUHq7F5Yf0LRxZpN5QJmeXPpj175mCAikbYkaUkymgUk6owZoKstb8TsmiK/htdrcW6F2g==
X-Received: by 2002:a4a:3e42:: with SMTP id t63mr1403771oot.32.1610508100443;
        Tue, 12 Jan 2021 19:21:40 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z189sm170866oia.28.2021.01.12.19.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 19:21:39 -0800 (PST)
Received: (nullmailer pid 1466404 invoked by uid 1000);
        Wed, 13 Jan 2021 03:21:38 -0000
Date:   Tue, 12 Jan 2021 21:21:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: Re: [PATCH 1/3] dt-bindings: power: Add domain regulator supply
Message-ID: <20210113032138.GA1466354@robh.at.kernel.org>
References: <20210107104915.2888408-1-hsinyi@chromium.org>
 <20210107104915.2888408-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107104915.2888408-2-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jan 2021 18:49:14 +0800, Hsin-Yi Wang wrote:
> Some power domains (eg. mfg) needs to turn on power supply before power
> on.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  .../bindings/power/mediatek,power-controller.yaml        | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
