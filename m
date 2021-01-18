Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38C72F99DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbhARG05 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Jan 2021 01:26:57 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:36301 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbhARG0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:26:39 -0500
Received: by mail-lf1-f46.google.com with SMTP id o13so22444664lfr.3;
        Sun, 17 Jan 2021 22:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3nptW95ygLFIn5TLK3XfM+T3+opmLi9dGoD+h9cW+MI=;
        b=lo+YNi+Rp33NuFOYUPQ64MLwInk0EzgG4X7CWXZkLbD9gtWi3nyjFfbw8R8EqLeYSV
         WwKSC5Nz3qeGxaWZ96AhoraIW2GBZQZd+hJYdkJ7KSsLZu10mMepPCw1TAlM/SHa3AiF
         0QVBVYGVPaX16ArFOKwcZJuCTpaMpDcXvM8VSbNpupDIfRu5ngtXj7dpe6BZyIrAmPXJ
         iQ20HfUTiyO4OJ1ezfGs94EsoyKux1K5EdU8XAKnSLoznliiydcKodZzg5+0rv+G56y8
         JrAsXrNoxCASOXRF+wG//L/Lfvgw2Yj4ssDWRVn0XQcVOnBLQ2xFvg5BjAKfahlYuBrz
         Nk7g==
X-Gm-Message-State: AOAM5306nyrE/0j5Vg1vYvrcM+a7ivbYY7CNwyPs3CQ0y4xtwVAYFgpm
        UwekOD8928k5J2lNw/geDtK9BWPk0WvgGg==
X-Google-Smtp-Source: ABdhPJyXcLzygkB/8MlE7UAKk0uG9gZ28iw7TLkXJEqsLT5x1wclWrjvdUQoN9I6d/EYXXi/WZpZUA==
X-Received: by 2002:a05:6512:466:: with SMTP id x6mr10946870lfd.257.1610951155001;
        Sun, 17 Jan 2021 22:25:55 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id l84sm1779588lfd.75.2021.01.17.22.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jan 2021 22:25:54 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id v67so22425293lfa.0;
        Sun, 17 Jan 2021 22:25:54 -0800 (PST)
X-Received: by 2002:a19:810:: with SMTP id 16mr11002147lfi.233.1610951154213;
 Sun, 17 Jan 2021 22:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20201218195033.2301127-1-contact@paulk.fr> <3035881.9zrMQt1rZd@jernej-laptop>
 <CAGb2v64xtm5wBuL6bkAYYFK2irjxs58df_xeHws6vaG_QDux+g@mail.gmail.com>
In-Reply-To: <CAGb2v64xtm5wBuL6bkAYYFK2irjxs58df_xeHws6vaG_QDux+g@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 18 Jan 2021 14:25:42 +0800
X-Gmail-Original-Message-ID: <CAGb2v67HY=EFX6-5NmXz0+02FOZkAa1r+AUy9QGeTEZBOcdJMw@mail.gmail.com>
Message-ID: <CAGb2v67HY=EFX6-5NmXz0+02FOZkAa1r+AUy9QGeTEZBOcdJMw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i-v3s: Add CSI0 MCLK pin definition
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 11:29 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Dec 22, 2020 at 4:17 PM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
> >
> > Hi!
> >
> > Dne petek, 18. december 2020 ob 20:50:33 CET je Paul Kocialkowski napisal(a):
> > > This adds a device-tree definition for the CSI0 MCLK pin,
> > > which can be used for feeding MIPI CSI-2 sensors.
> > >
> > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> >
> > Is this used anywhere? Current policy is to add pin definitions only if any
> > user exists.
>
> IIRC we sort of loosened that requirement with the use of /omit-if-no-ref/.
> The A20 dtsi file has a whole bunch of pins defined that are not directly
> used but are available for users to reference, especially in overlays.
> The "-@" parameter for the device tree compiler, used to build overlay
> compatible DTBs, makes the compiler ignore /omit-if-no-ref/ and include
> all the nodes.

I've queued up this patch for 5.12.

ChenYu
