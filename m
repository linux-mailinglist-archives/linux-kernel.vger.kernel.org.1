Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927E81DF935
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 19:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbgEWRYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387571AbgEWRYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:24:06 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A52C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:24:05 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y85so12137679oie.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=m82qONMyguJDys54lNi3xKT9kb4bYo0moeNoIRVcPz8=;
        b=XOjN2gwDV43r6h0JIDKY44Y6MViME9r9/702yjZLPXPguXg9l8y47bea7X2bJ0BT9k
         +1Exll4ihCgGlhrcLibMT2jO5Bx/jSbYDXHe50F31G431pFn92JTnRrnt5uE6Y3K7CCB
         jQZEk6V3roo707ySXIbIqvZx9ySeWe0zwmX34sRXYIWhk0Vstc1nbrdws568ATniwVaa
         0kYb444LdFQ6TP+jrMfCJw/1hi0249MsXcffENhtKJxFtU2w1GvbdGGC7VoKzFSm66Kf
         OY1Vj3JVCrleYuAjpjBsu3jAAZMJT1Stz4R4Q7f9TX8DnuAxt6RCt3tkDp3UqF/bbxaG
         GT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:cc:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=m82qONMyguJDys54lNi3xKT9kb4bYo0moeNoIRVcPz8=;
        b=enfPzZMg+0vz2dtGMtlDV86VQEHLtuP6lEzBSV8w0jtyAkP7iakLsugh3nDRDkULfb
         MLAC+i0lIgoLjjZax/6+AgsEVpNBMtnPNSV7UCSNDeNKd+vwY+//0/VlQjTeMicyGzLH
         C8Vm75jK+GbN8avcQwYq2z9CFGuc5uOrJVDKcbbdsz848aM1+qFIr95qGI0KCfzLk4QL
         gniVP9C/k8yO7Xquh+HHkPQjdE1ahSCjOJDuWiQv1NpCi8C1cgLGJj54pODkcB1EpHMv
         kMWuf7MbSMWRpKQh1apTo99kJR6abI0q6TvMxpgOaBYswWqo2ApiRFIRBAAuYhVHEQjl
         yvcw==
X-Gm-Message-State: AOAM5300QHICgwbCyQXlunykg7i9kTZfx4jWcPVqQPWbDyihdNiAnmxx
        o42nL/uHftT2y+cjEXjJIvA62CQX
X-Google-Smtp-Source: ABdhPJwxErllcB83XEQ3Y50IjmYU6I2fvFJayOCS4k8ab0JC9VcTwGb2jIUsu9YTwFnYOKsU8aoB2Q==
X-Received: by 2002:aca:5e0b:: with SMTP id s11mr6153309oib.160.1590254645184;
        Sat, 23 May 2020 10:24:05 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id p26sm3499409ood.28.2020.05.23.10.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 10:24:04 -0700 (PDT)
To:     Christophe Leroy <christophe.leroy@c-s.fr>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Kernel bug in 5.7 for PPC32 on PowerBook G4 - bisected to commit
 697ece7
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <2c361d8e-5e2a-cdd9-da8e-aa49a4f93cfd@lwfinger.net>
Date:   Sat, 23 May 2020 12:24:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Although kernel 5.7.0-rc2 appeared to boot cleanly, it failed on my G4 when I 
tried to generate a new kernel. The following BUG message is logged:

[  336.148935] ------------[ cut here ]------------
[  336.148950] kernel BUG at ./include/linux/swapops.h:195!
[  336.148971] Oops: Exception in kernel mode, sig: 5 [#1]
[  336.148975] BE PAGE_SIZE=4K MMU=Hash PowerMac
[  336.148978] Modules linked in: cpufreq_ondemand fuse ctr ccm b43 mac80211 
sha256_generic libsha256 cfg80211 hid_apple hid_generic joydev rfkill libarc4 
rng_core cordic uinput radeon evdev
ttm drm_kms_helper usbhid hid appletouch drm rack_meter ehci_pci ehci_hcd 
drm_panel_orientation_quirks ssb fb_sys_fops yenta_socket sysimgblt sysfillrect 
pcmcia_rsrc syscopyarea pcmcia pcmcia
_core i2c_powermac therm_adt746x loop ohci_pci ohci_hcd usbcore sungem 
sungem_phy usb_common
[  336.149052] CPU: 0 PID: 8346 Comm: ld Not tainted 5.6.0-rc2-00086-g36b7840 #249
[  336.149056] NIP:  c0166624 LR: c016661c CTR: 00000000
[  336.149062] REGS: f42ddb08 TRAP: 0700   Not tainted  (5.6.0-rc2-00086-g36b7840)
[  336.149064] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24000424  XER: 00000000
[  336.149072]
[  336.149072] GPR00: 00000000 f42ddbc0 c24fcb80 00000001 ef438f00 c1957b1c 
f42ddc4c 00000004
[  336.149072] GPR08: 00000050 00000100 00000000 edb9d000 00000000 100cba68 
10051b10 10051b08
[  336.149072] GPR16: 000001be ee68c078 0000105a 00000000 00000000 c1957b1c 
00000000 00000000
[  336.149072] GPR24: ec5d2540 00000000 7c002bf8 c1957ae0 00000000 ec5d2540 
ef438f00 ef438f00
[  336.149107] NIP [c0166624] _einittext+0x3f9d38a8/0x3fe4a284
[  336.149111] LR [c016661c] _einittext+0x3f9d38a0/0x3fe4a284
[  336.149114] Call Trace:
[  336.149118] [f42ddbc0] [c07b9b60] 0xc07b9b60 (unreliable)
[  336.149123] [f42ddbd0] [c013ff64] _einittext+0x3f9ad1e8/0x3fe4a284
[  336.149128] [f42ddc10] [c0140d4c] _einittext+0x3f9adfd0/0x3fe4a284
[  336.149133] [f42ddc90] [c002aadc] _einittext+0x3f897d60/0x3fe4a284
[  336.149137] [f42ddce0] [c00153a4] _einittext+0x3f882628/0x3fe4a284
[  336.149144] --- interrupt: 301 at _einittext+0x3fb52a50/0x3fe4a284
[  336.149144]     LR = _einittext+0x3fb52a4c/0x3fe4a284
[  336.149148] [f42ddda8] [c02e56c0] _einittext+0x3fb52944/0x3fe4a284 (unreliable)
[  336.149153] [f42ddde8] [c011644c] _einittext+0x3f9836d0/0x3fe4a284
[  336.149158] [f42dde38] [c01f5950] _einittext+0x3fa62bd4/0x3fe4a284
[  336.149163] [f42dde58] [c016b98c] _einittext+0x3f9d8c10/0x3fe4a284
[  336.149167] [f42ddec8] [c016ba60] _einittext+0x3f9d8ce4/0x3fe4a284
[  336.149172] [f42ddef8] [c016bd00] _einittext+0x3f9d8f84/0x3fe4a284
[  336.149177] [f42ddf38] [c0015174] _einittext+0x3f8823f8/0x3fe4a284
[  336.149182] --- interrupt: c01 at 0xfdf99fc
[  336.149182]     LR = 0xfd9cce0
[  336.149184] Instruction dump:
[  336.149189] 40be0018 4bffe359 3c80c06a 3884e48f 4bfd4c9d 0fe00000 4bffe345 
7c641b78
[  336.149196] 38600000 4bffe045 7c630034 5463d97e <0f030000> 39400000 393f001c 
39600001
[  336.149208] ---[ end trace d08833cae9c66ce3 ]---
[  336.149210]
[  336.193729] ------------[ cut here ]------------

This problem was bisected to commit 697ece7 ("powerpc/32s: reorder Linux PTE 
bits to better match Hash PTE bits").

If I had done more rigorous tests earlier, I would have found the bug with more 
time to fix it before release of 5.7, but every other problem I have found 
happened at boot, not when the machine had to swap.

Thanks,

Larry
