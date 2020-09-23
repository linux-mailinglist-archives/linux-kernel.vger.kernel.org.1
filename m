Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6E8275DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIWQlF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Sep 2020 12:41:05 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:51954 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWQlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:41:02 -0400
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 8EBFE3A070F;
        Wed, 23 Sep 2020 16:29:15 +0000 (UTC)
Received: from sogo5.sd4.0x35.net (sogo5.sd4.0x35.net [10.200.201.55])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPA id 7D5C21C0007;
        Wed, 23 Sep 2020 16:28:52 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
In-Reply-To: <20200921113039.GA19862@duo.ucw.cz>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Wed, 23 Sep 2020 18:28:52 +0200
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        kai.heng.feng@canonical.com, johan@kernel.org,
        tomasz@meresinski.eu, jonathan@jdcox.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
To:     "Pavel Machek" <pavel@denx.de>
MIME-Version: 1.0
Message-ID: <2f89-5f6b7800-e1-5029548@258698125>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH=5D?==?utf-8?q?_USB=3A?=
 =?utf-8?q?_quirks=3A?= simplify quirk =?utf-8?q?handling=2E?=
User-Agent: SOGoMail 4.3.2
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 21, 2020 13:30 CEST, Pavel Machek <pavel@denx.de> wrote: 
> Simplify quirk handling.

This patch seems to contain two different "simplifications" in one.
I have no objections against the first simplification:

-	if (quirk_list) {
-		kfree(quirk_list);
-		quirk_list = NULL;
-	}
-
+	kfree(quirk_list);
 	quirk_list = kcalloc(quirk_count, sizeof(struct quirk_entry),
 			     GFP_KERNEL);

Since kfree() does nothing to nullpointers, all lines that are cut seem
to be superfluous.

The second simplification does not seem to introduce any new bugs as far
as I can tell. Due to lack of experience, I shall refrain from commenting
on whether or not it simplifies things.

