Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF127D695
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgI2TP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:15:26 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37695 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgI2TPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:15:25 -0400
Received: by mail-oi1-f193.google.com with SMTP id a3so6727310oib.4;
        Tue, 29 Sep 2020 12:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=346hJnOPmUdYTO1XGKfGPvftZz7Be1FErSbqV+wAnOk=;
        b=W7FkNwIwVUb8/iowPEpW0Xia/RyJ5z35vTQY5W3Uw9Y2uZSNiDTRVeLEjd4rhQwfeQ
         xxsNfUbLh94WDGNhoPdD3orqOe/PYM9PBg5LDWOhfCb1VqQ2MIyIfN3jDG25uqaiBkyU
         8MyvyoGqdF2RLQyO2iySQZiAI8Vxs8P1NHca79bZZB125s8q30BQ2Kv3/n3i7ErxUTrw
         9CTTfH/tOpSKLSEnczMrwBrPx5VeA20lAEXlSlnU2I6DheN+YfIcrchLoMsggofQafJt
         lp30d175cA4/acJjK+rkiu2VgaUZxYs7JqLvK/LM5Nsmz15JKVT+tIwexaPYja4jG0ml
         A0WA==
X-Gm-Message-State: AOAM5315jqrhfjC2xpuVSWJBkrU7Vr6dUg0OLeGUJ6UqcyFNlalaGi+w
        zYSfslPvxSdh+WlHQinGM30n+Fu0w73DooM=
X-Google-Smtp-Source: ABdhPJyzfPf1XlU5BSygr2mx1dhBOPdRzVzEw9KhoGbdxHoU0skc1N7p1l3aYdyfh+ybxz4G4Cb3tQ==
X-Received: by 2002:aca:4fd5:: with SMTP id d204mr3649900oib.58.1601406925027;
        Tue, 29 Sep 2020 12:15:25 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x21sm1188927oie.49.2020.09.29.12.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:15:24 -0700 (PDT)
Received: (nullmailer pid 991934 invoked by uid 1000);
        Tue, 29 Sep 2020 19:15:23 -0000
Date:   Tue, 29 Sep 2020 14:15:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>
Subject: Re: [PATCH 01/14] dt-bindings: vendor-prefixes: add DFI
Message-ID: <20200929191523.GA991853@bogus>
References: <20200926162811.5335-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 18:27:58 +0200, Krzysztof Kozlowski wrote:
> Document binding for DFI Inc. company (https://www.dfi.com).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
