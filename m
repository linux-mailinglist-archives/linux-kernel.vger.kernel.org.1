Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991F02EAA21
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 12:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbhAELoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 06:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbhAELoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 06:44:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9D2C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 03:43:49 -0800 (PST)
Received: from zn.tnic (p200300ec2f103700516ef90d43f797fe.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:3700:516e:f90d:43f7:97fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5319A1EC03C1;
        Tue,  5 Jan 2021 12:43:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609847028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g/xf8hdoLpsGm0AJWHiHczuDrlihyCsQII90GMgmI3E=;
        b=ogLy3w6Hs7og2FvvT3btBenp2HnFVmhtUVfNFK32nuNT6LUpHyj4Adn6j5aMvibHvGh7O5
        nfcfpgBSkq8sqjJgZfgbEVZaebn9nl7xBVwI24qWO7LHl91HEvUk3HmtS2jJ4nyypd5C1j
        l1QBlPEGEGpbrsNZKe7nzvoS1qoSl4w=
Date:   Tue, 5 Jan 2021 12:43:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 5.11-rc1 TTM list corruption
Message-ID: <20210105114351.GD28649@zn.tnic>
References: <20201231104020.GA4504@zn.tnic>
 <e3bfa0a4-5d0a-bd68-6cc8-73db1d29f22c@amd.com>
 <20210104105802.GD32151@zn.tnic>
 <20210105041213.GA544780@hr-amd>
 <20210105103138.GB28649@zn.tnic>
 <20210105110852.GA1052081@hr-amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210105110852.GA1052081@hr-amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:08:52PM +0800, Huang Rui wrote:
> Ah, this asic is a bit old and still use radeon driver. So we didn't
> reproduce it on amdgpu driver. I don't have such the old asic in my hand.
> May we know whether this issue can be duplicated after SI which is used
> amdgpu module (not sure whether you have recent APU or GPU)?

The latest I have (I think it is the latest) is:

[    1.826102] [drm] initializing kernel modesetting (RENOIR 0x1002:0x1636 0x17AA:0x5099 0xD1).

and so far that hasn't triggered it. Which makes sense because that
thing uses amdgpu:

[    1.810260] [drm] amdgpu kernel modesetting enabled.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
