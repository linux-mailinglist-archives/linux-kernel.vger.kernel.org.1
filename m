Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8862853AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgJFVLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:11:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34647 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgJFVLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:11:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id d28so224274ote.1;
        Tue, 06 Oct 2020 14:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5FP0smEmtRjA7sa6KoPbSMBo/XXzMk5YV0latxBLaGo=;
        b=B1biTQ7G0TMiCR/L0g+TsD2+1UfQj7qXkolWxczh+39lD2UvdiHG5AAM1zYmh+7e0U
         UpiSZFsK6TdCtCIFZdQBNsEvsGH9mg4E6whR+9VtWaEFOe26SutfNnNwa8/ArPFwh43P
         IHL+ACecq1HlvkhMpYI+y7Nk4x0HjRxU88k7yk5Yh4uYVCHcrlEV1Nx1x08dUiaTHv5y
         EcuQIoXpg/XoMaMi+9uTWf9Pe0anFQ++uDcgneFlqPVYZYTGWQwkcZVI34/DSmCdTapl
         H44VfA+9JS0fDc0XCzOjJOhWyuV5CIC3Gy/KRUSMzv0z81He4GEcGU+n1+u6JBmWpFIp
         BK1Q==
X-Gm-Message-State: AOAM532HF4TMC1D2DbQ5oovUXjtXlAoqyzJB4UshTnRE4sWXJQ1Nli1Q
        OLwZBe20uImLLy83tnh/gQ==
X-Google-Smtp-Source: ABdhPJznxbwgrx4oSXOYZC8dTgbjtyD4TW76I6oDeE7VGirnsKALIyRtHYG26LH2daEjUmTJm4T2ag==
X-Received: by 2002:a9d:2ab:: with SMTP id 40mr3904256otl.137.1602018678507;
        Tue, 06 Oct 2020 14:11:18 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i205sm3286oih.23.2020.10.06.14.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 14:11:17 -0700 (PDT)
Received: (nullmailer pid 2848240 invoked by uid 1000);
        Tue, 06 Oct 2020 21:11:16 -0000
Date:   Tue, 6 Oct 2020 16:11:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v6 13/14] dt-bindings: sound: sun4i-i2s: Document H3 with
 missing RX channel possibility
Message-ID: <20201006211116.GA2848184@bogus>
References: <20201003141950.455829-1-peron.clem@gmail.com>
 <20201003141950.455829-14-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201003141950.455829-14-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Oct 2020 16:19:49 +0200, Clément Péron wrote:
> Like A83T the Allwinner H3 doesn't have the DMA reception available for
> some audio interfaces.
> 
> As it's already documented for A83T convert this to an enum and add the H3
> interface.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
