Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B5228CBB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbgJMKcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:32:54 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:45920 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729468AbgJMKcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:32:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id A88C9FB06;
        Tue, 13 Oct 2020 12:32:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l9H17qvFqi9u; Tue, 13 Oct 2020 12:32:49 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 86125402F3; Tue, 13 Oct 2020 12:32:48 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/panel: mantix panel reset fixes
Date:   Tue, 13 Oct 2020 12:32:45 +0200
Message-Id: <cover.1602584953.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

The binding were not part of a stable kernel so I hope it's okay to not worry
about backward compatibility.

Changes from v1:
 - As per review comments by Fabio Estevam
   https://lore.kernel.org/dri-devel/CAOMZO5B5ECcConvKej=RcaF8wvOxgq7nUzKJ-ad0aSAOzUqtbQ@mail.gmail.com/
   - Fix typo in commit messages
 - As per review comments by Rob Herring
   https://lore.kernel.org/dri-devel/20200929174624.GA832332@bogus/
   - Don't use an array of reset lines

Guido Günther (3):
  drm/panel: mantix: Don't dereference NULL mode
  drm/panel: mantix: Fix panel reset
  dt-binding: display: Require two resets on mantix panel

 .../display/panel/mantix,mlaf057we51-x.yaml   |  4 +++
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 25 +++++++++++++------
 2 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.28.0

