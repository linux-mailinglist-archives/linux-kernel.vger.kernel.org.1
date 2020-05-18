Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D419F1D7335
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 10:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgERIp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 04:45:56 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49957 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgERIpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:45:55 -0400
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 41C51C000C;
        Mon, 18 May 2020 08:45:53 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 0/2] TTY fix-ups for "TTY improve n_gsm support" series
Date:   Mon, 18 May 2020 10:45:11 +0200
Message-Id: <20200518084517.2173242-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jiri found issues or things to improve in the v2 of the series "TTY
improve n_gsm support". However it was already applied. So this series
implements the needed changes.

For the second patch, as the commit "tty: n_gsm: Fix waking up upper
tty layer when room available" was not yet in mainline, it has no
SHA-1 ID yet. That's why I reference the same commit that the one
fixed by "TTY improve n_gsm support", as they should be applied in the
same order in stable branch than in mainline.

Gregory


Gregory CLEMENT (2):
  tty: n_gsm: Remove unnecessary test in gsm_print_packet()
  tty: n_gsm: Fix bogus i++ in gsm_data_kick

 drivers/tty/n_gsm.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

-- 
2.26.2

