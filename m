Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C413529AC9B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900394AbgJ0NAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:00:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58592 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900387AbgJ0NAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:00:54 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kXOah-0007gc-MD; Tue, 27 Oct 2020 13:00:44 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, hui.wang@canonical.com,
        kai.vehmanen@linux.intel.com, mwolf@adiumentum.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v3 0/3] HDA controller PM and codec PM cleanups
Date:   Tue, 27 Oct 2020 21:00:35 +0800
Message-Id: <20201027130038.16463-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on the issue "ALSA: hda: fix jack detection with Realtek
codecs when in D3", I've found using pm_runtime_force_{suspend,resume}()
have surprising behavior, specifically, pm_runtime_need_not_resume()
uses pm_runtime_need_not_resume() to avoid calling resume callback, so
jackpoll was used to really power up the codec.

We can use direct-complete to do the keep the codec suspended throughout
the system PM flow, namely, keep the codec suspended all the way, unless
the codec needs to be woken up after resume.

For HDA controller, PCI core may enable direct-complete for it if
conditions are met. So make runtime and system PM distinctive to always
apply correct wake up setting.

At least point, hopefully all runtime PM issues are solved, let's enable
runtime PM by default again.

v3:
 - Drop "ALSA: hda: Stop mangling PCI IRQ"

Kai-Heng Feng (3):
  ALSA: hda: Refactor codec PM to use direct-complete optimization
  ALSA: hda: Separate runtime and system suspend
  ALSA: hda: Reinstate runtime_allow() for all hda controllers

 sound/pci/hda/hda_codec.c      | 45 +++++++++++++++---------
 sound/pci/hda/hda_controller.h |  3 +-
 sound/pci/hda/hda_intel.c      | 63 +++++++++++++++++++---------------
 3 files changed, 66 insertions(+), 45 deletions(-)

-- 
2.17.1

