Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621531D01A6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 00:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgELWLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 18:11:37 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33332 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgELWLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:11:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id o24so19693867oic.0;
        Tue, 12 May 2020 15:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RTpvgItjsIRFSZ5D5JwDplmKO7eAYduxml2laMqHkwg=;
        b=U8w01UMC4rUJGF7JBZTgCVkCLQXAiFLgACR3ATl3d6olI+eVbiYTUnzAGGs1LWFjJL
         9CFfiYmEZZaYKnscbLreC5mQ2qUQLZfM8EDPi21gKusqP9odUcxqyDGGvrOB/VdZ1J4e
         bLrnqTj49IYacUN/3hzIKOpUOBjew0XWj8TElfTA1DI5Lp+PcMGdYIUjUL8msmImIgxb
         zbj1VQLtOpbrmLe/CqoZYF2cjpzEIRKw+MqXwt4zHZmjFCY9qrgEc0RRjWQwgm6EJr8H
         9Vsu4pI+nXSY1vyCQ/v3o9pHS65+YcEzr2wsXQd3olcErJXUVnAJGJwJGLxTPfeXXhIi
         Mfbw==
X-Gm-Message-State: AGi0PubxjJsB/lXVLZXEmULH+Qmqk1OaYM/CKSmTyktxz9WF0CDIbirV
        gJx76FMxBEjU1Rq9kS2OGg==
X-Google-Smtp-Source: APiQypJE8Xl38hpDD0pF0oA7mVSnQ/28VAr9BYPuylNa8jiRVasWj469o633WLoXC1xsjFvRKB/CkA==
X-Received: by 2002:aca:b584:: with SMTP id e126mr19711969oif.15.1589321495878;
        Tue, 12 May 2020 15:11:35 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v9sm5624639oib.56.2020.05.12.15.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:11:35 -0700 (PDT)
Received: (nullmailer pid 25779 invoked by uid 1000);
        Tue, 12 May 2020 22:11:34 -0000
Date:   Tue, 12 May 2020 17:11:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     mani@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.torgue@st.com, mcoquelin.stm32@gmail.com
Subject: Re: [PATCH v2 5/6] dt-bindings: arm: stm32: Document IoT Box
 compatible
Message-ID: <20200512221134.GA25745@bogus>
References: <20200503154215.23654-1-mani@kernel.org>
 <20200503154215.23654-6-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503154215.23654-6-mani@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 May 2020 21:12:14 +0530,  wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> Document devicetree compatible of Shiratech IoT Box.
> 
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
