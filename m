Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2744C2D50C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgLJCQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 21:16:02 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37370 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgLJCQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:16:00 -0500
Received: by mail-ot1-f66.google.com with SMTP id o11so3495503ote.4;
        Wed, 09 Dec 2020 18:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s8/BifRKs0vgQVaDEd/Wk5y6lcQlYDdTiPMPRpMuFtg=;
        b=OTHgO7gT/B3nNw9kzvoKEpOucKO7uxeUyWldF0RCLcOlbzAnQoovzTVeGlpG9WRztk
         B9BOjLkAvq/jKEwDD6WyZaKCU7H0ctEvJy+UBOekqwdWB+Mv9ozQV/FeScPWE1OQRVJR
         WXAYbxwhgJaOlkwyeTgCLn5fKmGBoQbI6HwLwRmRJ+Yib9HUw7s0VoScyiW9hgta1cEX
         VfOodrUnKqTwANzGzwq5FvoeCFlBzzfwVc6zjN4s4wdj5t+Nx6vAdkV9y0QMj9hSuTW9
         Cl3S0WlAo/JRCRQh5cFCIctEErjW29tap6Buup2HrFjYiulf3ehKvGBJkNVLHHOHf4hV
         nh7w==
X-Gm-Message-State: AOAM532TflUxQW18H7DQoOQwbdp/e2EESTybhqi/2/ROS+A1a6KW6sGU
        JpHAwHJtebymbrIWydUp4P5YonKxIw==
X-Google-Smtp-Source: ABdhPJxveiIz8DsomaseOKut9J4qQ8f57Gw8nD/4OTmXmici4uFWS+L6eept2gpt6irjbcANCuSlQQ==
X-Received: by 2002:a9d:2043:: with SMTP id n61mr4199358ota.254.1607566513287;
        Wed, 09 Dec 2020 18:15:13 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k63sm707768oia.14.2020.12.09.18.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 18:15:12 -0800 (PST)
Received: (nullmailer pid 1497839 invoked by uid 1000);
        Thu, 10 Dec 2020 02:15:11 -0000
Date:   Wed, 9 Dec 2020 20:15:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, allen <allen.chen@ite.com.tw>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: Add an entry for
 AmpereComputing.com
Message-ID: <20201210021511.GA1497753@robh.at.kernel.org>
References: <20201208043700.23098-1-quan@os.amperecomputing.com>
 <20201208043700.23098-2-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208043700.23098-2-quan@os.amperecomputing.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Dec 2020 11:36:59 +0700, Quan Nguyen wrote:
> Add "ampere" entry for Ampere Computing LLC: amperecomputing.com
> 
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
> Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
