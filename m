Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81BF277835
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgIXSED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgIXSEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:04:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82766C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:04:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e11so182393wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NZUqV6Bvzd8cGlLiOqTGcuZ1Yef+3Qfd3N7B6yq5MdA=;
        b=HB2Z7wdE+cy1f1BINbMce7aOoq/uiu1TMnlcSs9JQDre4pgVVzO6fdURIEYL6hrLNo
         5/wIatPv3/aPCtjtNm033NNIiRbiqrOnzOENMUWs1pt0zSxlB7K2+EQD3a7BhmZb0/jI
         SC0/Yv55lCa605Gfww5F6gCt2rf6u6qGyc5WltCIuGLVIloM+iIFih7Znq7Znz0gVNwg
         9gpmacAJRU7YnapRhXS/qASNua3g9xSm1/LOgoj9CznLwjPNN/duVoIRAWZOWELTwSZU
         qrw8Mk1WbhDZW3G11MFQo2cq4Xpu0Yj5oaANHWvCZAsLR/YsBGeqtTymAHIApAEUtvqL
         1ZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NZUqV6Bvzd8cGlLiOqTGcuZ1Yef+3Qfd3N7B6yq5MdA=;
        b=r4WmkwnH/V3q63C03MKhCGKeKCHCbxg1+VIjiXxh03hSIoqg6RQJKaTp2aRDNnXJ9Y
         ifseSzbfKIUVFvNLB5EmDk7bNQQjhBC233LBI8OSHWCA+RL3m0J8M8TIzBIH2nD+5ONp
         EdSy0FQfBL/MjvfH4LnYLjxit5nr7m/ZYibKYZ/bn3VTaXi2wkIhfbKf15MS5A07OfLr
         nno+pKRuBVTGMwJ+U1Uqj9xcQvqfv46vzmJJfw2xp9eADd+Qtx1xodHE5LCtwEpoVAqp
         xpxBfPxCMQHdbGxXOgcAw8vMzcpxXqolt83VMvm1yWx040durYnpmqQizBvCHk5c1rbI
         Nf8w==
X-Gm-Message-State: AOAM531EQmpljTvrFJGD6GSMpkNfJFCR39WIpJKviWxYu+49i7q8BeRC
        pCuGQXuJinn6uPVt2Xn7wRK4zA==
X-Google-Smtp-Source: ABdhPJxgdbm5WtFN36J7bm9N5ZXswxOvraqE3+QPtP6NridZqs70Eg1VUO0GwuKYSQ84Q+b1z4edDw==
X-Received: by 2002:a1c:a987:: with SMTP id s129mr406580wme.38.1600970641058;
        Thu, 24 Sep 2020 11:04:01 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id n66sm94350wmb.35.2020.09.24.11.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 11:04:00 -0700 (PDT)
Date:   Thu, 24 Sep 2020 20:03:58 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH RFT/RFC 37/49] staging: media: zoran: add fallthrough
 keyword
Message-ID: <20200924180358.GA26916@Red>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
 <1600683624-5863-38-git-send-email-clabbe@baylibre.com>
 <20200921105945.GC4282@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921105945.GC4282@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 01:59:45PM +0300, Dan Carpenter wrote:
> On Mon, Sep 21, 2020 at 10:20:12AM +0000, Corentin Labbe wrote:
> > This patch adds fallthrough keyword where appropriate.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  drivers/staging/media/zoran/zoran_device.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/staging/media/zoran/zoran_device.c b/drivers/staging/media/zoran/zoran_device.c
> > index 9558bafdde7d..7634d94f9359 100644
> > --- a/drivers/staging/media/zoran/zoran_device.c
> > +++ b/drivers/staging/media/zoran/zoran_device.c
> > @@ -268,7 +268,9 @@ static void zr36057_adjust_vfe(struct zoran *zr, enum zoran_codec_mode mode)
> >  		btwrite(reg, ZR36057_VFEHCR);
> >  		break;
> >  	case BUZ_MODE_MOTION_COMPRESS:
> > +		fallthrough;
> >  	case BUZ_MODE_IDLE:
> > +		fallthrough;
> >  	default:
> 
> Hopefully, we don't need fallthrough labels for empty switch statements
> like this?
> 

I have removed this patch and nothing warn about fallthrough missing.
But this is strange, if I have added them, it is because something (checkpatch ?) complained.

Anyway, nothing complains now, it is cleaner without them.

Thanks
