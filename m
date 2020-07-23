Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2413B22B607
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 20:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGWSrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 14:47:51 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.172]:24568 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGWSru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1595530068;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ZBGeT5meaENGUkHBjaTnLB8Wyc3JbNoxdGt3rTZZJuE=;
        b=jIyJlWeC6htiBwmYGqOP3L/ZQy5QJxGPcPjCJ9yVLPmwCs32JQ8XQQpLCx+9mJBxgz
        aFVsQRPypuOA2ENtiuKNUgTT+nQmxjE77xNEXrb/am0QqYBXF+x386dzc/s/bEGSpqe/
        jTkNBWrN5484GastutkeIfu4kBoSiQZHBzA4I3oMivKUHbSm8fZFL3T4Ale78UeboToI
        6ZTw/WfMCaHclJwnORFE59QU0+Vk3EmKhifZ+3rCh6250FOD72e/98Mm7/0stpC8HZge
        kLUvJtoc5ka9mKMO5zFoiXzBmG4BI2m91RhLmGyBLNsrSEjh9hIQvQDxg5kXI2Y2z6Ev
        Az0g==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7IczHboo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id Y0939ew6NIif5J4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 23 Jul 2020 20:44:41 +0200 (CEST)
Date:   Thu, 23 Jul 2020 20:44:36 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Ajit Pandey <ajitp@codeaurora.org>
Subject: Re: [PATCH v2 2/2] ASoC: qcom: sc7180: Add machine driver for sound
 card registration
Message-ID: <20200723184432.GA321518@gerhold.net>
References: <20200721104422.369368-1-cychiang@chromium.org>
 <20200721104422.369368-3-cychiang@chromium.org>
 <ce029818-5082-643b-ff63-25aafea3de6c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce029818-5082-643b-ff63-25aafea3de6c@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 10:25:14AM +0100, Srinivas Kandagatla wrote:
> > +static int sc7180_parse_of(struct snd_soc_card *card)
> > +{
> 
> This code is getting duplicated in various places like apq8016_sbc_parse_of,
> it will be nice to common this up, if possible!
> 

FYI, I started work on making apq8016_sbc use qcom_snd_parse_of()
a while ago already, but didn't find the time to finish it up.
I have now sent it, this should make it possible to use the common
qcom_snd_parse_of() function in this driver as well.

See: https://lore.kernel.org/alsa-devel/20200723183904.321040-1-stephan@gerhold.net/

Stephan

