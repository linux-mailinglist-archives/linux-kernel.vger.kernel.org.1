Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E051CEA24
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 03:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgELBfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 21:35:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41298 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgELBfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 21:35:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id 63so1865601oto.8;
        Mon, 11 May 2020 18:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x3kC4pf7M56k3t7zRQqBblO/EsPXVYUQiGQ+TYskIi8=;
        b=KShczp3B7n+eRPX0eQCFOcqp/thX7jXIIwWDm6mk5OG+xR4e3G9Vfd4QRZpu+o3CAS
         aAF7ZXwFvbPozr0BMzxrusx+uRMPM1L3cRVoSJCfGl+ULbSE4xSr3F6L/U0dFW0iX2bS
         nsVnNaUZ/DRv08A8QlGlKFwkG49P7uVuvjPxI27uDy8K+SbWiVlp8uK5LB71OyzrzCAp
         /o6rfuvW8KXGB/Qs0L7f3eI8rL6qp1MeFiLOcuvuJlFQGEBrs4l35lhvBnNZRQdIEV5b
         hTsh/D4gzHHF13O84EEbWTHsvRAuHA8sG4YheA0arwL9qCYeNAY4y9H72vYp7ojnRMa5
         HxrA==
X-Gm-Message-State: AGi0PuYAJKRIBjL0WeJaVDJA5UlAiAs0l6JO3WahNJFsidArHJjxtN80
        liDaKlSaBjIlYLIEF1Da2g==
X-Google-Smtp-Source: APiQypKsl30cZFaQ3keApHQftWqKsHXq82zN/5Qa/ZRqSSe924LSGVgAN3i5HizLZ4TZae1D4rd06w==
X-Received: by 2002:a9d:4113:: with SMTP id o19mr14268278ote.354.1589247321540;
        Mon, 11 May 2020 18:35:21 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r1sm2301589oop.34.2020.05.11.18.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 18:35:20 -0700 (PDT)
Received: (nullmailer pid 2259 invoked by uid 1000);
        Tue, 12 May 2020 01:35:19 -0000
Date:   Mon, 11 May 2020 20:35:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        srinivas.kandagatla@linaro.org,
        Etienne Carriere <etienne.carriere@st.com>
Subject: Re: [PATCH] dt-bindings: nvmem: stm32: new property for data access
Message-ID: <20200512013519.GA2002@bogus>
References: <20200508134527.26555-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508134527.26555-1-etienne.carriere@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 May 2020 15:45:27 +0200, Etienne Carriere wrote:
> From: Etienne Carriere <etienne.carriere@st.com>
> 
> Introduce boolean property st,non-secure-otp for OTP data located
> in a factory programmed area that only secure firmware can access
> by default and that shall be reachable from the non-secure world.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> ---
>  .../bindings/nvmem/st,stm32-romem.yaml          | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Applied, thanks!
