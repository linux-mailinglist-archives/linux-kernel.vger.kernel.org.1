Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B74A25F9A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 13:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgIGLh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 07:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgIGLhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:37:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69744C061573;
        Mon,  7 Sep 2020 04:37:18 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i22so17798543eja.5;
        Mon, 07 Sep 2020 04:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwCUFaPhMN/skHLwgR+yYwv+8o4l72dNE5sxGCsCq7s=;
        b=lqUWNcbk5A+DnpTd7eQ++115FIy+qVDbyUIvQEYpY7qzS2PVj87gZlypM2XS+R7vL9
         C44GaeEwCeF3tK56uwIjb+mP4Bi7UAL2n2G+RqwsNG1ATfFJsHzEUWcTXn9Ntzty9MHa
         pgU9I1Zmzk9+0wAhwIT3d//o57eZl+RvZqkSStEvG5KivKohNuPArWDT3PFYNNmb1RRm
         3Mwfg8OMbsnbRzHlvhFUUuHyothXablhQNIocKEOIuhiCfb+5f9zd1lIhrBdQFgexupM
         Tt/jvk+Y07QDpvFqacfKWzTyE3p2txOB8nYOg9653dlv5EnzngK4bGs5zQ/0AuVDnD+H
         mW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwCUFaPhMN/skHLwgR+yYwv+8o4l72dNE5sxGCsCq7s=;
        b=VMeM6kD8apuAy9iCq57TAXG1MzaXVxO2n0j89q7spXhbC3G6wSXkIjlN4UJ8OzAGvO
         AdKoEn/d7UzOaljzngUuKF+Tyx/xaJGch6kjaFlCWpRzj25ypqgpawrGYx+fkGxNT28f
         x2FEEn1HsPyOaf3LIVxxZ8tuYSzGY7dt/6VR3UVS/0siyqdvSefK1k0BQUx4iWX8y6vB
         ELAA3B7qvmd+YVr+ALFSLcXGbLXLaY3S+h5+OFQGvLCBo12j1oylxJPdeJvuRTaR2cRe
         IGbNkdbPZ6J0Od7iQfr5f79wxm8u+BFfD5zSO+njLYkDfT77z87ZTldk2kdasRLt75TB
         v4dw==
X-Gm-Message-State: AOAM533/1BtADM+k22q/b3J+Tu9wWWMyKinTTj4Lykr3x/Ty/A7JUOi6
        n4p8axH0xtJrfRr9LsHHTr8=
X-Google-Smtp-Source: ABdhPJw7ZOCKMaPMH+ca8SVCvK0MM+oeH4Wgaotd51gkrg6Rox5A09NFa/TERucMA/PyTeWTVECdLQ==
X-Received: by 2002:a17:907:20e5:: with SMTP id rh5mr20474480ejb.267.1599478637051;
        Mon, 07 Sep 2020 04:37:17 -0700 (PDT)
Received: from ubuntu-laptop ([2a01:598:b902:e05f:7139:914b:4eed:99b3])
        by smtp.googlemail.com with ESMTPSA id 1sm15180447ejn.50.2020.09.07.04.37.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Sep 2020 04:37:16 -0700 (PDT)
Message-ID: <e35560d7ecf257a87dce544fe3a4d58e2998465b.camel@gmail.com>
Subject: Re: [PATCH 0/2] use generic_file_buffered_read()
From:   Bean Huo <huobean@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Date:   Mon, 07 Sep 2020 13:37:11 +0200
In-Reply-To: <e857400e-f6e8-9d84-804e-88f3c34edb50@kernel.dk>
References: <20200904091341.28756-1-huobean@gmail.com>
         <e857400e-f6e8-9d84-804e-88f3c34edb50@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-04 at 10:53 -0600, Jens Axboe wrote:
> > Bean Huo (2):
> >    block: use generic_file_buffered_read()
> >    fs: isofs: use generic_file_buffered_read()
> 
> The change is fine, but the title/commit message should reflect that
> this is just a comment change. The way it currently reads, it sounds
> like a functional change where something is switched over to using
> generic_file_buffered_read().
> 

Hi Jens
Indeed, it's easy to mistake this for a functional change, but it's
actually a comment change. I have corrected them in the new patch, you
can check now.

thanks,
Bean

