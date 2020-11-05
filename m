Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513942A7CFA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgKEL2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgKEL1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:27:32 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BD4C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:27:32 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id y12so1326804wrp.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K8M24HEmYE3mh2gcehHb/FROC3S8llrpdvcfhYqwL3w=;
        b=NuI7lolr7ufwN5ejtd86Sy2H3xCLsg4gtzA7X3Qsq4NK54Q/zamFKLibZd9BaAH51e
         peHyLoWdbWUuCvgAKM3Qu2AyV2d5IFo8/rPBe1RGOTfB01Ee9UjNai0jPKoGfZN+Xkkz
         ZZQQP2xy+uXFEfflZIJCxFlEeOzXacYT0fK/jijKIS6u9JAPhcltrx6rRpKK7Zl8q9wv
         SH5GWOfeFhnb54RoZScqbm1tviLts+H7iCj9JKXnPreL1aCi7VwZ6M7UuDyKzA1040U5
         FmtWQykci+EvtC0FWKYI6P6qdAJdnBrBmF4CvpileXX2OBB6hRi5RCNHgST2lkwUXHYi
         q8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K8M24HEmYE3mh2gcehHb/FROC3S8llrpdvcfhYqwL3w=;
        b=Ef9ymvUruYHtHw85YstR4BV/WRNJU9va7sQGepSnOZeMsNFOvEH+zw96HtMD/EWo8e
         sbKgZ9W8/whldCHPSkKKhveKPuizwYsXIoaPcAyzgQ5Lnk1vGkDpWbCt6PKbsAcYhx9y
         eEFr0HpkmwEbo0k3B5T2pwJxu98CLph3VLSZM2+LXAFi2Tp361q9TfxG2g4GXugXJBM7
         AuA20S57pG2TnQD8jVaesGr+Ql94KduO58dwLFR1eKLL2OCRAi8qXxRbqatwzED0otgV
         mnJdOzw4rgdyWRTgAMsYENjkAIA+2cNWs5f+OHcQ3vBIhhNZcP9pyNC58pRpW92MxHrS
         tJ+A==
X-Gm-Message-State: AOAM5330YLqHZ5FPpxlbD6f0TBZeZtoQsAfEPszVdDtERqBRGjkXNoGc
        jkv1q2o0V86bAc1bXZng1st5FQ==
X-Google-Smtp-Source: ABdhPJwVYipdj5ZocX3OcIGiLvlGAjjpLm5M1ooohBZkb+yMFBs45sqDFtSLUFcivMM+gjsVmZGmHw==
X-Received: by 2002:adf:ab50:: with SMTP id r16mr2256860wrc.235.1604575650826;
        Thu, 05 Nov 2020 03:27:30 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id i13sm2290978wrs.9.2020.11.05.03.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 03:27:30 -0800 (PST)
Date:   Thu, 5 Nov 2020 11:27:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Jiri Slaby' <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "paulkf@microgate.com" <paulkf@microgate.com>
Subject: Re: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as
 __always_unused
Message-ID: <20201105112728.GJ4488@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-28-lee.jones@linaro.org>
 <0a4043ee-dad5-7691-8c67-db73d3c12f52@kernel.org>
 <20201105084341.GZ4488@dell>
 <a95f8d0d-28ef-7351-cdbb-7da5ad8aa9ad@kernel.org>
 <6515b9ff5a9343f5a713e337f41450cc@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6515b9ff5a9343f5a713e337f41450cc@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, David Laight wrote:

> > >> And the loop can be turned into ndelay:
> > >>
> > >>          /*
> > >>           * Force at least 170ns delay before clearing
> > >>           * reset bit. Each read from LCR takes at least
> > >>           * 30ns so 10 times for 300ns to be safe.
> > >>           */
> > >>          for(i=0;i<10;i++)
> > >>                  readval = *MiscCtrl;
> > >
> > > Again, since I can't test this, I do not want this patch to contain
> > > any functional changes.  AFAIC, the 10 register reads must still
> > > happen after this patch is applied.
> 
> You can't use ndelay(); the writes can get posted so can appear
> much closer together by the time they get to the actual hardware.
> Multiple volatile reads don't need a target variable.
> (Shouldn't they also real readl()?)
> 
> Deleting the driver works...

Will post the removal patches when my tests finish.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
