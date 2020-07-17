Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97E1223ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgGQOxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:53:19 -0400
Received: from smtp103.iad3b.emailsrvr.com ([146.20.161.103]:35254 "EHLO
        smtp103.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbgGQOxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1594997597;
        bh=YNazr2X64J47Zs71qG1bJD53gaInVX9LWD2T4M7xB1M=;
        h=From:To:Subject:Date:From;
        b=TCDYB7zuZleX793vyEb6uMbZLk/A4zlzw43A1DVaNVhLJAlZoQOtLXq1RoQeAk0vr
         CfYKSDC6UpXblSfDkj0KNcHx0/HBb7AE0ZHZNxMpEEdH8uQdUL9YVfkZK2IBsAGn/K
         gH7G/u1HpkLZ4xQC8mIwdXOL588oqpSg/rqhhv9s=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp5.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 32D27401E7;
        Fri, 17 Jul 2020 10:53:17 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     devel@driverdev.osuosl.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] staging: comedi: INSN_CONFIG_DIGITAL_TRIG fixes
Date:   Fri, 17 Jul 2020 15:52:53 +0100
Message-Id: <20200717145257.112660-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 3cd28aa4-5d40-4a0c-a681-8cbccbead0a1-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches correct problems with INSN_CONFIG_DIGITAL_TRIG comedi
configuration instructions in various comedi drivers, in particular the
use of unconstrained bit shift amounts from userspace leading to
undefined behaviour (although hopefully not the kernel crashy sort).

The patches have been marked for inclusion in the stable tree.  Note
that patch 4 changes a similar area of code to Dan Carpenter's commit
ef75e14a6c93 ("staging: comedi: verify array index is correct before
using it"), so I have indicated it as a prerequisite.

*Note to Greg KH*: I have based these patches on your "staging-linus"
branch due to the prerequisite ef75e14a6c93 mentioned above being
present in neither "staging-next" nor "staging-testing" at the time of
posting.

1) staging: comedi: ni_6527: fix INSN_CONFIG_DIGITAL_TRIG support
2) staging: comedi: addi_apci_1032: check INSN_CONFIG_DIGITAL_TRIG shift
3) staging: comedi: addi_apci_1564: check INSN_CONFIG_DIGITAL_TRIG shift
4) staging: comedi: addi_apci_1500: check INSN_CONFIG_DIGITAL_TRIG shift

 drivers/staging/comedi/drivers/addi_apci_1032.c | 20 ++++++++++++++------
 drivers/staging/comedi/drivers/addi_apci_1500.c | 24 +++++++++++++++++++-----
 drivers/staging/comedi/drivers/addi_apci_1564.c | 20 ++++++++++++++------
 drivers/staging/comedi/drivers/ni_6527.c        |  2 +-
 4 files changed, 48 insertions(+), 18 deletions(-)

