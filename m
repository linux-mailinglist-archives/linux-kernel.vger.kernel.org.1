Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9272E77D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 11:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgL3Kms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 05:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgL3Kms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 05:42:48 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E39FC061799;
        Wed, 30 Dec 2020 02:42:07 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4D5SXC6rt2zQlLf;
        Wed, 30 Dec 2020 11:42:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1609324922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GhCJqzZ4lN0GQe8W9Z/liMJaPpZnNuUptD9YKV8yuyI=;
        b=pZ5GyclaYat0BeFmQzOIB5zDVKGHkG7edtAsA+RlDQQkJlC92zyNCuViIOXFcoZByzvadw
        ZdIfsQPtwsGJeW3fFDIv/nHpvzDqQS1LhuY9bM4CyeS2J8cdkneDQ0EFHu2UbkrYZBmkFw
        wcxqWAdgws7x+r6i4k8lTkOwnGrH4SudIwZ+xN7ahDq4aaI+XAiwOFJp4GTib7ZQnRt4iA
        pyBQZQ+qeuWKx7SW5lW5lmKZhirWQZWm5TKCZIIhy2+0Ui6QIzR5MepYrWUFlUkhYgnwB0
        KKX5zyqJtKX09Oej5BMEldmYIkoH+gVCipW+7i7joLz5O/G9LvWxh+V076spqw==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id LizqzpnvWkmn; Wed, 30 Dec 2020 11:41:57 +0100 (CET)
Message-ID: <6c27906cf7f67a4fc39f2d3898fb843005f1e4e6.camel@dylanvanassche.be>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: add 'pine64,
 pinephone' to the compatible list
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 30 Dec 2020 11:41:56 +0100
In-Reply-To: <CAGb2v67C+hQyqjrx9A9MiyjEQdeVv+9BgrzxcuiHwf2e8JTswg@mail.gmail.com>
References: <20201229154106.4867-1-me@dylanvanassche.be>
         <CAGb2v67C+hQyqjrx9A9MiyjEQdeVv+9BgrzxcuiHwf2e8JTswg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.72 / 15.00 / 15.00
X-Rspamd-Queue-Id: E7FA81859
X-Rspamd-UID: 722b92
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Good point!
I will send a new version of the patch soon.

Kind regards,
Dylan Van Assche

On Wed, 2020-12-30 at 17:38 +0800, Chen-Yu Tsai wrote:
> On Tue, Dec 29, 2020 at 11:42 PM Dylan Van Assche <
> me@dylanvanassche.be> wrote:
> > All revisions of the PinePhone share most of the hardware.
> > This patch makes it easier to detect PinePhone hardware without
> > having to check for each possible revision.
> 
> Sounds good.
> 
> > Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts | 2 +-
> >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts | 2 +-
> >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts | 2 +-
> 
> Please also update the DT binding file:
> 
>     Documentation/devicetree/bindings/arm/sunxi.yaml
> 
> ChenYu

