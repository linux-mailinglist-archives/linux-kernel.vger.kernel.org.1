Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4700829EB53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgJ2MJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgJ2MJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:09:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436DAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:09:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id j24so3431653ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Wxn488Z0C/g6VS0Jp1fNYciJVjpjpqdbwO1RTv39Swo=;
        b=W9pWrlZKDQ97v6ggul/dTnU4S/uQ0JPLaaIb3DV5V7BMbu6VNbiTJ9fxtsf1OgX/bG
         bVLoHI/qVfjf/9qJmqz0ZF7o741hnQciDNWXr9doefdPBNieFPfDdZ0HI2Vog6XETVyc
         CWtoGLwS+XDr54Sbxwt0v3nSVMh7QdxpkpJcG/0KjTd8R5C1JZoLFysNwwV7TxtUmUKh
         krNo5SAj/ExuqBuA5TP/VrF6/TzN80AWh4di3eLN/nvSjg7VPSGq9Gp7QXzik0wQ9vtp
         w5y/JGyxKQzFmlbijb+XxbnW3whvq3WlyD4oqjV0Ulx+b1ui1f/KIgDd4z3QPQi1y6uW
         dQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Wxn488Z0C/g6VS0Jp1fNYciJVjpjpqdbwO1RTv39Swo=;
        b=by8yWKtj/8T5aJveEkhZ4PHm+6oGYq5z+CI0WnHfwgUgzZVLAt5O5MevtpkvZc3fcI
         dJEOxFm/ICxpAecjnDyibgPwJIJr5HBnMvsjQ+He8udOq52PeJ4uf5Zacja76rL60kDJ
         ynzkRmrwV+QJb3osTv2CCzPn7JJo0bEYojnR7fLVncYXy1BkbfQ177HMBJZZN4VF3N3w
         XBQHxhjiKHhXEagHTV28XsNZZ01hbyQwT0LgBUSx8+b1narKbJzdsOU9CwCzpHY2TcAk
         2N057TDktrxNiE1IeZFJbIVeR7nga/GxvEKaKcL1wOT0Kmvasll1ruqLb6ndcGK7KxsS
         xCug==
X-Gm-Message-State: AOAM530WweMj994a5GlxDUhAUXYa7A5C/+FNp7vW7XaiGn6fn1D6+YBw
        3rimlvzyUHFnbt488VgS662Ept/hJ1Q=
X-Google-Smtp-Source: ABdhPJwPErwl0QNdIkrXneVibG9wM5KrXrGN8mgyt+dI/DcPBf7tuKbL765VubeymNBYNSO+ubxsYg==
X-Received: by 2002:a17:907:392:: with SMTP id ss18mr3776180ejb.429.1603973367583;
        Thu, 29 Oct 2020 05:09:27 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id s21sm1019197edc.42.2020.10.29.05.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 05:09:26 -0700 (PDT)
Date:   Thu, 29 Oct 2020 13:09:25 +0100
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v4 0/6] vt: Add SRG mouse reporting features
Message-ID: <cover.1603963593.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Changes from v3:
- Rebase against v5.10-rc1

Changes from v2:
- Rename enum and and use it as a type for vc_protocol_mouse
- Correct cding style and new spelling error

Changes from v1:
- Really fixed the style und spelling errors (Sorry Randy!)
- Created defines and enums for better readability
- Made variable to store last pressed button static and moved into
  mouse_report function

Changes from v0:
- Fixed al the style the things mentioned by Jiri and Randy (thanks!)
- Change datastructure for report (better compatibility)
- Changed documentation in large parts accordingly
- Added URXVT protocol

Tammo Block (6):
  tiocl.h: Change/Add defines for mouse report
  console_struct.h: Add members for mouse report
  vt/vt: Enable mode change via escape sequence
  vt/vt: Add SRG mouse reporting protocol
  vt/vt: Add URXVT mouse reporting protocol
  Documentation: Describe console mouse reporting

 .../admin-guide/console-mouse-reporting.rst   | 88 +++++++++++++++++++
 Documentation/admin-guide/index.rst           |  1 +
 drivers/tty/vt/vt.c                           | 45 ++++++++--
 include/linux/console_struct.h                |  9 +-
 include/uapi/linux/tiocl.h                    |  8 +-
 5 files changed, 143 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/admin-guide/console-mouse-reporting.rst

-- 
2.28.0

