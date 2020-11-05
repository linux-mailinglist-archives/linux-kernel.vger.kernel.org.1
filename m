Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFC22A745B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbgKEBFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKEBFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:05:02 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D367C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:05:02 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id v144so341563lfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 17:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfUDISWouGv8fBayDU8C+A1oMiIVxIMOtFz2zNKc8vA=;
        b=n91lOyRUYfd/ww3RPYIRbE9ys8A9V83N/AwRJjBH6CytjqeVsYZX3/jCDQwkYNyZ3j
         bGZpGCiHWJxpX/ZVO36R59Idj0Thk7Ux2VPTMSPDo80LZZ+rlPd+8OtK8CmvIGxthyjT
         CM3Z+14idzQkfDvShSFnK6bV6QDScIl4qt7PKa5giisJ9f7C/DGgrgeX41zxtSd57WDK
         870BdqOE2GSbOzC5ROYQ1qhyquFYnLel6Gm92aW0+Gaj0DKRBJQ88FeduvzQW6CDJ0Bm
         TdK5ZBqygQXM709ShTiuN+ZrNLlCCxgs+d2P364o9t1yclRSKpkEUjD99NbZLj/oF1oC
         nAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfUDISWouGv8fBayDU8C+A1oMiIVxIMOtFz2zNKc8vA=;
        b=LRS4/zBaYkWV4FDmsx5JwmIn1fgNL9r1S4NbK5r+9BR9byDmoDEYLh9cMiWmoNobi+
         GEtxu9MOrIXz4AJWnarTLzffI0qA/XXRWz9ACEbsXo4Zn3VLN7G+Nsuzk5HalS7ditta
         3tsXyuivp0ODOT80FXq/biNmBtcN6hJV6y3GbQfgJ0M82HcuFL0XogrBgmXBZCgSaMjI
         uTalkqO3UW7tUT7jCeId2voOuCzVtYNWVpGf1YWH/hFCgp6TqPaXJVKq3gzrCl+9EYSx
         E3WYVT7xGIjS2SrHJY8mXpUkXhOf+CMd0E7Pn8G33LgIFN3pf+OE9eZIO2ybJJ7cq+mS
         HYyw==
X-Gm-Message-State: AOAM533MRXP7ALxDlaIDhx1YRLmKfWsQiafgbSNRLXlpKxn/+P7ORjPt
        pcBpbGFTNp2tTCoMZQluIMJOdNpg3UDSgn6Y1MM=
X-Google-Smtp-Source: ABdhPJxFUJwpsHQTgAJb4JZa+500ipxiqT/jOGCpxu61aZctj8INRXLDx28Ns2ZN3MLYcVCb+gY3RZUlSyZtJ1bamY8=
X-Received: by 2002:ac2:50c1:: with SMTP id h1mr130197lfm.333.1604538300860;
 Wed, 04 Nov 2020 17:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20201104165418.4903-1-TheSven73@gmail.com>
In-Reply-To: <20201104165418.4903-1-TheSven73@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 4 Nov 2020 22:04:49 -0300
Message-ID: <CAOMZO5DvnjV8jPAGv8kOTPrXm8o1WiCA=LpOA8+D0=qMOc96=g@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: imx: mach-imx6q: correctly identify i.MX6QP SoCs
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 1:54 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> The i.MX6QP rev 1.1 SoC on my board is mis-identified by Linux:
> the log (incorrectly) shows "i.MX6Q rev 2.1".
>
> Correct this by assuming that every SoC that identifies as
> i.MX6Q with rev >= 2.0 is really an i.MX6QP.
>
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
