Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE5298F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781596AbgJZOe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:34:28 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:40932 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781580AbgJZOe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:34:26 -0400
Received: by mail-oo1-f65.google.com with SMTP id p73so1110440oop.7;
        Mon, 26 Oct 2020 07:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YJe0fLSQoNV5qYO4yyIlYdA+m7aYQXXQ7220k06Xnlg=;
        b=n3zMNYOSXqixiaps5zSPHmblQ05YtgILf6CkpuOfOfRlBPXfMOSUbIiDCTx3TPQhhE
         tTjk/lkzz4Zicc/PVU+3HN2+BzFufem1FZ+k6nVHx750S+GrM8EvrNQdHSXvtcHUePD9
         JJpoG6SbuoH1pAtsEnamtRdLuQjn+PRjtRc3le6qKN/s4ckWKeiUoiJI55CBuyhpS/ep
         BBrg6cd6O3mvy3HQfZMPQdHG6ttnd6XgnKHjXDlX3wXTF5+FxLAx2oNRUHG+kwifAJar
         W7E16r11tRBisu+FQPLHgPcLNVQhOrv11T2ecL4h3DudeLtyfyk5yiMfYZYiVFOBtdlI
         z+pw==
X-Gm-Message-State: AOAM533TdeRCenCYzcvuDKhww+jrujt4Ab8y5r94KyhZRvXMQnqsjSRH
        Liq8Sf/wEP/6/XSjKlSumA==
X-Google-Smtp-Source: ABdhPJzOzRdziG3eUhJyZY+fC+o+9/Ohme3aRAN88WQMguo4FqGdzYCyXFjHSK0uXu5EcU8Jcmx8gQ==
X-Received: by 2002:a4a:b28b:: with SMTP id k11mr14177359ooo.54.1603722865532;
        Mon, 26 Oct 2020 07:34:25 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k51sm3633362otc.46.2020.10.26.07.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:34:24 -0700 (PDT)
Received: (nullmailer pid 118055 invoked by uid 1000);
        Mon, 26 Oct 2020 14:34:23 -0000
Date:   Mon, 26 Oct 2020 09:34:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        alexandre.torgue@st.com, perex@perex.cz, tiwai@suse.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, arnaud.pouliquen@st.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 2/2] dt-bindings: stm32: dfsdm: remove
 stm32-adfsdm.txt binding
Message-ID: <20201026143423.GA118005@bogus>
References: <20201020155709.2621-1-olivier.moysan@st.com>
 <20201020155709.2621-3-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020155709.2621-3-olivier.moysan@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 17:57:09 +0200, Olivier Moysan wrote:
> Device tree audio configuration for STM32 DFSDM is already
> covered in the following binding:
> Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> Remove stm32-adfsdm.txt obsolete binding.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  .../bindings/sound/st,stm32-adfsdm.txt        | 63 -------------------
>  1 file changed, 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
