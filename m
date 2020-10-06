Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D42850E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgJFRgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:36:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45848 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgJFRgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:36:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id z26so13426159oih.12;
        Tue, 06 Oct 2020 10:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fQVce2z5WeUjQPeTAvsf6qiLaggJ6PT9QQGUR3fur7o=;
        b=uF+i/sbWDlbo9nkP9Ed8CqYSROP6xoX6iHS5YejnQbSpog4+utyeC763sBGZ0H1rKP
         rk2t1Bn2hfoUz6xHGpGKk4uORzDEWL8qwSqAJNymey1ifJ8XSqaK02X+RCUtr+S7t5Av
         mjA2XnPNMICu5BCr9o90b847WZkwdZgQvXdRYtbW8hUCVxSS5kRskpm5zaOPUxXIddMP
         eeXydrKniwmNZ55aF25n4h8m+f6CxhU3GkGufsAI9EE4HFWJJm9x1kutmL3Ubjz06jDS
         AhKH8JbbHhRLe8fARZDMd5l9/wonXZBHpj0SU6bSlMGkEEiW3qRyHb9IvbHAffqnJiS5
         CmvQ==
X-Gm-Message-State: AOAM532b6uzCTX1AyqliLjNJ6bIA57x8x2eMQu6c7Rc4B5KgXMooQYz5
        aHk9phZEdSNJ6qMqJFm5YA==
X-Google-Smtp-Source: ABdhPJyjtnyrsTSDC4kJEpqrowTCFCR+Yo6elqXS4w1jNpMivxFUDH7nzX3FFiza1q7kIai5q5W7RA==
X-Received: by 2002:aca:d744:: with SMTP id o65mr3602405oig.38.1602005764802;
        Tue, 06 Oct 2020 10:36:04 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t19sm513662otj.61.2020.10.06.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:36:04 -0700 (PDT)
Received: (nullmailer pid 2501520 invoked by uid 1000);
        Tue, 06 Oct 2020 17:36:03 -0000
Date:   Tue, 6 Oct 2020 12:36:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Robert Jones <rjones@gateworks.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/12] dt-bindings: vendor-prefixes: add MicroSys
Message-ID: <20201006173603.GA2501462@bogus>
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930190143.27032-2-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 21:01:32 +0200, Krzysztof Kozlowski wrote:
> Document vendor prefix for MicroSys Electronics GmbH.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
