Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7A01D2880
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 09:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgENHG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 03:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgENHG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:06:59 -0400
Received: from localhost (unknown [122.182.193.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 379B7206B6;
        Thu, 14 May 2020 07:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589440018;
        bh=ko+QJFwkWTXYfx2/kvXI/EtmyCz2qbfj80ZE33hTmAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JF8KeWkEKQH48nQOLMK5fn7soT369ypkah7Fvxc5sWzfo5h1zVgSmV5cYV5QokA3c
         0gPX0CzOQedX+koo3V7VxjydEx8AoAXAVNZYay7MN0GPR0ec85qUeDhAGMGWfyq8CA
         0WgJDh1kPVbZBriXQ/NhqLERMk0/u5obggzda2Sg=
Date:   Thu, 14 May 2020 12:36:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/3] drm/bridge: Introduce LT9611 DSI to HDMI bridge
Message-ID: <20200514070650.GO14092@vkoul-mobl>
References: <20200513100533.42996-1-vkoul@kernel.org>
 <20200513100533.42996-4-vkoul@kernel.org>
 <CACvgo502+8YroB5QtnGYFeSu92s_vpe_M3cPFeuC77u9xpanXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACvgo502+8YroB5QtnGYFeSu92s_vpe_M3cPFeuC77u9xpanXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Emil,

Thanks for the comments.

On 13-05-20, 20:20, Emil Velikov wrote:
> Hi Vinod,
> 
> Few high-level comments:
>  - handful of functions always return 0 and the return value is never
> checked - switch to return void

Sure makes sense, will do

>  - annotate all (nearly) arrays as static const

Will do

>  - consistently use multi_reg_write - in some cases non-const array
> will be fine, overwriting a few entries as needed

Okay that makes sense

>  - there is very partial comments about the registers/values - missing docs or?

yeah am not a big fan either, problem is documentation.

Well the spec I have doesn't have register names and few registers are
missing :( I have few name created but naming registers turned nasty
super quick.. Do let me know if you have suggestions, I will give it one
more shot though

> Personally I'm in favour of using symbolic names, instead of
> hex+comment. Considering how partial the comments are, current
> approach is perfectly fine.
> 
> On Wed, 13 May 2020 at 11:06, Vinod Koul <vkoul@kernel.org> wrote:
> >
> > Lontium Lt9611 is a DSI to HDMI bridge which supports two DSI ports and
> > I2S port as an input and HDMI port as output
> >
> > Co-developed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lt9611.c
> 
> Please add a vendor prefix to the filename.

Okay

> > +struct lt9611_mode {
> > +       u16 hdisplay;
> > +       u16 vdisplay;
> > +       u8 fps;
> We all enjoy the odd fps game, but let's use vrefresh here.

Sure will change

> > +static int lt9611_mipi_input_digital(struct lt9611 *lt9611,
> > +                                    const struct drm_display_mode *mode)
> > +{
> > +       regmap_write(lt9611->regmap, 0x8300, LT9611_4LANES);
> > +
> > +       if (mode->hdisplay == 3840)
> > +               regmap_write(lt9611->regmap, 0x830a, 0x03);
> > +       else
> > +               regmap_write(lt9611->regmap, 0x830a, 0x00);
> > +
> > +       regmap_write(lt9611->regmap, 0x824f, 0x80);
> > +       regmap_write(lt9611->regmap, 0x8250, 0x10);
> > +       regmap_write(lt9611->regmap, 0x8302, 0x0a);
> > +       regmap_write(lt9611->regmap, 0x8306, 0x0a);
> Create an (non-const) array, overwriting the [1] entry for 3840 mode?

So array is the recommendation, I dont have much liking for them but I
can see they would be useful here, so will change this and other
instances and we can use regmap_multi_reg_write() while taking care of
static const for non modified arrays

> 
> > +
> > +       return 0;
> Kill return type.

Yup, here and other places

> > +       regmap_write(lt9611->regmap, 0x82e3, pclk >> 17); /* pclk[19:16] */
> > +       regmap_write(lt9611->regmap, 0x82e4, pclk >> 9);  /* pclk[15:8]  */
> > +       regmap_write(lt9611->regmap, 0x82e5, pclk >> 1);  /* pclk[7:0]   */
> Comment does not match the code.
> We're discarding the LSB, so we cannot realistically be writing
> pclk[7:0]. Similar applies for the other two.

Thanks for pointing, will fix it up

> > +       /* v_act */
> > +       ret = regmap_read(lt9611->regmap, 0x8282, &temp);
> > +       if (ret)
> > +               goto end;
> > +
> > +       v_act = temp << 8;
> > +       ret = regmap_read(lt9611->regmap, 0x8283, &temp);
> > +       if (ret)
> > +               goto end;
> > +       v_act = v_act + temp;
> > +
> Having a helper for the above "result = read(x) << 8 | read(x+1)"
> would be great.
> This way one doesn't have to repeat the pattern 4-5 times.

will add

> > +static int lt9611_read_edid(struct lt9611 *lt9611)
> > +{
> > +       unsigned int temp;
> > +       int ret = 0;
> > +       int i, j;
> > +
> > +       memset(lt9611->edid_buf, 0, EDID_SEG_SIZE);
> How about:
>   memset(lt9611->edid_buf, 0, sizeof(lt9611->edid_buf));
> 
> Then again, do we need the memset()? We are allocating the memory with
> devm_kzalloc()

Yes but lt9611_read_edid() is called multiple times so would make sense
to memset it, will modify this to sizeof.

> > +
> > +       regmap_write(lt9611->regmap, 0x8503, 0xc9);
> > +
> > +       /* 0xA0 is EDID device address */
> > +       regmap_write(lt9611->regmap, 0x8504, 0xa0);
> > +       /* 0x00 is EDID offset address */
> > +       regmap_write(lt9611->regmap, 0x8505, 0x00);
> > +       /* length for read */
> > +       regmap_write(lt9611->regmap, 0x8506, 0x20);
> Is this the same 32 as seen in the loops below? #define and use consistently?

Sure will use defines here and other places

> > +       if (block > 1)
> > +               return -EINVAL;
> > +
> > +       if (block == 0) {
> > +               /* always read 2 edid blocks once */
> Please mention why that's a good idea. From memory - there aren't many
> other drivers that do this.

Okay will find the reason for this and 
> 
> > +               ret = lt9611_read_edid(lt9611);
> > +               if (ret) {
> > +                       dev_err(lt9611->dev, "edid read failed\n");
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       if (block % 2 == 0)
> > +               memcpy(buf, lt9611->edid_buf, len);
> > +       else
> > +               memcpy(buf, lt9611->edid_buf + 128, len);
> The above can be written as:
>    memcpy(buf, lt9611->edid_buf + (block * 128), len);

correct

> > +       /* Attach secondary DSI, if specified */
> > +       if (lt9611->dsi1_node) {
> > +               lt9611->dsi1 = lt9611_attach_dsi(lt9611, lt9611->dsi1_node);
> > +               if (IS_ERR(lt9611->dsi1)) {
> > +                       ret = PTR_ERR(lt9611->dsi1);
> > +                       goto err_unregister_dsi0;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +
> > +err_unregister_dsi0:
> Missing detach? If possible directly use lt9611_bridge_detach().

will update

> > +static int lt9611_read_device_rev(struct lt9611 *lt9611)
> > +{
> > +       unsigned int rev;
> > +       int ret;
> > +
> > +       regmap_write(lt9611->regmap, 0x80ee, 0x01);
> > +       ret = regmap_read(lt9611->regmap, 0x8002, &rev);
> > +       if (ret)
> > +               dev_err(lt9611->dev, "failed to read revision: %d\n", ret);
> > +
> The "failed" message will be followed by printing random kernel memory.
> Initialize rev to some dummy number or omit the dev_info.

Am printing the 'ret' error code here and not the uninitialized rev, so
I guess this one should be fine

> > +       ret = lt9611_parse_dt(&client->dev, lt9611);
> > +       if (ret) {
> > +               dev_err(dev, "failed to parse device tree\n");
> > +               return ret;
> > +       }
> > +
> > +       ret = lt9611_gpio_init(lt9611);
> > +       if (ret < 0)
> Missing of_node_put() here and for the next few error paths.

Yes this should be replaced by jump to of_node_put below

> > +static const struct of_device_id lt9611_match_table[] = {
> > +       {.compatible = "lontium,lt9611"},
> In the above two - add space after { and before }. Pretty sure

Correct, will fix this.

> ./scripts/checkpatch.pl will complain about those.
> Might want to double-check for other issues reported by said tool.

Somehow that was not the case :( I always run checkpatch.pl with
--strict option. I have 1 warn about 80 char limit for a error message
which I have ignored :)

-- 
~Vinod
