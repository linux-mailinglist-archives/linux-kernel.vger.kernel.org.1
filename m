Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B542678EA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 10:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgILIm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 04:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgILIm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 04:42:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D870C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:42:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1f6200b3d433c484530811.dip0.t-ipconnect.de [IPv6:2003:ec:2f1f:6200:b3d4:33c4:8453:811])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77BA11EC0347;
        Sat, 12 Sep 2020 10:42:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599900174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=Edl34YjZc7cv5n6S9xNqGakk91/esbOTK2KIQRl/MTM=;
        b=krqkoQiXsRhZTUzFtb0YQ6Kb+YN+XhVW3mS4W5DMB85RwBuoiNxkjEHffPN21Gu4OEZ4GA
        KLxEwMRZlcJ6Ejw6i3IimWMjh+WJAg0mriceZC0NoZffsXv8/XnHHWY5e0P9eH8i5i4v5V
        +0VIiw8VcJkcTXHP9Z7xo0E22ksrBxY=
Date:   Sat, 12 Sep 2020 10:42:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: first bad commit: [fc8c70526bd30733ea8667adb8b8ffebea30a8ed]
 drm/radeon: Prefer lower feedback dividers
Message-ID: <20200912084255.GB4827@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch breaks X on my box - it is fully responsive and I can log in
into it from another machine but both monitors are black and show this:

"The current input timing is not supported by the monitor display. Please

change your input timing to 1920x1200@60Hz or any other monitor

listed timing as per the monitor specifications."

Reverting it fixes the issue.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
