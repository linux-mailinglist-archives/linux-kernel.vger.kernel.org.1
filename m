Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68323263A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 04:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgIJCf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 22:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbgIJCdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:33:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182C3C0617BC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 16:44:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x10so3692892ybj.19
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 16:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=DHwWEFMQdmnuxNjm/Olb1jwBcPoSrUeSsheT6vgRQVs=;
        b=NrRNO8Kqhm8eWcB+S17v1Q00oGlXJn0iJO0P2uWSg61PSn6lS0EjyAli4TQ77ChGla
         6OeFSiAxeQvP9mD/gk2ASnnz37VgtAtjgKbNOft6v5q+p2EOZPI0bRdCM/3IAhzXhy5r
         piKVJsdISgay54uz00OQk9Pq7T58lzuibbBOUOwv5Nxr7DEjxg3BiY1sQi4fnqPv2VAP
         CawTLii12bD9YWr8gPd9A2aim7tRpbuyr/Cwevg9r9qMUetz8GHqtTyJNTFnnICnwq9/
         pZKbkso9nobiOYKK5CRTrnSSb9qNAVFOKLrCONsJrWvPA6/H7My9pqLFzJQdpIIp0f18
         7AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=DHwWEFMQdmnuxNjm/Olb1jwBcPoSrUeSsheT6vgRQVs=;
        b=g77DOAVT7p/5AH8FhsgFwd2resjVTXYGPngLPfWxIebHe4S1nsL+68q29DbstaA9BH
         kCpjdUkAV4AnQvE/9brt0RAAUBuDCAL4/ge/Ps/in/Af4vWVGzDBQz5OImHl4rAYeA2a
         sCdGcPUnJ1ynd+dzFObnyMIl2KEnrTbW0IEw4UFVGqJhMF5cQX96zssaDKBpq3MvKNuE
         yAhv+cLlHjxIFfa0lWum5MBv0A5nb6QOf9a9jZUJaxTb+CIY24gk3W0+1tLYIiRHwG+M
         5cyRlCeXmzRLikZYtvu8yzk15OFah33KZGEeNbrauXTTBP+pw88XOVHMVKtVjcqzTof2
         G8RA==
X-Gm-Message-State: AOAM5301Paa1Ix1tCSrNfAzzcS2JLKT01/4f16Hj9/21jlOwC8SGXBg4
        18jlBqcnf2iZNyzXL0+DynvYIetpTa0=
X-Google-Smtp-Source: ABdhPJy+RSLuoVD0yGW7ois0IJb5w2X4VoW/pKKhpkdaqpbInVRXxyUdRDsnmKS+pqa57cpiNKv0/QxF4z0=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:2d8e])
 (user=satyat job=sendgmr) by 2002:a25:81cb:: with SMTP id n11mr9544225ybm.490.1599695068787;
 Wed, 09 Sep 2020 16:44:28 -0700 (PDT)
Date:   Wed,  9 Sep 2020 23:44:19 +0000
Message-Id: <20200909234422.76194-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH 0/3] add support for inline encryption to device mapper
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for inline encryption to the device mapper.

Patch 1 introduces the "passthrough" keyslot manager.

The regular keyslot manager is designed for inline encryption hardware that
have only a small fixed number of keyslots. A DM device itself does not
actually have only a small fixed number of keyslots - it doesn't actually
have any keyslots in the first place, and programming an encryption context
into a DM device doesn't make much semantic sense. It is possible for a DM
device to set up a keyslot manager with some "sufficiently large" number of
keyslots in its request queue, so that upper layers can use the inline
encryption capabilities of the DM device's underlying devices, but the
memory being allocated for the DM device's keyslots is a waste since they
won't actually be used by the DM device.

The passthrough keyslot manager solves this issue - when the block layer
sees that a request queue has a passthrough keyslot manager, it doesn't
attempt to program any encryption context into the keyslot manager. The
passthrough keyslot manager only allows the device to expose its inline
encryption capabilities, and a way for upper layers to evict keys if
necessary.

There also exist inline encryption hardware that can handle encryption
contexts directly, and allow users to pass them a data request along with
the encryption context (as opposed to inline encryption hardware that
require users to first program a keyslot with an encryption context, and
then require the users to pass the keyslot index with the data request).
Such devices can also make use of the passthrough keyslot manager.

Patch 2 introduces the changes for inline encryption support for the device
mapper. A DM device only exposes the intersection of the crypto
capabilities of its underlying devices. This is so that in case a bio with
an encryption context is eventually mapped to an underlying device that
doesn't support that encryption context, the blk-crypto-fallback's cipher
tfms are allocated ahead of time by the call to blk_crypto_start_using_key.

Each DM target can now also specify that it "may_passthrough_inline_crypto"
to opt-in to supporting passing through the underlying inline encryption
capabilities.  This flag is needed because it doesn't make much semantic
sense for certain targets like dm-crypt to expose the underlying inline
encryption capabilities to the upper layers. Again, the DM exposes inline
encryption capabilities of the underlying devices only if all of them
opt-in to passing through inline encryption support.

This patch doesn't handle the possibility that the crypto capabilities of a
DM device may change at runtime after the initial table is loaded. While it
may be possible to handle the case with (possibly quite) some effort, the
use case might be unlikely enough in practice that it doesn't matter right
now. This patch also only exposes the intersection of the underlying
device's capabilities, which has the effect of causing en/decryption of a
bio to fall back to the kernel crypto API (if the fallback is enabled)
whenever any of the underlying devices doesn't support the encryption
context of the bio - it might be possible to make the bio only fall back to
the kernel crypto API if the bio's target underlying device doesn't support
the bio's encryption context, but again, the use case may be uncommon
enough in the first place not to warrant worrying about it right now.

Patch 3 makes some DM targets opt-in to passing through inline encryption
support. It does not (yet) try to enable this option with dm-raid, since
users can "hot add" disks to a raid device, which makes this not completely
straightforward (we'll need to ensure that any "hot added" disks must have
a superset of the inline encryption capabilities of the rest of the disks
in the raid device, due to the way Patch 2 of this series works).

Eric Biggers (2):
  dm: add support for passing through inline crypto support
  dm: enable may_passthrough_inline_crypto on some targets

Satya Tangirala (1):
  block: keyslot-manager: Introduce passthrough keyslot manager

 block/blk-crypto.c              |  1 +
 block/keyslot-manager.c         | 75 +++++++++++++++++++++++++++
 drivers/md/dm-core.h            |  4 ++
 drivers/md/dm-flakey.c          |  1 +
 drivers/md/dm-linear.c          |  1 +
 drivers/md/dm-table.c           | 52 +++++++++++++++++++
 drivers/md/dm-zero.c            |  1 +
 drivers/md/dm.c                 | 92 ++++++++++++++++++++++++++++++++-
 include/linux/device-mapper.h   |  6 +++
 include/linux/keyslot-manager.h |  9 ++++
 10 files changed, 241 insertions(+), 1 deletion(-)

-- 
2.28.0.618.gf4bc123cb7-goog

