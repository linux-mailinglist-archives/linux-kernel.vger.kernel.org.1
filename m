Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBC3301F42
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 23:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbhAXWcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 17:32:55 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:34988 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbhAXWcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 17:32:50 -0500
Received: by mail-ot1-f44.google.com with SMTP id 36so11007624otp.2;
        Sun, 24 Jan 2021 14:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m6wHg4CcRH88zHTgFz/tvg+1KvfQYJ5bN5Bm8kD7yRg=;
        b=Jxm0dmZ4MCBfpbGVqI3++HssjvqNHUtoUrvwnEMmmZqViLVjbrv/X0x2l/BNSWzOrE
         Hrh/kpC8DSge+3n02BnJQBhh/A2bEzFV9MVy+2MAxqbgqbP87x4N4K4LKa/61+T1ATJP
         ZFzWfUPL+DSDMT1WRuMNXKv/2y6MwjGDYhO3jDc8+Hjy350pwiPSVXbZIWAoAwefcFqA
         TIiBFF4txgyhuFZ8kmWauQWn5/rByOvANA46AvlK6mwdicJmNzFKqWnm06KK3cVby7f9
         tZBCxv5ghhJMjo2iZTpyzBCrrJHwUhIfu1Y5tSeKdGazzFM+kUlg9T9QM7yc/bm3oItU
         dgWA==
X-Gm-Message-State: AOAM533txCDrSP1mpMeQ3S9+OYJCyYURtUdSwEkCcJCafouRycVLNU1b
        rNOziCQY/XEGhS2DEoe12A==
X-Google-Smtp-Source: ABdhPJz9WA7Y/UPNnKKLntkH/tFcind9g1csMhNYkPPBXbcW+heCsZ0Y6nK7bCtXl9o3899XN/yFzg==
X-Received: by 2002:a9d:67d5:: with SMTP id c21mr2912287otn.247.1611527529363;
        Sun, 24 Jan 2021 14:32:09 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a52sm3185158otc.46.2021.01.24.14.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 14:32:08 -0800 (PST)
Received: (nullmailer pid 2737276 invoked by uid 1000);
        Sun, 24 Jan 2021 22:32:06 -0000
Date:   Sun, 24 Jan 2021 16:32:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     tzimmermann@suse.de, shawnguo@kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, guido.gunther@puri.sm,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        laurentiu.palcu@oss.nxp.com, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/6] dt-bindings: display: imx: Add i.MX8qxp/qm DPU
 binding
Message-ID: <20210124223206.GA2737091@robh.at.kernel.org>
References: <1611213263-7245-1-git-send-email-victor.liu@nxp.com>
 <1611213263-7245-2-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611213263-7245-2-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 15:14:18 +0800, Liu Ying wrote:
> This patch adds bindings for i.MX8qxp/qm Display Processing Unit.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v5->v6:
> * Use graph schema. So, drop Rob's R-b tag as review is needed.
> 
> v4->v5:
> * No change.
> 
> v3->v4:
> * Improve compatible property by using enum instead of oneOf+const. (Rob)
> * Add Rob's R-b tag.
> 
> v2->v3:
> * No change.
> 
> v1->v2:
> * Fix yamllint warnings.
> * Require bypass0 and bypass1 clocks for both i.MX8qxp and i.MX8qm, as the
>   display controller subsystem spec does say that they exist.
> * Use new dt binding way to add clocks in the example.
> * Trivial tweaks for the example.
> 
>  .../bindings/display/imx/fsl,imx8qxp-dpu.yaml      | 387 +++++++++++++++++++++
>  1 file changed, 387 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
