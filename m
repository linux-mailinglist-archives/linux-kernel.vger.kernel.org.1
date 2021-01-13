Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D9B2F46E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbhAMIw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:52:26 -0500
Received: from mail-vs1-f54.google.com ([209.85.217.54]:40789 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbhAMIwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:52:25 -0500
Received: by mail-vs1-f54.google.com with SMTP id x4so703048vsp.7;
        Wed, 13 Jan 2021 00:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxOjpIvjq4FtUsKB+JjsIoReLosXdu7ZabiRjS0D6o0=;
        b=pyNcZ1HInMfkRzTSDD9i0iWP2d+dRUzUNDf3Qz6Kk4bXF5BizcFxGVM6HWB2QIGtL0
         psl6ZqIx6j98ynsOUJk2O5+8N9jMiT2DozIQ5gBblxCKa7+d+2Vg+GGI6LB4CLicb//8
         H4pbKEOUNU+cth6ODPRaw3E7MiHW/cLrJ1Er0SLXEsb/30ttrDAF2eT8F9f3Ua4G+KtQ
         dVLi5/28VnKVJ+MdA1lLY6KLvw8xpda5cy9G/wsLF9SqDicMLnb9LuWb3nLNp6y7iXB9
         HlCpSS1lENBdbvCTThnaAiNg0vLZOI3n5medNgovROOGy++F084XgmKfWgyazb1jd7ht
         4M4w==
X-Gm-Message-State: AOAM531fgcLShfd6mSm7v0qp7uKCvuPpKjNXAt6DXiRnzXeQbcSjPzMO
        oWorcqfzuoaMySNpUbo/Za4nOpO7G+qOsA==
X-Google-Smtp-Source: ABdhPJxW/KsR7OidRJNRnmYK5ufYsvuP6yMuvcfWq9U7pgK47+e9qtM8i3jwl20xMUngE+UKzY75tw==
X-Received: by 2002:a67:d898:: with SMTP id f24mr1052008vsj.19.1610527903785;
        Wed, 13 Jan 2021 00:51:43 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id q23sm161744vsm.27.2021.01.13.00.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 00:51:43 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id t16so332658vkl.10;
        Wed, 13 Jan 2021 00:51:42 -0800 (PST)
X-Received: by 2002:a1f:2f81:: with SMTP id v123mr1054394vkv.24.1610527902050;
 Wed, 13 Jan 2021 00:51:42 -0800 (PST)
MIME-Version: 1.0
References: <20210110211606.3733056-1-jernej.skrabec@siol.net>
In-Reply-To: <20210110211606.3733056-1-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 13 Jan 2021 16:51:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v66NCu_GY9Yp=xBt=T6MLEjc81MFKmBSKj550OUaHYk9pA@mail.gmail.com>
Message-ID: <CAGb2v66NCu_GY9Yp=xBt=T6MLEjc81MFKmBSKj550OUaHYk9pA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] arm64: dts: allwinner: h6: PineH64 model B:
 Add bluetooth
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 5:16 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> PineH64 model B has wifi+bt combo module. Wifi is already supported, so
> lets add also bluetooth node.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Looks good to me, though I couldn't find anything on the polarity
of the interrupt lines.

ChenYu
