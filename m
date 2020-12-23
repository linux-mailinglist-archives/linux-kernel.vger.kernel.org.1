Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719122E1BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgLWLra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:47:30 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:35419 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgLWLr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:47:29 -0500
Received: by mail-wm1-f51.google.com with SMTP id e25so5908768wme.0;
        Wed, 23 Dec 2020 03:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ZSdCCUzMEnIYbJntS9xAiMl4+RBp/jbCpprNTs4u+Y=;
        b=JVelsdeaiEbA0pKB2UqRzDILVdxHgk4DPp+iQpTSUPukjwwjzfu+xQD7KWke8QDrow
         zYgDBnzjdeOm0dFm56PMRszGKB6w1Yu7L8/8x52Xz4P8doJBXYdz1+A1fl/FgHl5aP9p
         ELU9mram1unuA781vRcPD7iKqSMKAYZPK/dBSFH8vLkYou5VbxheyESi1VqZBzqaU3oG
         WMFm93sc/9uYj1u/hg4hf/Rp0DenSzVZIsWN9b2ayHRRuoz6rvqgzRjHtj3KhwXSgfHA
         35N8TkDi7zKj8BHKWcydO8Aijksyjyb3n+nLsBFU4o2kW7rdLcYdRZNADJ4MnpUFeDXW
         uPVw==
X-Gm-Message-State: AOAM533A9aCgq/VoH5u+rLmOCGehK4k91OR+MSIeqZvIit2i4hSDJXCr
        /2YHwq2A4ACzaMG6FvALGcM=
X-Google-Smtp-Source: ABdhPJzkeNy2+f3FN7FeD62h3bjrm6dI4yRbzEoWNCd64nokYIuohAhsR6TMXNJDejHZOu91T3n9UQ==
X-Received: by 2002:a1c:2003:: with SMTP id g3mr26564715wmg.136.1608724007409;
        Wed, 23 Dec 2020 03:46:47 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 67sm22008459wmb.47.2020.12.23.03.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 03:46:46 -0800 (PST)
Date:   Wed, 23 Dec 2020 12:46:44 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 2/6] dt-bindings: arm: fsl: Add Engicam i.Core MX8M
 Mini C.TOUCH 2.0
Message-ID: <20201223114644.GA21091@kozik-lap>
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
 <20201223110343.126638-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201223110343.126638-3-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 04:33:39PM +0530, Jagan Teki wrote:
> i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> 
> C.TOUCH 2.0 is a general purpose carrier board with capacitive
> touch interface support.
> 
> i.Core MX8M Mini needs to mount on top of this Carrier board for
> creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> 
> Add bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - add proper bindings 
> Changes for v2:
> - updated commit message
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
