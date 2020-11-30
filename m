Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903872C9078
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgK3WDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:03:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:32899 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbgK3WDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:03:33 -0500
Received: by mail-io1-f67.google.com with SMTP id o8so13510648ioh.0;
        Mon, 30 Nov 2020 14:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T7vPmxvgVqpuMC6ELOtW8OJRBhPCz8EP8sy+CmiOKmI=;
        b=Cx4LzhnPT9NONef1jVIbxr/xDzOkzCTAAygx+E+Loz2emm/S87KLwDSD6jVsE11QOD
         cuzAyq98CmhfuESfF5E0RLnHAemDGXEq4aNEXUdbLyMDB2di6y9TL4flNW1X/PhAVsn/
         7F6tlukNtFh2JjtOUUr1hEa0ZwAGZSs/wfeQdzsWghTn8z0QjejaF7st3VWw/4pwCPRx
         ycb6IC/SWc6vtiGti5iVcoHczAmEBu6guzEfPfdzsC38lz/DsjTCjubKLn+jG5jJEnho
         Qh1hSXsjdwPHO0HnbzEGeR+PlsjSxfjUNpaWVx0zVy/3/a6to27oeZjc48CWL6h5teTN
         6FaQ==
X-Gm-Message-State: AOAM533AlYAKIr+sO0T+6UMeTYDxZstgq1QFC3FhBIrlLzNNjpr742eN
        C8PTYcaMrOob0RksKggapIPJYkAwWw==
X-Google-Smtp-Source: ABdhPJzrgTU+avSScMCSBGUCOPmSFgCefy2xIwUGvipSDuvUQFKtAcT6C+2RNCx8fBDZTAbSsTZf0w==
X-Received: by 2002:a02:3716:: with SMTP id r22mr21582954jar.104.1606773772810;
        Mon, 30 Nov 2020 14:02:52 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z13sm831338iof.19.2020.11.30.14.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:02:51 -0800 (PST)
Received: (nullmailer pid 3110253 invoked by uid 1000);
        Mon, 30 Nov 2020 22:02:49 -0000
Date:   Mon, 30 Nov 2020 15:02:49 -0700
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        aford@beaconembedded.com
Subject: Re: [PATCH V5] dt-bindings: soc: imx: Add binding doc for spba bus
Message-ID: <20201130220249.GA3109751@robh.at.kernel.org>
References: <20201118230414.121316-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118230414.121316-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 17:04:14 -0600, Adam Ford wrote:
> Add binding doc for fsl,spba-bus.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> make dt_binding_check -j8 |grep spba
>   DTEX    Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dts
>   DTC     Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml
> 
> V5:  Rebase on 5.10-rc2 to be able to check yaml
>      Add Reg entry
> 
> V4:  Remove an accidental makefile change
>      Move type:object under additional properties
> 
> V3:  Rebase sample from aips-bus example
>      Split off from series adding i.MX8M Nano functions to reduce noise
> 
> V2:  Attempted to update yaml from feedback
> 

Applied, thanks!
