Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFD6210ED1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 17:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbgGAPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 11:14:38 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:37073 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgGAPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:14:38 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id B5B7C1F421;
        Wed,  1 Jul 2020 17:14:34 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Wed, 01 Jul 2020 17:14:34 +0200
Date:   Wed, 1 Jul 2020 17:14:34 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 6/6] Documentation: Describe console mouse reporting
Message-ID: <1a16072f2e8152e4cd3a9d733bf8bed84228e9de.1593615440.git.tammo.block@gmail.com>
References: <cover.1593615440.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593615440.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a description of the kernel interface(s) used for vt
console mouse reporting and describes the protocols and bitmasks.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 .../admin-guide/console-mouse-reporting.rst   | 88 +++++++++++++++++++
 Documentation/admin-guide/index.rst           |  1 +
 2 files changed, 89 insertions(+)
 create mode 100644 Documentation/admin-guide/console-mouse-reporting.rst

diff --git a/Documentation/admin-guide/console-mouse-reporting.rst b/Documentation/admin-guide/console-mouse-reporting.rst
new file mode 100644
index 000000000000..c75a627f27b8
--- /dev/null
+++ b/Documentation/admin-guide/console-mouse-reporting.rst
@@ -0,0 +1,88 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Console Mouse Reporting
+=======================
+
+A terminal may send escape sequences to enable applications to react to mouse
+input. As the kernel does not know when to emit these events a mouse daemon
+is needed to react to mouse movements and signal the kernel accordingly. The
+kernel will then send an escape sequence to the application. This is called
+mouse reporting and several types and protocols have been developed over time.
+
+See tiocl.h, the :manpage:`ioctl_console(2)` and :manpage:`console_codes(4)`
+man pages and the xterm [1]_ or terminalguide [2]_ home pages for a detailed
+list and description of the various protocols, their bit layout as well as
+their limitations.
+
+Events and formats
+++++++++++++++++++
+
+A Linux console keeps state about two different aspects of mouse reporting,
+the kind of **events** to be reported and the **format** to send to userspace.
+
+A mouse daemon can check which kind of mouse events a client wants to be
+informed about via the TIOCLINUX ioctl, using the TIOCL_GETMOUSEREPORTING
+subcall. The values of the supported event classes (9, 1000, 1002, 1003) are
+described in tiocl.h. Based on this information the daemon is responsible
+for not sending data packages for unrequested events.
+
+A userspace client may request to be informed by the kernel about one of
+the event classes and choose one of the data formats URXVT (1005), SRG
+(1006) or X10/X11 (default) via console escape sequences. In general all
+of them encode similar information, only the escape sequences differ.
+
+See the xterm [1]_ or terminalguide [2]_ home pages for all details.
+
+Reports from kernel to userspace client
++++++++++++++++++++++++++++++++++++++++
+
+The requested events are sent by the kernel to userspace encoded in an
+escape sequences; details depend on the chosen format. All of them use one
+based pointer coordinates and a single byte to encode the button status.
+
+Short summary (we call this the SRG button format for the rest of this text):
+
+ - 1,2 : Buttons, lower bits (see notes below)
+ - 3-5 : Modifier keys (Shift, Alt and Ctrl)
+ - 6   : Mouse movement only, no button status change
+ - 7-8 : Buttons, upper bits (for buttons 4-15)
+
+Reports sent from daemon to kernel
+++++++++++++++++++++++++++++++++++
+
+A report is sent by a mouse daemon to the kernel via the TIOCLINUX ioctl,
+using the TIOCL_SETSEL subcall. The coordinates are encoded zero based in
+xs and ys, with 0,0 as the upper left corner, but see the note below.
+The format used by the userspace mouse daemon for button encoding is almost
+identical to the SRG button layout described above and is put into the sel_mode
+of the tiocl_selection struct. All bits masked in TIOCL_SELBUTTONMASK are
+unchanged compared to the SRG button format above; the remaining three are
+changed the following way:
+
+- 3,4  : Unused, must be zero. The kernel knows modifier key state anyway.
+- 5    : Always 1, identifies mouse report / TIOCL_SELMOUSEREPORT
+
+Notes
++++++
+
+Button numbers are encoded like this:
+
+- 0-2  : Left, middle and right button
+- 3    : No button pressed / Button release
+- 4-15 : More buttons, e.g. 4 and 5 are scroll wheel
+
+Please note that button releases should only be reported for buttons 0-2.
+
+Also note that coordinates (xs,ys,xe,ye) are zero based for the TIOCL_SETSEL
+syscall but one based for the escape sequences sent by the kernel, so the
+kernel will increase all coordinates by one.
+
+Older kernels only used the lower 4 bits of sel_mode, effectively limiting
+the protocol to 3 buttons and button click only. The meaning of the 4 bits
+is equivalent to the SRG button layout. Note that newer kernels will ignore
+the upper two bits (modifier keys).
+
+.. [1] https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Mouse-Tracking
+.. [2] https://terminalguide.namepad.de/mouse/
+
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 58c7f9fc2396..c535902f3851 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -71,6 +71,7 @@ configure specific aspects of kernel behavior to your liking.
    cgroup-v2
    cifs/index
    clearing-warn-once
+   console-mouse-reporting
    cpu-load
    cputopology
    dell_rbu
-- 
2.27.0

