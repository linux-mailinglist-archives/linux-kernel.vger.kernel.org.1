Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A32DB44D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbgLOTId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731580AbgLOTId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:08:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC112C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 11:07:52 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f9e009c14e1abc4cc14de.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:9e00:9c14:e1ab:c4cc:14de])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CDC21EC04E2;
        Tue, 15 Dec 2020 20:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608059271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Y7ATcfrK47SnWop8qgLP9xxPQlkADRNQks6b3KI3qSA=;
        b=ZwpQI54b4wFb8SBAjZ39YLXdGvbX1HWakm/sfwN42RiBao/TIDrxvVqtbzqB5lOWwUDZFa
        rXJQB0aAX9J36pHeDJ9kInk3JhFksNg6BKo3VHIFQdCc49rtNa27Tygc3EOaxEP5zvYPZx
        eH3gc6/2TFdnD1DFMeKslttQG311d6M=
Date:   Tue, 15 Dec 2020 20:07:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Chiawen Huang <chiawen.huang@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
Message-ID: <20201215190752.GF9817@zn.tnic>
References: <20201211155553.GC25974@zn.tnic>
 <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
 <20201215155622.GC9817@zn.tnic>
 <20201215160720.ewce4usgb53pzt2j@outlook.office365.com>
 <CADnq5_MSJdrmxNW9jhdQPOZLUdkJtZMyA6FmqjyZsgGHBWoXVg@mail.gmail.com>
 <20201215164234.ywgesdqup6zdjxw4@outlook.office365.com>
 <CADnq5_N=CiuGKe4V-4a8s=SEAR9M4W8X_vdshgbwXH2b9u+L2g@mail.gmail.com>
 <20201215184306.GD9817@zn.tnic>
 <20201215190058.p6osaztp6wi6ci3p@outlook.office365.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201215190058.p6osaztp6wi6ci3p@outlook.office365.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 02:00:58PM -0500, Rodrigo Siqueira wrote:
> Thanks for reporting this issue and test the fix.

It was my pleasure. Thanks for the quick fix!

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
