Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79D22E91C8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 09:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbhADIeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:34:03 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:39962 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbhADIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:34:03 -0500
Received: by mail-lf1-f48.google.com with SMTP id m12so62455727lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 00:33:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7F0NXeBBE9yzsU9XFVx+R85wt5xq0VZMqXDuSCoKlY=;
        b=Lw8eETBpbT0dv9UdYWEnTfwQ4nbztq4seB3L1KYrEhUFkIUr9RBwOh4cQmjtwSj9cJ
         MCHWWV6gJQEu6nMRobvnYcarq+5aH1Q9uU/Y1G9UjCW4DL0fb37k9xE174vzsZWqVN1P
         XDqiKwENGfKk9K2IP/v0iMHLK7AR/Dv+tHdPbNmciB4RQpGN1glm6ta8KhxmWZg3M4FJ
         ros87lH91xhVyE7vJ5n8Xk1EZALMVai+w/GcfjiTamLfbGpffUwXi4QhCimeGo1UR4TP
         fX4u4FrHavScyn+Ua9mhxZSf2bkFSz/W/V4XzNmqz1IwoF+1TG870LYGgse4u0BLdPAx
         dW9w==
X-Gm-Message-State: AOAM530R3OkN7sJiN6cghALCYr0srSaYpOSHVcifIaF8/o1W8bpsjhA3
        ckoAahJcOZEQBuMo5NGwG47aup+MquFGyg==
X-Google-Smtp-Source: ABdhPJwg8jvMGLOzS76q3ETvOhMP1qI+UmGpQYSarxIGf9WpKPdj/uG6D7FqYyYgWVMpfPYsEszeKg==
X-Received: by 2002:a19:2c4:: with SMTP id 187mr30221914lfc.391.1609749200634;
        Mon, 04 Jan 2021 00:33:20 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id e27sm8564242ljb.6.2021.01.04.00.33.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 00:33:20 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id m12so62455633lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 00:33:20 -0800 (PST)
X-Received: by 2002:a19:810:: with SMTP id 16mr34440045lfi.233.1609749199911;
 Mon, 04 Jan 2021 00:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20210103110635.34823-1-samuel@sholland.org>
In-Reply-To: <20210103110635.34823-1-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 4 Jan 2021 16:33:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v6704ybnn2mOs_hGZm_ZM2bRAztDNZNx8CyASMJ8Z4GdCA@mail.gmail.com>
Message-ID: <CAGb2v6704ybnn2mOs_hGZm_ZM2bRAztDNZNx8CyASMJ8Z4GdCA@mail.gmail.com>
Subject: Re: [PATCH 0/4] bus: sunxi-rsb: Implement power managment
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 3, 2021 at 7:06 PM Samuel Holland <samuel@sholland.org> wrote:
>
> This series adds system (complete power down) and runtime (clock gate)
> PM hooks to the RSB controller driver. Tested on A64 and H6.
>
> Samuel Holland (4):
>   bus: sunxi-rsb: Move OF match table
>   bus: sunxi-rsb: Split out controller init/exit functions
>   bus: sunxi-rsb: Implement suspend/resume/shutdown callbacks
>   bus: sunxi-rsb: Implement runtime power management
>
>  drivers/bus/sunxi-rsb.c | 211 ++++++++++++++++++++++++++++------------
>  1 file changed, 150 insertions(+), 61 deletions(-)

Looks good to me.

Acked-by: Chen-Yu Tsai <wens@csie.org>

I already queued them up locally, but I think it's best to give other
people some time to review as well.

ChenYu
