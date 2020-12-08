Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8857C2D2F0E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgLHQFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:05:50 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46350 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbgLHQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:05:50 -0500
Received: by mail-ot1-f67.google.com with SMTP id w3so15601809otp.13;
        Tue, 08 Dec 2020 08:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ihmDbUM7hstnqkiOGXoNLdDE2JLW3b9BvV3/GXyBj6c=;
        b=BS1uUhqmnCHP05IkxYC0EYjLmXVhOS8xPRHPDidqeHui57hEa+ew50dffQFqTPz7G+
         rVU5wLIP6KTYh1k/8esAa/kwYSU1YDm34W3aNzrFnwLrubdvG0bsE/bFkKVufc76EAjy
         q5y3pcvjINLb7STnN/PEUzzJWcxcAkfU3DMhMR9fRJoff6PJe5g4kVv1E6lKA+s8kpHn
         oDv/VpC+FgJcMjds9jITdnB/HEpWr/2hQZy4lqXbf4wVV9/BbJJOQqSo1LXz7O0Pzi2d
         YXBp5kuAR6VkKtpGmaW1BM/Yo3zgeBiVAba6TO45tKoVBDnUqbjJq/GODTV4ox6agLGT
         +fsg==
X-Gm-Message-State: AOAM533vljxwN2aGihsEKRNIheFFajIqRnmiG4PLQmadOXherjLSn6oa
        rE/D6CjbCfiRVn18J9sSNQ==
X-Google-Smtp-Source: ABdhPJyCgXSpfxyq3WrhXCwmBgYHc4FTU0tJ+lmk+3WNQ9EfvFUFvQ5TKslabWJFtCEdDSEvHR7xXg==
X-Received: by 2002:a9d:71c9:: with SMTP id z9mr17879654otj.61.1607443509357;
        Tue, 08 Dec 2020 08:05:09 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w21sm3383322ooj.32.2020.12.08.08.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:04:58 -0800 (PST)
Received: (nullmailer pid 2613169 invoked by uid 1000);
        Tue, 08 Dec 2020 16:04:44 -0000
Date:   Tue, 8 Dec 2020 10:04:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        David Jander <david@protonic.nl>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: fsl: add Kverneland UT1 and
 UT1Q boards
Message-ID: <20201208160444.GA2613117@robh.at.kernel.org>
References: <20201125135708.16578-1-o.rempel@pengutronix.de>
 <20201125135708.16578-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125135708.16578-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 14:57:04 +0100, Oleksij Rempel wrote:
> Add Kverneland UT1 (imx6dl) and UT1Q (imx6q) based boards
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
