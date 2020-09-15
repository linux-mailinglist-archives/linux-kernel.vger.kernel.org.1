Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA6F26B3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgIOXHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:07:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47602 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgIOOlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:41:40 -0400
Received: from zn.tnic (p200300ec2f0e4200c97bc9af71f47aca.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:c97b:c9af:71f4:7aca])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5961B1EC026F;
        Tue, 15 Sep 2020 16:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600180897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=P93q3KUIjtnUEdqG79VfmmA1mIarxQAquVGTwCUSRC8=;
        b=W5SHr1ErnGzY4yc9srNIrV6s7C/BKWo1Ntcrk/CJ/aeGBzE2cTcnRp+2H9i2ZiReZvB02/
        XhPG8CtHoS3Zudv13AtQHmjmR9kxX9s0dl9XpYSXQYhTolQnaxTsX0MOzovqM3a5/2g9Hf
        UYDbLHXegO3/RP66CLwqIvoLAhArveo=
Date:   Tue, 15 Sep 2020 16:41:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200915144131.GK14436@zn.tnic>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915141816.GC28738@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:18:16PM +0800, Rong Chen wrote:
> I attached the config for your reference.

Thanks.

Can you pls fix your reporting so that the mail has the .config
attached?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
