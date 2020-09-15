Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB026A5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIOMzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgIOMpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:45:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DA1C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:45:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s12so3118233wrw.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prgbbLEwgblX++DIA6lSNe0xZAiKfHZki6I+StVAnLE=;
        b=Q1VROlQWfmlbZeeOVVji/0iVuQbrzHv3LyXlzJKB/jZyIl7jlwtq83iMQNIuBTtIDU
         mMJrv6XDPjLmOFIIlreqHabqlek6mVxO/yH3LCwl6pXubX3sxPWzQx+BTKkXXjULprxE
         a9hVqPQTocex/KOq6CV5LbnS1W7amLkZEXuFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prgbbLEwgblX++DIA6lSNe0xZAiKfHZki6I+StVAnLE=;
        b=kx+lQYoffjrKrVtfCHsZNFGy4JitPzIHMAKoMxtmeJsbmdXOBxIm7Pf8miEdymHLlw
         gRuILs67C9zd52UxCu1IVzCppCfrA+kIWI1g8ZdRM0dWgZxlJrkb48P/oebb++wpKY7q
         nKKmCtfzCVkXyXubZpj39RxIy9SdLtiLtuvN05bK8imA3Rm3dCxDoCpjx3wuitKzETfm
         jtoWBmx3wyfEOMs470jO3p5SRmV91RQ4AmPRJ7EElhC3zm7Lq5FM4GBXNqrQsCgjdJAK
         GszR8U96kPJdqn+t3WMGMjG7xr9P87Ps3GFkR81ui/M/mS4k5KuEztGvf5CZ1LjfwTj+
         7cqw==
X-Gm-Message-State: AOAM532piKs/H8WtCK6leFBc5uU1MqGQt7WMUwx50QBe0y4jWeqk3GqO
        /LmnY/LI4uGs57YetWBy7L4hv0MYTJE2qgc1htbBdA==
X-Google-Smtp-Source: ABdhPJywvAYnO/cUJA6n7jjsXdnAk2rhTKdrXd0MShhk2rxfYd1+ycLgavEuhL4DeOkvtc7FxftmCne4Gau4Rvcai7s=
X-Received: by 2002:a5d:510d:: with SMTP id s13mr21605335wrt.177.1600173908051;
 Tue, 15 Sep 2020 05:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200914080619.4178587-1-cychiang@chromium.org>
 <20200914080619.4178587-3-cychiang@chromium.org> <20200914174812.GA4125843@bogus>
In-Reply-To: <20200914174812.GA4125843@bogus>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 15 Sep 2020 20:44:37 +0800
Message-ID: <CAFv8NwLb4zKqc8BbRq5_B4PnGR+BAMZa2RpB0qjLez921j-diA@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] ASoC: qcom: dt-bindings: Add sc7180 machine bindings
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Dylan Reid <dgreid@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Patrick Lai <plai@codeaurora.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Srinivasa Rao <srivasam@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Doug Anderson <dianders@chromium.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Taniya Das <tdas@codeaurora.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 1:48 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 14 Sep 2020 16:06:18 +0800, Cheng-Yi Chiang wrote:
> > Add devicetree bindings documentation file for sc7180 sound card.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  .../bindings/sound/qcom,sc7180.yaml           | 130 ++++++++++++++++++
> >  1 file changed, 130 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> >
>
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.
>

Hi Rob,
There was a change between v9 and v10 on compatible string so I did
not add your Reviewed-by.
Now it is "qcom,sc7180-sndcard-rt5682-m98357-1mic" following Stephan's
comment in

https://patchwork.kernel.org/comment/23608881/

to make compatible string more specific to board configuration.
I only add the note to the cover letter. Sorry the cover letter became
too long to follow.
I will add the note in patch mail itself for future changes.
Thanks for taking a look again.
