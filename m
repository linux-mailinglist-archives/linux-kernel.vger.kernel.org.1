Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E08728D1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbgJMQGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:06:55 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:45733 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgJMQGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:06:54 -0400
Received: by mail-oo1-f67.google.com with SMTP id x1so1237600ooo.12;
        Tue, 13 Oct 2020 09:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lJvrwL/FuYX27TcA8XBAMttZyQaUzn/E6l7mrrmjFrA=;
        b=ew9Alr9/fM/m8wmxu8f8c2aRG9dYolwaPzGWFBBVu2qL88k6RCOn5M3tjYRROsCeQx
         ko4G9OJxhY2FmU9JlRvyIMQBMVymoVzapmW1fqPYp1dwdZxXVrMDSDAzSqJ2ofA8J0OJ
         MgRGfsfIjyj1pSDdkIrbezTG1zkmwUuM5FQDxfhSK/sRaCQYnTrhtnz/QyplSVd9Dm8U
         iecui3pa9NJgcPS8bggYoMPlRbYSunCzMhzjo0Ky/7lbS5g3ZuEPGKI/nsPmAwlrebyx
         K1iRw7n3+nBvYN9h6g1fACAzcA5ulBWPaet0LW+4cj8fT282TcxuIyAeTwZgbyuCqwqg
         OGzQ==
X-Gm-Message-State: AOAM530YCC3J30aNMsiNdq8w5LSLL9Pa+4CUP0zuXqLFz61lcr++6qN7
        KpG+U5rUQGLloRSlQlPZvg==
X-Google-Smtp-Source: ABdhPJxqdYOtrD/HpqNx8Jl2GuLgmmSCJn2kjs3ih3MXm5tW7/fk6d/rOnxhKD9k0szvgWN4vx9rbw==
X-Received: by 2002:a4a:d8c1:: with SMTP id c1mr65697oov.31.1602605213606;
        Tue, 13 Oct 2020 09:06:53 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 42sm52847otv.35.2020.10.13.09.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 09:06:52 -0700 (PDT)
Received: (nullmailer pid 3610298 invoked by uid 1000);
        Tue, 13 Oct 2020 16:06:51 -0000
Date:   Tue, 13 Oct 2020 11:06:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     linux-arm-kernel@lists.infradead.org, tiwai@suse.com,
        broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, arnaud.pouliquen@st.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alsa-devel@alsa-project.org, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com, perex@perex.cz
Subject: Re: [PATCH v4] ASoC: dt-bindings: stm32: convert sai to json-schema
Message-ID: <20201013160651.GA3610242@bogus>
References: <20201009141051.27365-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009141051.27365-1-olivier.moysan@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Oct 2020 16:10:51 +0200, Olivier Moysan wrote:
> Convert the STM32 SAI bindings to DT schema format using json-schema.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
> Changes in v2:
> - use pattern for compatible of child nodes
> - rework dmas and clocks properties
> - add "additionalProperties"
> 
> Changes in v3:
> - move clocks properties for st,stm32h7-sai compatible, to 'else' clause
> 
> Changes in v4:
> - fix dtbs_check errors
> ---
>  .../bindings/sound/st,stm32-sai.txt           | 107 ----------
>  .../bindings/sound/st,stm32-sai.yaml          | 200 ++++++++++++++++++
>  2 files changed, 200 insertions(+), 107 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
