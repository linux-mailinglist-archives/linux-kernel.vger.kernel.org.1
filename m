Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF932F0A04
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbhAJW1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbhAJW1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:27:10 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692CC061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 14:26:29 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id a12so35157776lfl.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 14:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zUDP90lO0cgtaoa+C+R0TXIrpE8ZSeZJnX7l4//TRtE=;
        b=ueOqPPKcPRT/fo3qweKh/vSrq8I/RFOWCmYettzMvTlMMQVzfTw1WMsauYdA75eWZN
         v4jwr+IrRKLgHKKSiuHge7QsCq5FeZB50iERo/cTt99icOjNG9Obwgap0zFdI++ycABm
         oURr15CLuolJV8M5mpRE2JQ/vUrp545yik5hFv7FYWDTfLsynWTp8Gnv7Q6ViiKcHJup
         DTvDG/GVb5ZuirAOfL3BlTpOcTXeawY/SpIvBER4tQLtzC2KMb1O0cDXKr731aNQPGf8
         nLxbiC6d4ns3li1MA470CFRN3qfv2Ip7NZbp81qCzkCzXwTigLto5+67T+KXKOfrdmTS
         yBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zUDP90lO0cgtaoa+C+R0TXIrpE8ZSeZJnX7l4//TRtE=;
        b=XT8XM9Sv2CiAmXZQoy7sxo85BYsEohCHmVGwhB15Ce/zI3vp+Euh2WRMmqLZe5W8Yg
         n/Vcn5xQH8pQOHFXD/c1RrrHspLcKaKCnhPF2wcZCh35kEbqXFui5dBbtN/JYo6rDanb
         tJnkqa5JgTHzhOeRm8voOZgT2azvnaZo/rWhzRciiiCJ2EasjXDc0TlmfU8EPw2SQVAR
         ukn9kCT/g1nN/83blSrHaY7YqaWnEOhrlGG4wK+v0D8XOi5N80XLQNp9o02xWAUvoz8D
         nWKZ4mGMet84rUJAYndXfy6sGrbgprtAgi/Zu5F5eEve1rFe1RATyZHV+BqA/VJPv3nw
         bsgg==
X-Gm-Message-State: AOAM532Q4+RE/+ooTMud8C1TFtMsoS44tFgil1UeBipkVbGMK9rMJCcK
        lm+JrL+GcN/2X/gjdbUtz/uqf0+cHh7sYdLf/Mw=
X-Google-Smtp-Source: ABdhPJyRWs1QcD4OkIBMQ8qIEoN6VsFRbmL/QTRoXDlffyxzDStYlQfz7FU5jMVsdoCFH0VrYFz5MYNDXGWqjwlPABU=
X-Received: by 2002:a19:f203:: with SMTP id q3mr5729955lfh.166.1610317588311;
 Sun, 10 Jan 2021 14:26:28 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 11 Jan 2021 03:26:17 +0500
Message-ID: <CABXGCsPSYh-Nvfig4j4N8073vA6WDdhdg13meAcUgCr_pd5mYw@mail.gmail.com>
Subject: [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
 framebuffer with error -12
To:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
today I joined to testing Kernel 5.11 and saw that the kernel log was
flooded with BUG messages:
BUG: sleeping function called from invalid context at mm/vmalloc.c:1756
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 266, name: kswapd0
INFO: lockdep is turned off.
CPU: 15 PID: 266 Comm: kswapd0 Tainted: G        W        ---------
---  5.11.0-0.rc2.20210108gitf5e6c330254a.119.fc34.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X570-I GAMING, BIOS 2802 10/21/2020
Call Trace:
 dump_stack+0x8b/0xb0
 ___might_sleep.cold+0xb6/0xc6
 vm_unmap_aliases+0x21/0x40
 change_page_attr_set_clr+0x9e/0x190
 set_memory_wb+0x2f/0x80
 ttm_pool_free_page+0x28/0x90 [ttm]
 ttm_pool_shrink+0x45/0xb0 [ttm]
 ttm_pool_shrinker_scan+0xa/0x20 [ttm]
 do_shrink_slab+0x177/0x3a0
 shrink_slab+0x9c/0x290
 shrink_node+0x2e6/0x700
 balance_pgdat+0x2f5/0x650
 kswapd+0x21d/0x4d0
 ? do_wait_intr_irq+0xd0/0xd0
 ? balance_pgdat+0x650/0x650
 kthread+0x13a/0x150
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x22/0x30

But the most unpleasant thing is that after a while the monitor turns
off and does not go on again until the restart.
This is accompanied by an entry in the kernel log:

amdgpu 0000:0b:00.0: amdgpu: 00000000ff7d8b94 pin failed
[drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
framebuffer with error -12

$ grep "Failed to pin framebuffer with error" -Rn .
./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:5816:
DRM_ERROR("Failed to pin framebuffer with error %d\n", r);

$ git blame -L 5811,5821 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
Blaming lines:   0% (11/9167), done.
5d43be0ccbc2f (Christian K=C3=B6nig 2017-10-26 18:06:23 +0200 5811)
 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5812)
7b7c6c81b3a37 (Junwei Zhang    2018-06-25 12:51:14 +0800 5813)  r =3D
amdgpu_bo_pin(rbo, domain);
e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5814)  if
(unlikely(r !=3D 0)) {
30b7c6147d18d (Harry Wentland  2017-10-26 15:35:14 -0400 5815)
 if (r !=3D -ERESTARTSYS)
30b7c6147d18d (Harry Wentland  2017-10-26 15:35:14 -0400 5816)
         DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
0f257b09531b4 (Chunming Zhou   2019-05-07 19:45:31 +0800 5817)
 ttm_eu_backoff_reservation(&ticket, &list);
e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5818)
 return r;
e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5819)  }
e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5820)
bb812f1ea87dd (Junwei Zhang    2018-06-25 13:32:24 +0800 5821)  r =3D
amdgpu_ttm_alloc_gart(&rbo->tbo);

Who knows how to fix it?

Full kernel logs is here:
[1] https://pastebin.com/fLasjDHX
[2] https://pastebin.com/g3wR2r9e

--
Best Regards,
Mike Gavrilov.
