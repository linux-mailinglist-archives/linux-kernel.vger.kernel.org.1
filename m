Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D4268C67
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgINNmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgINNgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:36:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F331CC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:36:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g4so18793602wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mQTSz+F0/jwQFSbAoSWyzCTHT0bx5sLVH4g78zcSlbE=;
        b=LqLlbN66yJSrvOLcI8W3zmw8eNHxlNnhKMFCJv0qMf42eKhDm38ZE3hAcVM3TgwCmg
         el8mZlcc6OlLjGEtKQVS1y90idI4J8y7HhxIL67VQcN1zxEPAWdnAaNyz4KLPuHQD/9u
         siwmV//jG68us421wvVxGp9kfS5aMBIzcXNKZTsycDI0JPI9raX/vM2/R/Lv/Z8L8ZRT
         WiQrlLGDz+ftHx51FzShdgSVOaAY7dA34C9/3tXgMMZMD1xiro0F2+ospPBxZXCbamEv
         UXBZbpW0GOmqbSpv5G7+jPARPbroOtM2SZ2cTeRLDPgquAkcHp1AHJjEkoRTphZZ/nce
         Mlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mQTSz+F0/jwQFSbAoSWyzCTHT0bx5sLVH4g78zcSlbE=;
        b=K/csYsRlLIjtnbCcSAc6UsntXrrGNpBMiEwY70EW5L/3GAfLdyu+RyOfe2TBVzbVjk
         5A4yzIpbPuTPrzyULuM6gpmM5VEVNFkxw0Dm+UWlh+1s2ISSKP8vXIb03mrFq+9jnUZ4
         DgEIzCbBWonsnpWj7/B6hgTElvsOopK0ofihDM2cbshf/YrbvfssISJnko7tmUHHz/XA
         +duIXoNAreiKjAdUn/Fqz4jaZncV3euGIChGgZfq869aRY1af3t5IN9XxL+0JgAxuAlT
         WiWwyXwXEJpJYJlF/TVvIzO0CjYcEvIeIP0pJVfC3PwXijLiUFACYop0AOY0MW4cZ0gz
         4WJw==
X-Gm-Message-State: AOAM530PAUyTdNCx+C47bUPp15GPJaUNcB3yDWw4eqwjRSAbbnUJ35EF
        LOKsuhG1Twz6eGuHIqh0wfrSiA==
X-Google-Smtp-Source: ABdhPJxlB0tFL7Vwj9BZKftP7pHnkfkJABeBpJnppD6g+0UMJCK4bdEchqU47IA+DGTju8H1SnuVKA==
X-Received: by 2002:adf:f245:: with SMTP id b5mr16663747wrp.288.1600090588501;
        Mon, 14 Sep 2020 06:36:28 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:1944:329c:8ce0:e1de])
        by smtp.gmail.com with ESMTPSA id b84sm20980901wmd.0.2020.09.14.06.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 06:36:27 -0700 (PDT)
Date:   Mon, 14 Sep 2020 14:36:26 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [BUG]: KVM: arm64: Fix symbol dependency in __hyp_call_panic_nvhe
Message-ID: <20200914133626.hlsvu5kces3wsirr@google.com>
References: <3750C774-62A4-4D02-8C07-6C98304F32F3@goldelico.com>
 <20200907142206.GL8670@sasha-vm>
 <3FB315D0-C65D-49C0-A632-6E103F1D02B7@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB315D0-C65D-49C0-A632-6E103F1D02B7@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

> > Right, it got moved around in upstream.
> 
> Maybe this has fixed something...
> 

Thanks for reporting this. I've managed to reproduce the problem with Linaro
GCC 4.9.4 and I can also confirm that the same toolchain builds v5.9-rc5 fine.

As Sasha pointed out, the patch was part of a larger series that ended up
moving the definition of __hyp_panic_string to a different source file. That
means in 5.8.7 switch.c sees it declared as 'static const char[]' but in
5.9 it is declared as 'extern const char[]'. When changed to 'extern', 5.8.7
compiles fine so this sounds to me like a bug in GCC that has since been fixed.

That means we have two options:
(a) define __hyp_panic_string in a different .c file in all pre-5.9 branches, or
(b) revert the backported patch.

The patch was needed in 5.9 and should stay there. It wasn't needed in earlier
versions because the symbol was being kept alive by another user. It did "fix"
the inline asm semantics, but the problem was never triggered in pre-5.9.

Sasha, with this and the GCC bug in mind, would you agree that (b) is the
better course of action?

-David
