Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AA62F93D3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 17:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbhAQQHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 11:07:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbhAQQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 11:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610899565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EacE5bdGI/vbbNWrSb4UQ45b4SwS399pIa9ugtyLzeM=;
        b=LqQTWSEhnQCE+IrhJ8jgyjot0X9mfKSMz2Uu0aA5LGMd3Ne/CQH+TitCOnj0mj9aCNH0c8
        V1Nr8mb0pXTQK01pCnX7hd8NThDsxoZSWajGSPGxPPalvt8b8LPC6vQxrSPEv10BWsDSiq
        D5ePy3tQ56mW4bO1laWw4F0nqe9ueq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346--1sE0xg1NIOtO_06jpFaFA-1; Sun, 17 Jan 2021 11:06:03 -0500
X-MC-Unique: -1sE0xg1NIOtO_06jpFaFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14669806666;
        Sun, 17 Jan 2021 16:06:01 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-7.ams2.redhat.com [10.36.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 058965C233;
        Sun, 17 Jan 2021 16:05:55 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v2 00/12] MFD/extcon/ASoC: Rework arizona codec jack-detect support
Date:   Sun, 17 Jan 2021 17:05:43 +0100
Message-Id: <20210117160555.78376-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series reworks the arizona codec jack-detect support to use
the snd_soc_jack helpers instead of direct extcon reporting.

This is done by reworking the extcon driver into an arizona-jackdet
library and then modifying the codec drivers to use that directly,
replacing the old separate extcon child-devices and extcon-driver.

This brings the arizona-codec jack-detect handling inline with how
all other ASoC codec driver do this.

This was developed and tested on a Lenovo Yoga Tablet 1051L with
a WM5102 codec.

The MFD, ASoC and extcon parts can be merged independent from each-other
although that could lead to a case where both the extcon driver and
the new arizona-jackdet library will try to do jack-detection. If we
end up with a git tree in that state then one of the 2 will fail to
load because the other will already have claimed the IRQs, so this
is not a problem really.

Or the entire series could be merged through the MFD tree if people
prefer that.

Note that this series also paves the way for some further cleanups,
removing some jackdetect related variables like hp_ena and hp_clamp
from the arizona data struct shared between all the MFD child devices.
I've deliberately not done that cleanup as part of this patch-series,
since IMHO the series is big enough as is. These cleanups can be done
in a follow-up series once this series has landed.

Regards,

Hans

