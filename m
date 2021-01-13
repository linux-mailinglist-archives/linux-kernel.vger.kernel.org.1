Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D442F5413
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbhAMU0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbhAMU0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:26:31 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C4CC061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:25:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r4so2784285wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w+kZv9kbYsmHr/JGy5iDhtegSxFGC5KTV0tLyw8dvw8=;
        b=ohigjfj+Kvg5LKBxNhr5js1B2AdGOZOnQHG0tH9Gv+QjQ3iarEg2hAGF+pPhuNUrkN
         mU/z9MRWz7VHMUC23GzaqdRFROIFJmeRJ+Aos1Snd1/8vvz793NH4QkFr0/Ykk7ny+45
         vvE7qPV/VZArWZimeNpeTaBi/gpjz2FMqusxom2KBRRYHmnXNx6RKagghLLD758gNoP1
         cWEJGc21SupCW30xsd+KXw5J8gU3BjMwMMn0Fbpq4LQBb9PPcG6xc4sPgOnCLLqNYRRp
         3+KLe4hGxby3BpakC80ATrAMZrER1juRp3IPouRwdu6HCqntA9EJb/8ery1YiNVirI4L
         /2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w+kZv9kbYsmHr/JGy5iDhtegSxFGC5KTV0tLyw8dvw8=;
        b=nFzqoYQJlTiPlmd+2do3uIL+NivzejJy3ovSNuQIya0TdeTMeF+fCS6TYxjxFSJoRT
         liwGpUCg33N3OJjniTad3TBrZxuwyww1ZVfsohWkUFfPxzzCeAbJSazIazGEtQQhfKGG
         htaoOYUJa8R+Tip/PJTiJvQ1O4TYT5kA/nd7U9oqQcSyHKn6nNUb2WEBnFEvNq++LXUs
         oeK/K/D71u3YkUWr2Du3aWqbRNy4DCDMmEu1j1pvWGdxnb7qrkfZvM6beG8Vkxp13ser
         jFFS1l/BW3cUk4/3+QkE+YC1H17KHYL5oQBqs9DWlmcE4DtNdHUBgPqo6M6gyjFa6YDk
         +3ZQ==
X-Gm-Message-State: AOAM530rU7+xu0aXZ3N27s8vkGdlVD0/ACfV8boV12W3pDTCx4aEdJ6N
        aTIPXBaSi6rrqzP5f3hjUxwemA==
X-Google-Smtp-Source: ABdhPJz/+lJZkI7anapuMcRBn/lk43KTNF/diGn2gD6fqYtQDwiTQc1zvndtf8bPqr6YQRCy/2y+KQ==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr878238wmf.58.1610569549645;
        Wed, 13 Jan 2021 12:25:49 -0800 (PST)
Received: from dell ([91.110.221.193])
        by smtp.gmail.com with ESMTPSA id v20sm4490293wml.34.2021.01.13.12.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 12:25:48 -0800 (PST)
Date:   Wed, 13 Jan 2021 20:25:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Jakub Jelinek <jakub@redhat.com>, linux-fbdev@vger.kernel.org,
        Anthony Tong <atong@uiuc.edu>, Alex Kern <alex.kern@gmx.de>,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Software Engineering <lg@denx.de>,
        Paul Mundt <lethal@chaoticdreams.org>,
        Frodo Looijaard <frodol@dds.nl>,
        "Thomas J. Moore" <dark@mama.indstate.edu>,
        "Mark D. Studebaker" <mdsxyz123@yahoo.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Evgeny Novikov <novikov@ispras.ru>,
        Helge Deller <deller@gmx.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Ani Joshi <ajoshi@unixbox.com>, daniel.mantione@freepascal.org,
        James Simmons <jsimmons@users.sf.net>,
        Emmanuel Marty <core@ggi-project.org>,
        carter@compsci.bristol.ac.uk, Alan Cox <alan@redhat.com>,
        Oliver Kropp <dok@directfb.org>,
        Jeff Garzik <jgarzik@pobox.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Eddie C. Dost" <ecd@skynet.be>,
        Ani Joshi <ajoshi@shell.unixbox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        John Fremlin <vii@users.sourceforge.net>,
        Ilario Nardinocchi <nardinoc@cs.unibo.it>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Jakub Jelinek <jj@ultra.linux.cz>, Urs Ganse <ursg@uni.de>,
        William Rucklidge <wjr@cs.cornell.edu>,
        Antonino Daplas <adaplas@pol.net>,
        Brad Douglas <brad@neruo.com>,
        Ralph Metzler <rjkm@thp.uni-koeln.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jim Hague <jim.hague@acm.org>,
        Egbert Eich <Egbert.Eich@physik.tu-darmstadt.de>,
        Jes Sorensen <jds@kom.auc.dk>,
        Gerd Knorr <kraxel@goldbach.in-berlin.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-kernel@vger.kernel.org, Martin Mares <mj@ucw.cz>,
        Philip Edelbrock <phil@netroedge.com>,
        Ben Dooks <ben@simtec.co.uk>, Hannu Mallat <hmallat@cc.hut.fi>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Ghozlane Toumi <gtoumi@laposte.net>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 00/31] Rid W=1 warnings from Video
Message-ID: <20210113202546.GG3975472@dell>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
 <20210113190118.GA180942@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210113190118.GA180942@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021, Sam Ravnborg wrote:

> Hi Lee,
> 
> On Wed, Jan 13, 2021 at 02:49:38PM +0000, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > This patch-set clears all of the W=1 warnings currently residing
> > in drivers/video.
> 
> I am sorry to say that I expect most of your nice patches to clash
> with patches that is already present in drm-misc-next.
> 
> drivers/video/ are warning free with W=1 in drm-misc-next today.
> 
> I do not know why drm-misc-next is not yet pullled into linux-next.

Well that kinda sucks.  What are the chances of that?

Most of my patches fix issues that have been there for years!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
