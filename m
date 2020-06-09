Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8F71F428D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgFIRkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 13:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728603AbgFIRkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:40:23 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E91A207ED;
        Tue,  9 Jun 2020 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724423;
        bh=w7KpdQejkKvQFJ3gl5VbHATOZZ4/I7zkecz/lkMl5ic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YYnoAgvghsQKMfB8A5ha44IibF0Ht/eT28Qm+BBUw5W6U/3V68wvenHYLDlPY9ypT
         QAgTRulQ/kvEaRZy3TbotNUCPHd/swzxRVCKgqQZOFMI+dPDiqlC36OSOYLV5X0X8I
         3+w0+4RjT86Tg018zcvheI0KP+AevrgQ+kg8zDQc=
Received: by mail-ot1-f52.google.com with SMTP id t6so8063056otk.9;
        Tue, 09 Jun 2020 10:40:23 -0700 (PDT)
X-Gm-Message-State: AOAM532kNRAFrTPbiyIJFdQBbkBUG+D9488mYSCnfFMO+NotQ0b/kwmq
        eFn3muoz1acvlgIq+O8F0/mNSf5gLe/ooP8F7Q==
X-Google-Smtp-Source: ABdhPJwimPI5Smkek0oUYxzIjvdaqI9A++Y6WSxijtb8L3lHTu4dOfY2YwSzEUK+7YPDljPv/Ey588Be+RFNrvFTerM=
X-Received: by 2002:a05:6830:549:: with SMTP id l9mr22951532otb.129.1591724422941;
 Tue, 09 Jun 2020 10:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200605065258.567858-1-lkundrak@v3.sk>
In-Reply-To: <20200605065258.567858-1-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Jun 2020 11:40:11 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Tpwu3BxNunAEWZeXcWo7-5bz-PetezkrHqweD60rMgw@mail.gmail.com>
Message-ID: <CAL_Jsq+Tpwu3BxNunAEWZeXcWo7-5bz-PetezkrHqweD60rMgw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: Add a missing include to MMP Audio
 Clock binding
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 12:53 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The include file for input clock in the example was missing, breaking the
> validation.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reported-by: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml      | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
