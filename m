Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073C529FC12
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgJ3DI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:08:26 -0400
Received: from mail.v3.sk ([167.172.186.51]:41964 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbgJ3DIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:08:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 581A7DF6FB;
        Fri, 30 Oct 2020 03:05:53 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1VQQUa6AtEMT; Fri, 30 Oct 2020 03:05:52 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E3C18DF87E;
        Fri, 30 Oct 2020 03:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xtRULSH0Q7PE; Fri, 30 Oct 2020 03:05:51 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E90F6DF5E1;
        Fri, 30 Oct 2020 03:05:50 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: 
Date:   Fri, 30 Oct 2020 04:07:58 +0100
Message-Id: <20201030030800.1036888-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH v6 0/2] Add a Himax HX8837 display controller driver
Date: Sat, 26 Sep 2020 02:07:17 +0200
Message-ID: <20200926000719.229204-1-lkundrak@v3.sk> (raw)

Hi,

please take a look at the patches chained to this messages and consider
applying them. They add support for the controller that drives the panel
on the OLPC XO laptops.

Compared to v5, points risen in review by Sam Ravnborg have been
addressed. Details in change log of patch 2/2.

Tested on an OLPC XO-1.75 laptop.

Thank you
Lubo


