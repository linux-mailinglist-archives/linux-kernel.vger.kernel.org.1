Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDC21E4E72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 21:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgE0ToK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 15:44:10 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43133 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgE0ToJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:44:09 -0400
Received: by mail-il1-f196.google.com with SMTP id l20so25277825ilj.10;
        Wed, 27 May 2020 12:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VTnNbKVHo2kU5waALuLEH2I4ImVO/YuvBJE0G4ruySE=;
        b=lvHFbAvN4G+1ZUGLvRTIMt+1dNUWRUH4Em/MfoZen5g/5IoXAsZLRaY1VE34TB36r7
         modCqPl0xfFt9xDG8Fc47J4oF1cZl6vesU3uudsBSgJ8vZ00CPS1D1WCcwAZVL5WJ4fq
         ItLg61Np1g4lAh513n2bbR8HTtTMJ+I/x8RBzkRT1zTKaiaG7RapM/fX9g6goVvENpa/
         m5JijTTVRcA6tmjdqm+Spyad0tAqOttNWPtZtPmcn455wkAI6d7GIQfv6rJqW1UztW5Y
         BaokToQDEVyq6/KRyrCjvsZfew1XvrDQcI87FkvuHHfj6r7xWnCF7ZCPo1wa2xW0IGkv
         XCqQ==
X-Gm-Message-State: AOAM533FE9WcV72jsc9i3OrA65HIgdFcNtOJVIgzGaApHn4xGQv76idY
        44ikVSGFw/JfSRXU80CSKA==
X-Google-Smtp-Source: ABdhPJxD3quuMqWFfOV0gEmTYCxoLh5WnCZrFY0Az/p69lDKpGHkDfK9wfEeelZtxoZeRORtlDbJ5Q==
X-Received: by 2002:a92:c609:: with SMTP id p9mr7287729ilm.243.1590608648535;
        Wed, 27 May 2020 12:44:08 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v70sm2113715ilk.84.2020.05.27.12.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 12:44:07 -0700 (PDT)
Received: (nullmailer pid 2618317 invoked by uid 1000);
        Wed, 27 May 2020 19:44:05 -0000
Date:   Wed, 27 May 2020 13:44:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lgirdwood@gmail.com, myungjoo.ham@samsung.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, broonie@kernel.org,
        lee.jones@linaro.org, cw00.choi@samsung.com,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v3 3/7] ASoC: arizona: Move binding over to dtschema
Message-ID: <20200527194405.GA2618224@bogus>
References: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
 <20200513095720.8867-3-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095720.8867-3-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 10:57:16 +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No changes since v2.
> 
> Thanks,
> Charles
> 
>  .../devicetree/bindings/sound/wlf,arizona.txt      |  53 ----------
>  .../devicetree/bindings/sound/wlf,arizona.yaml     | 114 +++++++++++++++++++++
>  2 files changed, 114 insertions(+), 53 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.yaml
> 

Applied, thanks!
