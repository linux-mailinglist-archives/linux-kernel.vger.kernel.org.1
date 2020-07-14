Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C253521FDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 21:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgGNTmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbgGNTmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:42:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6546CC061755;
        Tue, 14 Jul 2020 12:42:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so8047768pgk.4;
        Tue, 14 Jul 2020 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=scAKWZ9w0PnLLtxMyje28uys2NF0S5edA01+XM+QBig=;
        b=Uh6O3LWGHVo+rR8bvdIFPF1rtF6BZXiFm/vocDTMfCreMN6x0z6KK52OTeJLSxeNP2
         F68n+OjcIz4XlpqlrDHjcComyXR8mrwwzqNQf77nNucK7AxsHFiqZoAn9NE1phYZG1/7
         0v76P9O9taaZDBegGxGgtDhfTlPUWBBB5xGtNMorfpNREb6qYv3XwktYjD45hiPVIHnv
         mXJA8+8jYD1PqBD5BiuUUqXlpAv7n8dN9X6BtAwQu/byZnrrE+MXNxzYjZ2u2efmyTBf
         F4n5aZbCZUJq9ZEMoJ9vqBGEt/j3C24VuNIeXErWYByvRRr+FzRfd6tpVNrk8wL06lVi
         GRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=scAKWZ9w0PnLLtxMyje28uys2NF0S5edA01+XM+QBig=;
        b=OVHRrc+2QZckRwChHDZRgTFDJhccJosesaMH3IFi9n3JQmvfHftC2p04K93B4mFYkp
         zwpt4Q2UVTgK73/thkgE9op9B9Vh7y6H1QTFa5zumk7mLm7r4XfYOFxzCSImHUS1Ktn8
         lDjkSXeZxRoRVbLAVutRaXERNBXOzMFowB33Pskw5eMUuCK5TZaXoJiPXN+eTEkLwZks
         vHlb5c97gK4WLMvhVo2yp1Nh4gENXOexjjNhsrZuw0avDHAT15TCR1KgvvoCFE5j3M6k
         vsfaL1/PjInVhEs4skHQ3TNAJF/Rz59t/hSCZElLBusftybN6weDibulqS/FGIBKNNiX
         rWMA==
X-Gm-Message-State: AOAM531ym14On26EOoB3LkfwmoBk5fpZSjFo39UywhCpBU0wZh7S1YRS
        ke8URKwOD/yZ2h38gJ6qxeI=
X-Google-Smtp-Source: ABdhPJw/XfW7t8laLRAfSW3wQGYIjrPK3epddxCzffXxjhzfSrf+oav76cn+bQe9QVD8DaiiHifW6Q==
X-Received: by 2002:a63:4545:: with SMTP id u5mr4500145pgk.229.1594755726949;
        Tue, 14 Jul 2020 12:42:06 -0700 (PDT)
Received: from localhost (g175.219-103-161.ppp.wakwak.ne.jp. [219.103.161.175])
        by smtp.gmail.com with ESMTPSA id bx18sm3335942pjb.49.2020.07.14.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 12:42:05 -0700 (PDT)
Date:   Wed, 15 Jul 2020 04:42:02 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Openrisc <openrisc@lists.librecores.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] OPENRISC ARCHITECTURE: Replace HTTP links with HTTPS ones
Message-ID: <20200714194202.GE437393@lianli.shorne-pla.net>
References: <20200710062019.28755-1-grandmaster@al2klimov.de>
 <20200713113430.1c1777bb@lwn.net>
 <CAMuHMdXoUME_dCOZP1N0tXyMv61edfNECM4-n4NPa56YbBCncw@mail.gmail.com>
 <20200714074022.24481c73@lwn.net>
 <CAMuHMdXMumw9CnMHOc_GJGO0MNsLowTv-wE399BMJveXgTXbLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXMumw9CnMHOc_GJGO0MNsLowTv-wE399BMJveXgTXbLQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 07:30:38PM +0200, Geert Uytterhoeven wrote:
> On Tue, Jul 14, 2020 at 3:40 PM Jonathan Corbet <corbet@lwn.net> wrote:
> > On Tue, 14 Jul 2020 09:22:39 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > -     website         http://openrisc.io
> > > > > +     website         https://openrisc.io
> > > > >       email           openrisc@lists.librecores.org
> > > > >       =======         =============================
> > > >
> > > > Applied, thanks.
> > >
> > > Is that site accessible for anyone? It times out for me.
> >
> > Works for me.
> 
> Now it indeed does.

Thanks for checking,

There was an issue with our server hardware that hosts https://openrisc.io as
well as other FOSSI sites including https://www.librecores.org and
https://fossi-foundation.org.

We migrated these all to different infrastructure (github pages) to fix the
issue.  They should be more stable now.

-Stafford
