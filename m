Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE57D2EEB6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 03:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbhAHCmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 21:42:16 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:33775 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbhAHCmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 21:42:15 -0500
Received: by mail-il1-f179.google.com with SMTP id n9so8921643ili.0;
        Thu, 07 Jan 2021 18:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UReZgsEeNazDb1E0tvnMlZgxkV/SKchhzjq/uOzNftA=;
        b=ucvyoQ2AEbBll7CxfTQ5659xwdQPV98a3D81eGTQGgYwSlrTKXfayGamWT1LE7PZNG
         J67mRUWlWWmVkgOo6jHAAaMnn7Ur7m/BsK+jH4unuXMgMzQzhSFQO2eJORU7+6r/r/fO
         cZLOvUP07DfGbaldaQjwU2O49pMPGb0aCX0/CKSv0iwLc1SESqvBFp0H3/xplAlj/10Z
         aUul0BzguVJtkzfJDVRUcKXc0MeKrBB+o3dN9qg81xbnRoRAbgK3sw1eI4vqrhdeUVQD
         XU6MtbHD4DmRk10v+EzKisspW2XGKmEcj7sDoLnKsgu/hK2CxM2xZEdyD63RJE3mYBG4
         WsUQ==
X-Gm-Message-State: AOAM530Jnpr4mHQoyS0woi7yUwp5U+tny5/Hja7TUes3rgX4d9gAgszd
        ToSDjVVkurcJEIWL8tlyLQ==
X-Google-Smtp-Source: ABdhPJxzJ8EBfjRzhw77Uq2UvKWCik2FGY5zfXOrBWgNrJ1t2elsxK6eFsDm54ajklXduSQSYmSkEQ==
X-Received: by 2002:a05:6e02:1311:: with SMTP id g17mr1746135ilr.223.1610073694571;
        Thu, 07 Jan 2021 18:41:34 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id c9sm589879ili.34.2021.01.07.18.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 18:41:33 -0800 (PST)
Received: (nullmailer pid 1768224 invoked by uid 1000);
        Fri, 08 Jan 2021 02:41:31 -0000
Date:   Thu, 7 Jan 2021 19:41:31 -0700
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-amarula@amarulasolutions.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: arm: stm32: Add Engicam MicroGEA
 STM32MP1 MicroDev 2.0 7" OF
Message-ID: <20210108024131.GA1768173@robh.at.kernel.org>
References: <20201223191402.378560-1-jagan@amarulasolutions.com>
 <20201223191402.378560-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223191402.378560-5-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Dec 2020 00:44:01 +0530, Jagan Teki wrote:
> MicroGEA STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.
> 
> MicroDev 2.0 is a general purpose miniature carrier board with CAN,
> LTE and LVDS panel interfaces.
> 
> 7" OF is a capacitive touch 7" Open Frame panel solutions.
> 
> MicroGEA STM32MP1 needs to mount on top of MicroDev 2.0 board with
> pluged 7" OF for creating complete MicroGEA STM32MP1 MicroDev 2.0
> 7" Open Frame Solution board.
> 
> Add bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
