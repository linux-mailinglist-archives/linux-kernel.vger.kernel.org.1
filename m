Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7504129EB5D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgJ2MLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgJ2MLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:11:10 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AA5C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:11:08 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bn26so3480905ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bpkD0JCevlbToguWRdp5HR8K25HvNulwRlZ8zBbV5Zk=;
        b=A8LMhUPH51RlrLBW8SCMkLFNByymFI3zWFqzB8tqw9vsNMDAvxnH3Clx87GZcSmUcA
         TuroZ0mPDVUsagWnhnesWi0Q0WRey/Z+SKbcHdmfeGV8tDIJrH8KlmLxsEXS1uI0b1Fw
         oUURVNbBLLm9KDurRVJmvlYB6UPGm2VBaWjqzurnYOLnTJcSr2eiqEK3FqWwMLTinPiB
         5GwZUJsxlfmzGVXYzp3fdGXsFWs8fq5EjCxEWa3j7/RYSp0REBJBFrc/ZEWg34jOVUd3
         i4J+bUewj4UDkiSUWZcir/owAHpFyvyTUMPvcgI5B+CLNK9Hm0OCdX6eZGGnxKoZULW2
         v2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bpkD0JCevlbToguWRdp5HR8K25HvNulwRlZ8zBbV5Zk=;
        b=QsK4+12deQGcLVNp8XfN5wpS2TbvzhDCpnqxk/g+VohNy8IBFqDmJXj+zOWPQQBVdc
         sCVdixcZIBN4M2DcTB22h+sGp2nR/kmAqSJSsf5WaLBO7pcGqLBFKEevHoeg4AvfNUsw
         NYMiBCfQTklGOc+T35arQjmuSDY857QhpfkO2/RF3BM6x/fmyhBt81rsAfs0iORLJdv0
         yLZzR/zup1rNXzFMQRGKwhPOge6LvdhronSZ65RAqdDWcqv8zkynEn1KMjmQ20Thrc/M
         kKmgaxAN5pXYCINM4EF2lGRK/qBX+KgPk+PQd5EVL7L4nlb4PbudpzAlNezNDqmL/T9X
         29Lg==
X-Gm-Message-State: AOAM532RRzBkuMkWdqW6qOjapycWtQE/jo6SYDWGR8XX4QBXrmEKRwyh
        +pAoIojymjjawqKSeEJBx8YXyCC7Ofw=
X-Google-Smtp-Source: ABdhPJy/ZK9NpVSO03lFCMCy8dOQCnUdrdrGq6zZie8K4gIhkkx/C3mfXWR3k7xYZatGMaTTD/Icpw==
X-Received: by 2002:a17:907:204c:: with SMTP id pg12mr3564816ejb.464.1603973467184;
        Thu, 29 Oct 2020 05:11:07 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id c19sm1381390edt.48.2020.10.29.05.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 05:11:06 -0700 (PDT)
Date:   Thu, 29 Oct 2020 13:11:05 +0100
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v4 6/6] Documentation: Describe console mouse reporting
Message-ID: <a773e48920aa104a65073671effbdee665c105fc.1603963593.git.tammo.block@gmail.com>
References: <cover.1603963593.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603963593.git.tammo.block@gmail.com>
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
index 000000000000..a05dfe251daf
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
+escape sequence; details depend on the chosen format. All of them use one
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
index ed1cf94ea50c..e0e44c934723 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -72,6 +72,7 @@ configure specific aspects of kernel behavior to your liking.
    cgroup-v2
    cifs/index
    clearing-warn-once
+   console-mouse-reporting
    cpu-load
    cputopology
    dell_rbu
-- 
2.28.0

