Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7136725705B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 22:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgH3UDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 16:03:44 -0400
Received: from st43p00im-ztfb10063301.me.com ([17.58.63.179]:51503 "EHLO
        st43p00im-ztfb10063301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbgH3UDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:03:42 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Aug 2020 16:03:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1598817502; bh=KqNm/0mh1bsH8v3Lu3UEk+dlYQBUL1DqCp4JKr8rfM4=;
        h=From:To:Subject:Date:Message-Id;
        b=ynRGxZSOHZx3K8ntAFUaL+WtqoFTGv8aN2yrZ2D/PcXg5NrQ9GK/KRofJfnnSU8jT
         mzLRYjsFgI3zs28OGYfedMxExcUghiX1LJs5Yynhn86zNnqmwnFFhXJJjAwbKZwXxt
         RL3fBg9udcKQGW9k9ILKkNuVOnYglOrf6cRHftG5ymrcp/pxHCi5MFUhLMh42xA8vR
         7OFTL1krFIE5Qb0tReeK7uoS68g63jKe4PvGWB9Lt4brP1+Z3BC43GnjyXGAzsP4x8
         Tm+F3m1A1HINC6Ay6AmdQ+ggivbp2U24BmqjXGkpej45TMNEgv2QTI7onhYpeeertI
         iH0mnGUqLpAmg==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztfb10063301.me.com (Postfix) with ESMTPSA id 89FFCA401F5;
        Sun, 30 Aug 2020 19:58:21 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     patrice.chotard@st.com, avolmat@me.com
Subject: [PATCH v2 0/2] arm: sti: LL_UART updates & STiH418 addition
Date:   Sun, 30 Aug 2020 21:57:46 +0200
Message-Id: <20200830195748.30221-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-30_07:2020-08-28,2020-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=756 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2008300163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie update the STi Platform LL_UART code to rely on
DEBUG_UART_PHYS & DEBUG_UART_VIRT and add the STiH418 SoC support.

Alain Volmat (2):
  arm: use DEBUG_UART_PHYS and DEBUG_UART_VIRT for sti LL_UART
  arm: sti LL_UART: add STiH418 SBC UART0 support

 arch/arm/Kconfig.debug       | 38 +++++++++++++++++++++++++-----------
 arch/arm/include/debug/sti.S | 26 ++----------------------
 2 files changed, 29 insertions(+), 35 deletions(-)

v2: rebased on top of linux 5.9-rc2


