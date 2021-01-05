Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FAC2EAA90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbhAEMXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:23:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbhAEMXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609849312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=U39k5ipMHANWOJWrOXSYV59iZX09Ei6dL9ebZb8Ogeg=;
        b=h0lLt4/Tksg6sI88+7rwPMzNQCYPJcQNpokcL+CsnYogR/Knm6EeB1j/rMH0Xv7n/UlUQX
        LlkU39FznW/EwWqgsRi0jFX8bk+O+VXF0sqjFU3xTMPuUBN4p4SuN8NmJrzE+D7PpMZsIo
        x0Aay4OYfwQIX3GQJGqZpcZNh9OuCUg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-1D9Knf35MRS1fhhrfNQwzQ-1; Tue, 05 Jan 2021 07:21:50 -0500
X-MC-Unique: 1D9Knf35MRS1fhhrfNQwzQ-1
Received: by mail-wr1-f69.google.com with SMTP id g17so14720246wrr.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=U39k5ipMHANWOJWrOXSYV59iZX09Ei6dL9ebZb8Ogeg=;
        b=S3x03S8twypS+DySvrSA4h89rdK0qXP4KWMoD8zGcslFM7rH9viERwPmdWjS4odCSn
         mSgMOJVPfceWXI4fRpas+7CwHkw+b2XMBPjZtp6EARggzdMAp74YpiQCmb1OCE7mCY3u
         VyppPXGLt7FYXbz/rgg3kY/nNno2ngUoakKQveAiYGhvCDZkMC4nh/1l2+cTwXXrIerK
         9YRzZsZcSUZvsPOdzzO/bSkhWCjVeGVsQpkLMa6Px92zjl+sFouIAjiREhnOqtQIsJHf
         g2VoVI9ZF7Ef7fEgYvNJ1objY6izzgHEtqKEE5kYBh9h+Krp0XwT98PCSftFPWwbGtp3
         arig==
X-Gm-Message-State: AOAM531k3dU7SbC3KIJ3JjiGIgHh202VrNAy0gDJFTrstPpDrZBQkyis
        ywrv67L5pFGH5fJdWJJZe5ukOHBZ3NdGAh4ZRzw3bjbiqs52qE9worSZjwVv3CZSonS4d83Bm7b
        oHUblnSxq0VBYYVnrO2lumxBQ
X-Received: by 2002:adf:bb0e:: with SMTP id r14mr85949742wrg.159.1609849309287;
        Tue, 05 Jan 2021 04:21:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRxC04NYGeb6WaL98Uxtwkp2M43zTcBL2qoRpI0IP4stOIB1HKct8R0XtAhgJEy1jrpROFhg==
X-Received: by 2002:adf:bb0e:: with SMTP id r14mr85949711wrg.159.1609849308953;
        Tue, 05 Jan 2021 04:21:48 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
        by smtp.gmail.com with ESMTPSA id y7sm3716921wmb.37.2021.01.05.04.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:21:48 -0800 (PST)
Date:   Tue, 5 Jan 2021 07:21:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com
Subject: [GIT PULL] vhost: bugfix
Message-ID: <20210105072145-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 418eddef050d5f6393c303a94e3173847ab85466:

  vdpa: Use simpler version of ida allocation (2020-12-18 16:14:31 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to e13a6915a03ffc3ce332d28c141a335e25187fa3:

  vhost/vsock: add IOTLB API support (2020-12-27 05:49:01 -0500)

----------------------------------------------------------------
vhost: bugfix

This fixes configs with vhost vsock behind a viommu.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Stefano Garzarella (1):
      vhost/vsock: add IOTLB API support

 drivers/vhost/vsock.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 3 deletions(-)

