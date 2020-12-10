Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1142D51FF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbgLJDrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:47:41 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44172 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbgLJDrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:47:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id f16so3628366otl.11;
        Wed, 09 Dec 2020 19:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sHVoDtmCmY/s7TtdCaLwKYidKDoDMHp/1AUTvPprfnI=;
        b=pw1db3QpyK7kdLyHh0V87VIiVxp2OZy4tib97v3fsNqoQy1htSyML2wCplfY3scB6o
         M5DQJPJefo8ow+OM23MFfLY1rnzvvGk7CeDdGlEQpLCMBMfcrG2H031xr8W0N55JuTXd
         O0bQSNYf6I8NwJdmM4s4mg2xU5LVBusi7V/uLDM6+iy7s7Vn3mYOZZKodWygAWGhx2to
         /go93SMg8EPWthE+fc6D4v4fHI8MjBwL0nL0wTSqhpYK8xC4g7n1q4Z0jEa6/4MQq7dJ
         3qjQri6NlD1lE8lfft4l9FHDrmcKITRxgNRnJ3R050/bkM7MgdDoUxtFpARLvHXGMhE5
         HdpA==
X-Gm-Message-State: AOAM530xHErGLtwl0lHQxl/XffTgi2gM8VMQN5oZprBYuHg83HuICoVT
        d6BgcziP0NwlJzlx3HCwcw==
X-Google-Smtp-Source: ABdhPJzWuYu9FVgLu39IVoGiJfqULyAoakhMQ/p22q2ukeNf2GuZ7WnTHG308B8SK2U05TfRG0xBnA==
X-Received: by 2002:a9d:6aca:: with SMTP id m10mr4567204otq.26.1607572016318;
        Wed, 09 Dec 2020 19:46:56 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x66sm742500oig.56.2020.12.09.19.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 19:46:55 -0800 (PST)
Received: (nullmailer pid 1620662 invoked by uid 1000);
        Thu, 10 Dec 2020 03:46:54 -0000
Date:   Wed, 9 Dec 2020 21:46:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        David Jander <david@protonic.nl>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/8] dt-bindings: display: simple: Add Kyocera
 tcg070wvlq panel
Message-ID: <20201210034654.GA1620633@robh.at.kernel.org>
References: <20201207140939.31297-1-o.rempel@pengutronix.de>
 <20201207140939.31297-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207140939.31297-4-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 15:09:34 +0100, Oleksij Rempel wrote:
> So far, this panel seems to be compatible with "lg,lb070wv8", on other
> hand it is better to set this compatible in the devicetree. So, let's
> add it for now only to the dt-binding documentation to fix the
> checkpatch warnings.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
