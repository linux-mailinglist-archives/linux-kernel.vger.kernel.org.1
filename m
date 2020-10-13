Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB8E28D245
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgJMQar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:30:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38471 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJMQar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:30:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12so588437ota.5;
        Tue, 13 Oct 2020 09:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s1p76MddqxJYFl/89DelLRDMt10sSWhPZ2iE1pGNU00=;
        b=VrkMP1Dwrr6j+jRbxTMbLoCyfUS4wigkMVqiEegImdzfCXPHgHGx1AJMQupkIuHlIm
         2eG77zhpKTG1Fq08lhKMc+xwAjFK91MEU3jI19CM7Xdv5ar9p+vw3lC7FIfkVOEIdB0+
         a5GoBhIQQTfnrdKXE2lodx/cICEYdoVwZi9N6rcRkkATh1htO8ROTSqi442z6e+vYtQp
         4bu2pTnKm1e90/NlA7l0VdBoGUU38wL7pl4ScJnae9tzRZlHnKhvQfGI+uHYH139TVk6
         /o4OenuQA/N7/5xypC3yexVzpi35vwluQbBPAtjHHxoK9Nq9CLB/RtQ03C8ZB2Ozdwmk
         Obig==
X-Gm-Message-State: AOAM532zLAmpkuyYW83smd3XFVEFYvI/ZbXw3eAvFnAEDv4wF+8zC61x
        gu2lRVMpdyiKN+SdTAUB2A==
X-Google-Smtp-Source: ABdhPJz41xPpOmjgA2PU/4NydTd417ZdyVMePq9PP0mSJDgzLb9ZPsySCZxHQmOiAPb4vx9lh0Bkzg==
X-Received: by 2002:a05:6830:4af:: with SMTP id l15mr348957otd.126.1602606646181;
        Tue, 13 Oct 2020 09:30:46 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w125sm81382oiw.30.2020.10.13.09.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 09:30:45 -0700 (PDT)
Received: (nullmailer pid 3646774 invoked by uid 1000);
        Tue, 13 Oct 2020 16:30:44 -0000
Date:   Tue, 13 Oct 2020 11:30:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Jander <david@protonic.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 2/3] dt-bindings: arm: fsl: add Altesco I6P board
Message-ID: <20201013163044.GA3645647@bogus>
References: <20201012072452.14021-1-o.rempel@pengutronix.de>
 <20201012072452.14021-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012072452.14021-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 09:24:51 +0200, Oleksij Rempel wrote:
> Add Altus-Escon-Company BV I6P iMX6dl based board
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
