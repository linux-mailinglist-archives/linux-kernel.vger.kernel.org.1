Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF0B2EBD36
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 12:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbhAFLiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 06:38:19 -0500
Received: from tux.runtux.com ([176.9.82.136]:56784 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbhAFLiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 06:38:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id 2F1266EFD2;
        Wed,  6 Jan 2021 12:37:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m6fH7ffneFtG; Wed,  6 Jan 2021 12:37:31 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id 0205F6EF93;
        Wed,  6 Jan 2021 12:37:30 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 5BD1646C; Wed,  6 Jan 2021 12:37:30 +0100 (CET)
Date:   Wed, 6 Jan 2021 12:37:30 +0100
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH 0/1] auxdisplay: Add I2C gpio expander example
Message-ID: <20210106113730.k5qveshjgcd57kgx@runtux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hitachi HD44780 is often used together with a PCF8574 based I2C
I/O expander. It was non-obvious to me that the existing parallel
connected version of the auxdisplay driver can already handle this
configuration with appropriate device tree magic. This patch documents
the necessary incantations in an example.

That this is not only non-obvious to me is documented by at least two
I2C kernel implementations for the display out there.

Thanks to Geert Uytterhoeven for pointing out how this is done.
Thanks to Miguel Ojeda for extensively commenting on my previous patch.

 .../bindings/auxdisplay/hit,hd44780.yaml      | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

Ralf
-- 
Ralf Schlatterbeck                      Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com
