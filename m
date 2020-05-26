Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451EB1AE144
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 17:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgDQPfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 11:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728956AbgDQPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:35:45 -0400
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5300::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90039C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1587137743;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Qaen0lQiP0FWn3qCidsRX3hKu//mw1RvQ8vN/KmdeWY=;
        b=gN8Zqi9xos9QZGjWGqtQ8cOb69RRogf9Fg97bGM+h0pXnWrdZo/iMYPNP0anTMu43W
        UlAH39DjhKgDHU5H0pVDaipLma3/f1AQZOZToTQerPb0tJwU1Zf/cnezhVYtP+hbALor
        QGBExb7aCWafiWFzzL5YU84IqnGqJOwt96Yfs4uziKjyvFDFBJ85VHwTMkTE5SCUACvQ
        UaO2E/V+2cZV8wg8nfdGNtXpghzgJeWwfpw4ymPhUWNDSGMfywB0G3EOmtT1o6qe/uVL
        1zhvMG1gr2O/bxaBhPVU4YNSHKY7gtQ5BpynXNal4rKwwLDsLnGNlCo4D9KbZsHkgcDe
        76xg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j8Ic/Fboo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.5.0 DYNA|AUTH)
        with ESMTPSA id I0a766w3HFZe3da
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 17 Apr 2020 17:35:40 +0200 (CEST)
Date:   Fri, 17 Apr 2020 17:35:34 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com
Subject: Re: [PATCH 0/2] ASoC: qdsp6: fix default FE dais and routings.
Message-ID: <20200417153534.GA65143@gerhold.net>
References: <20200311180422.28363-1-srinivas.kandagatla@linaro.org>
 <20200417112455.GA7558@gerhold.net>
 <03d0d14c-d52c-460b-0232-184156f62eb7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03d0d14c-d52c-460b-0232-184156f62eb7@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 02:02:08PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 17/04/2020 12:24, Stephan Gerhold wrote:
> > Hi Srini,
> > 
> > On Wed, Mar 11, 2020 at 06:04:20PM +0000, Srinivas Kandagatla wrote:
> > > QDSP6 Frontend dais can be configured to work in rx or tx or both rx/tx mode,
> > > however the default routing do not honour this DT configuration making sound
> > > card fail to probe. FE dais are also not fully honouring device tree configuration.
> > > Fix both of them.
> > > 
> > 
> > I discovered this patch set when QDSP6 audio stopped working after
> > upgrading to Linux 5.7-rc1. As far as I understand, device tree bindings
> > should attempt to be backwards compatible wherever possible.
> > This isn't the case here, although this is not the reason for my mail.
> > (I don't mind updating my device tree, especially since it is not
> > upstream yet...)
> > 
> > I have a general question about the design here.
> > 
> > I understand the original motivation for this patch set: Attempting to
> > configure a TX/RX-only DAI was not possible due to the default routing.
> > In my opinion this is only relevant for the compressed DAI case.
> > 
> > If we ignore the compressed DAIs for a moment (which can be
> > unidirectional only), I think we shouldn't care how userspace uses the
> > available FE/MultiMedia DAIs. We have this huge routing matrix in q6routing,
> > with 800+ mixers that can be configured in any way possible from userspace.
> > 
> > In "ASoC: qdsp6: q6asm-dai: only enable dais from device tree" you mention:
> > 
> > > This can lead to un-necessary dais in the system which will never be
> > > used. So honour whats specfied in device tree.
> > 
> > but IMO the FE DAIs are a negligible overhead compared to the routing
> > matrix and the many BE DAIs that are really never going to be used
> > (because nothing is physically connected to the ports).
> 
> Two things, one unnecessary mixers, second thing is we need to know how many
> FE dais are in the system, which should be derived from the number of dai
> child nodes. These can potentially be SoC specific or firmware specific.
> 

So there are SoCs/firmwares that just support e.g. MultiMedia1-4 and not
all 8 MultiMedia FE DAIs?

> My plan is to cleanup the BE DAIs as well!, any patches welcome!
> 
> > 
> > Even if you restrict FE DAIs to RX/TX only, or disable them entirely,
> 
> I think this is mistake from myside. Alteast according to bindings direction
> property is only "Required for Compress offload dais", code should have
> explicitly ignored it. Here is change that should fix it.
> 

This would make the MultiMedia1-3 bi-directional in sdm845-db845c,
but MultiMedia5-8 would still be disabled.

My question here would then be similar as above:
Is this an arbitrary selection of a reasonable amount of FE DAIs,
or actually based on some firmware limitations?

As I described in the rest of my mail (below your diff),
before this patch set it was simple to just expose all 8 FE DAIs.
At least on MSM8916 all of them work in exactly the same way,
there is no difference between any of them.

If we list what is working in SoC/firmware in the device tree,
would I just list all 8 FE DAIs?

Basically I'm still trying to understand why we limit the number of
FE/MultiMedia DAIs that we expose, when all of them would be working
fine. :)

Thanks,
Stephan

> --------------------------->cut<---------------------------------
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c
> b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index 125af00bba53..31f46b25978e 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -1067,6 +1067,11 @@ static int of_q6asm_parse_dai_data(struct device
> *dev,
>                 dai_drv = &pdata->dais[idx++];
>                 *dai_drv = q6asm_fe_dais_template[id];
> 
> +               if (of_property_read_bool(node, "is-compress-dai"))
> +                       dai_drv->compress_new = snd_soc_new_compress;
> +               else
> +                       continue;
> +
>                 ret = of_property_read_u32(node, "direction", &dir);
>                 if (ret)
>                         continue;
> @@ -1076,8 +1081,6 @@ static int of_q6asm_parse_dai_data(struct device *dev,
>                 else if (dir == Q6ASM_DAI_TX)
>                         dai_drv->playback = empty_stream;
> 
> -               if (of_property_read_bool(node, "is-compress-dai"))
> -                       dai_drv->compress_new = snd_soc_new_compress;
>         }
> 
>         return 0;
> 
> --------------------------->cut<---------------------------------
> 
> Thanks,
> srini
> 
> > all the routing mixers still exist for them. They will just result in
> > configurations that are not usable in any way. IMO the only thing we
> > gain by restricting the FE DAIs is that the available mixers no longer
> > match possible configurations.
> > 
> > Before this patch set I used a slightly different approach in my device
> > tree for MSM8916: I kept all FE DAIs bi-directional, and added DAI links
> > for all of them. This means that I actually had 8 bi-directional PCM
> > devices in userspace.
> > 
> > I didn't use all of them - my ALSA UCM configuration only uses
> > MultiMedia1 for playback and MultiMedia2 for capture.
> > However, some other userspace (let's say Android) could have chosen
> > different FE DAIs for whatever reason. We have the overhead for the
> > routing matrix anyway, so we might as well expose it in my opinion.
> > 
> > My question is: In what way are the FE DAIs really board-specific?
> > 
> > If we expose only some FE DAIs with intended usage per board,
> > e.g. MultiMedia1 for HDMI, MultiMedia2 for slimbus playback,
> >       MultiMedia3 for slimbus capture,
> > I could almost argue that we don't need DPCM at all.
> > The FE DAIs are always going to be used for the same backend anyway.
> > 
> > This is a bit exaggerated - for example if you have a single compress
> > DAI per board you probably intend to use it for both HDMI/slimbus.
> > But this is the feeling I get if we configure the FE DAIs separately
> > for each board.
> > 
> > I wonder if we should leave configuration of the FE DAIs up to userspace
> > (e.g. ALSA UCM), and expose the same full set of FE DAIs for each board.
> > 
> > I think this is mostly a matter of convention for configuring FE DAIs
> > in the device tree - I have some ideas how to make that work
> > with the existing device tree bindings and for compressed DAIs.
> > But this mail is already long enough as-is. ;)
> > 
> > I also don't mind if we keep everything as-is
> > - I just wanted to share what I have been thinking about.
> > 
> > What do you think?
> > 
> > Thanks for reading! ;)
> > Stephan
> > 
> > > Originally  issue was reported by Vinod Koul
> > > 
> > > Srinivas Kandagatla (2):
> > >    ASoC: qdsp6: q6asm-dai: only enable dais from device tree
> > >    ASoC: qdsp6: q6routing: remove default routing
> > > 
> > >   sound/soc/qcom/qdsp6/q6asm-dai.c | 30 +++++++++++++++++++++++-------
> > >   sound/soc/qcom/qdsp6/q6routing.c | 19 -------------------
> > >   2 files changed, 23 insertions(+), 26 deletions(-)
> > > 
> > > -- 
> > > 2.21.0
> > > 
