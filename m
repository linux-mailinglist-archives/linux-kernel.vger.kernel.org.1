Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7511F4658
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 20:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbgFISbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 14:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732042AbgFISa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:30:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5316FC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 11:30:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d128so4159860wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kryske-cz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=AN+lt6L+HMUoUt8DMf8VcMe9yokwhR6uf5HA20ScyCA=;
        b=yFKFDOR6NwW3CZ2SCVbgCK0ZKRMOS4qWPW66wPeL6QJpPpxw/Lobnq+k12iKWAYI1E
         nYxxXsaqdBC48zduzQitCOpjBA+QVNEQpfaUypOBEI+RDE9cmyOwWopJvvYiNaJZaxAx
         sgPmeZeghiMcq+rmE9JOvISe/RtZ8WGtQJlDe/3v1QBtu0mtbvYqkUTgzmmprZTJ/k/v
         cXYdjhE9mNvLdqbqX+xtBvhsUdsNVirybCHwzgDt42nb5fSF0HDRFo4e2rKvfmz2zBuZ
         3dvGAOQ0R8XfnWvzLIu8uPIyxzLSGuNEH5Dmv4+XsNMz8GuDI4GjeTHalfZ7fE0oqGaW
         6soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AN+lt6L+HMUoUt8DMf8VcMe9yokwhR6uf5HA20ScyCA=;
        b=C78nXSeXH1bneYzFTKzVqeW94dggPG/9VIXhCIiS8i/pZHMFJvzL5RmnWPYjQxZUkI
         NUmOvanllPr2dQ8YEB8wu4r3d5pG/Qh65pqrrbj65zMEGvI6V8YLTJzvWWWnNW3pjP7a
         bxB4siNIyk2oQzZrz7Oqh7kmzpQ2AtRrDy+BgDb29N3Buueaq5ieLFBFxV+wJuqEHH1L
         5mOjG2ESJWGJaI+FjhhaU1BUcpV2dpmDfEsKguYQDXTOLKTeXQUNBUh6Tfjo+f94mUVG
         xJDYg2EwWbZIgFO67rWgjjRorFy2hy+a2IhXumfepDM9gtoOM6/PHZw6YWh6o/7SkKNS
         VEgQ==
X-Gm-Message-State: AOAM5318EZhOm88M0zEQZvYyT1phmyuD6Gc1YeTlRv8Rsh6OOTBU8wOf
        bnu/ERif8xm9ja8Xz2q/UAVXlNxTM6qMIpWtk0St0w1KPWZiqQ==
X-Google-Smtp-Source: ABdhPJxdhqkHWsUSOp4dXJuP2j2eA7JSvGJvWHCUNLRWthpnfP6Xzq0KtekJ7tqxpSAUTxKYxMP05mDdeK3dzo3jRF0=
X-Received: by 2002:a1c:9804:: with SMTP id a4mr5276766wme.109.1591727454459;
 Tue, 09 Jun 2020 11:30:54 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?THVrw6HFoQ==?= <lukas@kryske.cz>
Date:   Tue, 9 Jun 2020 18:30:43 +0000
Message-ID: <CALBYz=3dKHUkWBH5x29KgB094zX47shbfVQjbxVc_WuFtaHePg@mail.gmail.com>
Subject: 
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

auth 569683ef unsubscribe linux-kernel
