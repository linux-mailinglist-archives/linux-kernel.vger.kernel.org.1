Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5195292F57
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgJSUZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:25:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42083 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJSUZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:25:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id 16so1401447oix.9;
        Mon, 19 Oct 2020 13:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2eJvh+OiDExYcnw0fjD4IRdxMtw5g7kaSI+P1n3wmsQ=;
        b=l24xSSlH7hd/gFnhUdt85HuOh/jHEs5k9+zq+IqURF5vXMCQP2/3w3+vh+KcQREKBf
         jq5bOYlvfV1hdtpvsc/545U9cRbXgbGg2lDfN/GrSo45vts+uqv/FyJyNvtLMmGGWDfs
         KRMZnG4167afVOP0+TZWbNXnCsrIHQaRv19DK9GnsGtSGcIxv/U89vW1JeozwJuQN1G5
         A6V5+HNRwYGGnrseOrbsBz5Dr3/JGkBGBPdXVfhqvCDm8YEotUfENl0UfAPK6J3J2Jmb
         TJTL8MSFwIl4+X8CTlts3eIMBDVnywMGVeXjuPsCxHRCWKPy7BzwThFGAvUVgyPML8/1
         ze0A==
X-Gm-Message-State: AOAM532fm6NYZnD9CyjRfKGeNT+0BHYjyZtVUQX96/xDdv+uqOGNgBtx
        kmCPo5oikuPbqxORK8B3wQ==
X-Google-Smtp-Source: ABdhPJztogXjATiDScTQzUAmCLK5ItkQoRw7qffd7jiZfUIT0HmuWhenym77skh/v47Cj3OLzspmqQ==
X-Received: by 2002:aca:5058:: with SMTP id e85mr799620oib.79.1603139126431;
        Mon, 19 Oct 2020 13:25:26 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p10sm225896oig.37.2020.10.19.13.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:25:25 -0700 (PDT)
Received: (nullmailer pid 3547145 invoked by uid 1000);
        Mon, 19 Oct 2020 20:25:19 -0000
Date:   Mon, 19 Oct 2020 15:25:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alexandre.torgue@st.com, mark.rutland@arm.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: stm32: convert audio dfsdm to
 json-schema
Message-ID: <20201019202519.GA3541912@bogus>
References: <20201014123531.6991-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014123531.6991-1-olivier.moysan@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 02:35:31PM +0200, Olivier Moysan wrote:
> Convert the STM32 DFSDM audio bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  .../bindings/sound/st,stm32-adfsdm.txt        | 63 -------------------
>  .../bindings/sound/st,stm32-adfsdm.yaml       | 42 +++++++++++++
>  2 files changed, 42 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.yaml

This is almost already documented in 
Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml. You 
should either make that complete or reference this.

Rob
