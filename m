Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A33A22A196
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 23:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgGVVwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 17:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgGVVwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:52:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349F6C0619E1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:52:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s189so1991672pgc.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UhpBIu+fLyut9dkZQ1QoXg5xvF8Rpu4aR+akPmAgts0=;
        b=RLTODLA/Lv2X1LiEJMRsgc8cNZLE9C5T132aE7qQLBOXWc8QuVmBhxMkDZyIs4ILA1
         Rc/qAJhNpeW5X/DMkTMJ8N4C40LEwItk2SehAFqOQJ/H+BLOwqxlh/P0cZ66Z3J40TG3
         T04R6lhah09KRP3L9AA+zZ6zzlrvfFamkFCWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UhpBIu+fLyut9dkZQ1QoXg5xvF8Rpu4aR+akPmAgts0=;
        b=I4UcVRtEdxp2ONrWmj2XCta1d8VTLa2USgPw8tud6rn2oeWWIQcmP2Gb21UVLDx8cP
         OXb21yu8YmiNlLnTv83dYtqo0C1ST3USvHEAw+WK/i9tn05alCUSoK96D5SbgBSVzWnJ
         3rHUSa1HMsF7w07klH5RQdPGwVwzVaBrMNJpf1lmoAaSQUJ34wNGnQ1571FIdGTSPXr5
         C1/hdLVfvmDJKGkrhhw/caxQwNjyrGCav60ltM0bfYlIqkwzNh7XJe+M8vQ+EYs497ka
         8vDn22/IIci99kj4a+pRKKbXww3ddO82mDfDyV0FzqZmaPsd7t2DfCin+yyCFhEAZPSd
         zLuQ==
X-Gm-Message-State: AOAM533PI5NjaEFHUm0ZIfGteOmlmPORmorAooO0UM1jz0rVKF8lPsqu
        VnotHOwMmYy23eqoaTv1guK/Ng==
X-Google-Smtp-Source: ABdhPJwxx7XnDDEsAXreWtClyszsrsNFCBByut9XE2cHvwjdxXzfOxKQE/tmd47A0ziamdP54HnVxQ==
X-Received: by 2002:a62:8096:: with SMTP id j144mr1533250pfd.78.1595454744632;
        Wed, 22 Jul 2020 14:52:24 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id m17sm570134pfo.182.2020.07.22.14.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 14:52:23 -0700 (PDT)
Date:   Wed, 22 Jul 2020 14:52:20 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Aseda Aboagye <aaboagye@chromium.org>
Subject: Re: [PATCH v2 4/4] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
Message-ID: <20200722215220.GA2137556@google.com>
References: <20200720202243.180230-1-linux@roeck-us.net>
 <20200720202243.180230-5-linux@roeck-us.net>
 <401aec54-ff21-7e0f-85dc-e32435df2672@collabora.com>
 <20200721142320.GA20067@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721142320.GA20067@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ drinkcat, aseda

On Tue, Jul 21, 2020 at 07:23:20AM -0700, Guenter Roeck wrote:
> On Tue, Jul 21, 2020 at 01:29:01PM +0200, Enric Balletbo i Serra wrote:
> > On 20/7/20 22:22, Guenter Roeck wrote:
> > > +	[EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
> 
> Any idea for EC_RES_INVALID_HEADER_VERSION ? I am not entirely happy
> with -EBADMSG: the error is distinctly different to CRC errors.
> EPROTONOSUPPORT as well, maybe, or something else ?

FWIW, these (INVALID_HEADER_VERSION, INVALID_HEADER_CRC,
INVALID_DATA_CRC) aren't actually used on any firmware yet. This has
been open forever:
https://crbug.com/787159
Added here:
https://chromium-review.googlesource.com/c/chromiumos/platform/ec/+/780452/

Unfortunately, the linked design doc (still in draft) is not public.

My understanding is that while they're not all exactly the same (CRC is
different than the others), they are all still supposed to represent
"corrupt request [from the Application Processor]". EBADMSG seems good
enough to me.

Brian

P.S. for those added late -- you can grab the whole thread from here:
https://lore.kernel.org/lkml/20200720202243.180230-1-linux@roeck-us.net/
or in mbox form:
https://lore.kernel.org/lkml/20200720202243.180230-1-linux@roeck-us.net/t.mbox.gz
