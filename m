Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4480D2AC334
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbgKISHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:07:34 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45907 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730011AbgKISHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:07:33 -0500
Received: by mail-ot1-f65.google.com with SMTP id k3so9816008otp.12;
        Mon, 09 Nov 2020 10:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LL8NPgXogoNlUMeu3WT4Rthu8q22EfXdmt9F6yjargo=;
        b=PGDluyVMShCQ9vxSTY22nrZtm5FLGrpSd9wMqwAHU3fVQKP1OAqGWjeSoMuTQr7yMe
         3TlvMWV7XG0PQ+znR9T74GcMhQwZ5Qc8JsrAsTZJKGBFoMPl1H5AsiYe5a3qo+s8EcYL
         rO5N7nS8n9U0/42OTF7rCcunp4/JBxp1COiw+bFmAY4Zb+M7+N58QnYQa8t99DoJvYEs
         ciOU/Vl7dtfuS4rNkJrySAbOaYiAJiEXMPrHqTbJNQAdHfoDpM7a2YlwQUTbfE465F6V
         lijk4XO1CA8yg6Vw+yjxvva90aVngOJDXfjdNOSPyvMSBAJA3UWjapXUMJoa/bndwLzw
         ZeqQ==
X-Gm-Message-State: AOAM53161mpiI8/TlrM9hQHs1PJysH0yWcPCfW32q6lC4f8CuO2j0gzP
        Wz/qJynhTH8kqAj4SRRzIQ==
X-Google-Smtp-Source: ABdhPJwrY9+pUaXSDLsZ+KQnJn9K+YyIl8Pz8PK1hyBW5haK4eYCy/nZc5Dig59XPwbB3PNwmGdnCw==
X-Received: by 2002:a05:6830:150b:: with SMTP id k11mr10733112otp.234.1604945252768;
        Mon, 09 Nov 2020 10:07:32 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f18sm2664482otf.55.2020.11.09.10.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:07:31 -0800 (PST)
Received: (nullmailer pid 1521578 invoked by uid 1000);
        Mon, 09 Nov 2020 18:07:31 -0000
Date:   Mon, 9 Nov 2020 12:07:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: adau1372: Add bindings
 documentation
Message-ID: <20201109180731.GA1521527@bogus>
References: <20201104201209.907018-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104201209.907018-1-alexandre.belloni@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Nov 2020 21:12:08 +0100, Alexandre Belloni wrote:
> Add device tree binding documentation for Analog Devices ADAU1372.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> 
>  .../bindings/sound/adi,adau1372.yaml          | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1372.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
