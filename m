Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF155280684
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbgJAS1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgJAS1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:27:21 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72113C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 11:27:21 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c13so6625561oiy.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zromK0/y1g94z1qMbmCPDoqoKsF72rgD/Yb3hoPUPLE=;
        b=pLBTVtvJ9NKHNXLlKWMCwrI1NKqibC67z+5cNeyc2WXfC7fy/QkHxOFhguWXhpkjjm
         kvFuUKjdbaHfctbf0UifWDngSs4qrbslBkkmgpOGr0FfupKXFkBf0PCyjzQhD7S5R50m
         mkMv+zD8KygJZmW33d0TB3W2CDZ538/00wp8K/fnc+bLkm/atasPqnnytIWJgjoVe2pn
         m34dE+Ejk4EcyS31EKVlVKAf/+3+p271nX9o+T9vaCkTwMLKi3lVfTx9i8MdD4+feDG0
         YA2A2w5ry4sZigiY1eNKH3KAq/k9pz2DPfFt2tje5PvHWl24z7DGIO5LB8G/yhy2fSn5
         PF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zromK0/y1g94z1qMbmCPDoqoKsF72rgD/Yb3hoPUPLE=;
        b=sZ2TVS8gBTSBSgzf9KZJqQbK3qReQyGZvT308EwLkqJAHL927eceLyX5mxu0sImckz
         Zi/wMlf5acqS6YH9VgVO9YNvz0OqrIwIVOBYMRS033uaLQfMvQZM/4hmiQU8miyh3R9g
         Z60P3o4jgpvL1ZjACxgIy0oLALnM8zdF7MuutYTAgGRuyFm3FqKTNAdI01QbAX2KOg1k
         6cPnhjgalbWhpCiFmsuM4/dBelKS7mGyMCfDrgz+v3Ev+5gbuAvCaedCyMfpRSS9ucIg
         aGqT3VesibPBLi7tJkBwpY2+2aDcp7KlqFCfXTrFdkCWndhvufQq+l80y7TxAuFZlmBQ
         nP6w==
X-Gm-Message-State: AOAM533TJTbhP32i17XU5ooUmEo69uZ2RNFULI1q39RSiPghqjbIjm51
        9Ge0w4jHFZLJjatCWwVTj9t5sf6fe0KKILarjT2znQ==
X-Google-Smtp-Source: ABdhPJzCcYsTc+Gbn+vcX/SUcoHjDOjZU40L0YDPwvNusAh6NPCap8hFfSdxCse55eKzTcbn+lL3yvgaDWcCEeOq2y4=
X-Received: by 2002:aca:d982:: with SMTP id q124mr824698oig.103.1601576840640;
 Thu, 01 Oct 2020 11:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200930071342.98691-1-tali.perry1@gmail.com> <20200930093117.GY3956970@smile.fi.intel.com>
 <CAHb3i=sWxiVLCC0hfY+6-_x92ZEMY7Ctyyuz9CbMYxrH_BqAZQ@mail.gmail.com>
 <CAHp75Vc3Bw-dTpEmpeUpB4n5-8-xGPx+jm_HkB5Pj6Qr8U=CAw@mail.gmail.com>
 <CAKKbWA4gHobXFGi5CiPnawWoMOi0GFrCbzanuOFZ+Aky6=9Mpg@mail.gmail.com> <20201001174046.GK3956970@smile.fi.intel.com>
In-Reply-To: <20201001174046.GK3956970@smile.fi.intel.com>
From:   Alex Qiu <xqiu@google.com>
Date:   Thu, 1 Oct 2020 11:27:09 -0700
Message-ID: <CAA_a9xL+qP3zOy=oKHjCuR+CvsXeoU5EX9WgEhUH0Fza2Vs5DA@mail.gmail.com>
Subject: Re: [PATCH v1] i2c: npcm7xx: Support changing bus speed using debugfs.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Wolfram Sang <wsa@kernel.org>, Kun Yi <kunyi@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 10:41 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Oct 01, 2020 at 08:13:49PM +0300, Avi Fishman wrote:
> > Hi Andy,
> >
> > Customers using BMC with complex i2c topology asked us to support
> > changing bus frequency at run time, for example same device will
> > communicate with one slave at 100Kbp/s and another with 400kbp/s and
> > maybe also with smae device at different speed (for example an i2c
> > mux).
> > This is not only for debug.
>
> The above design is fragile to start with. If you have connected peripheral
> devices with different speed limitations and you try to access faster one the
> slower ones may block and break the bus which will need recovery.
>

Hi Andy,

To clarify, we are using a single read-only image to support multiple
configurations, so the supported bus rate of the devices are not known
at compile time, but at runtime. We start with 100 kHz, and go 400 kHz
if applicable. FYI, we are using 5.1 kernel, however I don't know much
about DT overlay.

Thx.

-Alex Qiu
