Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BAA27B436
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgI1SOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgI1SO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:14:29 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DBAC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 11:14:29 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 185so2344796oie.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=55aAJrVhMXWffHVOMOiMWLpkVkOYp1ATgjDEAbxe50g=;
        b=ObdGJJofPIwPWlBgoR1FDvuCiAIk6BlSqrMJ7g9EAVdzhO9439NtjEdeOoTPlzx9tf
         p/ILub35551sU3KhgqcdJBtW0yN1qb5I1j8njcte3CTRf6uxdS/Y3qzBwzYOeJkyPJSJ
         maiZxJogNxCh9FTLr8UAH8LQMTZTjKpy2b1Qe1E72YvzbtYTUzlQ8ssT71Me1ynb20mr
         mEXECQ/w/iG6y9m+5UGttoIOCwWtdDvLQBrAIUlaNGQ/EU++zu7lB39mS+Syi40bO12P
         u+kVU5fgwiUkkNoob57OO0FWahZWXV7GV3sAz2sr/ebfMyhcHiJ9UENxWkpWalgPOOvr
         zE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=55aAJrVhMXWffHVOMOiMWLpkVkOYp1ATgjDEAbxe50g=;
        b=HVCSTgKdmJK5PGIJ7kAZdbzxRdApYWS6WZ729Z6Gay3rHCozsHjvR0YPGakHiF4LdW
         4Hy3GxJqYpVASZUHjkdeHyYLvRdVkb0skLNGXhTuQgAwb09YN183Y9cbLeQIZwXC4WJB
         FCuMS+62yGkCnwKl90Q5micuC4j+r7riWwynNgBQrcPFWwvC3RcPRqCbr+d+qC5UJ3T/
         4bSPSNVO2Mj4v2yoyr2m76cEGV9EknaAwbu7l6aXlXblkiFTPK3gx+UE6jFmwg6x9fk4
         Vw2kZ7w7resvQoi/xHyO4A/AjcKo/yKuj0LD5HQMiQwucWJVAE0WdOEt5M32fq6ZcBt2
         FD1Q==
X-Gm-Message-State: AOAM5322HclWMtu36rXu2ltFnqEoHruMP44WfD+f1iyAZ7JB0Q6ZOGY5
        zh92aAKVgnuvpl2JGx7OOvYfLYPLQd8dP2VsFok=
X-Google-Smtp-Source: ABdhPJyxJgF8NkBTM/roPcXtEvcioEmI39rObor+OG7KUOgJKK33myEl7ybYKpY/r8hGONspccyBS0yfyU5f3/g2Pcg=
X-Received: by 2002:a54:4895:: with SMTP id r21mr79356oic.83.1601316868714;
 Mon, 28 Sep 2020 11:14:28 -0700 (PDT)
MIME-Version: 1.0
From:   Tony Fischetti <tony.fischetti@gmail.com>
Date:   Mon, 28 Sep 2020 14:14:16 -0400
Message-ID: <CAOMV6SUP1=U3bqO=+f_HrnTYpaLLwvZY4muCdW-ixQU2M10_WQ@mail.gmail.com>
Subject: REGRESSION: in intel video driver following introduction of mm_struct.has_pinned
To:     peterx@redhat.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a length git bisection, I determined the commit that introduced
a change that ultimately caused a bug/oops null dereference (see below
for relevant syslog entries) was 008cfe4418b3dbda2ff.. (mm: Introduce
mm_struct.has_pinned)

The RIP (according to syslog) occurs in function
`__get_user_pages_remote` and the last function to call it from the
i915 code is `gem_userptr_get_pages_worker`
More specifically, it appears to be the call to
`pin_user_pages_remote` in `gem_userptr_get_pages_worker` in
drivers/gpu/drm/i915/gem/i915_gem_userptr.c that directly leads to the
oops.

Unfortunately, I don't know enough to try to fix and share the fix
myself, but I hope the information I provided is helpful. Please let
me know if there is any further information I can provide that might
be of use.

BUG: kernel NULL pointer dereference, address: 0000000000000054
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
Oops: 0002 [#1] PREEMPT SMP NOPTI
CPU: 8 PID: 497 Comm: kworker/u25:0 Not tainted
5.9.0-rc7-alice-investigate-3+ #2
Hardware name: LENOVO 10ST001QUS/312A, BIOS M1UKT4BA 11/11/2019
Workqueue: i915-userptr-acquire __i915_gem_userptr_get_pages_worker [i915]
RIP: 0010:__get_user_pages_remote+0xa0/0x2d0
Code: 85 e7 01 00 00 83 3b 01 0f 85 e0 01 00 00 f7 c1 00 00 04 00 0f
84 12 01 00 00 65 48 8b 04 25 00 6d 01 00 48 8b 80 58 03 00 00 <c7> 40
54 01 00 00 00 c6 04 24 00 4d 8d 6f 68 48 c7 44 24 10 00 00
RSP: 0018:ffffa1a58086bde0 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffffa1a58086be64 RCX: 0000000000040001
RDX: 00000000000007e9 RSI: 00007f532f800000 RDI: ffff92f22d89c480
RBP: 00007f532f800000 R08: ffff92f23a188000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffa1a58086bcfd R12: ffff92f23a188000
R13: ffff92f22d89c480 R14: 0000000000042003 R15: ffff92f22d89c480
FS:  0000000000000000(0000) GS:ffff92f23e400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000054 CR3: 0000000016c0a002 CR4: 00000000001706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __i915_gem_userptr_get_pages_worker+0x1ec/0x392 [i915]
 process_one_work+0x1c7/0x310
 worker_thread+0x28/0x3c0
 ? set_worker_desc+0xb0/0xb0
 kthread+0x123/0x140
 ? kthread_use_mm+0xe0/0xe0
 ret_from_fork+0x1f/0x30
Modules linked in: snd_hda_codec_hdmi snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio iwlmvm mac80211 libarc4
x86_pkg_temp_thermal intel_powerclamp iwlwifi coretemp i915
crct10dif_pclmul crc32_pclmul crc32c_intel i2c_algo_bit
ghash_clmulni_intel drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops cec mei_hdcp wmi_bmof snd_hda_intel drm tpm_crb
snd_intel_dspcfg intel_wmi_thunderbolt snd_hda_codec snd_hwdep
aesni_intel crypto_simd glue_helper snd_hda_core cfg80211 i2c_i801
snd_pcm intel_cstate pcspkr snd_timer mei_me i2c_smbus mei i2c_core
thermal wmi tpm_tis tpm_tis_core tpm rng_core acpi_pad ppdev lp
ip_tables x_tables
CR2: 0000000000000054
---[ end trace 8d080e8b96289c9e ]---
