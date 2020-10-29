Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB329F60F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgJ2UT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgJ2UT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:19:27 -0400
Received: from mail-oi1-x262.google.com (mail-oi1-x262.google.com [IPv6:2607:f8b0:4864:20::262])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A5C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:19:27 -0700 (PDT)
Received: by mail-oi1-x262.google.com with SMTP id u127so4349599oib.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drivescale-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2iQ4elk9FgfQv+62N5cHiNqbEe0TWvc3n9943eVTiyg=;
        b=yXCdS98mpmaX7UeAjnR6AXJnvkpFv75LNfUcdtQT4e37Sywkx9c1RP7gNkHKuAQp3F
         N3cm/18IgJ8hK//4ckamHYCCDTRaetwXeG3rOnXwpnkrh8H+gy+n35y41P4CJW74jMWC
         5QrifI9IdTQjyyeImhxD7bxcQ80kbNxgSSBVMK4VtqaaNNRhmy0M2mjIDY4aX9Upfj6a
         W8pf2OzlCL1zmKdVS0EEAukA3OHviWwz5nBga1bn8kL0+QtYHPbD6rxd+6dLTx7Km1eh
         Lt7ypbSgdZQhRQydEKw78BTjbbv8CrRyYZ3fWAenATzTCFD6uiJGMh/NjNUl7pI03cd2
         XxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2iQ4elk9FgfQv+62N5cHiNqbEe0TWvc3n9943eVTiyg=;
        b=ESOPaz2gxM841eELegykdWGOzEbv9IEzGJwAU2ARc0M9jJyH7delJ8UfyoU7dgUSUQ
         yyKpDKrHSz+XivRRIS1m7pfaQzm/Wco51UtskRIxjLTpIwdnS7qGX12L+VCD3O8sE/vT
         Uph824vcQ1mR0OTb9COSreSoTHZPPn6HpKAxmvvHkzJQcnVBFyCvEbcbW+5g/AOYw6jb
         9uB5ns4o2A4AXlNKID+n12rIDiKG5t6iCv0lijQdEs0LSk3xciSVBQKyOi8lkZKhXtyk
         JeEZcXKV8ahfx3PWbtJN//UpP8tcJjayLTCg+GtihpZExpH0pKcNazE792d43V8eIZs2
         AfXA==
X-Gm-Message-State: AOAM532ZcV6duYCMyYlkAKfVRAt/q09Dxcg9kJvwqOGUdEsVrSh7uo7s
        EBFuqYTrPQjc2/1lc3JSuTlX1/SqTWIt7f572AAkj6ZFrUid+A==
X-Google-Smtp-Source: ABdhPJxGVPOIv3rPhLECNYEo6SrkooEM4PaeQCyPGzhcxOCSLWgttL5N9iSKtEXXRZoAgpv7qyRWvIKocycC
X-Received: by 2002:aca:4c8d:: with SMTP id z135mr1044614oia.23.1604002766035;
        Thu, 29 Oct 2020 13:19:26 -0700 (PDT)
Received: from dcs.hq.drivescale.com ([68.74.115.3])
        by smtp-relay.gmail.com with ESMTP id m1sm606012ooo.0.2020.10.29.13.19.25;
        Thu, 29 Oct 2020 13:19:26 -0700 (PDT)
X-Relaying-Domain: drivescale.com
Received: from localhost.localdomain (gw1-dc.hq.drivescale.com [192.168.33.175])
        by dcs.hq.drivescale.com (Postfix) with ESMTP id 4DBB34210A;
        Thu, 29 Oct 2020 20:19:25 +0000 (UTC)
From:   Christopher Unkel <cunkel@drivescale.com>
To:     linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Christopher Unkel <cunkel@drivescale.com>
Subject: [PATCH v2 0/3] md superblock write alignment on 512e devices
Date:   Thu, 29 Oct 2020 13:13:55 -0700
Message-Id: <20201029201358.29181-1-cunkel@drivescale.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for the feedback on the previous patch series.

A updated patch series with the same function as the first patch
(https://lkml.org/lkml/2020/10/22/1058 "md: align superblock writes to
physical blocks") follows.

As suggested, it introduces a helper function, which can be used to
reduce some code duplication.  It handles the case in super_1_sync()
where the superblock is extended by the addition of new component
devices.

I think it also fixes a bug where the existing code in super_1_load()
ought to be rejecting the array with EINVAL: if the superblock padded
out to the *logical* block length runs into the bitmap.  For example, if
the bitmap offset is 2 (bitmap 1K after superblock) and the logical
block size is 4K, the superblock padded out to 4K runs into the bitmap.
This case may be unusual (perhaps only happens if the array is created
on a 512n device and then raw contents are copied onto a 4kn device) but
I think it is possible.

With respect to the option of simply replacing
queue_logical_block_size() with queue_physical_block_size(), I think
this can result in the code rejecting devices that can be loaded, but
for which the physical block alignment can't be respected--the longer
padded size would trigger the EINVAL cases testing against
data_offset/new_data_offset.  I think it's better to proceed in such
cases, just with unaligned superblock writes as would presently happen.
Also if I'm right about the above bug, then I think this subsitution
would be more likely to trigger it.

Thanks,

  --Chris


Christopher Unkel (3):
  md: factor out repeated sb alignment logic
  md: align superblock writes to physical blocks
  md: reuse sb length-checking logic

 drivers/md/md.c | 69 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 17 deletions(-)

-- 
2.17.1

