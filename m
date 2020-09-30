Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0805827E70B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgI3Kuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbgI3Kud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:50:33 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AE51207FB;
        Wed, 30 Sep 2020 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601463033;
        bh=kmAGaVMqiwysW8JkOJjFQECYtvVl9Al7aYA3dmLOxmk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AIuXPwd8yDHcH9OFLr3YZF6sWpeSl7vgXgTmXcdAwzYzn4FmbsmZwSVfh/BS23j6G
         BT/ssP2JvxiHegFwiDEq/isiTUWZHCwRZxg66+HMAW7GuLhz1/NhW34kgewbYadCnk
         I+6DaxRbgFWXCvdMFvyBc/U+HMqJ5C+PPk1u8AHE=
Received: by mail-ej1-f48.google.com with SMTP id p9so2096697ejf.6;
        Wed, 30 Sep 2020 03:50:32 -0700 (PDT)
X-Gm-Message-State: AOAM532MyHbYsu8G/wR0n8caTzaXcQywphCw+v53xkm9eIGE/OcZ1Ten
        rMNSvra4/4qANl4Q43sZuKD4X8Qezo5qs+rAtJY=
X-Google-Smtp-Source: ABdhPJxT7KJoIm3iB8yiJJ4BlIjWUV0kEToptUUaw1oVEasuPm/KggXX6LiiSUrYdTl6pBhphWD1vyhy/1rbdEYXtro=
X-Received: by 2002:a17:906:4046:: with SMTP id y6mr2276225ejj.148.1601463031603;
 Wed, 30 Sep 2020 03:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200821121755.24599-1-martin.kepplinger@puri.sm>
 <20200821121755.24599-2-martin.kepplinger@puri.sm> <20200830131459.GL32096@dragon>
In-Reply-To: <20200830131459.GL32096@dragon>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 30 Sep 2020 12:50:19 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcJUg+a8rJEn1D-_Ex3HEyHi7TZdh8VGPr9C23xq8L2pA@mail.gmail.com>
Message-ID: <CAJKOXPcJUg+a8rJEn1D-_Ex3HEyHi7TZdh8VGPr9C23xq8L2pA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] MAINTAINERS: Add Purism Librem 5 section to the list
To:     Shawn Guo <shawnguo@kernel.org>, Joe Perches <joe@perches.com>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        kernel@puri.sm, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, mchehab@kernel.org,
        Anson.Huang@nxp.com, agx@sigxcpu.org, angus@akkea.ca,
        broonie@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Aug 2020 at 15:15, Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Fri, Aug 21, 2020 at 02:17:54PM +0200, Martin Kepplinger wrote:
> > Add development information for the devicetree files for hardware
> > by Purism SPC.
> >
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
>
> I decided to drop this patch from my queue, as I took the suggestion
> from Joe and sent a patch to have get_maintainer report email address
> in the dts file.
>
> Shawn
>
> [1] https://lkml.org/lkml/2020/8/30/118

Shawn, Joe,

Cool idea! Multiple times I needed review/testing for individual
boards and this should be faster than going through git history.

Could you tell me how this is supposed to work for DTS/DTSI files? It
seems it ignores the comments, so usual copyright notice does not have
an effect. Where to put the address?

Best regards,
Krzysztof
