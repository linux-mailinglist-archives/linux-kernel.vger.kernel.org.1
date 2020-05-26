Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E5B1DA077
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 21:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgESTGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 15:06:43 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33060 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgESTGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:06:42 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jb7ZS-0005bQ-Mf; Tue, 19 May 2020 21:06:34 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, maxime.ripard@free-electrons.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpu: arm,mali-utgard: add additional properties
Date:   Tue, 19 May 2020 21:06:33 +0200
Message-ID: <1740173.3xtLDEJ6Vg@diego>
In-Reply-To: <20200519164425.9729-1-jbx6244@gmail.com>
References: <20200519164425.9729-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 19. Mai 2020, 18:44:25 CEST schrieb Johan Jonker:
> In the old txt situation we add/describe only properties that are used
> by the driver/hardware itself. With yaml it also filters things in a
> node that are used by other drivers like 'assigned-clocks' and
> 'assigned-clock-rates' for some older Rockchip SoCs in 'gpu' nodes,
> so add them to 'arm,mali-utgard.yaml'.

though the other option would be to just get rid assigned-clocks
in dt-node for utgard malis ;-)

Like any good gpu, lima should just use frequency scaling to achieve
suitable (fast <-> powersaving) frequencies and it looks like a set
of patches for this was posted in december already [0].

So I guess one could expect opp-based scaling to land at some point.

Heiko

[0] https://lwn.net/Articles/807444/


