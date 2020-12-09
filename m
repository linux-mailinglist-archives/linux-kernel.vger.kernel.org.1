Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205BB2D46D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgLIQex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:34:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35267 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgLIQex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:34:53 -0500
Received: by mail-ot1-f65.google.com with SMTP id i6so1953847otr.2;
        Wed, 09 Dec 2020 08:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9amksMRaTre1TKphGMa6RukD/0UXnG4x5MJc8xzPF+8=;
        b=L5oczlRG2CKvs59LsTiMpaUtxfaWgRe36GLHu12kFAq3FA0C1sOrv2z1beR3vF+hKr
         lF0ulA0N0IPyUs0BA5nuDOp1kpIDbxHPK91cB2czuT8OxCBcUiNmuA06WuRR7oKOtKtg
         n6NP0dQNKQNgckKiU7XObT9sBIhyBLc4hvPBUzgf/mSduDRydEJtZj50AK4SSsv4CWtv
         IWXoEWJ9jQkE8+ATNPKc/DVKyWirA9MBqTuUm5zllsgY4rLJIQoZaU5CJJ5cEgqtCji+
         HoyQdz63FxhS6q0ybEv3nvOu8VnHH4+tP3803ezaEnIK9boThuSI4wJw/FPiZBcd8XM6
         CYJg==
X-Gm-Message-State: AOAM5337veQxI7aGlc2Tpw2NHqIJEzNfoiWfVI3Eimff5avWDAUYhgHL
        v8EJ2q+ngjyuilAPlENSlw==
X-Google-Smtp-Source: ABdhPJw079OcH9Wx/tOkfeG7V+did7VdjHcLMAldhzxsI94Q/ADO9vhyb7XLabLtHUSZaUYxtlnBlg==
X-Received: by 2002:a05:6830:1011:: with SMTP id a17mr2440801otp.97.1607531651586;
        Wed, 09 Dec 2020 08:34:11 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h2sm480685otn.15.2020.12.09.08.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:34:10 -0800 (PST)
Received: (nullmailer pid 567548 invoked by uid 1000);
        Wed, 09 Dec 2020 16:34:09 -0000
Date:   Wed, 9 Dec 2020 10:34:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, arnd@arndb.de, w@1wt.eu
Subject: Re: [PATCH v2 02/10] dt-bindings: vendor-prefixes: Add honestar
 vendor prefix
Message-ID: <20201209163409.GA566058@robh.at.kernel.org>
References: <20201201134330.3037007-1-daniel@0x0f.com>
 <20201201134330.3037007-3-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201134330.3037007-3-daniel@0x0f.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:43:22PM +0900, Daniel Palmer wrote:
> Add prefix for Honestar Technologies Co., Ltd.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 2735be1a8470..a6cf2cef6f89 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -451,6 +451,8 @@ patternProperties:
>      description: Holt Integrated Circuits, Inc.
>    "^honeywell,.*":
>      description: Honeywell
> +  "^honestar,.*":
> +    description: Honestar Technologies Co., Ltd.

Alphabetical order please.

>    "^hoperun,.*":
>      description: Jiangsu HopeRun Software Co., Ltd.
>    "^hp,.*":
> -- 
> 2.29.2
> 
