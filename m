Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4396300494
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbhAVNww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbhAVNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:52:43 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B033C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:52:03 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id m6so3730319pfk.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0CdidXL9JqNASCWuJRmNf4tnrFhZ2Ys482HTC2wueeU=;
        b=eC5U90fghxE+n7CKNa61zlt/x+toKTPUKMHPD58h8ct+ARa5CJJ3MLoHsqR1sGY6po
         sjdAV4QjW9rKBFqbBlhJ8yMmsnMbe0ven0xG8CX6DYnaRFrjAA4P96wHvMHBd6Vj6XU6
         xy/rfetnkfrrTdV/j7+97xOUlMg6e5Bw0rKfT7b+DuH+q3gaWtcYg24qmqx9wmjAqXSk
         mtwaa9A6IOOtEwAaWna4M0cCTkEYUKV+rVraChYFJtkYb+9J3KqLyg2adleiqo702QHm
         9M5lPjT1k6seAB5LZz1p9P5gYm/D+T8Uk1uj8WIQ6Y9IKPv4AG739uqhUWAes0Zik6we
         NsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0CdidXL9JqNASCWuJRmNf4tnrFhZ2Ys482HTC2wueeU=;
        b=b+ksk7TjW1mMpodV1w1mY8vbL3D+tLjaK0gXTP0KuY6p3BwwtNYuMM8kFodbnYvHoX
         hm15zky3XdmcRagzphBFK9HSNpWjhqjjk7B3svXYFTseIc3pMAgZ07WuCa+5id15uiZx
         597wT58Iet3NfBrWrLZ4rv/9E7NowcuGgg2pdwrafeIEcEe4/R2r04dP4Ziv7zV+ZFf7
         KoDTCN/5HvMAbx9yDzeByKbndr8XNMS0HPxxFCIIk6AkwNVvdr6FQk9paWTiHISHwph+
         +en9GXWWWeQo1+yZqGXVELoihnZtp04GmwYZeLrJjYiTmheZSApq/Ge37a97ihZJ97DB
         B1zQ==
X-Gm-Message-State: AOAM532/ZzcrKOza1nPGTF7iuI4KYLAa9mb08dDWOD7PitKmBXjTxogQ
        20T71HplayT4M5JCl6Cz6jzL
X-Google-Smtp-Source: ABdhPJxoSgjsOi7KJvW0fiz+egsgCeN7n5OWTeHOlCuGtfnw/Wy6J3Ex3Apm3cGyw6U2OXiWp0ieKw==
X-Received: by 2002:a63:1e56:: with SMTP id p22mr4842928pgm.70.1611323522493;
        Fri, 22 Jan 2021 05:52:02 -0800 (PST)
Received: from work ([103.77.37.137])
        by smtp.gmail.com with ESMTPSA id f3sm2135041pfb.119.2021.01.22.05.51.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jan 2021 05:52:01 -0800 (PST)
Date:   Fri, 22 Jan 2021 19:21:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Subject: Re: [PATCH] pinctrl: actions: Add the platform dependency to drivers
Message-ID: <20210122135158.GB32437@work>
References: <20210121062547.27173-1-manivannan.sadhasivam@linaro.org>
 <CACRpkdYDB883r7RRa-i1T_aWvDW1n3c_LvScigQVnt5TsPbPCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYDB883r7RRa-i1T_aWvDW1n3c_LvScigQVnt5TsPbPCg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 02:19:07PM +0100, Linus Walleij wrote:
> On Thu, Jan 21, 2021 at 7:26 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> 
> > The Actions Semi pinctrl drivers are a mix of both ARM32 and ARM64
> > platforms. So let's add the correct platform dependency to avoid them
> > being selected on the other.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Are you not opting out of build tests when you do this?
> 
> What about:
> 
> depends on ARM64 || COMPILE_TEST
> (etc)
> ?
> 

Oh yeah, I missed it. Will send v2.

Thanks,
Mani

> Yours,
> Linus Walleij
> 
> Yours,
> Linus Walleij
