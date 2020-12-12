Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D593A2D83ED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 03:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436635AbgLLCDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 21:03:03 -0500
Received: from gproxy5-pub.mail.unifiedlayer.com ([67.222.38.55]:48166 "EHLO
        gproxy5-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728615AbgLLCCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 21:02:32 -0500
Received: from cmgw10.unifiedlayer.com (unknown [10.9.0.10])
        by gproxy5.mail.unifiedlayer.com (Postfix) with ESMTP id 980A314049A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 19:01:48 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id nuEGkDWoSDlydnuEGkz02b; Fri, 11 Dec 2020 19:01:48 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=W/gWqyek c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=8nJEP1OIZ-IA:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=Lf4RsGNfElH3hGyD6IsA:9
 a=wPNLvfGTeEIA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v2GlEnwZ2lMQQmJFu00QuOncDx1u1mAUso5Oa34QuZU=; b=KLqPcpaH3UnI+D8fC0ZFo84VuS
        up6XUX68/lnmn6dBnqbOnoVPO/BnNqMODThi3eWPh0Ja1fyc7JTMKKzsviZPjAbwpmQbhSQE/DaIM
        CUcxy5UXkm3tEX1I9fGHPOIwVlg8KxckWujocXkjgEZ898ZlgIHpU8goXQPi/9OD7Zcop5LFOhEN5
        jp6QRjwxrM3p95R2dybKKgf8PZbUYKkZUgEoUwuPuF1jQRw3zs3faqjcyO1gbsBDFd3AIJ6ophqoP
        vK1N145lp87E6pNnbvLA0M+IIl8aVWgZ2a2FCFT14D9vF7slfhRzZz0gzKFKaceDoNdybNhlLASy7
        L2OzUiqQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:45106 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1knuEF-000H1L-J9; Sat, 12 Dec 2020 02:01:47 +0000
Date:   Fri, 11 Dec 2020 18:01:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki " <rafael@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] driver core: platform: use bus_type functions
Message-ID: <20201212020146.GA27353@roeck-us.net>
References: <20201119124611.2573057-1-u.kleine-koenig@pengutronix.de>
 <20201119124611.2573057-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201119124611.2573057-3-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1knuEF-000H1L-J9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:45106
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 01:46:11PM +0100, Uwe Kleine-König wrote:
> This works towards the goal mentioned in 2006 in commit 594c8281f905
> ("[PATCH] Add bus_type probe, remove, shutdown methods.").
> 
> The functions are moved to where the other bus_type functions are
> defined and renamed to match the already established naming scheme.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Qemu test results:
	total: 426 pass: 91 fail: 335

This patch isn't responsible for all the crashes (-next is in pretty bad
shape), but for a good chunk of it.

Guenter

---
Bisect results for arbitrary arm64 test:

# bad: [3cc2bd440f2171f093b3a8480a4b54d8c270ed38] Add linux-next specific files for 20201211
# good: [0477e92881850d44910a7e94fc2c46f96faa131f] Linux 5.10-rc7
git bisect start 'HEAD' 'v5.10-rc7'
# good: [0a701401d4e29d9e73f0f3cc02179fc6c9191646] Merge remote-tracking branch 'crypto/master'
git bisect good 0a701401d4e29d9e73f0f3cc02179fc6c9191646
# good: [6fd39ad603b113e9c68180b9138084710c036e34] Merge remote-tracking branch 'spi/for-next'
git bisect good 6fd39ad603b113e9c68180b9138084710c036e34
# bad: [c96b2eec436e87b8c673213b203559bed9e551b9] Merge remote-tracking branch 'vfio/next'
git bisect bad c96b2eec436e87b8c673213b203559bed9e551b9
# good: [f99c2fbbff522300c309e517be1f5bed4bd34704] Merge remote-tracking branch 'kvm-arm/next'
git bisect good f99c2fbbff522300c309e517be1f5bed4bd34704
# bad: [0e3f63470c00704498be2bfac586076cfa93214f] Merge remote-tracking branch 'usb-chipidea-next/for-usb-next'
git bisect bad 0e3f63470c00704498be2bfac586076cfa93214f
# bad: [903821bc4404ae12d4e50e95fb5c2d7b46f4d1c6] Merge remote-tracking branch 'driver-core/driver-core-next'
git bisect bad 903821bc4404ae12d4e50e95fb5c2d7b46f4d1c6
# good: [0cd3f561efa9adce840140720e0581355db3e554] platform/x86: ISST: Mark mmio_range_devid_0 and mmio_range_devid_1 with static keyword
git bisect good 0cd3f561efa9adce840140720e0581355db3e554
# good: [bd7cf676c3ed2fc91e777d91c3bf9220e84da2ad] Merge remote-tracking branch 'chrome-platform/for-next'
git bisect good bd7cf676c3ed2fc91e777d91c3bf9220e84da2ad
# good: [d475f8ea98a039e51d27f5557dc17333cf8a52f6] driver core: Fix a couple of typos
git bisect good d475f8ea98a039e51d27f5557dc17333cf8a52f6
# good: [16c1af8b52ea282b098c9b7506f3f4d0d3953260] Merge remote-tracking branch 'leds/for-next'
git bisect good 16c1af8b52ea282b098c9b7506f3f4d0d3953260
# bad: [feaba5932b6f4bfc875c874a3b7a28c7f05f5a77] vfio: platform: Switch to use platform_get_mem_or_io()
git bisect bad feaba5932b6f4bfc875c874a3b7a28c7f05f5a77
# bad: [9c30921fe7994907e0b3e0637b2c8c0fc4b5171f] driver core: platform: use bus_type functions
git bisect bad 9c30921fe7994907e0b3e0637b2c8c0fc4b5171f
# good: [e21d740a3fe5ad2db7b5f5c2331fe2b713b1edba] driver core: platform: reorder functions
git bisect good e21d740a3fe5ad2db7b5f5c2331fe2b713b1edba
# good: [16085668eacdc56c46652d0f3bfef81ecace57de] driver core: platform: change logic implementing platform_driver_probe
git bisect good 16085668eacdc56c46652d0f3bfef81ecace57de
# first bad commit: [9c30921fe7994907e0b3e0637b2c8c0fc4b5171f] driver core: platform: use bus_type functions
