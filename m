Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996D01E299B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 20:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgEZSEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 14:04:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46847 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgEZSEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:04:22 -0400
Received: by mail-io1-f65.google.com with SMTP id j8so23010308iog.13;
        Tue, 26 May 2020 11:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ClJL8gB+/7Ulq3yj2f4VaDBjcjvT7VkWGg/z9gQ4pgg=;
        b=YB/7jRzIWHrCjwDKoJ5EU63VfJWnOpZOD8pQU4bu60XdB8cySAq/Z32rSJC/VSM/fr
         oobRUOr3RS1FxlveCLZ7d4nbHj2V6IhXV94mU53Ir7Kofl3Shu0m6vESU7V8DqYErtuO
         kNvp0YJQKZ9kHQSoMsFhArQtZuLmm/f1JgERoniCDWwB72eMwkvfunoS2kcniLZBDbb7
         TtKDIWfyhIg7qX64k/n5WgDE0vz3FYpZN3D0WvUUWX+AfoGvWfyFL7q60LD08uEjZZvF
         /8d7u0gEhTJLIhFigQZVd2/I4HpMqQt2wL27L8ac9QsdxXbdT0YRg0VlT6LTr10YDc4I
         MHkw==
X-Gm-Message-State: AOAM533lxFv5bKmQAglSDCT25ePDxoIdPLFAl4XokSQxdP+qtGVI6byT
        XXmLFr6ZjUpY42Bwuv3ofg==
X-Google-Smtp-Source: ABdhPJzcu2nCj6F92lx7P/df1l59GGQNg9IGF9YDymeeq6DRFL67TpPCdRsq+oEeB/mS2xXLEmpasQ==
X-Received: by 2002:a05:6602:2c8f:: with SMTP id i15mr11103155iow.45.1590516260900;
        Tue, 26 May 2020 11:04:20 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z13sm319397ilh.82.2020.05.26.11.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:04:19 -0700 (PDT)
Received: (nullmailer pid 80209 invoked by uid 1000);
        Tue, 26 May 2020 18:04:18 -0000
Date:   Tue, 26 May 2020 12:04:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devel@driverdev.osuosl.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Pi-Hsun Shih <pihsun@chromium.org>, devicetree@vger.kernel.org,
        Sheng Pan <span@analogixsemi.com>,
        David Airlie <airlied@linux.ie>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v11 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter DT schema
Message-ID: <20200526180418.GA80145@bogus>
References: <cover.1589511894.git.xji@analogixsemi.com>
 <393386c0a18753cb4b3f695348fe506a192ea82a.1589511894.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <393386c0a18753cb4b3f695348fe506a192ea82a.1589511894.git.xji@analogixsemi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 13:49:20 +0800, Xin Ji wrote:
> anx7625: MIPI to DP transmitter DT schema
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../bindings/display/bridge/analogix,anx7625.yaml  | 95 ++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
