Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB611AD20D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 23:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgDPVoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 17:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbgDPVoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:44:44 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73271C061A0C;
        Thu, 16 Apr 2020 14:44:44 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o19so310535qkk.5;
        Thu, 16 Apr 2020 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o1VdeUmGCBiTDzJFj51BAWPhL6tznPoJdb2GhVOAHKI=;
        b=YFtabvSdIbo74a69nc7T1qDFqKauZaL2j+5312DAS6J9DDbo5LwT0yEl6qsi0dNa0u
         9k8FPqFRcuufMKG5cUjAhrfOhwTtu+8X8aSzOGXrREJJjJ3IDLzlFYA90Y7G3lkowkCu
         Rux94/fE2hDIiF1Uw3Gyt0KlxkzDP11KsuiOjVTN3d0IMdELCACzsZlQ+JXk74ntrOMG
         /Fb71k4+i9Fc4Ymxj7xpMCbV9XCsdbg5COc//M405JNm54IlX/BzIpBvPLqXTmEJptuZ
         lLAFBam5+BlYc9TFGmR1dkS4BY8oRer31NlwuxzjTDHINfAn6hVromtmYo+8vtPh/2Hu
         RrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o1VdeUmGCBiTDzJFj51BAWPhL6tznPoJdb2GhVOAHKI=;
        b=WtgsNuweowIHMiLIIuKqCLmS3ScxBeLf/m4Qmy7sKUvCD8NKesDGd+CI9p/Itw+d+t
         hsef4lEK43aI3RO+eWxS1q67zcfCNJSifBl8kZm6EAfUmFyT+bnD9GocUkxn7rDqS7kM
         +HNoQdPmMmH3utKSEBST4xUAQ8o6PQTwkX6TDXsGRyLxHX4vAQ4Ls1cWowLhC8CCeNLX
         kc8yedlYu1Sxa2ZBw2W9ZkzaepYjrQY2gs+YPf7UOz1EoD2Wj+UjD6sNqlPE3wd2Sx/m
         OMzN27fgRvEqWWUcehKGy/XfYe7H6WDMFXcA4mOLi89J7I3XVmI9IDmfQ0Dqw95oNSGA
         Sk7g==
X-Gm-Message-State: AGi0PuaQUTwlLkmhLCPE5NhLMPeyK08zmjP/PWSWFxF0DlCVyGW5+jU7
        qWZ5fb3yhA6R8OiZOlmNM9o=
X-Google-Smtp-Source: APiQypJolQrwTOroFnBfZ5NeaExE344MYr0JoOpAUL+TCSyxM2q2lGGFQwXibZmAZJHFdevaRZgHww==
X-Received: by 2002:a37:7e47:: with SMTP id z68mr125220qkc.362.1587073483621;
        Thu, 16 Apr 2020 14:44:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id z34sm3164141qth.43.2020.04.16.14.44.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 14:44:43 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Erhard F." <erhard_f@mailbox.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 0/5] of: unittest: kmleak detected memory leaks
Date:   Thu, 16 Apr 2020 16:42:45 -0500
Message-Id: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Original bug report:
  https://bugzilla.kernel.org/show_bug.cgi?id=206203
  https://lore.kernel.org/r/877dyqlles.fsf@mpe.ellerman.id.au

kmemleak detected many memory leaks originating if devicetree
unittests.

Five separate causes were found.  Four causes were bugs and
one was expected.

Fix the four bugs and modify the test that led to the expected
memory leak to no longer have a memory leak.


Frank Rowand (5):
  of: unittest: kmemleak on changeset destroy
  of: unittest: kmemleak in of_unittest_platform_populate()
  of: unittest: kmemleak in of_unittest_overlay_high_level()
  of: overlay: kmemleak in dup_and_fixup_symbol_prop()
  of: unittest: kmemleak in duplicate property update

 drivers/of/overlay.c                               |  2 ++
 .../of/unittest-data/overlay_bad_add_dup_prop.dts  | 23 ++++++++++++++----
 drivers/of/unittest.c                              | 28 +++++++++++++++-------
 3 files changed, 40 insertions(+), 13 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

