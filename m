Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26EB273299
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgIUTQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:16:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53580 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgIUTQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:16:20 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 63F5920B7179;
        Mon, 21 Sep 2020 12:16:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63F5920B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600715779;
        bh=bAvtruGL6eb8K//9E5HUFx+RIR5erE8cJVQBiE7jV4A=;
        h=From:To:Cc:Subject:Date:From;
        b=Bbcp4de/s3kSsU86og09oMnY1wV6mpagBU2CMnh/oQ4mNjXQP8vcBC+d7cwEI2rG9
         S+PNYc4CDpaP7heM6dXVXNbeBhQhrQZfYYtfeysZNb0btEM+PkNMhH4KdiXQyPiKC1
         HZ+uMhQ3xyPOeETuC6QmJnX85XerFZON2m6NyFrc=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: Implement CONFIG_CMDLINE_EXTEND
Date:   Mon, 21 Sep 2020 14:15:55 -0500
Message-Id: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the CONFIG_CMDLINE_EXTEND config option for arm64 kernels. This
config option can be used to extend the kernel command line parameters,
specified by the bootloader, with additional command line parameters
specified in the kernel configuration.

This option addresses the following use cases:

1) Switching between stable and development kernel versions, where one
   of the versions benefits from additional command line parameters,
   such as debugging options.
2) Specifying additional command line parameters, for additional tuning
   or debugging, when the bootloader does not offer an interactive mode.

After implementing these patches, I noticed that a previous attempt has
been made to upstream CONFIG_CMDLINE_EXTEND support in arm64:

 https://lore.kernel.org/linux-arm-kernel/1447838885-9888-1-git-send-email-p.fedin@samsung.com/

I don't believe that the previous objection still holds as the generic
command line parsing series hasn't been revised in over a year.

This series is based on commit f322010a08da ("Merge branch
'for-next/mte' into for-next/core") of the for-next/core branch of the
arm64 tree.

Below is a summary of testing that I performed.

Upgrade testing:

* CONFIG_CMDLINE unset
  - oldconfig target doesn't prompt, 
* CONFIG_CMDLINE set, CONFIG_CMDLINE_FORCE unset
  - oldconfig target prompts for command line type with default choice
    set to CONFIG_CMDLINE_FROM_BOOTLOADER
* CONFIG_CMDLINE set, CONFIG_CMDLINE_FORCE set
  - oldconfig target prompts for command line type with default choice
    set to CONFIG_CMDLINE_FORCE

Functional testing:

* Set CONFIG_CMDLINE="nokaslr apparmor=0" and CONFIG_CMDLINE_EXTEND=y to
  test early init parsing and regular parsing
  - /proc/cmdline shows that "nokaslr apparmor=0" was appended to the
    end of the bootloader supplied command line
  - "KASLR disabled on command line" found in dmesg
  - AppArmor is disabled. /sys/kernel/security/apparmor does not exist
    and aa-status prints:
     apparmor module is loaded.
     apparmor filesystem is not mounted.
* Set CONFIG_CMDLINE="nokaslr apparmor=0",
  CONFIG_CMDLINE_FROM_BOOTLOADER=y, and have the bootloader specify a
  command line without those options
  - The bootloader's command line is used and does not contain
    CONFIG_CMDLINE's value
  - AppArmor and KASLR are enabled
* Set CONFIG_CMDLINE="nokaslr apparmor=0" and CONFIG_CMDLINE_FORCE=y
  - The CONFIG_CMDLINE value is used and does not contain the
    bootloader's command line
  - AppArmor and KASLR are disabled

Tyler

Tyler Hicks (2):
  arm64: kaslr: Refactor early init command line parsing
  arm64: Extend the kernel command line from the bootloader

 arch/arm64/Kconfig        | 23 ++++++++++++++++++++++-
 arch/arm64/kernel/kaslr.c | 26 ++++++++++++++++++--------
 2 files changed, 40 insertions(+), 9 deletions(-)

-- 
2.25.1

