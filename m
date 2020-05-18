Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8681D8544
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 20:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbgERSRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 14:17:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46588 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbgERSRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:17:45 -0400
Received: by mail-io1-f65.google.com with SMTP id j8so11628431iog.13;
        Mon, 18 May 2020 11:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wH2wpsF4FeBFwhkjZBgF9GlZnTfwvwb/yr+LagJqrpw=;
        b=kSBJbeBFe+iqYOKsUy2ANOUT8RnmtwuSOZsuYT1YMDQyfI5zjyNFEoaxhwa/ZCMSdo
         20aDF0mWfFxw3QyEN2nU9Z45pbew96wpeIAGHFaGqj2SfNmU9c2yDuql0+BZmc/jfUdr
         p1JOPon4PPHYj1Ws1RL4XE+Gc9Q3BvxVlN6hBkYr1A5dGsLYnh7d/iR+giYrr8VTjfBT
         u8tDDpEfJ2btPz866vJivQfRyhjTvpnJTelmVzKWA5bJ5LPqyA1QsIwGblEIQ8S+hxsa
         f3PlraMeJQwsKBAMxPHwZgI+ppbvaeMw0LuMscsPGK14EzXr0G3k0MlqUscsQtQqWqfW
         h54g==
X-Gm-Message-State: AOAM531riIaBuWjHUc21bfL8MldypR9tQ7jcOaJnYrElWGyha1nHlsH3
        1uFc5wwwOp6KNMRI7bGkSA==
X-Google-Smtp-Source: ABdhPJxBTebcxj6RzsmcfGZ/6flTsiq6MHsYPPbOoqoI1bDj5QSrtkeJ/VN4Vm/MyZaUM3vZkbSFww==
X-Received: by 2002:a5d:954c:: with SMTP id a12mr15748646ios.208.1589825864973;
        Mon, 18 May 2020 11:17:44 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id g65sm4587417ila.21.2020.05.18.11.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 11:17:44 -0700 (PDT)
Received: (nullmailer pid 22861 invoked by uid 1000);
        Mon, 18 May 2020 18:17:43 -0000
Date:   Mon, 18 May 2020 12:17:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v2 1/3] dt-bindings: phy: Drop reset-gpios from
 marvell,mmp3-hsic-phy
Message-ID: <20200518181743.GA22794@bogus>
References: <20200509081754.474787-1-lkundrak@v3.sk>
 <20200509081754.474787-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509081754.474787-2-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 May 2020 10:17:52 +0200, Lubomir Rintel wrote:
> This has been added in error -- the PHY block doesn't have a reset pin.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml     | 7 -------
>  1 file changed, 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
