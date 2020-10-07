Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5FF285E09
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgJGLWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGLWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:22:54 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC879C061755;
        Wed,  7 Oct 2020 04:22:53 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id w5so880783qvn.12;
        Wed, 07 Oct 2020 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDZ7366PYXV+EES+h1SP5kqwgNb+8wXHAp/x+TfkHHQ=;
        b=V4ewLRuSp54/Es30G+9lHydPGsIBHA/iBPNIIFC6wqeHjmE+cKVoD2hVaFWbdOjWLk
         ArfNdh0xsJdlKSi8t+YbszArS+osss156prcP2g6lNyME0srRiGPuyE2+ytEXTRrAlLq
         hMWDB7UsNJMXpmaNx5oGxvmksdmRwpWkv65Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDZ7366PYXV+EES+h1SP5kqwgNb+8wXHAp/x+TfkHHQ=;
        b=cS7fI1DqYl+j2oJTHNnY6leXaaBTpx//K3JLfyZlrQt4sSD1eOWoS0gR9QoprgdTfe
         5C98gZbZqzF9j0Ysmp9NzqBMxoUQ0d4b6wPqu+HlWyAd7MxsPU3KB7fv9BtLxeppYwmB
         h4cfnrs8Fq6lTuOW9OPwikfspds5Z2394bsHl6FZcxD7o/p7X8hpbOM5GQmLvvoWTqkG
         KaYojDPjGmTbEPXeqVjk7816aD5wBaWgGWgLdRQIwlF6mziG2OM8+Uvzawz/v+5fEfj7
         yZZkyURqXfxku5NJoThXLihIfSEmdbkEtqecoSUX8HmKsz5bKe1PNzmLQrgycUwwAWMo
         Ufcg==
X-Gm-Message-State: AOAM532tL96RzI7nR47417do4FIFpGAGEsDq2eRAJUp8hFbHojAsePRY
        vubQF6J8//NTueliIZR2ghcTuT7NyQE96COCpOQ=
X-Google-Smtp-Source: ABdhPJzKVQdBmFZCKKWSEm97o3B7rUKLuxjDE9PQwX6qhes4HRH5nA7bRHEpXLl2xuSjOCJ4fc5lYvanqO7avGGYxDI=
X-Received: by 2002:a05:6214:11e4:: with SMTP id e4mr2447677qvu.61.1602069773219;
 Wed, 07 Oct 2020 04:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200930040823.26065-1-ryan_chen@aspeedtech.com> <20200930040823.26065-2-ryan_chen@aspeedtech.com>
In-Reply-To: <20200930040823.26065-2-ryan_chen@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 7 Oct 2020 11:22:41 +0000
Message-ID: <CACPK8XfBQgFk8oCaN_YAoKrvmV7QaOTFrHCWcjpEQv3bbjm70w@mail.gmail.com>
Subject: Re: [PATCH 1/3] configs: aspeed: enable UHCI driver in defconfig
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, bmc-sw@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 at 04:08, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> Enable UHCI driver in aspeed_g5_defconfig.
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Joel Stanley <Joel@jms.id.au>

> ---
>  arch/arm/configs/aspeed_g5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
> index 2bacd8c90f4b..a57009d1a3b8 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -212,6 +212,7 @@ CONFIG_USB_DYNAMIC_MINORS=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_ROOT_HUB_TT=y
>  CONFIG_USB_EHCI_HCD_PLATFORM=y
> +CONFIG_USB_UHCI_HCD=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_ASPEED_VHUB=y
>  CONFIG_USB_CONFIGFS=y
> --
> 2.17.1
>
