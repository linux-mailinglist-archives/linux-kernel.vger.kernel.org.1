Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1552C69EB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbgK0QnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:43:00 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:49046 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731747AbgK0Qm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:42:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id ED977FB02;
        Fri, 27 Nov 2020 17:42:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zmcUeqjlFrgO; Fri, 27 Nov 2020 17:42:54 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 88FF64068E; Fri, 27 Nov 2020 17:42:54 +0100 (CET)
Date:   Fri, 27 Nov 2020 17:42:54 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
Subject: Re: [PATCH v1 6/8] arm64: defconfig: Enable CONFIG_VCNL4000
Message-ID: <20201127164254.GA22652@bogon.m.sigxcpu.org>
References: <cover.1606486893.git.agx@sigxcpu.org>
 <9e6572819789805df2acd31a06004db788127d55.1606486893.git.agx@sigxcpu.org>
 <CAJKOXPdEwiSTg+cMes_wes5oz2F1qEexsus6iHenuLs9SAXk6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJKOXPdEwiSTg+cMes_wes5oz2F1qEexsus6iHenuLs9SAXk6g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
On Fri, Nov 27, 2020 at 05:13:58PM +0100, Krzysztof Kozlowski wrote:
> On Fri, 27 Nov 2020 at 15:23, Guido Günther <agx@sigxcpu.org> wrote:
> >
> > This is the Librem 5's proximity sensor.
> 
> Just squash all of them. Enabling option by option is too much.

Done for v2.
Cheers,
 -- Guido

> 
> Best regards,
> Krzysztof
> 
