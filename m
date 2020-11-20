Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125A72BA7D2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgKTKyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:54:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33162 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgKTKyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:54:31 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 8FBA01F45E80
Subject: Re: [PATCH 2/2] drm/meson: dw-hdmi: Enable the iahb clock early
 enough
To:     Marc Zyngier <maz@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20201120094205.525228-1-maz@kernel.org>
 <20201120094205.525228-3-maz@kernel.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <966e90ba-5b38-9ba5-65b3-1a17dbd51871@collabora.com>
Date:   Fri, 20 Nov 2020 10:54:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201120094205.525228-3-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2020 09:42, Marc Zyngier wrote:
> Instead of moving meson_dw_hdmi_init() around which breaks existing
> platform, let's enable the clock meson_dw_hdmi_init() depends on.
> This means we don't have to worry about this clock being enabled or
> not, depending on the boot-loader features.
> 
> Fixes: b33340e33acd ("drm/meson: dw-hdmi: Ensure that clocks are enabled before touching the TOP registers")
> Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>

Although I am triaging kernelci bisections, it was initially
found thanks to our friendly bot.  So if you're OK with this, it
would most definitely appreciate a mention:

  Reported-by: "kernelci.org bot" <bot@kernelci.org>

Thanks,
Guillaume
