Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297A41B4D43
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 21:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgDVTVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726102AbgDVTVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 15:21:45 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B173AC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:21:43 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id j20so2434503edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxCJuKeYutDLDPXAPSEMJzIV43DxzgPvToiuGHFZFLc=;
        b=o8msrCuYl9yzwxwdinHp/5zJ/iluTXdc1PKyO8gPAZru5AYRPBYpTv4YM7zOXc3nZ2
         FGujQQrnudYueNgJjGfkvcAh+9/zKbk6PPZq6bKDzW6/flpD97bfMTX1npa9m0v9spXg
         chVFpy1nyofJYumkysSQudI+cOAaRtj7pqe6tohr6PYBQvlIvsVKL0tQD9PjhghVSJiH
         zN9nuJGnSUuENXK2lVmroUT265WhUirrk/aBSjMAScCtF3fleu1UAPyUaP4gx31qOlCk
         QNC6+SqqfYISxB040FO1lDWibFTqu2SxfQZQxx/Mqavaf1xszxYhNDBN3QoHxy7651nB
         FG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxCJuKeYutDLDPXAPSEMJzIV43DxzgPvToiuGHFZFLc=;
        b=NubUsWqvQYddhdaGMENASJQXyUqN1T04i4xiyAuSEeTxCwOzUTSBiBkCdFygZ3eq6u
         c7QZ2B6/1o9aLNTPAAAXaRANI+YqomM7oCnBVBEp+vpQFHnq2wqzbHYb+IbpQU3lrC3v
         lteDcBsuRp0+c5b7XXjvYvGNRlPY5mp6VrC0ekTz4ZWUCjQS34qt6AzjpK5vFpWBZwXH
         VUoOfpvFCKhlHqIzh04HcuKas3IUOUYgVOBL61fqDJCn+eVJElPP6ulqj3gZntiypdUn
         5sivGD6MRPfZ+1AifldQpssXqOJbIb3RieGTmrT5j0hkmkIlC2mIyKzLObOQ+oCNjTcZ
         rWtQ==
X-Gm-Message-State: AGi0PubRWnc+8gnDEXZjHZXBnSo/guswsCLwfaXVc9nqadg9WP+JuhFW
        ea/GTB/AV8dHf9RRu3UN9j1xhjvmRpdAJikRmslK
X-Google-Smtp-Source: APiQypIvh77fUhTJY8QW3thwdXTgaIIw2VU2oQABHxAtS41WIPnpdUCvR4mja7yxyHkw8pkxV5zKKFWsvAua+tkBpBM=
X-Received: by 2002:a50:d98b:: with SMTP id w11mr129015edj.196.1587583302343;
 Wed, 22 Apr 2020 12:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200422190753.2077110-1-carnil@debian.org> <20200422191301.GA2361@lorien.valinor.li>
In-Reply-To: <20200422191301.GA2361@lorien.valinor.li>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Apr 2020 15:21:31 -0400
Message-ID: <CAHC9VhSxMA3cjdjUt+wYFLnct835KedTL9JSRCgQsecqGs+wDQ@mail.gmail.com>
Subject: Re: [PATCH] netlabel: Kconfig: Update reference for NetLabel Tools project
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 3:13 PM Salvatore Bonaccorso <carnil@debian.org> wrote:
> On Wed, Apr 22, 2020 at 09:07:53PM +0200, Salvatore Bonaccorso wrote:
> > The NetLabel Tools project has moved from http://netlabel.sf.net to a
> > GitHub. Update to directly refer to the new home for the tools.
>
> Oh, well s/GitHub/GitHub project/.
>
> >
> > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> > ---
> >  net/netlabel/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Salvatore.

Acked-by: Paul Moore <paul@paul-moore.com>

> > diff --git a/net/netlabel/Kconfig b/net/netlabel/Kconfig
> > index 64280a1d3906..07b03c306f28 100644
> > --- a/net/netlabel/Kconfig
> > +++ b/net/netlabel/Kconfig
> > @@ -14,6 +14,6 @@ config NETLABEL
> >         Documentation/netlabel as well as the NetLabel SourceForge project
> >         for configuration tools and additional documentation.
> >
> > -        * http://netlabel.sf.net
> > +        * https://github.com/netlabel/netlabel_tools
> >
> >         If you are unsure, say N.
> > --
> > 2.26.2

-- 
paul moore
www.paul-moore.com
