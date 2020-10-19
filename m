Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD36F293052
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 23:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbgJSVPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 17:15:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34286 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgJSVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:15:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id d28so1197874ote.1;
        Mon, 19 Oct 2020 14:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XcLSpr6CykfDSrDSQqTsKUgM5Hz7nJ8bS4WWCeBCzJY=;
        b=EJkedUwEjc0wDcyNv1nP+q8SoeJyFAwhYMp6ylNM+QnMbsNUtdU0Rf9gF6/coVTBk+
         pdMKKgTEvUsZPqleKe3LnuarTkyrILMPUoLx/Mt+WgZQl+Y6I56fFQYQdCtpvUtgXuK2
         kmkar7GPPCzJTJKA+zbwtMrwK4epV9iO6DVE8b6w5TUJAO8MgxYeQiTWn6BjVBaew51q
         nboVp4yf9RfJsvSKS9U6dM9tMz0J6LPHpG9MAFAGQ1GvUe6gRoRBBXFCQaKhnC6Q0M1a
         vPpy88MXYWX6s8kBakCKhjR2TS7qyTWb3RSUaTFkIbHpI0ID2DlmMR3bGbwm7iKVc1vD
         LZIg==
X-Gm-Message-State: AOAM531Inha0fCFxbjSXm+8/jsGgJzsR5Y1xnkq/PNuQm2GxyCnuvtjC
        S7ghPF5d99fnsPGxSPM0gg==
X-Google-Smtp-Source: ABdhPJzat6TGcOAm2n5kZXXDopXrqFiornzyn2QtQqVbaWf1HokCLb5HMwnBJd916GvyutkLMQ79hw==
X-Received: by 2002:a05:6830:1e44:: with SMTP id e4mr1392163otj.346.1603142112235;
        Mon, 19 Oct 2020 14:15:12 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f13sm288086oij.0.2020.10.19.14.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:15:11 -0700 (PDT)
Received: (nullmailer pid 3614032 invoked by uid 1000);
        Mon, 19 Oct 2020 21:15:10 -0000
Date:   Mon, 19 Oct 2020 16:15:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add an entry for
 Van der Laan b.v.
Message-ID: <20201019211510.GA3613979@bogus>
References: <20201015090924.6185-1-o.rempel@pengutronix.de>
 <20201015090924.6185-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015090924.6185-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 11:09:22 +0200, Oleksij Rempel wrote:
> Add "vdl" entry for Van der Laan b.v.: https://www.teamvdl.nl/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
