Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892712DB0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgLOP6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbgLOP5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:57:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0349C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:56:29 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f9e00f1a225f790dae810.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:9e00:f1a2:25f7:90da:e810])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 74CF01EC052C;
        Tue, 15 Dec 2020 16:56:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608047786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jo3x3cAXCEFcVh/x07VCfdFGsck/d89LJzeAOW0iS4k=;
        b=X5ENld1jV1a5fXRQaZ6bkmGIUHUoQPDXB4a9GjpjYIBRi2ly5nR1A9epDHqoPaFOGsipxL
        UL+c73vyIEv1VjPpNKMRzc1WtYacolOgTo8VdU11ZOLa00IgxS1IQ0zHLo9LaSYR/Kd1BZ
        pbkmNGNtyAMSZ9XBDsA1yrnVmdW/o7k=
Date:   Tue, 15 Dec 2020 16:56:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Chiawen Huang <chiawen.huang@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
Message-ID: <20201215155622.GC9817@zn.tnic>
References: <20201211155553.GC25974@zn.tnic>
 <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 10:47:03AM -0500, Rodrigo Siqueira wrote:
> Hi Boris,
> 
> Could you check if your branch has this commit:
> 
>  drm/amd/display: Fix module load hangs when connected to an eDP
> 
> If so, could you try this patch:
> 
>  https://patchwork.freedesktop.org/series/84965/

So I did a bisection between

git bisect start
# bad: [3650b228f83adda7e5ee532e2b90429c03f7b9ec] Linux 5.10-rc1
git bisect bad 3650b228f83adda7e5ee532e2b90429c03f7b9ec
# good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9

and the patch in $Subject came in in 5.10-rc1.

I can test any tree you want me to so just tell me on which tree to
apply this patch and I'll run it.

In any case, it doesn't apply on v5.10 though:

$ test-apply.sh /tmp/rodrigo.siqueira 
checking file drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
Hunk #1 FAILED at 120

You can push a tree of yours somewhere which I can try directly,
alternatively.

Lemme know.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
