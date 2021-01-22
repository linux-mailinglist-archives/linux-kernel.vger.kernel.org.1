Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B022FFAD9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 04:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbhAVDKV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Jan 2021 22:10:21 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:44597 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbhAVDKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 22:10:13 -0500
Received: by mail-lf1-f43.google.com with SMTP id p21so476640lfu.11;
        Thu, 21 Jan 2021 19:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4lGuVHhcKVrdOs4QmSKpbm9VyPli3VuiFPw1ljmvzq8=;
        b=L/Ldh4cAwdOzBnojn1SkXdRhQrnB/diqCyfUl1f7101YaBecaHRbHrb+2XcYcaD3Yq
         zVkEc2eleh+2Cbfp2ykt+KXwGSyo2IdoZ1FTQ+yz88YPPIa9K7YE0j/ggALK3mZcGzOX
         vM4AhbLoCDy0KpFMf8+OuOLdfLBXmVDwXnrwjACh3ikW74BScGySCvCA2JdxjvlJeAZ2
         ZXGNt5AM+B+EbC/4ec8PgaZ+z0MfuR/0fDP5nLCP+zoidl4qOzVEtvquek4VRyho8QMr
         D35NoPiHE2YcHTA78OFcZdQkG2iBRv971pUrxpl3eKhQ/dp7t3sQOsq4GgRPP6wZlpXB
         /fCQ==
X-Gm-Message-State: AOAM5312A+wqm2qQyfF2SwfK+CXVqiorV8lFxDs6NdLTm4OHz2jWW2no
        34uFUAQdkSceglMLtAjvP4W1aQJe7IiEFw==
X-Google-Smtp-Source: ABdhPJwAMT7pj6ch4+XSDnDbnteI3GHrnqnEd/hJfad2hwWZdCc2H+2SojojIp1xOdumYeMpfs30gw==
X-Received: by 2002:a05:6512:b04:: with SMTP id w4mr1146186lfu.43.1611284970951;
        Thu, 21 Jan 2021 19:09:30 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id a8sm716338lfj.65.2021.01.21.19.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 19:09:30 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id o17so5588688lfg.4;
        Thu, 21 Jan 2021 19:09:30 -0800 (PST)
X-Received: by 2002:a19:810:: with SMTP id 16mr1178235lfi.233.1611284969893;
 Thu, 21 Jan 2021 19:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20210121170836.GA4948@lemon.iwr.uni-heidelberg.de> <2438641.b0YrFlWa0f@kista>
In-Reply-To: <2438641.b0YrFlWa0f@kista>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 22 Jan 2021 11:09:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v64CFoj5gLtZvVu8Hhdy1SAdqLd-pPwT0APh-FYymZnP8Q@mail.gmail.com>
Message-ID: <CAGb2v64CFoj5gLtZvVu8Hhdy1SAdqLd-pPwT0APh-FYymZnP8Q@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: sun7i: a20: bananapro: Fix ethernet node
To:     Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 3:54 AM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>
> Dne četrtek, 21. januar 2021 ob 18:08:36 CET je Hermann Lauer napisal(a):
> > BPi Pro needs TX and RX delay for Gbit to work reliable and avoid high
> > packet loss rates. The realtek phy driver overrides the settings of the
> > pull ups for the delays, so fix this for Banana Pro.
> >
> > Signed-off-by: Hermann Lauer <Hermann.Lauer@uni-heidelberg.de>
>
> Much better. Now the only thing missing is "Fixes" tag, which references
> commit which introduced the issue. Probably this will be the commit which
> added ethernet node. This tag is important for deciding which commits should
> be backported to stable releases. Take a look in v1 for M2U fixes tag.
>
> Btw, each version should have changelog under "---" line, so maintainers and
> reviewers know what changed.

The subject line should also be more concise. "Fix ethernet phy-mode" reads
much better than "Fix ethernet node", which could mean a number of things.

ChenYu
