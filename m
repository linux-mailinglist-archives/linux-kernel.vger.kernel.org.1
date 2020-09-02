Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C0525A8EF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 11:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIBJup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 05:50:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39654 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgIBJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:50:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id c10so4289303edk.6;
        Wed, 02 Sep 2020 02:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v+z/Iz5Kt6N55tJf/v6lifigRsgJrV4tsPh9oDDZNS8=;
        b=teJwk/G3J/3EBOB/BF4/tc8a3KH75FC580ApKCo82n6CTgV8bXCDM7yxOPQt27kmRV
         DEMqQEgoQPBNp1StyEhLxcNJFoQfalBePffHAgS+6wtWTxjepXy8rINtLCwG0FKCD7EP
         xVzuxj4k8Ijpj+tsoQqD9vGkfFY7pAu0n8CW/cF0cTgtwFrk6VIdJUyp5GRVXyXmv5M3
         NnjfjVszi6AlPDc71MPINl8sC/SHyR30Wg/OI65A8KoAiKE327WCQBPBg6R+pQvUNKIS
         vsXJl5K+yJsWvj6LYgiymKFWOWDGltyGu1aXdT/aKDmvYD9VHxscek7FE1q6oMehn1aE
         8bGQ==
X-Gm-Message-State: AOAM532/uzABT7Bd0guPPFPqXfaBGR3LJ33ddW6KgTRK9QdAWqOkbCRA
        ullqMT0flZUBxDX92aa4oLwfxVJiM5vtyw==
X-Google-Smtp-Source: ABdhPJwQBzxHKXtb9qVKUc/ANdcVm79cQo5uAcpJOq0mP2c85DCaM8X3t+UdeH1e6u4Wj8v9CTgd2g==
X-Received: by 2002:a50:cc92:: with SMTP id q18mr5778693edi.159.1599040240771;
        Wed, 02 Sep 2020 02:50:40 -0700 (PDT)
Received: from pi3 ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id d23sm3740363ejj.74.2020.09.02.02.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 02:50:40 -0700 (PDT)
Date:   Wed, 2 Sep 2020 11:50:38 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing
 sound-dai phandles
Message-ID: <20200902095038.GA14284@pi3>
References: <20200830112633.6732-1-krzk@kernel.org>
 <20200901110349.GC6262@sirena.org.uk>
 <20200902091038.GB13726@pi3>
 <20200902093839.GA6162@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902093839.GA6162@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 10:38:39AM +0100, Mark Brown wrote:
> On Wed, Sep 02, 2020 at 11:10:38AM +0200, Krzysztof Kozlowski wrote:
> > On Tue, Sep 01, 2020 at 12:03:49PM +0100, Mark Brown wrote:
> 
> > > Please submit patches using subject lines reflecting the style for the
> > > subsystem, this makes it easier for people to identify relevant patches.
> 
> > The usual prefix for bindings is "dt-bindings: ..." so I wonder what
> > type of prefix you expect:
> > 1. ASoC: dt-bindings: ...
> 
> This.  Bindings aren't a separate subsystem.

Sure, thanks!

Best regards,
Krzysztof

