Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E655F2BFEC4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 04:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgKWDii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 22:38:38 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:41742 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgKWDih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 22:38:37 -0500
Received: by mail-vk1-f194.google.com with SMTP id v185so466064vkf.8;
        Sun, 22 Nov 2020 19:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMj4IG3WEYUucQKM+AjqBiLZYECt5AVgAzWiMHA5ug0=;
        b=t+ykFNrroFeV3URAH0UhYz4ia5mrgVKFfKGIRphkkbMzYJUZNDKIuzaUzVmYDaW0iZ
         9tdtOzsbLjU5t6TlYfNL6ZuCqkQuou9sQG7eL1x+CV+fnrQfKGBdDRMhRf6D4jDW1l81
         EhfxSbr5C9Gbz5NVMJ1oYfC5Htc9lxaQ2OAEfPNB99ZFETDybItD9iD8aj/3JrwKqs9w
         WF7g3uHbyNw43SZT+BfIYh3+1QWKGUrhsUHKWvv1UJJXYHjfVqxorIs7phIvIpJhmguA
         NBGjWi0rnnBhhIUtIRfjRu/Q+O5gxJNtBPGtTYj3rl14fojNPY8zM0wsmob+KSmJJC3j
         1qqg==
X-Gm-Message-State: AOAM532CyheDqU7r5g0PwMoXsegknD4aarTtKETkN6K+6KE4VkmPPtsA
        Xtg/Of/Eq1EDZzf1MO45s8wCw1657G7BVg==
X-Google-Smtp-Source: ABdhPJyRhUNQBYXhDiOj4f1f8dPK5dqU3+XxHjA45ec1YNie16vaOfEdpgvjiyvFDMNyVmi3NevtSg==
X-Received: by 2002:a1f:9d04:: with SMTP id g4mr19463046vke.10.1606102716074;
        Sun, 22 Nov 2020 19:38:36 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id r186sm1310828vkf.33.2020.11.22.19.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 19:38:35 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id i62so3655958vkb.7;
        Sun, 22 Nov 2020 19:38:35 -0800 (PST)
X-Received: by 2002:a1f:288a:: with SMTP id o132mr17167985vko.2.1606102715417;
 Sun, 22 Nov 2020 19:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20201122003841.1957034-1-icenowy@aosc.io> <20201122003841.1957034-2-icenowy@aosc.io>
In-Reply-To: <20201122003841.1957034-2-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 23 Nov 2020 11:38:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v64BLcoYAd2VvP-bak3keqXfDpg1BoNaO8TZXiHxHOhP4Q@mail.gmail.com>
Message-ID: <CAGb2v64BLcoYAd2VvP-bak3keqXfDpg1BoNaO8TZXiHxHOhP4Q@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 1/3] ARM: dts: sun8i: v3s: add EHCI/OHCI0
 device nodes
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 8:39 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> The USB PHY 0 on V3s SoC can also be routed to a pair of EHCI/OHCI
> controllers.
>
> Add the device nodes for the controllers.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Chen-Yu Tsai <wens@csie.org>
