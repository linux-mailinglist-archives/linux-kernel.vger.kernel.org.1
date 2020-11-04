Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB92A6F83
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 22:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbgKDVUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 16:20:48 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40305 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731533AbgKDVUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 16:20:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id m143so14401860oig.7;
        Wed, 04 Nov 2020 13:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TmGKQaM8NbX4Apyre6CwXX87WW/CQm3JJBjPFFR/Jdw=;
        b=R7EcMe/cCcvQU5RvzNxR6RsR2qPbH+ubFS9W/6ArG3YdPxW1hAI6RJPGPPK1l4DLtn
         XHwJzYdD9BfZ56wXEDTC+cSCH2B3QITQJSnp8PIWII5qsdHFgMoeG0YRSOk5Rh6SCfoG
         /+D94TBnqLMDkLLJ3l9ULICA5Sb3nfuFAUx7+cmrOH7Cxinhq6OWQqZuCKouFS2WvSsF
         VfjZs0uGP+UwlzP2qdJXtQ2TyBJZd+VqJECMRA3xiXJV73yNadEgWMrPkb0j3jHzDb0n
         JxDfArTePEWPX9Q+RfjbP5jkoXFrGWRXErn0shwGvKs9kS3+afuskgHq31go6GwfCFq2
         5cfA==
X-Gm-Message-State: AOAM530VojzeEI7xQtJe64dDWHfiWTgV08YDOmTylH9Wj3w44l+zuyGU
        OoH8s5/HVPws9OXFbsCOFA==
X-Google-Smtp-Source: ABdhPJzAiDR3F9PdJQBRdF9PaBCZnqE8Qk/J6u5jSUzcXJOA7Y+oQ+kHikaUZqCFJpe8DWCtufvn9g==
X-Received: by 2002:aca:2810:: with SMTP id 16mr3980189oix.166.1604524847617;
        Wed, 04 Nov 2020 13:20:47 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l19sm728056otp.65.2020.11.04.13.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 13:20:47 -0800 (PST)
Received: (nullmailer pid 4143657 invoked by uid 1000);
        Wed, 04 Nov 2020 21:20:46 -0000
Date:   Wed, 4 Nov 2020 15:20:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH v2 1/6] ASoC: qcom: dt-bindings: add bindings for lpass
 wsa macro codec
Message-ID: <20201104212046.GA4143597@bogus>
References: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
 <20201029110829.16425-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029110829.16425-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 11:08:24 +0000, Srinivas Kandagatla wrote:
> This binding is for LPASS has internal codec WSA macro which is
> for connecting with WSA Smart speakers.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-wsa-macro.yaml  | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
