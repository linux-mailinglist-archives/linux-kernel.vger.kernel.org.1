Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E87228452C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 07:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgJFFEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 01:04:36 -0400
Received: from mr85p00im-zteg06021901.me.com ([17.58.23.194]:59154 "EHLO
        mr85p00im-zteg06021901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbgJFFEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 01:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1601960675; bh=4L/88aSfT3Jd2O4n4WIr/TVbRuwsPh3DIZiCIFm0yYw=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=p16OWtyvHvVI9CHN+i0x9UCwvDmwAMneJMRpaXZ66hZaXelmyyJMrDLoY+Ex3p4//
         +jx+s6ZdRapBy7MpuvafzQ93fESw3rGG7WTgysRE8DTkF+x5ZyanILkrwRTMB7NoF7
         lH7hE914Yg65iUCWkHEQzq2P8xPNEAbwpjbI6Jxh3507SY2uRz+gb0d0LcB2yzgvYi
         PR4qbtQRz36CgBxPagH1p8u9vRib6uncp1CoCFiKaUMDvuVJfZ/uAWUBkOH70qkosN
         mMOtaQsQEWo2lIYz0NMsdkELs2qldWRtXIbPK3Dq5tbJuWcEagq0TjQUpmwjgVjjeA
         rP2vHPSBXxcPg==
Received: from gnbcxl0029.gnb.st.com (101.220.150.77.rev.sfr.net [77.150.220.101])
        by mr85p00im-zteg06021901.me.com (Postfix) with ESMTPSA id 15B157209A0;
        Tue,  6 Oct 2020 05:04:31 +0000 (UTC)
Date:   Tue, 6 Oct 2020 07:04:28 +0200
From:   Alain Volmat <avolmat@me.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/2] arm: sti: LL_UART updates & STiH418 addition
Message-ID: <20201006050427.GA2996@gnbcxl0029.gnb.st.com>
Mail-Followup-To: Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20200830195748.30221-1-avolmat@me.com>
 <CACRpkdaMK8xkvGiSXx=kVjncB=BNy_jcvKsQNTCxRwSKGKJ8Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaMK8xkvGiSXx=kVjncB=BNy_jcvKsQNTCxRwSKGKJ8Lg@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-06_01:2020-10-05,2020-10-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=992 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2010060029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell, 

Could you have a look a those two patches for the STi platform ?

Regards,
Alain

On Sat, Sep 12, 2020 at 12:13:59PM +0200, Linus Walleij wrote:
> On Sun, Aug 30, 2020 at 9:58 PM Alain Volmat <avolmat@me.com> wrote:
> 
> > This serie update the STi Platform LL_UART code to rely on
> > DEBUG_UART_PHYS & DEBUG_UART_VIRT and add the STiH418 SoC support.
> >
> > Alain Volmat (2):
> >   arm: use DEBUG_UART_PHYS and DEBUG_UART_VIRT for sti LL_UART
> >   arm: sti LL_UART: add STiH418 SBC UART0 support
> 
> Both patches looks good to me:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I made some patches to the debug UARTs that are pending in Russell's
> patch tracker:
> https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9004/1
> https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9005/1
> https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9006/1
> 
> It doesn't look like these will conflict with your patches but please take
> a look just to make sure.
> 
> Yours,
> Linus Walleij
