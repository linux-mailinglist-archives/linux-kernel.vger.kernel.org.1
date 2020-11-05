Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D9A2A80FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbgKEOdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKEOdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:33:41 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ABAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:33:39 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k18so1820720wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dJrVaW1T2oqpkxUTn13D+eeWU5ppupk4o6g18zEvuLo=;
        b=Ksj0dq0UzyN7Jj74oPgk6k0dAC9gBuHoTgbone2hjziNphMDu+OswYTfHnSMYtjuF7
         OfY5XdYUnCKbvT6sljLGEPxooFYtdSf3gQuaiZZQQmA2JpU1929ZDqU0lXufWjaCrbW6
         ToXn+W+k6d12cnFkpxj9ebkw6+5sDS0AhMV+mbP6ewPzSKyLAs93W252QSrd1S/7+goD
         LRh1zK4Wu4AvEWeSI0ce2VV4DWygS4eCERsj7vEzvxatY3Q6jgPfXmuc1HqxygHw8g5T
         r7mknGG1sbCUHla2ZAgxaJlznNQgwHwYHHj7ZAYw5t71eVh/FgTaBDyUWLH9Zz8+mc0w
         sdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dJrVaW1T2oqpkxUTn13D+eeWU5ppupk4o6g18zEvuLo=;
        b=jVem1fUznNFiJTWIRqznlAfUHP8g9d1oc0HmM+jAxEQWJ+8PU17oiTKy0nA9JHLqsj
         iosJ5oSmq01nNgNdlZFIshvx9ldQKKf86wbTu+YUuk8NoC5Y+DmrGYWVnRAFtl5I8Cvi
         Z9FqC8xA688x0llsad//D+n7d0HY/ORmZrnTrq5FOByABqqoJrmH7ll5q/ZtqPUOtr9b
         qcB31QOFJj6UBPvuEHaOSR59gjqDJh6WqKnAKnXNM25/lqjwbCPTjA/h79asXVPU7zM7
         UNmsO1y4Iqog/XpsOP8OrW5xTXoD9JX9GnH/2dXcdRYv6E3Q5gb1oB4XnH6h5cBGtSz4
         desQ==
X-Gm-Message-State: AOAM531Z8VRMvq9Ed/Gz+XDSrk+VWmxz7dyFK+/DOpT22bIOt0eLsWDA
        VxK8dXJ7arg7JcMN/wRlgwi3xg==
X-Google-Smtp-Source: ABdhPJxiE8pTNw+xY3JenO1QKY/gJddrZr/lbM8WZ97wn9cRXPS2YZPmnfGMo03i1HPm/gBGymd4XA==
X-Received: by 2002:a1c:b346:: with SMTP id c67mr3025956wmf.105.1604586817976;
        Thu, 05 Nov 2020 06:33:37 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id y185sm2997644wmb.29.2020.11.05.06.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:33:37 -0800 (PST)
Date:   Thu, 5 Nov 2020 14:33:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] tty: Remove obsolete drivers
Message-ID: <20201105143335.GL4488@dell>
References: <20201105123357.708813-1-lee.jones@linaro.org>
 <aa82ff49-8090-dcb8-7e96-6a92b189d302@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa82ff49-8090-dcb8-7e96-6a92b189d302@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Christophe Leroy wrote:

> Hi,
> 
> Le 05/11/2020 à 13:33, Lee Jones a écrit :
> > As per the vendor's request.
> 
> Is the vendor in copy of the patch ?

Not directly.  Only interested parties as indicated by
`get_maintainer.pl` were included.  My assumption is that he'd
pick this set up in the same manner he picked up the last one
(filters?).

> What about the other synclink adapters, namely the synclink_gt ? And the
> synclink_cs in the drivers/char/pcmcia/ ?

Ref *_cs:

  If it wasn't directly mentioned, I've left it in place.

Ref *_gt:

 "synclink_gt.c is still in production and the driver still actively
  used."

> > Lee Jones (2):
> >    tty: Remove redundant synclink driver
> >    tty: Remove redundant synclinkmp driver
> > 
> >   arch/powerpc/configs/ppc6xx_defconfig |    2 -
> >   drivers/tty/Kconfig                   |   27 -
> >   drivers/tty/Makefile                  |    2 -
> >   drivers/tty/synclink.c                | 7899 -------------------------
> >   drivers/tty/synclinkmp.c              | 5580 -----------------
> >   5 files changed, 13510 deletions(-)
> >   delete mode 100644 drivers/tty/synclink.c
> >   delete mode 100644 drivers/tty/synclinkmp.c
> > 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Paul Mackerras <paulus@samba.org>
> > 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
