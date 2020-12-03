Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D8D2CD83F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbgLCNxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:53:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbgLCNxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:53:01 -0500
From:   Jessica Yu <jeyu@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org, systemd-devel@lists.freedesktop.org
Cc:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        Franck Bui <fbui@suse.com>, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH RFC 0/1] Delay module uevent until after initialization
Date:   Thu,  3 Dec 2020 14:51:23 +0100
Message-Id: <20201203135124.16695-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch addresses a race condition between udev and the module loader
that was recently described here:

    https://github.com/systemd/systemd/issues/17586

Currently, the module loader issues a KOBJ_ADD uevent before it calls a
module's initialization function. Some mount units expect that the module
has initialized already upon receiving the uevent. For instance, the
configfs module creates the /sys/kernel/config mount point during its init
function, but the module loader issues the uevent before the init function
is called. If udev processes the uevent before the module loader calls the
init function, then the mount unit will fail, since /sys/kernel/config will
not exist yet.

Nicolas Morey-Chaisemartin provided a simple test script to trigger the
race condition:

while true; do
        umount configfs
        rmmod configfs
        sleep 1
        modprobe configfs
        ls -alFd /sys/kernel/config
        sleep 1
        systemctl status sys-kernel-config.mount | tail -n 1
done

When the mount fails due to the race condition, you would see a message like:

systemd[1]: Condition check resulted in Kernel Configuration File System being skipped.

I ran the script for about 30 minutes on my own machine and managed to trigger
the failure condition 4 times. With the patch applied, I was not able to
trigger the failed condition anymore after running the script for the same
amount of time. Nicolas also reported similar test results after testing a
kernel with the patch applied.

This is sent first as an RFC to both LKML and systemd mailing lists since
the uevent call has been like this in the module loader for more than a
decade (since v2.6), I would be cautious as to not break anything that
actually relies on the current behavior for whatever reason. More testing
would be greatly appreciated.

Thanks,

Jessica

Jessica Yu (1):
  module: delay kobject uevent until after module init call

 kernel/module.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

