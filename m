Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD7C2909EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 18:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410653AbgJPQr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409423AbgJPQr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:47:59 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1164C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 09:47:58 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z2so3334034ilh.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SzwfP2POlAsPwbCyWLzULYTBtugyUxRZmRVXFQKGh/Q=;
        b=Vsq9OlasW6VbbxEP0ADh8LkBCRxYT8yCOSN5TtFgTG7S75p//SD6XMCY1BL80slNUN
         zaytwu4bGnjg3dEV0uWCNcA9eaO7dwcj4NddewNSbaFniVHrwetA/24beUULVTE+S1y0
         6e6C2Hnxg2Y9TjZQSo0uyRV7ZNtTu7doDPyThfhzK3pCV9B5FHwez6zbtAnYfMZSrkB3
         RgTh/DxVkaGtv23IGwmerOht7YtCMOYWcK64zEb5xtJ17iuoO9/uwT3NEAlnFjwZvZxD
         yWTopAURJtwr/+oQ+4PGmMnzfrR+JhIZuG0U3YG7DScruUEmsMf8C5YMvQXR+5mEHVD/
         pxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SzwfP2POlAsPwbCyWLzULYTBtugyUxRZmRVXFQKGh/Q=;
        b=jtZIxYBUCVis3maE0ORLLfYMWATcs9CZXLf8mC413gFv0NZwRsJacDxAagMFjSdPNP
         BZOmG9gKmRiTWm6+TyzL0cCacENotXqt3h+QnPdPWka1dIL/s/FtFQ3w7xI/RXoShcbe
         WClQtRzjYsC1RzQ0HJeBwV9T48SJscNfFcZGyxQJ+qjFQMcOqr5IBvBGkkE2miEyj6P4
         7HNKhMC7P1nP3zi+mDxm5gGSvcCBIydquVD85a2L1njqFrLwasAgtNyjnVvKHaU6ppag
         0bM6lADZWfxii2f4n6yolkg2CKqp6tW4q5WWVy8zvwsnYKu+lh9WmGnPK9k+QS/oeVh1
         jfpw==
X-Gm-Message-State: AOAM531Y0zCdTVSD+GV2vG2qw8JOeOzxu2184f4ch9Zk7z1Dg0A4wnq7
        0R3tT9+RzhGpawUtnMV1D/PDPRL2oTegpg==
X-Google-Smtp-Source: ABdhPJwDBW/H+e3voWKhbLjIaDWA4sFnh2TaqAeF/seuMl28xJqbqVCQdfTKWLs6soBoK3H46jzXkA==
X-Received: by 2002:a05:6e02:6c6:: with SMTP id p6mr3340787ils.91.1602866878261;
        Fri, 16 Oct 2020 09:47:58 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u8sm2980123ilc.59.2020.10.16.09.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 09:47:57 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 16 Oct 2020 12:47:55 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] x86/boot/64: Explicitly map boot_params and
 command line
Message-ID: <20201016164755.GA1185111@rani.riverdale.lan>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-5-nivedita@alum.mit.edu>
 <20201016162759.GG8483@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016162759.GG8483@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 06:27:59PM +0200, Borislav Petkov wrote:
> On Thu, Oct 08, 2020 at 03:16:22PM -0400, Arvind Sankar wrote:
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  arch/x86/boot/compressed/ident_map_64.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> Ok, just pushed your two fixes here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=rc0%2b1-seves
> 
> Please rebase this one ontop and put the two cleanups last so that the
> fixes can go into urgent while the two cleanups can follow later through
> normal tip flow. And yes, pls do this in the future too: fixes should
> be minimal so that they can be expedited first and normal cleanups and
> features can be done later.
> 

Just for clarity, by cleanups you mean patches 2 and 3? i.e. you want to
see 1, 4, 2, 3?

Thanks.
