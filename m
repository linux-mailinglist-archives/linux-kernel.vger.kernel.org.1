Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B985A2A2E5B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgKBPbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:31:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34002 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgKBPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:31:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id j14so2731810ots.1;
        Mon, 02 Nov 2020 07:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VkT+mPMaNNQ1uOKIaMs+kRmIM51v2J/yVY8GqjEu4z8=;
        b=DRQYPk+hr3bnx0TyeXxH5TnOVt/6V7xHeuweSPD43ubs3u3hNWo89sn70gE/OWI8eF
         Dbq2IF27+n0c4EnMCMQkGtQg0nOCqhYSHoKHV7mJxwXhhh+TiLYUrJ1WXS4BG0PZT9WZ
         EkM3imisadgdl1RziYBElxZwc5sFd6yMyUBw38cP1OqmcpUFcS9E0FEi87J3oXJ6AsKD
         agxj/NCAEHj+xeLYa3VpgNmU/G+yATc7bmn8w/gEQihq3bxFZ0pMc++rpn/qOnQVOyVb
         N+MzReG9castUne8VMPdZm03BY5/KX69gAJOnUDGzAflWbyTrvq4WKnp2cwy0Ez1wa8t
         jsLA==
X-Gm-Message-State: AOAM530mOAuaOtFTcw/GO2ESgRTh5LxjxoCZ/UJPajp+FzO5D3RkYcSs
        i4rIYSwG/9wrDavBJMgHAg==
X-Google-Smtp-Source: ABdhPJzSjtrS3V+u2N9M3si1fuHKu8kg2Sm7lQ8cTJN5U0K1HL/CUzmbAhyLo5Opyy+1m9o5Fnc/zg==
X-Received: by 2002:a05:6830:16c2:: with SMTP id l2mr13167027otr.255.1604331096459;
        Mon, 02 Nov 2020 07:31:36 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t83sm3500406oie.58.2020.11.02.07.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 07:31:35 -0800 (PST)
Received: (nullmailer pid 3927926 invoked by uid 1000);
        Mon, 02 Nov 2020 15:31:35 -0000
Date:   Mon, 2 Nov 2020 09:31:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robdclark@chromium.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: dt-bindings: display: simple: Add
 BOE NV110WTM-N61
Message-ID: <20201102153135.GA3927896@bogus>
References: <20201028155617.v2.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
 <20201028155617.v2.3.I28d9e32b3cc0aae980ecc39d364263a3f9871298@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028155617.v2.3.I28d9e32b3cc0aae980ecc39d364263a3f9871298@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 15:58:03 -0700, Douglas Anderson wrote:
> Add yet another eDP panel.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
