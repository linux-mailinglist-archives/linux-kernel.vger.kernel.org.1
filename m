Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E112F8D0C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 11:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbhAPKyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 05:54:04 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:44450 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbhAPKyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 05:54:03 -0500
Received: by mail-lf1-f48.google.com with SMTP id m25so16969237lfc.11;
        Sat, 16 Jan 2021 02:53:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Rl3nB1jw38+x2tTQIabyckKYI6mcf1Lq12uOBpi5+4=;
        b=tw+UlDVP/Y31we7r5wtVmNgvX7655RdmYi3EyMz2SAw8jWmvyskqFSQr8fKZtEqn6e
         RFOjfYw8gGzhlIfuEd+Cn4ZXAmGNnFGkYbXBD1aZ79Zd5jS8hpLiRLX5p+rXWZ9YI+Cb
         fRaZWfj4QNDmsy/n+U3N7fFWSKvWEMP++qTPalR63UuMgbG8vO88wk0m43MJLro3ogZV
         nVLIOEJEyKK6zZ70IOYSnLjkzCVGqzdBMEvUbPx5c/6/vJHDYLeLNK23XgVUOByPwYdQ
         jpErRAlwI6XmmZpbxJk71NVAH8Z3bd9Om0J9q9ELoLq+OEfIGvI8oa6D+GGHu8xj5hCh
         i6EA==
X-Gm-Message-State: AOAM5328bHzzLBuidIHbmPE51I/x2wvzlQR1ntDOYXYCGkpxaLmRTP0F
        c/ezYKvxfLeZmhmBs8wKlR1vNA0dOBn97Q==
X-Google-Smtp-Source: ABdhPJzRsOR+xX4btwseawk5sLo5BV9oh7qOJPtvKoIso9/UM/xnFQgQd9eGypwI1pUCGkWM0N6hXQ==
X-Received: by 2002:ac2:5338:: with SMTP id f24mr7120769lfh.337.1610794400866;
        Sat, 16 Jan 2021 02:53:20 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id y26sm1061764ljk.22.2021.01.16.02.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 02:53:20 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id f17so13078043ljg.12;
        Sat, 16 Jan 2021 02:53:20 -0800 (PST)
X-Received: by 2002:a2e:90d6:: with SMTP id o22mr6920600ljg.56.1610794400273;
 Sat, 16 Jan 2021 02:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20210116105228.847073-1-jernej.skrabec@siol.net>
In-Reply-To: <20210116105228.847073-1-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 16 Jan 2021 18:53:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v67r6G0i89LpbGFheEE2i7OzE3TcM91GLW0r_vNOQxJCHQ@mail.gmail.com>
Message-ID: <CAGb2v67r6G0i89LpbGFheEE2i7OzE3TcM91GLW0r_vNOQxJCHQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] ARM: dts: sunxi: bananapi-m2-plus: Increase
 BT UART speed
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

On Sat, Jan 16, 2021 at 6:52 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Bluetooth module on BananaPi M2 Plus can also be used for streaming
> audio. However, for that case higher UART speed is required.
>
> Add a max-speed property.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Chen-Yu Tsai <wens@csie.org>
