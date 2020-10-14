Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BD928EA53
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbgJOBkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389158AbgJOBji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:39:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1094C05113D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 16:12:26 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i2so1190251ljg.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 16:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pAvZc2gfIDjGucI+VwMq6whQr0/X879Oidvupvz4o8Y=;
        b=A8ynlJkvJwu91bo1EWLWkCdSoSsQOYY27iLOzHN9LrJCn/9FttdpwSl7LCaiHFBWPU
         d2qwxL/Z2dBelY1gPIpdNoJbzejfSDUiWJ1po2uf2uumX/elh707ayGNBojGD8rKYC8W
         vfXI/Sd9WF7LGiFge0wniSqlTuIXeGGij18nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAvZc2gfIDjGucI+VwMq6whQr0/X879Oidvupvz4o8Y=;
        b=RfjNJ0nwZFVUYFii32kep92/2IBmZn674ulRvITSDlLLEK4tIEQp35i0TjMyhLORUs
         V9fJxI/ZAau9f687vPNsHn1CqQi6ghieUosAV9oomOosvmuL7bPveF3Zm6Q62dAJGrhS
         p7MqnMjU8XGEdXm6zp9f9dBIXT/JdLCXixhhnnkk4h9pAsuoWomQGaczw/NFutb7pS5e
         HCVWKQq9uSrOmb71i1O0u1utf12P/2uvHEApEh8WeXZOfDLhW9ljYJthqxnVGJkYhAAO
         0fCPI2fCA10YB2pDiPfJX1yrxgItBABvBGu2Uuq8x7XjTkmR2SACwqU2+dh4RjZWXnrp
         UE7w==
X-Gm-Message-State: AOAM532CoctDc9VY/kj00Mc/VclBUVLxxaJ58+IG5V1nJV47s2GllCtH
        fYOuXCzpsElfKNcnE2V5/mqHbMEE4C9IFQ==
X-Google-Smtp-Source: ABdhPJwDtddLomu6MIMULeJ/FX5BQXgZuK88Sw3JP/Ei/+JnFUS7NXnuGToR7Z2GEfCOAae7dyJj5Q==
X-Received: by 2002:a2e:9052:: with SMTP id n18mr187950ljg.78.1602717144880;
        Wed, 14 Oct 2020 16:12:24 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id i19sm272498lfj.212.2020.10.14.16.12.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 16:12:23 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id b1so1297814lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 16:12:23 -0700 (PDT)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr122638lfz.344.1602717143436;
 Wed, 14 Oct 2020 16:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201014204529.934574-1-andrii@kernel.org> <CAHk-=wiE04vsfJmZ-AyWJHfNdGa=WmBYt4bP3aN+sTP05=QXXA@mail.gmail.com>
 <20201014230858.GL3576660@ZenIV.linux.org.uk>
In-Reply-To: <20201014230858.GL3576660@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 16:12:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=winDPLHSayCSPJnFZF9K31krw5TbLdGSxn_x-s++8=meQ@mail.gmail.com>
Message-ID: <CAHk-=winDPLHSayCSPJnFZF9K31krw5TbLdGSxn_x-s++8=meQ@mail.gmail.com>
Subject: Re: [PATCH] fs: fix NULL dereference due to data race in prepend_path()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-team@fb.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 4:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>  If you've already grabbed it, I'll just push a followup cleanup.

Already grabbed (along with the ppc32 csum fix). Your suggested helper
function cleanup sounds good.

          Linus
