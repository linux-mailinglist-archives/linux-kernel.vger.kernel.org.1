Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C095429F96A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgJ3AFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgJ3AFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:05:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A485C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 17:05:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e7so3708533pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 17:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eLpbt9/2/VjIZLqzcsErAP0i+T3IlGBIp1RUoX8H4HA=;
        b=qCP9pwgdQxzhiSETv8BvpHiuOJVzgJGW1mB4RTQAkBVocrtjuX5M3/Qa/zOUXGS3b8
         cCJCe7GuPpkal2BSLaHObquYjMKyNOtRWTPVeQ2FqV1hPJoddJUJC0FIc3ipi4oMh3i2
         Tcoi5EiLDNVLdNiOhDnXHVeE8cxSW4OAsFou0ZPoYbfMCmSRzT7od8wKqdvVydlrNLA4
         UGdCgFLy+/DV0PIk6e1r1cjnEYbK7GibwXTS/AiKY0oLMnNcsYn0Xfy6xhaqorqnpQSS
         7CICAKEEluSuazc1BSPdtUdFOSd5Vj/3aplo/c92HsXUYEyMlIsIP/GpmnbWlv6XbBmf
         nc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eLpbt9/2/VjIZLqzcsErAP0i+T3IlGBIp1RUoX8H4HA=;
        b=PTzSDnFrsBRGBlkWnYmNYNYFlQ5VsLlind2XjOe+SbupttVQ899zqM5YbBbBBbYLXX
         wVk9XX6MT4FoTTcwaNmWgNgQpdC0gnw6IEeq2cUCRKkoeNqdnfeK989XRqh6bKcTgWYQ
         PGtC053NBPHdt28Ci/sQo8PLqwmasa7rAOX6meAiztl3UpEUMKEsoHILP9xTPgg/hQn+
         s1H6XVkKK0SiIbGIQN12UgLsMVwGU658PXo3SJWxo/kJfzlgoN9jjgloHBi17Hdtf+Gf
         TU7/e+HJXQ3osOb4hQkWw3nIWZnIUD3GlD2JOQCGpLK0LT+XpkndH/mv8RDvj7ViHYLn
         qCCg==
X-Gm-Message-State: AOAM531nUKQKlMic6xvEWzGA7pqSunXzSMW7C+pVV9MG7hzX0jMSZK7h
        vsVyxIeqx9qguVmo/4B9wFY=
X-Google-Smtp-Source: ABdhPJxq7l3s5stXJ+BOnCECIuoOwFXRk299b5QqZRtQnKJbAmFuJ+YZEEr6kAkLsrNrxr4bEEWR6Q==
X-Received: by 2002:a17:90a:5b02:: with SMTP id o2mr814618pji.221.1604016332492;
        Thu, 29 Oct 2020 17:05:32 -0700 (PDT)
Received: from raspberrypi (c-73-71-109-8.hsd1.ca.comcast.net. [73.71.109.8])
        by smtp.gmail.com with ESMTPSA id o13sm991536pjq.19.2020.10.29.17.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 17:05:31 -0700 (PDT)
Date:   Thu, 29 Oct 2020 17:05:29 -0700
From:   Allen Martin <armartin@gmail.com>
To:     Matthias Reichl <hias@horus.com>, phil@raspberrypi.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: bcm2835: Add enable/disable clock functions
Message-ID: <20201030000528.GA23043@raspberrypi>
References: <20201010192617.12569-1-armartin@gmail.com>
 <CABfSH=oUfY=+eDDwccxMu724YAGOAf2kskZxvibxwOhYrd0_jQ@mail.gmail.com>
 <20201028093912.GA25254@lenny.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201028093912.GA25254@lenny.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:39:12AM +0100, Matthias Reichl wrote:
>On Wed, Oct 28, 2020 at 01:18:33AM -0700, Allen Martin wrote:
>> Hi, just checking if you had a chance to review this patch.
>>
>> On Sat, Oct 10, 2020 at 12:26 PM Allen Martin <armartin@gmail.com> wrote:
>>
>> > Add functions to control enable/disable of BCLK output of bcm2835 I2S
>> > controller so that BCLK output only starts when dma starts.  This
>> > resolves issues of audio pop with DACs such as max98357 on rpi.  The
>> > LRCLK output of bcm2835 only starts when the frame size has been
>> > configured and there is data in the FIFO.  The max98357 dac makes a
>> > loud popping sound when BCLK is toggling but LRCLK is not.
>
>I'm afraid that changing the clocking in the way you proposed has a high
>potential of breaking existing setups which need bclk to be present
>after prepare(). And it complicates the already rather convoluted
>clock setup even more. So I don't think this patch should be applied.
>
>Since you mentioned max98357: have you properly connected and configured
>the sd-mode GPIO? This chip has very strict timing requirements and is
>known to "pop" without sd-mode wired up - see the datasheet and devicetree
>binding docs.

The board I'm testing on is this: https://www.adafruit.com/product/3346
which does not have SD_MODE wired to GPIO (schematic is here:
https://www.adafruit.com/product/3346).  I agree this should ideally
be wired to GPIO as described in the max98357 datasheet to enable the
click and pop suppression feature, however there are still problems
with the clock initialization this patch addresses:

1) In bcm2835_i2s_hw_params() BCLK is enabled before the FIFO is
cleared causing residual data in the FIFO to be transmitted when BCLK
is initialized.

2) Also in bcm2835_i2s_hw_params() BCLK is enabled before the frame
size is configured in MODE_A or DMA is initialized.  This causes the
i2s controller to transmit a data frame many thousands of bits long,
violating the 0.5*BCLK < t < 0.5*LRCLK requirement of the max98357
datasheet.

I think the driver should separate clock initialization from output
enable and only start trasmitting once everything is initialized and
there is data to transmit.

Do you have more details about what setups require BCLK output after
prepare()?  I have access to a PCM5101A DAC, but I have not tested it
yet.

-Allen


>> >
>> > Signed-off-by: Allen Martin <armartin@gmail.com>
>> > ---
>> >  sound/soc/bcm/bcm2835-i2s.c | 35 +++++++++++++++++++++++++++++++++++
>> >  1 file changed, 35 insertions(+)
>> >
>> > diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
>> > index e6a12e271b07..5c8649864c0d 100644
>> > --- a/sound/soc/bcm/bcm2835-i2s.c
>> > +++ b/sound/soc/bcm/bcm2835-i2s.c
>> > @@ -122,9 +122,27 @@ struct bcm2835_i2s_dev {
>> >         struct regmap                           *i2s_regmap;
>> >         struct clk                              *clk;
>> >         bool                                    clk_prepared;
>> > +       bool                                    clk_enabled;
>> >         int                                     clk_rate;
>> >  };
>> >
>> > +static void bcm2835_i2s_enable_clock(struct bcm2835_i2s_dev *dev)
>> > +{
>> > +       if (dev->clk_enabled)
>> > +               return;
>> > +
>> > +       regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_MODE_A_REG,
>> > BCM2835_I2S_CLKDIS, 0);
>> > +       dev->clk_enabled = true;
>> > +}
>> > +
>> > +static void bcm2835_i2s_disable_clock(struct bcm2835_i2s_dev *dev)
>> > +{
>> > +       if (dev->clk_enabled)
>> > +               regmap_update_bits(dev->i2s_regmap,
>> > BCM2835_I2S_MODE_A_REG, BCM2835_I2S_CLKDIS, BCM2835_I2S_CLKDIS);
>> > +
>> > +       dev->clk_enabled = false;
>> > +}
>> > +
>> >  static void bcm2835_i2s_start_clock(struct bcm2835_i2s_dev *dev)
>> >  {
>> >         unsigned int master = dev->fmt & SND_SOC_DAIFMT_MASTER_MASK;
>> > @@ -145,6 +163,7 @@ static void bcm2835_i2s_start_clock(struct
>> > bcm2835_i2s_dev *dev)
>> >
>> >  static void bcm2835_i2s_stop_clock(struct bcm2835_i2s_dev *dev)
>> >  {
>> > +       bcm2835_i2s_disable_clock(dev);
>> >         if (dev->clk_prepared)
>> >                 clk_disable_unprepare(dev->clk);
>> >         dev->clk_prepared = false;
>> > @@ -158,6 +177,7 @@ static void bcm2835_i2s_clear_fifos(struct
>> > bcm2835_i2s_dev *dev,
>> >         uint32_t csreg;
>> >         uint32_t i2s_active_state;
>> >         bool clk_was_prepared;
>> > +       bool clk_was_enabled;
>> >         uint32_t off;
>> >         uint32_t clr;
>> >
>> > @@ -176,6 +196,11 @@ static void bcm2835_i2s_clear_fifos(struct
>> > bcm2835_i2s_dev *dev,
>> >         if (!clk_was_prepared)
>> >                 bcm2835_i2s_start_clock(dev);
>> >
>> > +       /* Enable clock if not enabled */
>> > +       clk_was_enabled = dev->clk_enabled;
>> > +       if (!clk_was_enabled)
>> > +               bcm2835_i2s_enable_clock(dev);
>> > +
>> >         /* Stop I2S module */
>> >         regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG, off, 0);
>> >
>> > @@ -207,6 +232,10 @@ static void bcm2835_i2s_clear_fifos(struct
>> > bcm2835_i2s_dev *dev,
>> >         if (!timeout)
>> >                 dev_err(dev->dev, "I2S SYNC error!\n");
>> >
>> > +       /* Disable clock if it was not enabled before */
>> > +       if (!clk_was_enabled)
>> > +               bcm2835_i2s_disable_clock(dev);
>> > +
>> >         /* Stop clock if it was not running before */
>> >         if (!clk_was_prepared)
>> >                 bcm2835_i2s_stop_clock(dev);
>> > @@ -414,6 +443,8 @@ static int bcm2835_i2s_hw_params(struct
>> > snd_pcm_substream *substream,
>> >         /* Clock should only be set up here if CPU is clock master */
>> >         if (bit_clock_master &&
>> >             (!dev->clk_prepared || dev->clk_rate != bclk_rate)) {
>> > +               if (dev->clk_enabled)
>> > +                       bcm2835_i2s_disable_clock(dev);
>> >                 if (dev->clk_prepared)
>> >                         bcm2835_i2s_stop_clock(dev);
>> >
>> > @@ -534,6 +565,8 @@ static int bcm2835_i2s_hw_params(struct
>> > snd_pcm_substream *substream,
>> >                 mode |= BCM2835_I2S_FTXP | BCM2835_I2S_FRXP;
>> >         }
>> >
>> > +       if (!dev->clk_enabled)
>> > +               mode |= BCM2835_I2S_CLKDIS;
>> >         mode |= BCM2835_I2S_FLEN(frame_length - 1);
>> >         mode |= BCM2835_I2S_FSLEN(framesync_length);
>> >
>> > @@ -668,6 +701,7 @@ static int bcm2835_i2s_trigger(struct
>> > snd_pcm_substream *substream, int cmd,
>> >         case SNDRV_PCM_TRIGGER_RESUME:
>> >         case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> >                 bcm2835_i2s_start_clock(dev);
>> > +               bcm2835_i2s_enable_clock(dev);
>> >
>> >                 if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
>> >                         mask = BCM2835_I2S_RXON;
>> > @@ -839,6 +873,7 @@ static int bcm2835_i2s_probe(struct platform_device
>> > *pdev)
>> >
>> >         /* get the clock */
>> >         dev->clk_prepared = false;
>> > +       dev->clk_enabled = false;
>> >         dev->clk = devm_clk_get(&pdev->dev, NULL);
>> >         if (IS_ERR(dev->clk)) {
>> >                 dev_err(&pdev->dev, "could not get clk: %ld\n",
>> > --
>> > 2.20.1
>> >
>> >
