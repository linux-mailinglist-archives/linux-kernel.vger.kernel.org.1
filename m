Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC0E29DB3D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389023AbgJ1XqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:46:14 -0400
Received: from mail.horus.com ([78.46.148.228]:54891 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgJ1XqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:46:13 -0400
X-Greylist: delayed 4201 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2020 19:46:12 EDT
Received: from lenny.lan (185-64-50-250.net.pr-link.at [185.64.50.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "E-Mail Matthias Reichl Lenny", Issuer "HiassofT CA 2014" (verified OK))
        by mail.horus.com (Postfix) with ESMTPSA id E83E66409C;
        Wed, 28 Oct 2020 10:39:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1603877954;
        bh=7d5a+3Ljqax+6DgAhxaIp1YXNLgsdlmutL9avA9nyb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDe75A2utxUug1bs+L89lLbN2+gpYqDsZltuxR1N4eqCE0wfG7XXHhST/kQHuro+a
         NudA7t/3GS69ZfdzTOacOMO5vubvLVhyuk43bW8DYwiV0rGo4eKHdkmysoPJ1xRz4t
         Wjl6oseLUN80/HQ0QKQFrK/XAnHYsgrZgCd6FUOw=
Received: by lenny.lan (Postfix, from userid 1000)
        id A8AC3200978; Wed, 28 Oct 2020 10:39:12 +0100 (CET)
Date:   Wed, 28 Oct 2020 10:39:12 +0100
From:   Matthias Reichl <hias@horus.com>
To:     Allen Martin <armartin@gmail.com>
Cc:     phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: bcm2835: Add enable/disable clock functions
Message-ID: <20201028093912.GA25254@lenny.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Allen Martin <armartin@gmail.com>, phil@raspberrypi.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201010192617.12569-1-armartin@gmail.com>
 <CABfSH=oUfY=+eDDwccxMu724YAGOAf2kskZxvibxwOhYrd0_jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABfSH=oUfY=+eDDwccxMu724YAGOAf2kskZxvibxwOhYrd0_jQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 01:18:33AM -0700, Allen Martin wrote:
> Hi, just checking if you had a chance to review this patch.
> 
> On Sat, Oct 10, 2020 at 12:26 PM Allen Martin <armartin@gmail.com> wrote:
> 
> > Add functions to control enable/disable of BCLK output of bcm2835 I2S
> > controller so that BCLK output only starts when dma starts.  This
> > resolves issues of audio pop with DACs such as max98357 on rpi.  The
> > LRCLK output of bcm2835 only starts when the frame size has been
> > configured and there is data in the FIFO.  The max98357 dac makes a
> > loud popping sound when BCLK is toggling but LRCLK is not.

I'm afraid that changing the clocking in the way you proposed has a high
potential of breaking existing setups which need bclk to be present
after prepare(). And it complicates the already rather convoluted
clock setup even more. So I don't think this patch should be applied.

Since you mentioned max98357: have you properly connected and configured
the sd-mode GPIO? This chip has very strict timing requirements and is
known to "pop" without sd-mode wired up - see the datasheet and devicetree
binding docs.

so long,

Hias

> >
> > Signed-off-by: Allen Martin <armartin@gmail.com>
> > ---
> >  sound/soc/bcm/bcm2835-i2s.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
> > index e6a12e271b07..5c8649864c0d 100644
> > --- a/sound/soc/bcm/bcm2835-i2s.c
> > +++ b/sound/soc/bcm/bcm2835-i2s.c
> > @@ -122,9 +122,27 @@ struct bcm2835_i2s_dev {
> >         struct regmap                           *i2s_regmap;
> >         struct clk                              *clk;
> >         bool                                    clk_prepared;
> > +       bool                                    clk_enabled;
> >         int                                     clk_rate;
> >  };
> >
> > +static void bcm2835_i2s_enable_clock(struct bcm2835_i2s_dev *dev)
> > +{
> > +       if (dev->clk_enabled)
> > +               return;
> > +
> > +       regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_MODE_A_REG,
> > BCM2835_I2S_CLKDIS, 0);
> > +       dev->clk_enabled = true;
> > +}
> > +
> > +static void bcm2835_i2s_disable_clock(struct bcm2835_i2s_dev *dev)
> > +{
> > +       if (dev->clk_enabled)
> > +               regmap_update_bits(dev->i2s_regmap,
> > BCM2835_I2S_MODE_A_REG, BCM2835_I2S_CLKDIS, BCM2835_I2S_CLKDIS);
> > +
> > +       dev->clk_enabled = false;
> > +}
> > +
> >  static void bcm2835_i2s_start_clock(struct bcm2835_i2s_dev *dev)
> >  {
> >         unsigned int master = dev->fmt & SND_SOC_DAIFMT_MASTER_MASK;
> > @@ -145,6 +163,7 @@ static void bcm2835_i2s_start_clock(struct
> > bcm2835_i2s_dev *dev)
> >
> >  static void bcm2835_i2s_stop_clock(struct bcm2835_i2s_dev *dev)
> >  {
> > +       bcm2835_i2s_disable_clock(dev);
> >         if (dev->clk_prepared)
> >                 clk_disable_unprepare(dev->clk);
> >         dev->clk_prepared = false;
> > @@ -158,6 +177,7 @@ static void bcm2835_i2s_clear_fifos(struct
> > bcm2835_i2s_dev *dev,
> >         uint32_t csreg;
> >         uint32_t i2s_active_state;
> >         bool clk_was_prepared;
> > +       bool clk_was_enabled;
> >         uint32_t off;
> >         uint32_t clr;
> >
> > @@ -176,6 +196,11 @@ static void bcm2835_i2s_clear_fifos(struct
> > bcm2835_i2s_dev *dev,
> >         if (!clk_was_prepared)
> >                 bcm2835_i2s_start_clock(dev);
> >
> > +       /* Enable clock if not enabled */
> > +       clk_was_enabled = dev->clk_enabled;
> > +       if (!clk_was_enabled)
> > +               bcm2835_i2s_enable_clock(dev);
> > +
> >         /* Stop I2S module */
> >         regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG, off, 0);
> >
> > @@ -207,6 +232,10 @@ static void bcm2835_i2s_clear_fifos(struct
> > bcm2835_i2s_dev *dev,
> >         if (!timeout)
> >                 dev_err(dev->dev, "I2S SYNC error!\n");
> >
> > +       /* Disable clock if it was not enabled before */
> > +       if (!clk_was_enabled)
> > +               bcm2835_i2s_disable_clock(dev);
> > +
> >         /* Stop clock if it was not running before */
> >         if (!clk_was_prepared)
> >                 bcm2835_i2s_stop_clock(dev);
> > @@ -414,6 +443,8 @@ static int bcm2835_i2s_hw_params(struct
> > snd_pcm_substream *substream,
> >         /* Clock should only be set up here if CPU is clock master */
> >         if (bit_clock_master &&
> >             (!dev->clk_prepared || dev->clk_rate != bclk_rate)) {
> > +               if (dev->clk_enabled)
> > +                       bcm2835_i2s_disable_clock(dev);
> >                 if (dev->clk_prepared)
> >                         bcm2835_i2s_stop_clock(dev);
> >
> > @@ -534,6 +565,8 @@ static int bcm2835_i2s_hw_params(struct
> > snd_pcm_substream *substream,
> >                 mode |= BCM2835_I2S_FTXP | BCM2835_I2S_FRXP;
> >         }
> >
> > +       if (!dev->clk_enabled)
> > +               mode |= BCM2835_I2S_CLKDIS;
> >         mode |= BCM2835_I2S_FLEN(frame_length - 1);
> >         mode |= BCM2835_I2S_FSLEN(framesync_length);
> >
> > @@ -668,6 +701,7 @@ static int bcm2835_i2s_trigger(struct
> > snd_pcm_substream *substream, int cmd,
> >         case SNDRV_PCM_TRIGGER_RESUME:
> >         case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> >                 bcm2835_i2s_start_clock(dev);
> > +               bcm2835_i2s_enable_clock(dev);
> >
> >                 if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> >                         mask = BCM2835_I2S_RXON;
> > @@ -839,6 +873,7 @@ static int bcm2835_i2s_probe(struct platform_device
> > *pdev)
> >
> >         /* get the clock */
> >         dev->clk_prepared = false;
> > +       dev->clk_enabled = false;
> >         dev->clk = devm_clk_get(&pdev->dev, NULL);
> >         if (IS_ERR(dev->clk)) {
> >                 dev_err(&pdev->dev, "could not get clk: %ld\n",
> > --
> > 2.20.1
> >
> >
