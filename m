Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0E71EA69C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 17:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgFAPOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 11:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgFAPOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:14:44 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247B7C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PIZ+lVLQagv2LzCpnL+lQMbd+eEgTlAiMx0920iCwH8=; b=nb3XuYt6KaS3K6JXq4mom4OUv
        A3TZiLSUAVxInYU6nTJGb47CBbnklOEMIiFr+NDU9Ywxd7l0yBkgbvoZv+38IXLERUzeeY5G1gW4q
        0m4tT5oOe+EX/3o0hk3XhPCw9QGjNy2C10NZ+mstc4kHKgw+y3mKHUqW17S3E4gxwY7wf0smuFY0V
        435MAU8Ebyy+9cyEiZnZWAiexKALkh1wJ3KJe+UjKbXRcbPoA3MXeKay55kExTNPJfYskmhvy8U51
        TKUl+WYkhcYkE7+n/ozNKZkwRq6y532LhTz8wx/GvrHTI18cuzGIWW7YWrlcE1tjr2Dw6jnCZaqBL
        qYakL7EXw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:48060)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jfm94-0000df-3d; Mon, 01 Jun 2020 16:14:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jfm91-0003QH-Sw; Mon, 01 Jun 2020 16:14:31 +0100
Date:   Mon, 1 Jun 2020 16:14:31 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 5/5] arm: kexec_file: load zImage or uImage, initrd and
 dtb
Message-ID: <20200601151431.GN1551@shell.armlinux.org.uk>
References: <20200601142754.26139-1-l.stelmach@samsung.com>
 <CGME20200601142811eucas1p1604c8e6ca06c09f1ec821ea5e1918c53@eucas1p1.samsung.com>
 <20200601142754.26139-6-l.stelmach@samsung.com>
 <20200601150745.GL1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601150745.GL1551@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 04:07:45PM +0100, Russell King - ARM Linux admin wrote:
> On Mon, Jun 01, 2020 at 04:27:54PM +0200, Łukasz Stelmach wrote:
> > diff --git a/arch/arm/kernel/kexec_zimage.c b/arch/arm/kernel/kexec_zimage.c
> > new file mode 100644
> > index 000000000000..d09795fc9072
> > --- /dev/null
> > +++ b/arch/arm/kernel/kexec_zimage.c
> > @@ -0,0 +1,199 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Kexec zImage loader
> > + *
> > + * Copyright (C) 2020 Samsung Electronics
> > + * Author: Łukasz Stelmach <l.stelmach@samsung.com>
> 
> Please credit me as part author of this - you have taken some of my
> code from the userspace kexec tool (such as the contents of
> find_extension_tag()) and copied it in here, so this is not all your
> own work.

It would also be a very good idea to indicate _where_ you copied some
of this code from.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
