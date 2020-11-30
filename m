Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD312C8509
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgK3NXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgK3NXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:23:31 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC86C0613D2;
        Mon, 30 Nov 2020 05:22:51 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id v14so21609753lfo.3;
        Mon, 30 Nov 2020 05:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Udf4EL7k79IQTzHQv/izcaa4PNNrQbAoqpJGLzAXG/M=;
        b=icinteIM4YPB7xRZSAsL/hXHkGgZYEblrhSh/Z6HY6dbMFdYiM4qAjmt+M/WPghk5F
         KGhoe1vaxwuT5GMzMr5j0CoUHhcx++IzkIcB/hCjWldXRJkvBmecCuLqPiFUMSaxF6g2
         D9hj9fA9PlM4ug7pUSZeCHISKFvq2Ei4w0TEdPUOcPeCn9v09T6Gw1n0C018o5ww8OHY
         /h3KYyZhzQIyHVwAHk8ZDfsmjMZ23FJn3aEVhM55raxjFQSpcHdYi3kXy+1BZg+uE3GN
         Uc/WmDwUhQFPP5B1Ur2LjTcNC634cmBrk/Eyrc/sFpcLCPqcVH+sFrZzCwgRLRtM6xMe
         l+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Udf4EL7k79IQTzHQv/izcaa4PNNrQbAoqpJGLzAXG/M=;
        b=RPDhl6XL+IQPsp8GC/IdMGqACyPaO47h9h+U7LpqZv6lVjOLOkV6Nzz+mf0vCqHoxY
         HiLy/LTer8weQ63/08UWefIig1ZymhpJ+SXCGJGKH9q07StTPR8zRJYVsfJGSCwDEq33
         nk+HtknwqYPOzvkLFU+lVSF8gCkWb96PwoKC+Ld4mxLLKaj8Q3MAa4OPCSbe+d5/6gVd
         rQZ3J1hHl4hJUE5c6pYdcqtM7bN+9gLiuGjwyIzXIoiYVflb91lzuTtwaRWmbTXuXsr6
         ZFu9C9R7L11121lhvW8WDP+ka63lFzRkuCdDQ3JRNKzv2EMP02DPYOv7VkaAXXG+/j/D
         UV+A==
X-Gm-Message-State: AOAM530s4GAZYuuRTu8ilMbwTLIJpEG1yxBhDVVhDc4bRimaQe9EbUDl
        GM6L0jGg67SPiymMjnyTlmXUvMoF7O12mJ6SjY4=
X-Google-Smtp-Source: ABdhPJxSJNmEg+DsZXDfJdG9Djvx2jKaHfDAVxIsDTzWbOF0I9lFsVrpiy8SwFysszJkMOQZa5dGNMHhZEDyeddnodQ=
X-Received: by 2002:a19:8686:: with SMTP id i128mr9292847lfd.333.1606742569638;
 Mon, 30 Nov 2020 05:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20201130131406.10925-1-o.rempel@pengutronix.de> <20201130131406.10925-2-o.rempel@pengutronix.de>
In-Reply-To: <20201130131406.10925-2-o.rempel@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 30 Nov 2020 10:22:38 -0300
Message-ID: <CAOMZO5DM8aToy_PRrY2cW5zbZf0xjfN9H4PrYTy+9Mq0NRii7w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ARM: dts: add Protonic MVT board
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

On Mon, Nov 30, 2020 at 10:14 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> +&ecspi1 {
> +       cs-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;

Shouldn't this be GPIO_ACTIVE_LOW instead?
