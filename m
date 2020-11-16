Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CBD2B43DA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgKPMi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgKPMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:38:57 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E600C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 04:38:57 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h2so23610970wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 04:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y4gJgxhJXaBwjjKLdJ8Rz0Qk77irsJngIufROA1uTAc=;
        b=Cb8BzTvxdplBo3lBRDHCDrjpXQkX4oeznmGodGJNRdqZG2qCxbkgf0eJyltEr70Z34
         QAGXJKEuejAlNiOYfA4dU0ylOZuVy9ueApg2Q5OD1jwH7BVThrmBOQCHTC21dwv3Ty1E
         Ro/dmV+D4uGdUmgjsT1pk30QfbU/k9gfmILEiWucPU1oEvZ5CwDgpiTOPcIosuoCrnzm
         lxc6NFE2CbwpnJLd5jSRwEIVHmNOfi96OdAp2zHX/235PzQPR6x2VIj3WLQtfYt0EJqD
         BOCGf1FKbhfwRkMpTajoCoof3xq861y9pj1a1/ou3ZNpCKmpFKrPKp8ad1E4nuZcMbVL
         t2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y4gJgxhJXaBwjjKLdJ8Rz0Qk77irsJngIufROA1uTAc=;
        b=czzTFqeUNf0X1d6RaU4h+f/p0aisaBQcVHK5RRdh+1Hd7MC7woFDp0k6uybWZizx0n
         CyCezNxr01Tknk0wzwU4Tx+wig1A8+G8eCWbhFCICS0ggVoDXhTL5afKMnLHLYlkwm/I
         +PnyxYNy5paxeS4g7/75NSqDMNK9dDv1Tx8MQDKjcH4eBwC3IjPT5qsdl8rGg422hNBJ
         BeYe/qdbHWenLHHhXKcd/N/5IBOa4KW/hR5wflvQ8lCdyR5IB4sDQRjbb6XfnP/x5V0x
         XXWe0b9dPIrdfNYI62uq/wzOwvgYgfoiepmjESUGhnWIRlhl6liICgKJnvFIN6qZ9stY
         3lcA==
X-Gm-Message-State: AOAM531aS4Mq5Fc3KPO/jbZnmKABnCHpy2PJkWV7o522m69tWl/kgfIG
        XzahgAX+tbM5dMxgK0AoHTywQUiZdeWYLeIa
X-Google-Smtp-Source: ABdhPJxlvYdt1QVpkINIC6VnjNHfccSDMmewPLbAiLKcdaD8vEmsj5J1ACt21tkWsat8TdfpktNkFA==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr15142362wmc.172.1605530335996;
        Mon, 16 Nov 2020 04:38:55 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id s188sm19971107wmf.45.2020.11.16.04.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 04:38:55 -0800 (PST)
Date:   Mon, 16 Nov 2020 12:38:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Maarten Brock <m.brock@vanmierlo.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 22/36] tty: serial: xilinx_uartps: Supply description for
 missing member 'cts_override'
Message-ID: <20201116123853.GP3718728@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-23-lee.jones@linaro.org>
 <230a462dd8d22fc8cd9dc6f4827edf04@vanmierlo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230a462dd8d22fc8cd9dc6f4827edf04@vanmierlo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020, Maarten Brock wrote:

> On 2020-11-04 20:35, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/tty/serial/xilinx_uartps.c:205: warning: Function parameter
> > or member 'cts_override' not described in 'cdns_uart'
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > Cc: linux-serial@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/tty/serial/xilinx_uartps.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/tty/serial/xilinx_uartps.c
> > b/drivers/tty/serial/xilinx_uartps.c
> > index a9b1ee27183a7..a14c5d9964739 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -192,6 +192,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
> >   * @baud:		Current baud rate
> >   * @clk_rate_change_nb:	Notifier block for clock changes
> >   * @quirks:		Flags for RXBS support.
> > + * @cts_override:	Modem control state override
> >   */
> >  struct cdns_uart {
> >  	struct uart_port	*port;
> 
> While you are at it, would you consider to also fix the indentation of the
> cts_override flag at line 208?

This set has already been merged sadly.

Please feel free to submit a patch of your own.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
