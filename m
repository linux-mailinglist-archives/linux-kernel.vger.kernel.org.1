Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCA272F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgIUQ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:56:15 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:39468 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729991AbgIUQz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:55:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id F3B25FB06;
        Mon, 21 Sep 2020 18:55:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PwhMdxTLLlij; Mon, 21 Sep 2020 18:55:53 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id EFE46457CC; Mon, 21 Sep 2020 18:55:52 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/3] drm/panel: mantix panel reset fixes
Date:   Mon, 21 Sep 2020 18:55:49 +0200
Message-Id: <cover.1600707235.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Posting as RFC since I'm not sure how to handle the bindings, please see below.

The first patch in this series fixes dereferencing a NULL mode in the error
path. The second one extends the resets to not only reset RESX but also TP_RSTN
since otherwise the display will stay completely blank. I didn't spot that
before initial submission since the reset line was bound to the touch
controller and although that failed to probe it came far enough to deassert the
reset line (at an arbitrary point in time during boot) and hence we got a
picture. Since touch and panel are on the same IC they're not completely
independent and i might have to turn the whole thing into an MFD at some point
but this series gets the panel to a reliably working state on boot and on fb
blank/unblank.

Since the reset-gpios are active low we can deassert in prepare and assert in
unprepare simplifying the code making sure lines are kept low when the
panel is off.

As for the bindings it seems I can't override the maxItems of reset-gpios since
that is already set in bindings/display/panel/panel-common.yaml to maxItems:
1`.  Is there a way to do that instead of side stepping the issue and using
a different name or using enable-gpios for one of them or forcing everyone else
to set `maxItems: 1`?

The binding were not part of a stable kernel so I hope it's okay to not worry
about backward compatibility.

Guido Günther (3):
  drm/panel: mantix: Don't dereference NULL mode
  drm/panel: mantix: Fix panel reset
  dt-binding: display: Require two rests on mantix panel

 .../display/panel/mantix,mlaf057we51-x.yaml   |  7 +++-
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 39 ++++++++++++-------
 2 files changed, 30 insertions(+), 16 deletions(-)

-- 
2.26.2

