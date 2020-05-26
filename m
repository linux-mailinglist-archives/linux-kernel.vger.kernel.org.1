Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA071BF6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 13:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgD3LfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 07:35:02 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33831 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgD3LfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:35:02 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A23DF1C0006;
        Thu, 30 Apr 2020 11:35:00 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 0/3] TTY improve n_gsm support
Date:   Thu, 30 Apr 2020 13:34:29 +0200
Message-Id: <20200430113433.2162886-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series if patch improve n_gms support especially with TELIT
LE910. However the fix should benefit to any modem supporting cmux.

The first patch is just about improving debugging output.

The second one removes a tty optimization which make the LE910 hang.

The last one fixes an issue observed on the LE910 but should benefit
to all the modem. We observed that pretty quickly the transfer done
using the virtual tty were blocked. We found that it was due of a
wakeup to the real tty. Without this fix, the real tty wait for
indefinitely.

Gregory

Gregory CLEMENT (3):
  tty: n_gsm: Improve debug output
  tty: n_gsm: Fix SOF skipping
  tty: n_gsm: Fix waking up upper tty layer when room available

 drivers/tty/n_gsm.c | 59 +++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

-- 
2.26.1

