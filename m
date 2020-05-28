Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC971E6EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 00:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437118AbgE1W2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 18:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437150AbgE1W2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:28:10 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6388C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:28:10 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id f18so439851otq.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vBqcZa0IKiH93Vv3eDpAabhizVXuv+QF0uHI7s8tiJs=;
        b=RyVVuHGgbeohMtZWowGb6nsOSoRGBGTZxqHmZy4WpLugiwVI3yN+H3Qt4B+GXSbNZj
         HwKeJx017EXyLdVb2a4+dAmq9DORkmQycKqA58f8/4ge6OTgCOIaDwhOUXKgAISpwrEj
         cuu3TWBinZ+MY1QEtbLroH64Q7ji1E5lT8gmzmGvXP9fddMT8WMFa36bM2IG3koytxom
         XLtaN5yGU4lyFvfAaKkYxbvx4JMcS6UXniJAHY+frBuCYQBGeYK2EViAbMrl4u5hOr74
         AmFqJD88qhtY7pGDSSzLPEoVhnW0UMDRNRPiz1G8AfofbLiqO/aQA1iHlLMuz64tQK+i
         NiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vBqcZa0IKiH93Vv3eDpAabhizVXuv+QF0uHI7s8tiJs=;
        b=kCVZfC6T5X//pHHT1f/+bvo+kGmL4h6/om3zZ6dN3OK+DuHMdA/R/UNEMpQznC5Wh9
         vOdG21TdJfZbdnJ6AYVRr3617vwY1NBd1+oorEy0e9JabSNQos34CMbuxASIEyPOYbAJ
         YEHNUnM/kUbP+Lb9Hn3d4jpjgfwHWDQH3muZwHV41tpw5pjc6mfv5wdtF8EJ2xvY22U1
         MMEd66TnkPBpNJiMCMW/8CwSJlAyiXB/yoU7tvCFYCb8NZQdJjrRku/mdXZThbFboOSx
         /QdSXYAwhgr533xu8ZayRB1kDTfARGPhgrQYL2L5qeiIxv45UGPMx58RPr5CZl/+N9xF
         A+Lg==
X-Gm-Message-State: AOAM532nyeSbuLJDNbxIlhsYITzeddZ1Eldee/wQnRQPHu22CwVO1bAW
        L4AG4ljzTiGrA/adAWyq7xFkZg==
X-Google-Smtp-Source: ABdhPJw+RI+UIuFlYcaLreO+yaKaqgPIabuohOSnq0foAahFvztOM4aoi7DNrJPg5nTTV2YDJzjQKw==
X-Received: by 2002:a9d:705c:: with SMTP id x28mr3992974otj.180.1590704889796;
        Thu, 28 May 2020 15:28:09 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id c21sm1975157otr.64.2020.05.28.15.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 15:28:09 -0700 (PDT)
Subject: Re: [GIT PULL] sh: remove sh5 support
To:     Rich Felker <dalias@libc.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org> <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200528221450.GF1079@brightrain.aerifal.cx>
From:   Rob Landley <rob@landley.net>
Message-ID: <89155328-93ea-662f-389e-f4500cfdf79c@landley.net>
Date:   Thu, 28 May 2020 17:28:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528221450.GF1079@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 5:14 PM, Rich Felker wrote:
> Aside from that, the open source & open hardware J-core models are
> still active and in development, with the latest release having been
> made this month, and the J32 with MMU nearly complete and pending
> release, contingent mostly on integration and testing with Linux.

J-core's doing stuff:

https://github.com/j-core

https://www.prnewswire.com/news-releases/spacechain-foundation-invests-in-core-semiconductor-to-produce-open-hardware-platform-for-direct-satellite-to-devices-communication-301061761.html

https://www.reddit.com/r/IAmA/comments/gs7qpn/we_are_jeff_garzik_and_jeff_dionne_and_we_are/

And I note that I worked a year long contract in 2018 porting an existing sh4
Windows CE board to Linux (as a field upgrade to a widely deployed building
control system with a big stock of parts to build replacement units), so
conventional superh isn't exactly dead either.

Rob
