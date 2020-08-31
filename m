Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C0258197
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 21:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgHaTKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 15:10:15 -0400
Received: from ms.lwn.net ([45.79.88.28]:38314 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbgHaTKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 15:10:15 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0B3767C0;
        Mon, 31 Aug 2020 19:10:14 +0000 (UTC)
Date:   Mon, 31 Aug 2020 13:10:14 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Documentation fixes
Message-ID: <20200831131014.34bd1367@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.9-3

for you to fetch changes up to 92001bc0365a144783f8f3108be94e74baf61011:

  Documentation: laptops: thinkpad-acpi: fix underline length build warning (2020-08-24 17:19:07 -0600)

----------------------------------------------------------------
A handful of documentation fixes for 5.9.

----------------------------------------------------------------
Brandon Jiang (1):
      Documentation: fix typo for abituguru documentation

Kees Cook (1):
      docs: Fix function name trailing double-()s

Lukas Bulwahn (2):
      MAINTAINERS: mention documentation maintainer entry profile
      Documentation: add riscv entry in list of existing profiles

Marta Rybczynska (1):
      Documentation/locking/locktypes: fix local_locks documentation

Puranjay Mohan (2):
      IIO: Documentation: Replace deprecated :c:func: Usage
      Fpga: Documentation: Replace deprecated :c:func: Usage

Randy Dunlap (1):
      Documentation: laptops: thinkpad-acpi: fix underline length build warning

Theodore Dubois (1):
      devices.txt: fix typo of "ubd" as "udb"

 Documentation/RCU/lockdep.rst                      |  2 +-
 Documentation/admin-guide/devices.txt              |  2 +-
 .../admin-guide/laptops/thinkpad-acpi.rst          |  2 +-
 Documentation/driver-api/fpga/fpga-bridge.rst      |  6 +++---
 Documentation/driver-api/fpga/fpga-mgr.rst         |  6 +++---
 Documentation/driver-api/fpga/fpga-programming.rst | 16 +++++++--------
 Documentation/driver-api/fpga/fpga-region.rst      | 18 ++++++++--------
 Documentation/driver-api/iio/core.rst              | 16 +++++++--------
 Documentation/hwmon/abituguru-datasheet.rst        |  6 +++---
 Documentation/hwmon/abituguru.rst                  |  4 ++--
 Documentation/hwmon/abituguru3.rst                 |  4 ++--
 Documentation/locking/locktypes.rst                | 24 +++++++++++-----------
 .../maintainer/maintainer-entry-profile.rst        |  1 +
 Documentation/process/deprecated.rst               |  2 +-
 .../translations/it_IT/process/deprecated.rst      |  2 +-
 MAINTAINERS                                        |  1 +
 16 files changed, 57 insertions(+), 55 deletions(-)
