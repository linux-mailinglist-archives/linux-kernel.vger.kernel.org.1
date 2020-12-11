Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC542D782F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406397AbgLKOrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406205AbgLKOqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:46:52 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5EBC0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:45:56 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w5so5555251wrm.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+GGr76mXiTZ/QdlXY/YlotYgldQW3f2YpHTXa0H3v2Q=;
        b=Px+k+o9e/02NpP4knUhSv6h5yAfbn4/4bRz3QK1d84j4yuqQ7zvb9MirX9ORZVNS7n
         7fUg2vQIdo3EMSivLaZ09DE16E3Aei8lKsgYuMf+Cp6KkttKMcFW9d6rME9yOO8tbjCc
         DIychwzuCFABBGKO3h9SEOMi5pzTdDW1FOLsNDqTIM/MpIbJRLbsyeqMdZezFjEzEyqS
         WunBBe4v28BYYz0yVv4Q0/rxvhfcGrCzqtNnWbA2h/oB23Hd3zaPtp5svkmAwG3aFGF9
         nebO0ALALjuWiyrlms7WrNKd0yB0Yc8lGSmzFZYTmbsvOnEDFXuc42ag5CZkA6dHn8rN
         iI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+GGr76mXiTZ/QdlXY/YlotYgldQW3f2YpHTXa0H3v2Q=;
        b=Vy9mssoVluZutuYsmx+5I2+Xe+loFp+NGixwSnoTNT/NVtABu9SsuCXnsWceW7v/Na
         vjT/3w9qsMlvQTsMG/m5qw5HPUfXmyLm7xBi4VAbBgw1zXH/ZNvygEWjomLeI/fbWtUO
         ivyABSz5NTelXY2K9Pc84+yt56leDWWo932/XrTwoonXOltj7QutheNiz70MfZTurF8H
         F//RFFHWzo89Bj+lyq/uKtuMgGMgByNMOtSaC94v762kJaYNq+ribqdGCBhvJGRqQzTX
         a2lSVBw6w9aaeJthOHaL7upkRFih8WKuobxhfW7eeZIAED90634H/PBhBEHO0n1xXYZ0
         vb+g==
X-Gm-Message-State: AOAM531P2FqIUHrxj847sAQkFWQyo+T+OM6fUu+mwYHXn5NlLaOBPbJy
        OJQTDFxb+eOigGFjx6rU67eLTQ==
X-Google-Smtp-Source: ABdhPJzmUIoojBskohRb1a/KLsk+qrsTFltTB0dTrZrdFkZC7BF8K14BTbt9f0O7aj7+bLzMQhZvEw==
X-Received: by 2002:a5d:6ccb:: with SMTP id c11mr14413709wrc.224.1607697955466;
        Fri, 11 Dec 2020 06:45:55 -0800 (PST)
Received: from dell ([91.110.221.240])
        by smtp.gmail.com with ESMTPSA id i18sm12109720wrp.74.2020.12.11.06.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 06:45:54 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:45:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bikeshed: [PATCH -next] mfd: rave-sp: convert comma to semicolon
Message-ID: <20201211144553.GF5029@dell>
References: <7416de308a9b41d3ac881210ab114159@AcuMS.aculab.com>
 <20201211131049.GE5029@dell>
 <10351cc41c244d9a8cfa6a8fb8f502c3@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10351cc41c244d9a8cfa6a8fb8f502c3@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020, David Laight wrote:

> From: Lee Jones
> > Sent: 11 December 2020 13:11
> ...
> > > Nowt wrong with commas.
> > 
> > Well you learn something new every day!
> > 
> > > Why not go the other way.
> > > Convert almost all the ; to , and delete most of the { } in
> > > if and for statements (etc).
> > 
> > Sorry, I don't understand.  Please elaborate/provide an example.
> 
> You can (largely) replace:
> 	if (...) {
> 		xxx;
> 		yyy;
> 	}
> 	zzz;
> With
> 	if (...)
> 		xxx,
> 		yyy;
> 	zzz;
> 
> Saves a vertical line....
> You may need to replace some 'if' by ?: to avoid the terminating ;

No, please don't do any of that.

The current patch is fine.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
