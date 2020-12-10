Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEE92D51E9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgLJDrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:47:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37686 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730376AbgLJDql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:46:41 -0500
Received: by mail-ot1-f68.google.com with SMTP id o11so3652795ote.4;
        Wed, 09 Dec 2020 19:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VQx7yjIF6t40nyTfvDutQravU0D0XLMrI7K2WmuirR4=;
        b=btbT0DnE1C264KRHwdoZl7Tz+SXoHL9ExTqhODb+FctTGzZDAwYG3s4YNPIGVtK/1b
         mgG0vRlnjFr/iHmGwUn0G+LUtv5axd9vBMEC9GJs7cH/DhOliTyJgWJ5vDc+lDfzNcVr
         5ktAmk8QvyiI5910qPBEE20tf+TDGu/a2YNxCfPdzY+Ya+6emsuYVgIYEwYPkCZQegyz
         ucRF/CYmQV9K5ySQlU8JV8LoOjmc+Tp9hHO6quL6KL58nczZ8M6TUDJi+9Ffl4dy71Re
         E/F1FDjlYD2+qtDMROouof4ye3iEemjyBC7WVRrwq8ZfvdP/+sHwkPJSNxhk4VNQl2Es
         +8IQ==
X-Gm-Message-State: AOAM532ib6EOk+d2xYrZTV9LA8bNLCmcytH46w8remXsxTBDan095Tgj
        0H/kY8HaGBfgRw1bz4W47Q==
X-Google-Smtp-Source: ABdhPJy3qhbxYjqjVBYxRWhar+RAWhvyTk9oVKbpg0DqpYbLOcvv/6x9snENh+uiP+/YUwc4bsosKA==
X-Received: by 2002:a05:6830:128a:: with SMTP id z10mr4537702otp.3.1607571959738;
        Wed, 09 Dec 2020 19:45:59 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b82sm745563oif.49.2020.12.09.19.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 19:45:58 -0800 (PST)
Received: (nullmailer pid 1619256 invoked by uid 1000);
        Thu, 10 Dec 2020 03:45:57 -0000
Date:   Wed, 9 Dec 2020 21:45:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/8] dt-bindings: display: simple: fix alphabetical
 order for EDT compatibles
Message-ID: <20201210034557.GA1619207@robh.at.kernel.org>
References: <20201207140939.31297-1-o.rempel@pengutronix.de>
 <20201207140939.31297-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207140939.31297-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 15:09:32 +0100, Oleksij Rempel wrote:
> Reorder it alphabetically and remove one double entry.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/display/panel/panel-simple.yaml       | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
