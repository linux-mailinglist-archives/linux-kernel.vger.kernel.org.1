Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88F62DB3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbgLOSnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:43:47 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44190 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbgLOSnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:43:47 -0500
Received: from zn.tnic (p200300ec2f0f9e009c14e1abc4cc14de.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:9e00:9c14:e1ab:c4cc:14de])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C412A1EC0529;
        Tue, 15 Dec 2020 19:43:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608057785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uwhF67ZNq4sHnhH4bMNia+fCOML1Ao8wrayJg2Hb1n4=;
        b=eiry/sVTRuyjkvnBzbUEW5pXzL5qLA3Dvxh9q691rObSbQXTZSIGWzJmudGSI9eVKfREOT
        +SLPCBmbbbwjEzf+KRnAdjP483UDgBrch970AiQN7j1FQVhCfBb7bKfQP0kfxfb3mlTICf
        j1nGXWHvc+CWgYV3IsA9HZBFLOg5tPc=
Date:   Tue, 15 Dec 2020 19:43:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Chiawen Huang <chiawen.huang@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
Message-ID: <20201215184306.GD9817@zn.tnic>
References: <20201211155553.GC25974@zn.tnic>
 <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
 <20201215155622.GC9817@zn.tnic>
 <20201215160720.ewce4usgb53pzt2j@outlook.office365.com>
 <CADnq5_MSJdrmxNW9jhdQPOZLUdkJtZMyA6FmqjyZsgGHBWoXVg@mail.gmail.com>
 <20201215164234.ywgesdqup6zdjxw4@outlook.office365.com>
 <CADnq5_N=CiuGKe4V-4a8s=SEAR9M4W8X_vdshgbwXH2b9u+L2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_N=CiuGKe4V-4a8s=SEAR9M4W8X_vdshgbwXH2b9u+L2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 12:04:23PM -0500, Alex Deucher wrote:
> That patch trivially backports to 5.10.  See attached backported
> patch.  @Borislav Petkov does the attached patch fix 5.10 for you?

Yes, thanks.

Reported-and-tested-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
