Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CF320EF02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 09:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgF3HJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 03:09:59 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:40928 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730600AbgF3HJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:09:59 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id BE7631F436;
        Tue, 30 Jun 2020 09:09:55 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Tue, 30 Jun 2020 09:09:55 +0200
Date:   Tue, 30 Jun 2020 09:09:55 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v1 0/6] vt: Add SRG mouse reporting features
Message-ID: <cover.1593499846.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

this patchset adds xterm like mouse reporting features to the console.

The linux virtual console has support for mouse reporting since 1994 or so,
but the kernel only supports the original X10/X11 style standard protocols.
To support more protocols these patches expand the kernel structures in a
up- and downwards compatible way, see the last patch for detailed
documentation and pointers to even more detailed docs.

The main goal is to become compatible with xterm, as most TUI software today
is tested in xterm or another compatible terminal.

Support by the mouse daemons (consolation, gpm) will be needed too.


Kind regards,
Tammo


Changes from v0 :
- Fixed al the style the things mentioned by Jiri and Randy (thanks!)
- Change datastructure for report (better compatibility)
- Changed documentation in large parts accordingly
- Added URXVT protocol


Tammo Block (6):
  tiocl.h: Change/Add defines for mouse report
  console_struct.h: Two members for mouse report
  vt/vt: Enable mode change via escape sequence
  vt/vt: Add SRG mouse reporting protocol
  vt/vt: Add URXVT mouse reporting protocol
  Documentation: Describe console mouse reporting

 .../admin-guide/console-mouse-reporting.rst   | 92 +++++++++++++++++++
 Documentation/admin-guide/index.rst           |  1 +
 drivers/tty/vt/vt.c                           | 38 +++++++-
 include/linux/console_struct.h                |  3 +-
 include/uapi/linux/tiocl.h                    |  8 +-
 5 files changed, 134 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/admin-guide/console-mouse-reporting.rst

-- 
2.27.0

