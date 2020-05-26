Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDC41D855F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 20:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbgERSSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 14:18:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34580 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732102AbgERSS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:18:26 -0400
Received: by mail-io1-f67.google.com with SMTP id f3so11714894ioj.1;
        Mon, 18 May 2020 11:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ls2oGb584lE+ih5A0xlC1D9uSKfFyTXu9czWBNVlDL4=;
        b=bQk+8FEaNjTDZFVrzuzltiKHA3nYK3C+W7IiYFLw2+P4t+cNzZMkqShN5wBeVoxYM6
         rEg6WigXUVQ6ikZOf9PjLiCL2cre0cho9fPblJcQJAnMS4kT1tM6LNGVnzPyfBS2ZUnM
         V3rpN8ZmDcJDZvxUsOoP9JCnfRnUEA+5ec5SkB4zJTqS55oMSYKt7w+fNC5E5fcZUo8v
         hTPmD00stFhyF9fowpSCZ0vnjuJxlu5FVD0XXuogxsQD/hZ68efaOImd2PHk8RN0Iww7
         kj20r4hVDsY8LY5QkjZC+nx2Hceiaie7L0NRTijkHzrmjvUwo8O+tff+61PKcThVLpH3
         Uoow==
X-Gm-Message-State: AOAM5319ILHcMOGChbsTYE8jUtgImh4bTrIOVX1Yz4fK2X/UbzKVXKw9
        qLd+eIiQNClnGcBgWDXQ6o79OqQ=
X-Google-Smtp-Source: ABdhPJySwSncBqstvZnifWbUwSs+7NnwA8TVJ2UTLqaiVB8AIydXrixRJL0jgp88qHAOi/ilJtwmHQ==
X-Received: by 2002:a02:394d:: with SMTP id w13mr15975374jae.58.1589825905257;
        Mon, 18 May 2020 11:18:25 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id a6sm4144806ioe.10.2020.05.18.11.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 11:18:24 -0700 (PDT)
Received: (nullmailer pid 23837 invoked by uid 1000);
        Mon, 18 May 2020 18:18:23 -0000
Date:   Mon, 18 May 2020 12:18:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RESEND PATCH v2 2/3] dt-bindings: phy: Allow BSD licensing of
 marvell,mmp3-hsic-phy.yaml
Message-ID: <20200518181823.GA23778@bogus>
References: <20200509081754.474787-1-lkundrak@v3.sk>
 <20200509081754.474787-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509081754.474787-3-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 May 2020 10:17:53 +0200, Lubomir Rintel wrote:
> I wrote this binding and I'm fine with it being GPL + BSD dual-licensed,
> as is recommended for new DT bindings.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
