Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D342C6936
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbgK0QOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgK0QOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:14:12 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAE5222242
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606493652;
        bh=Q1z+ajOqm3HB4ADX19Y79J4UyekHjRG2hxKzs5R3f0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lW8ECdSyjdOqAg/7n0HzaPlxWHZsQat/lxnvN6LL/iJ16GWvoy6Rtn/hlJS2dVAzg
         7NJouQiwdqG9NcmEUw7Ata1CWvBivlC+dxPCoIXgQS/QIHAL7R48+jy6X6tRepM0fg
         drBuMgrhaXyp9SME2NW6nEPoevBVWM7wbG755fOs=
Received: by mail-ej1-f49.google.com with SMTP id o9so8349941ejg.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:14:11 -0800 (PST)
X-Gm-Message-State: AOAM5308OazNOH8NHdL0EoJ3V1m1BtPXtvJTbMocabxpYuNvbYOoKx+U
        o1mlBMSYewKTJmjiHw9MUIKUmGVhWWmN1p+3XZQ=
X-Google-Smtp-Source: ABdhPJzU5L0g9Brv0yY+r1LZEDcFhx2z4zJN89QQhRHAZP09H7g0gJFJcs2IE1rl3RovnFHTm5yaW4zc0SpXv0BVQ5Q=
X-Received: by 2002:a17:906:9588:: with SMTP id r8mr7191286ejx.148.1606493650262;
 Fri, 27 Nov 2020 08:14:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606486893.git.agx@sigxcpu.org> <9e6572819789805df2acd31a06004db788127d55.1606486893.git.agx@sigxcpu.org>
In-Reply-To: <9e6572819789805df2acd31a06004db788127d55.1606486893.git.agx@sigxcpu.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 27 Nov 2020 17:13:58 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdEwiSTg+cMes_wes5oz2F1qEexsus6iHenuLs9SAXk6g@mail.gmail.com>
Message-ID: <CAJKOXPdEwiSTg+cMes_wes5oz2F1qEexsus6iHenuLs9SAXk6g@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] arm64: defconfig: Enable CONFIG_VCNL4000
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020 at 15:23, Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> This is the Librem 5's proximity sensor.

Just squash all of them. Enabling option by option is too much.

Best regards,
Krzysztof
