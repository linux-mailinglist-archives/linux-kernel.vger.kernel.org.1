Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2C62E32C4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgL0VOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:14:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726204AbgL0VOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609103562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x6mS5fwdK6liDxgjybZtFeenAXjcPuU8dH8q/9rJU64=;
        b=cQHzDDZkuY8pwfSMOpVdTWsvHMp7RAkxZ8eyeIAP+mhfaEHuqkTFLeC0jb89gJrUJDImeV
        EyCi3h7QmfW98BeHmxU4r31cMok+ix0fUo4rlyANQ/VCqk/34oZTP74CP/HGD3D7vSAghd
        5qXl7I8AYInpstifra3+F4u0yLpRef0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-jwqao8p3NgSZNlMDDv8DlQ-1; Sun, 27 Dec 2020 16:12:38 -0500
X-MC-Unique: jwqao8p3NgSZNlMDDv8DlQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A1151005504;
        Sun, 27 Dec 2020 21:12:36 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-25.ams2.redhat.com [10.36.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55B54629C0;
        Sun, 27 Dec 2020 21:12:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 00/14] MFD/extcon/ASoC: Add support for Intel Bay Trail boards with WM5102 codec
Date:   Sun, 27 Dec 2020 22:12:18 +0100
Message-Id: <20201227211232.117801-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series adds support for Intel Bay Trail based device which use
a WM5102 codec for audio output/input. This was developed and tested on a
Lenovo Yoga Tablet 1051L.

This series consists of 3 parts:
1. Arizona MFD drv patches for ACPI bindings, better jack-detect support
   and misc. fixes
2. extcon-arizona driver fixes and improved jack reporting (this depends
   on the MFD changes)
3. ASoC patches in the form of a quirk for BYTCR detecting, a new
   machine driver for BYT + WM5102 and jack-detect support for the new
   machine driver (which again depends on the MFD changes).

Given that 2. and 3. depend on the MFD changes I believe that it is best
if all patches in this series are merged through the MFD tree (once
reviewed and acked) and then Lee can provide a immutable branch for
the ASoC and extcon maintainers to merge into their trees.

I have a patch with matching UCM profile changes available here:
https://github.com/jwrdegoede/alsa-ucm-conf/commit/316109e7814926ba984322c1d9190575fab9021c

This series + the UCM profile has been tested with both the SST and
SOF ASoC drivers for BYT devices.

Regards,

Hans

BugLink: https://github.com/thesofproject/linux/issues/2485

