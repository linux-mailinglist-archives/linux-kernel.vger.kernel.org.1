Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA8F2C7986
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 15:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgK2OWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 09:22:37 -0500
Received: from mail.v3.sk ([167.172.186.51]:56874 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbgK2OWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 09:22:36 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 02ED0DFA00;
        Sun, 29 Nov 2020 14:19:01 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id j7ravqHqDd0P; Sun, 29 Nov 2020 14:19:00 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8B4D8DF887;
        Sun, 29 Nov 2020 14:19:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BIV-dPy_fT-4; Sun, 29 Nov 2020 14:19:00 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 55F88DF5C9;
        Sun, 29 Nov 2020 14:19:00 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add driver for power button on Dell Wyse 3020
Date:   Sun, 29 Nov 2020 15:21:43 +0100
Message-Id: <20201129142145.1526022-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please consider applying the patches chained to this message. It's a
rather simple driver for a power button on Dell Ariel board along with
the Device Tree binding document.

Compared to previous version, endianness issues are fixed and I
connected a Reviewed-by for the binding doc that I failed to before.
Change logs are present in individual patches.

Note that this set is versioned "v2", but I've sent the previous version
(both unversioned) out twice before, because I've forgotten about
the previous submission before. Sorry if it caused a confusion.

Thank you
Lubo


