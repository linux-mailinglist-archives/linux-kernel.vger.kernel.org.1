Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7387B22D1C2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 00:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGXWYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 18:24:33 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:45629 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGXWYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 18:24:32 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D4C37240003;
        Fri, 24 Jul 2020 22:24:30 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        ludovic.desroches@microchip.com, cristian.birsan@microchip.com,
        arnd@arndb.de, Razvan Stefanescu <razvan.stefanescu@microchip.com>
Subject: Re: [PATCH 1/3] ARM: configs: at91: sama5: add support for KSZ ethernet switches
Date:   Sat, 25 Jul 2020 00:24:30 +0200
Message-Id: <159562945733.1896936.16137235431438947426.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723162434.1983643-1-codrin.ciubotariu@microchip.com>
References: <20200723162434.1983643-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 19:24:32 +0300, Codrin Ciubotariu wrote:
> Enable DSA and KSZ9477 support as modules. Ethernet switches are used by
> the SAMA5D2-ICP board.

Applied, thanks!

[1/3] ARM: configs: at91: sama5: add support for KSZ ethernet switches
      commit: 6dadeab7d260eaa410649a48d8368e4d3237377d
[2/3] ARM: configs: at91: sama5: enable bridge and VLAN filtering
      commit: 33d8c87ef47f5303dca851f320611552bc84e32f
[3/3] ARM: configs: at91: sama5: enable CAN PLATFORM driver
      commit: c12b539787efff5b4fc5abac1debf3ea1901348e

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
