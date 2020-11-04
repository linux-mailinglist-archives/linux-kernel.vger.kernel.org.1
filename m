Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1332A666B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgKDObw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbgKDObo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:31:44 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D1EC061A4C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 06:31:43 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id e6so5021289wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 06:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JzET7Jlv2jmxts2RjmfLSE+ugQqnI/OJZGsydNl/hiQ=;
        b=XVduVZ4WIbPCg68dNfG7zMB9KvvYx2zIKcmFVH2smYgXUc9lpTHnxYr7gYN1sg4ctR
         SQ5JVmnsvQTgYGJ/gK/3UlEpQ8qv3xSWDirRNoxToUkD/J5X0Juy1XcCbscFNz6cCi8M
         Fxtj5zYA5b7eVvq2r1/K1Ul0y4FVLz8tWszrlH4gPwG+goPm5zMheXSrZok73VWCTODp
         mb+fi8FfCdilZTsQgT0EQ9DxJBZBPzn8+lRI0/+ZPhNqSu138HpXjbG8EzTjf2renSTn
         idFDXeh3wflQRS1C6h1e4FcfLb9os9kJ7i5A1/kh6+n/nBVIShalEbRDtzkaKvQ6k1Wc
         Oakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JzET7Jlv2jmxts2RjmfLSE+ugQqnI/OJZGsydNl/hiQ=;
        b=nQWsvxg11Gltyao05RHjuCyLGxk6Mq6rq/SP2gk9iGKqRxPj9uIvTy4fSL2IpBrvvi
         GKQx0BSgHqysk5rRiBssszhDkKI6o/6x3p8Cj9By3WeTZPHPC1Bvv21PwkZtcfedIEvJ
         QKeCu7VUUyFCer5kLlDguGRusHp9zdrnz+xMb4PfTEJj+Tyb/UiJC3pjCsmT3KRwLrgK
         kd8kxpv/e1OJcRzM8ZI0GdBA+fAxF43NgEBP8H3rAvHQqjeWMtzOcIfQ3BYDLfeNjokO
         dSP7qaHkmAsrrxKDzAIwgXRSLxP3jKHGS6rGyPicPpgvoP2kNBj7w8OA0OoTBt8xLEyT
         znFg==
X-Gm-Message-State: AOAM533kYDnnEpUlgvOum/8+lAMljGIJgRqU21Yq6UVAHEB1OjdXCKFb
        Zuxy/oi9/t4matutXYQPVnxTeA==
X-Google-Smtp-Source: ABdhPJwSesSTNRgKVguedg8+wTQ02tqZOuutPWhVXdm2jZTyaTQhO8YfIvGuGSNwOVQyr76Ixk6G5A==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr30907421wrn.73.1604500302647;
        Wed, 04 Nov 2020 06:31:42 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v14sm2659853wrq.46.2020.11.04.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 06:31:41 -0800 (PST)
Date:   Wed, 4 Nov 2020 14:31:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, kuba@kernel.org,
        Dustin McIntire <dustin@sensoria.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 02/12] net: ethernet: smsc: smc911x: Mark 'status' as
 __maybe_unused
Message-ID: <20201104143140.GE4488@dell>
References: <20201104090610.1446616-1-lee.jones@linaro.org>
 <20201104090610.1446616-3-lee.jones@linaro.org>
 <20201104132200.GW933237@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201104132200.GW933237@lunn.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Nov 2020, Andrew Lunn wrote:

> On Wed, Nov 04, 2020 at 09:06:00AM +0000, Lee Jones wrote:
> > 'status' is used to interact with a hardware register.  It might not
> > be safe to remove it entirely.  Mark it as __maybe_unused instead.
> 
> Hi Lee
> 
> https://www.mail-archive.com/netdev@vger.kernel.org/msg365875.html
> 
> I'm working on driver/net/ethernet and net to make it w=1 clean.  I
> suggest you hang out on the netdev mailing list so you don't waste
> your time reproducing what i am doing.

I believe that ship has sailed.  Net should be clean now.

It was it pretty good shape considering.  Only 2 sets.

Wireless alone was more like 4.  And SCSI, well ... :D

Maybe that was down to some of your previous efforts? 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
