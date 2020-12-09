Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FD42D4599
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgLIPkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:40:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36606 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbgLIPkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:40:00 -0500
Received: by mail-ot1-f65.google.com with SMTP id y24so1753778otk.3;
        Wed, 09 Dec 2020 07:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+d+2aIF1fPREDcuZqrlheHQ+9kmWHfvuajGEvnzr79g=;
        b=tJmu71EHfOGEOa5w0+8Kujw2o80NWFmlnc2hLFYiGLdRCzTV9YHN4OYOf9LvKAHBlX
         CXJoYTS5+KJpZCfdr/rzer+NsnkfwfxjdiauSasP5762a3fGePV4+qfYyJqo0HZ/v/uE
         /P/Ou4HJKW7OT8mt7KI7QCdFHLb9lqPQi/bp24rLntF6ecsaCiVIgr4yjWoGB12EvF80
         IAJ+eYDdzIBZfAtqNkMu/CmLqf1L41bpNsavWhAAXob799giOKbXWt2mH1BBE6KoxV6u
         NbUZKbs/i1BuoQ4Qal4W+yyXE2Qqxr9I/Ok+JrkZ1M1HfUTZVnUC1MzwuP0PhoZzTtHD
         x+iA==
X-Gm-Message-State: AOAM530zsh0Nr4VxnmvN4Am2WvhlbJVZ9J2q01p5VwTI8r/pupz2pLKa
        fBAmffOhr39ZgBsTBiwWw9Rz8PRbSg==
X-Google-Smtp-Source: ABdhPJzZNJka3cKmKHGwgxJycxGiXGcplglrg2Z9qr2xQQ+fBRYP3XUazo8N4hZa47HYOqtSxndZMA==
X-Received: by 2002:a05:6830:22d3:: with SMTP id q19mr2169450otc.115.1607528359487;
        Wed, 09 Dec 2020 07:39:19 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x20sm377612oov.33.2020.12.09.07.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:39:18 -0800 (PST)
Received: (nullmailer pid 495138 invoked by uid 1000);
        Wed, 09 Dec 2020 15:39:17 -0000
Date:   Wed, 9 Dec 2020 09:39:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/5] dt-bindings: vendor-prefixes: Add an entry for
 Kverneland Group
Message-ID: <20201209153917.GA493557@robh.at.kernel.org>
References: <20201201072449.28600-1-o.rempel@pengutronix.de>
 <20201201072449.28600-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201072449.28600-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 08:24:44AM +0100, Oleksij Rempel wrote:
> Add "kvg" entry for Kverneland Group: https://ien.kvernelandgroup.com/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 8332d50301ea..7da549f508ae 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -567,6 +567,8 @@ patternProperties:
>      description: Sutajio Ko-Usagi PTE Ltd.
>    "^kyo,.*":
>      description: Kyocera Corporation
> +  "^kvg,.*":
> +    description: Kverneland Group

Alphabetical order please.

>    "^lacie,.*":
>      description: LaCie
>    "^laird,.*":
> -- 
> 2.29.2
> 
