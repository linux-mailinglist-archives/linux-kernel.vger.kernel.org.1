Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7F129964D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1791090AbgJZS60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1791072AbgJZS6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603738700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=kaOCH2p3/Nu0DCrQ0FgXRUQNXyBXyy87Pagb1Hdgksw=;
        b=LYGrILgW3Fmbm3/21S1GL28RXBq4BAtDw2m9/hj7BRKre+oLGXLVSSoI5lNIKOA4w7YcQO
        cKs+cm8jrGdavz5nDav4RvutIquHIMjEWUqgFZn5DDB/PDHWRH4UsvkQCugVAa5bcwIrmp
        Dkrm9Gs+KTP7RS2ZVG8B79DyuDGOCGQ=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-CGvO4J_5ORKanH-_BA2fkQ-1; Mon, 26 Oct 2020 14:58:19 -0400
X-MC-Unique: CGvO4J_5ORKanH-_BA2fkQ-1
Received: by mail-oo1-f70.google.com with SMTP id g9so6070046ooq.17
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 11:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kaOCH2p3/Nu0DCrQ0FgXRUQNXyBXyy87Pagb1Hdgksw=;
        b=GtC3utfImzbzbon7PvEiSWc6i+FJwd5OuCIYCVhhZo9v/LAECPhH4oZ3LJssPPlAk+
         S8+X/L4bCxnJG44YQFzhDW71S/aleYWB7kMr4RoB0+S1z8ReIvCZhQAHmbi/YRryzAUl
         aOK/tlaBkYPwbCNdHB/tDoghnAp3y5np7Ijcpzspl0LNDjjPSsU0eEkY1VwMt1804wXI
         Yqa/mSPuCXhB8uMVcU9kEitOZ2r420OK+xXB0VysSKanElpP878jTpUp5GNayLYPOTyV
         98eVon2joQjEN9nJHbSqmv6B4tidzp1B1xJ0uUCoe2eHuQjDoIvFAk9LShcGf2yt/FgF
         3jsg==
X-Gm-Message-State: AOAM530vIrK7T1JQAYVvkUC/zD9CHpnNyy46PFeJbj9X+5NfkLiwfoZ1
        rr32/OknL+rcnz1AO1mCggl3w7n8LK9oqCmN7+YnoF44PvZj0UjNP4y2RdlsNY0z7UjP83rzEkR
        SneVXrQPRgoY5mKbWbC+mw0h+
X-Received: by 2002:a9d:65c7:: with SMTP id z7mr16068721oth.327.1603738698274;
        Mon, 26 Oct 2020 11:58:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnbxRJ34NQlGUWZAODFv8pRoOSuBSReKA6tvsTH8368c1uhSb/dA9yoQ2cjXek2pdoLPyawg==
X-Received: by 2002:a9d:65c7:: with SMTP id z7mr16068703oth.327.1603738698033;
        Mon, 26 Oct 2020 11:58:18 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l204sm3100893oia.32.2020.10.26.11.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:58:17 -0700 (PDT)
From:   trix@redhat.com
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] usb: host: xhci-mem: remove unneeded break
Date:   Mon, 26 Oct 2020 11:58:12 -0700
Message-Id: <20201026185812.1427461-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: split out as single changed file
---
 drivers/usb/host/xhci-mem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index fe405cd38dbc..b46ef45c4d25 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1144,7 +1144,6 @@ int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *ud
 	case USB_SPEED_WIRELESS:
 		xhci_dbg(xhci, "FIXME xHCI doesn't support wireless speeds\n");
 		return -EINVAL;
-		break;
 	default:
 		/* Speed was set earlier, this shouldn't happen. */
 		return -EINVAL;
-- 
2.18.1

