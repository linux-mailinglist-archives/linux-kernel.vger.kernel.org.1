Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2F270723
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgIRUfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:35:52 -0400
Received: from mr85p00im-ztdg06011901.me.com ([17.58.23.198]:41216 "EHLO
        mr85p00im-ztdg06011901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbgIRUfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:35:52 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 16:35:52 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1600460922; bh=T8v6m++2luK52rVt8w2SXku9CeV+sPMKImP6eAvxKTg=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=tWsN7Q8QhjnfkQPA43Pd2eCPIyh4EilOSt27A9IQ9mo273Raic4mbOR3FOasFp3l/
         UdPCw9Yt54M9DBYWhvawR1wre3DLcvjo5Q1sGE96/gYBgQulajnAzYU6w7yzoVlrXH
         7sS00zGIvv3bEHSWo5v1iST9obKYbS3qWdUOBlviOUiCO/rK0HN7dUqSsvM8L+sonQ
         TvYzXd9YHEbnscnohIe15dpARALgCb/oDIpDM9I5pdc9y3dCDiqeUJfjaxMsHUHiK5
         Tp7IDEoVPCaxpFIfgv4KEJcz2wScWeOJcEP3rlfaeC9VzmfPuPBxqi9b+uBtliBPzP
         GyAC+8xIZ2h5g==
Received: from gnbcxl0029.gnb.st.com (101.220.150.77.rev.sfr.net [77.150.220.101])
        by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 3F99DA60AAA;
        Fri, 18 Sep 2020 20:28:39 +0000 (UTC)
Date:   Fri, 18 Sep 2020 22:28:35 +0200
From:   Alain Volmat <avolmat@me.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
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
        Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [PATCH v2 0/2] arm: sti: LL_UART updates & STiH418 addition
Message-ID: <20200918202834.GA7621@gnbcxl0029.gnb.st.com>
Mail-Followup-To: Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
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
        Patrice CHOTARD <patrice.chotard@st.com>
References: <20200830195748.30221-1-avolmat@me.com>
 <CACRpkdaMK8xkvGiSXx=kVjncB=BNy_jcvKsQNTCxRwSKGKJ8Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaMK8xkvGiSXx=kVjncB=BNy_jcvKsQNTCxRwSKGKJ8Lg@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_17:2020-09-16,2020-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2009180165
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

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

I confirm that they do not conflict with my two patches.

Alain

> 
> Yours,
> Linus Walleij
