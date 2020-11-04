Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBE22A66DC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgKDO4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbgKDO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:56:05 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29139C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 06:56:04 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b8so22381739wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 06:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=O/B/F4kbVTR+G5SaHVwDeKIS2eZqdbc0hyyi5Ghppq4=;
        b=bcv6gJT8f5Rt1YXxQoWFef3+70kJkUVEWJwVluu2QBBXgmTeEn85dZ3LQX4vJEMHw9
         5QXC8bgT/rIKytuDrk1Hlu/hq7bluXXY2MPegyPT9aOObOWqIMRW9qzbfciKpLSOG34N
         UfXUCIJ98rPPZOmLFeQjIaFSH+co8X/Nr9HF+2KID5aDgVeHoBFYcPg2cN8kauv7QYCJ
         k6LLcJRBwhmaWCuPmLa+1WIQaRV9YuWsMbCkKkTT6u4FN+dQJbvnXKXWp4pO2K1/mDoH
         K7IXGVG5vDe8B6MaxYnS8QrKr/Yhj6M5/KpO2Vn4UeSLcJDPrquslw+G7cCklL6Ngawm
         PM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O/B/F4kbVTR+G5SaHVwDeKIS2eZqdbc0hyyi5Ghppq4=;
        b=BX9GDEhCRufTRT13Ct1qhIL3fr8AGm+a6DwkbKVLQa+UzLkinNpLp6HYfHLTmMBjLQ
         F0VMcLt/aiYRlYnbx7xeQw10MsFxzTzm+tEreQqPYoTqT7f2HCcf6h2garR1mz7opCBv
         qbeSVoDxboP2dtgnITkwngzFxp+S9/IzNlbF4blQ3X8/saUxjnxkEOZVasenFRkWGkZ6
         i2oPClD7Sodwxss3P97toUfNKBRzha7IGhiVuUo+SvyFVgS+ObNVr9JDIMXm4Hj5tqfK
         wRV7wrnh8bd7HEoz7mRRrGaBOfyyGfxqopi6Fajl0L9c9ammhdFXAM0ErXv7PKT8g5/u
         G9xQ==
X-Gm-Message-State: AOAM530NxBUBGFliuCFR1iTIsMI1jc3u8KIRAKUB7mb0/4yvp/saAD1O
        G2C+T+wmqZ7OsFMLIGnu82TuMg==
X-Google-Smtp-Source: ABdhPJybfGNV5XWVSE49VuqFlUPCA5BjJkQBmsjhU//r3CNsRokIseYc+yA/3sMffQS83X/3BXwq/Q==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr33424001wrm.263.1604501762860;
        Wed, 04 Nov 2020 06:56:02 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id 109sm3004976wra.29.2020.11.04.06.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 06:56:02 -0800 (PST)
Date:   Wed, 4 Nov 2020 14:56:00 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dustin McIntire <dustin@sensoria.com>, kuba@kernel.org,
        davem@davemloft.net, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/12] net: ethernet: smsc: smc911x: Mark 'status' as
 __maybe_unused
Message-ID: <20201104145600.GJ4488@dell>
References: <20201104090610.1446616-1-lee.jones@linaro.org>
 <20201104090610.1446616-3-lee.jones@linaro.org>
 <20201104132200.GW933237@lunn.ch>
 <20201104143140.GE4488@dell>
 <20201104144510.GE1213539@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201104144510.GE1213539@lunn.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Nov 2020, Andrew Lunn wrote:

> On Wed, Nov 04, 2020 at 02:31:40PM +0000, Lee Jones wrote:
> > On Wed, 04 Nov 2020, Andrew Lunn wrote:
> > 
> > > On Wed, Nov 04, 2020 at 09:06:00AM +0000, Lee Jones wrote:
> > > > 'status' is used to interact with a hardware register.  It might not
> > > > be safe to remove it entirely.  Mark it as __maybe_unused instead.
> > > 
> > > Hi Lee
> > > 
> > > https://www.mail-archive.com/netdev@vger.kernel.org/msg365875.html
> > > 
> > > I'm working on driver/net/ethernet and net to make it w=1 clean.  I
> > > suggest you hang out on the netdev mailing list so you don't waste
> > > your time reproducing what i am doing.
> > 
> > I believe that ship has sailed.  Net should be clean now.
> 
> drivers/net is getting better, but is not clean. I have some patches
> from Arnd which allow W=1 to be enabled by default for subdirectories,
> and i have to skip a few. Also net, not driver/net has problems, which
> i'm working on. I hope Arnd will post his patches soon, so we can get
> them merged and prevent regressions with W=1.

That's odd.  I wonder why I'm not seeing any more issues?

> > Maybe that was down to some of your previous efforts? 
> 
> And Jakub running a bot which compile tests all new patches with W=1.

That's great!  My aim is for all maintainers to be doing that.

> No, not really. I'm a networking guy, so will look mostly at
> drivers/net and the core net code.

Duly noted.  I'll leave 'net' alone then.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
