Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6B284E10
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgJFOfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:35:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35272 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFOfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:35:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0B6C4296252
Subject: Re: [PATCH] ARM: dts: cros-ec-keyboard: Add alternate keymap for
 KEY_LEFTMETA
To:     Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>
References: <20200925162604.2311841-1-swboyd@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <fba1a3ea-ddbb-d0cf-9ec5-b7c8832cb668@collabora.com>
Date:   Tue, 6 Oct 2020 16:35:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925162604.2311841-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 25/9/20 18:26, Stephen Boyd wrote:
> On newer keyboards this key is in a different place. Add both options to
> the keymap so that both new and old keyboards work.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Queued for 5.10.

Thanks,
 Enric

>  arch/arm/boot/dts/cros-ec-keyboard.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/cros-ec-keyboard.dtsi b/arch/arm/boot/dts/cros-ec-keyboard.dtsi
> index 4a0c1037fbc0..165c5bcd510e 100644
> --- a/arch/arm/boot/dts/cros-ec-keyboard.dtsi
> +++ b/arch/arm/boot/dts/cros-ec-keyboard.dtsi
> @@ -46,6 +46,7 @@ MATRIX_KEY(0x02, 0x08, KEY_LEFTBRACE)
>  			MATRIX_KEY(0x02, 0x09, KEY_F8)
>  			MATRIX_KEY(0x02, 0x0a, KEY_YEN)
>  
> +			MATRIX_KEY(0x03, 0x00, KEY_LEFTMETA)
>  			MATRIX_KEY(0x03, 0x01, KEY_GRAVE)
>  			MATRIX_KEY(0x03, 0x02, KEY_F2)
>  			MATRIX_KEY(0x03, 0x03, KEY_5)
> 
