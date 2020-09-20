Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68673271836
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 23:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgITVcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 17:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITVcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 17:32:15 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA895C061755;
        Sun, 20 Sep 2020 14:32:15 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v8so6628837iom.6;
        Sun, 20 Sep 2020 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zl4uqFm3yPB6x7Hy8vdaFwmv1E7h2D7sRx3SQmvIRXU=;
        b=VSMIJzXr04+KE0LLcVJ20lZzuJ6LTNdJ2ytVxu/nLeGeHOuSwD7AWKA20qISHSLDVW
         BP8HMh8KqUMfBtunEPGWpR1h3160kQz1nsHRD7Jy8Ew/c3QYX6hr+oIt9bDWGCLnSRgA
         DRC2rZajZaroGhdB3Sa5BrfxfuwLYaeCdB+K+3iqLGymh0eu9rUdJBNKzrlZgPXBfAfV
         U6W84E93GKxLIsbtrU7es9LzPNuCmnTa5qCgoD1NJTY6CU/jexGAsyTK34COFsxb+R3K
         SI7CiUyzFIFCPQkS2R69DAKddcQd/IIr5qs1XiCF0ahobHCw8vdXRx95yL7V9zbXqvcG
         KhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zl4uqFm3yPB6x7Hy8vdaFwmv1E7h2D7sRx3SQmvIRXU=;
        b=kBJmqbA9n1kJ5J1nUJo/RsTfY0YyFoI4czKHnSXUfQoZGNPxn9h7nf+y6cSYpdakUL
         1DRbbX0hxu6T8JQP2dS6txCfLHi4yez5OcdKk+plgu7xZEFJYMRESTFso2N4uxLaM5bf
         pi2VVwcmIdUlAvauiZ6FHzQ7+ZW8Liuc/PeGmDT6dQzvu6qO0PT7WqjN7aFkjS5xtQA8
         ZgMgwuhc9l9wBHdBZLYl4vih5yTZNoYfBBfCp47QXmIhO/aabTRh3+Gk0YnX/uUOYvqD
         uYkxscTSSzKfeSBkEtzD7pKHsOxv8juWH6UxoYiIuIP8s8cW6+d7c8Zk1FOv9UMrbP5l
         dKpw==
X-Gm-Message-State: AOAM531IaIuftIIN7YQ6ClkVw+xyVWGTjF8GVU5COiv7VJa29uR+xEHT
        EaJ2km5vwM2Ywfo1oXJ9Y1aOdhMw909rdiM5EED2RWmn2tBFkW7D
X-Google-Smtp-Source: ABdhPJzBIdXB8dWyLH0FcLOI7kzaUQSBoFIW/9bNwv9d/zobjxL/7xzmN/ng0VcJW6M1oEZlXTgmu3yobI0sbINo6ps=
X-Received: by 2002:a02:734f:: with SMTP id a15mr38597014jae.120.1600637534793;
 Sun, 20 Sep 2020 14:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200920180758.592217-1-peron.clem@gmail.com> <20200920180758.592217-6-peron.clem@gmail.com>
 <2d2799c5-62e8-8e64-c739-3d85b89c1178@sholland.org>
In-Reply-To: <2d2799c5-62e8-8e64-c739-3d85b89c1178@sholland.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 20 Sep 2020 23:32:03 +0200
Message-ID: <CAJiuCcfH3Z=-ow0S1Za_Qtvx_Bnjic9ivNEtGUmyVTgetgkZhQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/19] ASoc: sun4i-i2s: Add 20 and 24 bit support
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Sun, 20 Sep 2020 at 20:45, Samuel Holland <samuel@sholland.org> wrote:
>
> On 9/20/20 1:07 PM, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Extend the functionality of the driver to include support of 20 and
> > 24 bits per sample.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > Acked-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> As I have mentioned before, if you want to support a 32-bit slot width on=
 sun4i
> variants (which patch 2 does via TDM and this patch does via PCM format),=
 you
> need to fix sun4i_i2s_get_wss() to return "3", not "4", for a 32-bit inpu=
t.

Sorry I didn't get it the first time.

Is using a switch case is a correct solution?

static s8 sun4i_i2s_get_wss(const struct sun4i_i2s *i2s, int width)
{
switch (width)
{
case 16:
return 0x0;
case 20:
return 0x1;
case 24:
return 0x2;
case 32:
return 0x3;
}

return -EINVAL;
}

Clement

>
> Cheers,
> Samuel
