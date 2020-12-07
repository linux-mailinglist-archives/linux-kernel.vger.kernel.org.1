Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AC52D1D9B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgLGWnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:43:25 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37513 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgLGWnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:43:25 -0500
Received: by mail-oi1-f194.google.com with SMTP id l207so14421210oib.4;
        Mon, 07 Dec 2020 14:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YiGMY24NvG+qDD2dLzercR68pk9jWvYpHiZ4hoYrapc=;
        b=kmUbt6vCrEYrzKDJ+m2KgB9s9IJOAoGVc6yRAQM0AH48j9f7AApP5LYQ2lH66IJEEg
         eH0GF0+9KdO60Wzg+pGnYksO3Ga9oTxG3v/A2i8EG1CAq3KU5kheXQH2HZ096o3guqmr
         cXhzytIjEG6xBTqBKCkh0TBSSZW7ogQivd2twvU12agjE6VSjzq88GrcW4tJy+erQJoc
         IiQMB5eppKv792jwe8g8W7OAAK8yg81eocQ0b1HWvGICk1A1sIUxDrr95q+KmiPdym7F
         Z9bpHQZABpx1xakhGhn5tJZ4YK+E6hCw+ZTDS+KjxvOM3cQ3WYvuR66zNuwoK+lSVjyZ
         r+aA==
X-Gm-Message-State: AOAM531EChxs2B5kZeCUpu4XP2tQa2aSK0vVXqACzx/t8Ni2y6B+8SvZ
        XJlsH4N4PqBVCGNmxFxzVQ==
X-Google-Smtp-Source: ABdhPJyEh6obLo3kkPcOpFXkhowNTZBEANUOz5IaapchbwUFJKb2tWBZruUtSCktbtkr34ZI8dJpqQ==
X-Received: by 2002:a54:4e95:: with SMTP id c21mr788580oiy.84.1607380958531;
        Mon, 07 Dec 2020 14:42:38 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m21sm1357720oos.28.2020.12.07.14.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:42:37 -0800 (PST)
Received: (nullmailer pid 978070 invoked by uid 1000);
        Mon, 07 Dec 2020 22:42:36 -0000
Date:   Mon, 7 Dec 2020 16:42:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>, Xin Ji <xji@analogixsemi.com>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: anx7625: Add power
 supplies
Message-ID: <20201207224236.GA978011@robh.at.kernel.org>
References: <20201123034652.3660584-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123034652.3660584-1-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 11:46:52 +0800, Hsin-Yi Wang wrote:
> anx7625 requires 3 power supply regulators.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> Change:
> v2: remove maxItems for supplies
> ---
>  .../bindings/display/bridge/analogix,anx7625.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
