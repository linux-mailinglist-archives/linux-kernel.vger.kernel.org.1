Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C04D2F9577
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 22:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbhAQVYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 16:24:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbhAQVY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 16:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610918580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xji7LGKGDvU0URPlz+sFbNQ00D7ypSDEKKTbZiGgMTA=;
        b=JxzC9q+OIM8etO3dFKwsJOd9sYnK/VdNOrtpCZRY3f3wk7SzkHvMMRZfqaa3xTJpY/rDjU
        n/8Xe1UPz5miMNywr6rxW3+vm3wm4tk9CT6jQYiAnM8Rl9ZW1LjAArueMOJ5EaBBo/0cTU
        wnwcxE+YxVNs5Tdok3Tu/H5D39+fPRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-bX1NwOqNN_St8pKGKFEyAQ-1; Sun, 17 Jan 2021 16:22:58 -0500
X-MC-Unique: bX1NwOqNN_St8pKGKFEyAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62D4E800D53;
        Sun, 17 Jan 2021 21:22:56 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-7.ams2.redhat.com [10.36.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 748FF100AE2F;
        Sun, 17 Jan 2021 21:22:53 +0000 (UTC)
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
Subject: [PATCH v3 0/5] MFD/ASoC: Add support for Intel Bay Trail boards with WM5102 codec
Date:   Sun, 17 Jan 2021 22:22:47 +0100
Message-Id: <20210117212252.206115-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is v3 of my series to add support for Intel Bay Trail based devices
which use a WM5102 codec for audio output/input. New in v3 is that the
compile error when CONFIG_ACPI is unset should be gone. Everything else
is the same as in v2, see the cover-letter of v2 below:

This was developed and tested on a Lenovo Yoga Tablet 1051L.

The biggest difference from v1 is that, based on all the discussions about
the jack-detect stuff, I've decided to split this into 2 series.
One series adding the basic support for this setup, which is this series.

And a second series which reworks the extcon driver into an arizona-jackdet
library and then modifies the codec drivers to use that directly, replacing
the old separate extcon child-device and extcon-driver.

The are 2 reasons for the split:

1. With the new jack-det rework, the series really address 2 separate
(but related) enhancements.

2. I expect this series to be ready for merging, while the jack-det stuff
likely will need a couple more revisions.

Other then the split there are some minor changes addressing various review
comments, see the individual patch changelogs.

The MFD and ASoC parts can be merged independent from each-other (both must
be merged to get working sound on these boards, but that is only a runtime
dependency and a part missing won't have any bad side-effects). Or the
entire series could be merged through the MFD tree if people prefer that.

Regards,

Hans


