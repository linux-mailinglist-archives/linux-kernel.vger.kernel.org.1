Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D562A6F86
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 22:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgKDVVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 16:21:19 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41705 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731845AbgKDVVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 16:21:19 -0500
Received: by mail-oi1-f195.google.com with SMTP id m13so14659920oih.8;
        Wed, 04 Nov 2020 13:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aZtQfM5KBrbiy+gWC27nrljgHccPhY/KcNRzzbJU6nw=;
        b=S4Dg+vp5nYrtEaEDs5MLSMlJgggDo8jkSxq4Vh9vNYXJJvFI6X2ATDzOANFsNAUwhA
         eFuQajzSe/8KlzqWxbZChdFUU/9a3yvBC8uWI6xow+5Im0vnq6Hy0GoZUEopkehWR7OY
         jv041ATrSLJ4uavLXVKWPKQq/iHi3Y9bcKDf8Xu6sQ7OU9VEry6OaSCe8T92HeWEM9sO
         zx1CtVXvWRgOi4zNq1xqFweEANTjOSRtGnlCXVnAmsMyV07g5YtSAorCBFE5M3+uukUU
         tuyD5oP/H/e8JFVmR5uaKw9VhOro/JAbAjIHvYli1PqVHi9jdr7iAz5lYcJq7602wKCu
         9b0Q==
X-Gm-Message-State: AOAM531NES9L0j4SuqGPoyn0aoPP+cEkMdifrg61ivetqvuZ13f3QxUt
        qUi4OL03sQS21U+3J5m3Hg==
X-Google-Smtp-Source: ABdhPJyDaOJViGJX07fUT0WbV67TuFIoZZydDHDeyusO5qHV7wFq9sr1wM5JU41KZujIeBmaTt6tCA==
X-Received: by 2002:a05:6808:91a:: with SMTP id w26mr3878979oih.159.1604524877040;
        Wed, 04 Nov 2020 13:21:17 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m65sm760695otc.36.2020.11.04.13.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 13:21:16 -0800 (PST)
Received: (nullmailer pid 4144464 invoked by uid 1000);
        Wed, 04 Nov 2020 21:21:15 -0000
Date:   Wed, 4 Nov 2020 15:21:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        broonie@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/6] ASoC: qcom: dt-bindings: add bindings for lpass
 va macro codec
Message-ID: <20201104212115.GA4144415@bogus>
References: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
 <20201029110829.16425-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029110829.16425-5-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 11:08:27 +0000, Srinivas Kandagatla wrote:
> This binding is for LPASS has internal codec VA macro which is
> for connecting with DMICs.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-va-macro.yaml   | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
