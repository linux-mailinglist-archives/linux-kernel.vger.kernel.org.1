Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57CC28130F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbgJBMpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgJBMpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:45:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2EBC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 05:45:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t17so1622963wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wFV5imeeVNh4aFNipAcfdjblW/ZOSyL9D39PK7KSmYo=;
        b=lWxGJoebMl3Ow+l/cLANA9HhBH3zJXSC8xy+gtbKmRCNZf7WDvBhpyDDf83Zz5iQFC
         j5b61CbPjBbeYKNb5XcJ48lV5DcDUV8mFTEGv+dRdnlL/n6mucyiuK6rch3ueoR2B+bd
         tCbjia8xLyjBuvY2Ss7GvcAQ6mXD1/P8aULn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=wFV5imeeVNh4aFNipAcfdjblW/ZOSyL9D39PK7KSmYo=;
        b=rUz9yD/Lft3abpJ0vknHiuNi4fenQEocAu4XAWssaQG32B5J1T8f8MUDzNQSHDr3U3
         88lCwCD9tC78BLadrMvb1yfXTnKJjXC15Wpiyl4lAFiYvw09y9L4+HNM8GBmNy/I2dKH
         HAUr21TvRXt1P43Pb1/wa9SSpcQfRUdl9pxbPIITTGXaa3SFsYR881WqN7Y763mCZjTd
         b722BTOu9X8D356IhrIyh/ONkmkq32ANJDKsysdinpzxzLOrDda2mQsbkzywUJAvvjLW
         QtFMJrwqU0zoEXlczVN5cHMl1tlH+oTePWNpzaN+llS6nmbW8yq13FdT0rgfKvIlGfEc
         qLEA==
X-Gm-Message-State: AOAM532ZSYzRV2rwsY/P2ZwogfVeSwizNPwYB1lQqbosQYJNbpuUMkni
        p3k8hSLN9HXxeBTbKG38WCvc4n7m6xtdsnxU
X-Google-Smtp-Source: ABdhPJy1lt6kNIxeUs6/VE8gsVST8rl8/txotIGZob4YZPT7AgI1xK1NnarLou4liJCfaYVaPQX8LA==
X-Received: by 2002:a1c:5a05:: with SMTP id o5mr2589737wmb.7.1601642732877;
        Fri, 02 Oct 2020 05:45:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u13sm1616278wrm.77.2020.10.02.05.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 05:45:31 -0700 (PDT)
Date:   Fri, 2 Oct 2020 14:45:29 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jiri Slaby <jslaby@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 0/2] Add configurable handler to execute a compound
 action
Message-ID: <20201002124529.GI438822@phenom.ffwll.local>
Mail-Followup-To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Jiri Slaby <jslaby@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@collabora.com
References: <20200818112825.6445-1-andrzej.p@collabora.com>
 <20201002123158.GA3346786@kroah.com>
 <95030036-87fe-8c61-6fc6-c60452d8ca96@collabora.com>
 <9bd7ff2e-ddf3-f950-54ad-c143e9c60daa@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bd7ff2e-ddf3-f950-54ad-c143e9c60daa@collabora.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 02:36:33PM +0200, Andrzej Pietrasiewicz wrote:
> W dniu 02.10.2020 o 14:33, Andrzej Pietrasiewicz pisze:
> > W dniu 02.10.2020 o 14:31, Greg Kroah-Hartman pisze:
> > > On Tue, Aug 18, 2020 at 01:28:23PM +0200, Andrzej Pietrasiewicz wrote:
> > > > This is a follow-up of this thread:
> > > > 
> > > > https://www.spinics.net/lists/linux-input/msg68446.html
> > > 
> > > lore.kernel.org is easier to pull stuff from :)
> > > 
> > > Anyway, what ever happened to this series?  Is there a newer one
> > > somewhere?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > 
> > https://lkml.org/lkml/2020/8/18/440
> > 
> > Andrzej
> 
> Sorry about confusion.
> 
> This is the same thing, so there is nothing newer.

Maybe split out the s/V/v/ in drm so I can pick that up? Alternatively
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch> if Greg takes it all.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
