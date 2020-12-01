Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979692C9503
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgLACJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:09:48 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37670 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgLACJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:09:47 -0500
Received: by mail-il1-f195.google.com with SMTP id k8so173347ilr.4;
        Mon, 30 Nov 2020 18:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MDcAkPWg6r1CvNkSpBNZR5QQHHH+YNbNEbY/B/QhrOk=;
        b=crtI7fL0Iyl2+8URNFqFAcKqoxCtDOXlq6SOIaOBvL+U0haOEsz4PtEF9yc+uSahCk
         +31mjPC3M3UN28x332nBFzRDGZs7WMG0PqPZQL528YHlDm8TEWjY4lVtBbdfSEKdbxB1
         vd1XI4hqHFGmetTXfdGiXI5N/D81vZ8JOWVQ2lJEPTcFXRB8qZZaBEvolJ4OlRX1Wiav
         pZdLIWwgLvb/bOj17vqUJHF9/a7XBitkCEvAR9RPVwPsbDm9ny9Ip9BotQKxM+98MHbX
         /6OWQNCN7B0qeltGaEGwelo+LF3pMAfYInkVPhVOVvC38u9+yIUAoSq6+38/LVoQY/BM
         OHxw==
X-Gm-Message-State: AOAM532HCktcidhNmpHaNq59JCOV8djukACpm4dyMuk/22OgRZbbetY7
        pbGE278Zqk+wDhbI/LHcvg==
X-Google-Smtp-Source: ABdhPJzlcCKd722WEqdXZrsNxM9uNm7QlBazEUb4vNFFAPAxdFDwS3eGe0LTyWBp+X9Zxy420l35tQ==
X-Received: by 2002:a05:6e02:90:: with SMTP id l16mr665790ilm.228.1606788546547;
        Mon, 30 Nov 2020 18:09:06 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p89sm228214ili.29.2020.11.30.18.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 18:09:05 -0800 (PST)
Received: (nullmailer pid 3494650 invoked by uid 1000);
        Tue, 01 Dec 2020 02:09:02 -0000
Date:   Mon, 30 Nov 2020 19:09:02 -0700
From:   Rob Herring <robh@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     xiaobo.xie@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jiafei.pan@nxp.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        leoyang.li@nxp.com, Biwen Li <biwen.li@nxp.com>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jason@lakedaemon.net, linux@rasmusvillemoes.dk,
        zhiqiang.hou@nxp.com
Subject: Re: [v4 11/11] dt-bindings: interrupt-controller: update bindings
 for supporting more SoCs
Message-ID: <20201201020902.GA3494421@robh.at.kernel.org>
References: <20201130101515.27431-1-biwen.li@oss.nxp.com>
 <20201130101515.27431-11-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130101515.27431-11-biwen.li@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 18:15:15 +0800, Biwen Li wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> Update bindings for Layerscape external irqs,
> support more SoCs(LS1043A, LS1046A, LS1088A,
> LS208xA, LX216xA)
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v4:
> 	- none
> 
> Change in v3:
> 	- remove robust information
> 
> Change in v2:
> 	- update reg property
> 	- update compatible property
> 
>  .../bindings/interrupt-controller/fsl,ls-extirq.txt       | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
