Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB2C22FAE1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 23:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgG0VAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 17:00:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35442 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0VAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:00:24 -0400
Received: by mail-io1-f67.google.com with SMTP id s189so11242115iod.2;
        Mon, 27 Jul 2020 14:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q/xx8a2iBuQvh2CskhteFtxckcB5mAiI21DtCGwJE70=;
        b=Y4psj9wFS3ltulrmDJJHywaoK4jMgznO/Iaev1h4M0uyoB1MekaVngemaZByLW3GGl
         PU6rX1w+G0zTvJkhg+HzYBebn/3/Z47cPqYKjI5HHkhb6CrnKh0q9CmLWbilXMxweHBM
         V4Ef+L/BqH/3BoFlSODG1Cn6+2e/67wzRChMbdgeLdVBvL1Rv081RXzArMoBXT+XJF2w
         cBCvmL+B5b6giLGYszVohLQUapvJ7vvmDHNb+EkNQ/eflH4poo+TtQaBdoiQCNcyvPNe
         TVZG5+zT3EFKc4fV3fKwjLE0tMaia9O6vCxRzYpu+I7Ivx4jmEfv91KdZMCFCehGaIrY
         LgOQ==
X-Gm-Message-State: AOAM533esOeJe87r45N+h+YItC0AwJgNmYTj6h3/kaUoAzQ+wQZH6lOd
        I2g58fKFjWIKgOLYgHW9XA==
X-Google-Smtp-Source: ABdhPJzdCLTZ2NA/wRoY6sUwazpy2vMTI1rQNQTsNfv0kTp2JW8MZpYqzkgO5mWrLnkse06fqotpVQ==
X-Received: by 2002:a02:bb05:: with SMTP id y5mr19148048jan.98.1595883623966;
        Mon, 27 Jul 2020 14:00:23 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q5sm8914029ilm.73.2020.07.27.14.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:00:23 -0700 (PDT)
Received: (nullmailer pid 863116 invoked by uid 1000);
        Mon, 27 Jul 2020 21:00:21 -0000
Date:   Mon, 27 Jul 2020 15:00:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org, perex@perex.cz,
        lgirdwood@gmail.com, devicetree@vger.kernel.org, tiwai@suse.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 1/2] dt-bindings: tas2562: Convert the tas2562 binding
 to yaml
Message-ID: <20200727210021.GA863046@bogus>
References: <20200723160838.9738-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723160838.9738-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 11:08:37 -0500, Dan Murphy wrote:
> Convert the TAS2562 text file to yaml format.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/sound/tas2562.yaml    | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas2562.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
