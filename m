Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B8D2AE601
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 02:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbgKKBrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 20:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731805AbgKKBra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 20:47:30 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56726C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 17:47:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a6so448748ybi.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 17:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=FxgG6C8MNarNIrksAc2vZbdhW8ip0bCS/z9vVgyXDNc=;
        b=XG1NLhaztaGy9uEIyJqVmQKwvkssXXvS2Zw2USFL0RJT2tfUR1g2p5CuJrbwHdzWHB
         ejdaqHnxoveZbJSjTc8f5NxlXlOvbTXWKCxqp2VhTXu+nMfdtCo3uw1bKobNjHPpPqIZ
         ewpqi/dESTPK86rhP2kLhYtjve+Sr/cwGhpRX/5yuZ7EVqKUXOmAyIug5bpICNnXY4cm
         pgejCoywbt5Qx9j3KMLaP+VPN69gnia0q6Aj9Xxpykg3wY78IW5kuhPtmOufP/Y4enUw
         HFI7h+m0rGp1cEq6B8EO9xp9Hdtnji6+q34+/3mnwSo1lNBawPPHhqaeetGXVVHEjtD4
         TJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=FxgG6C8MNarNIrksAc2vZbdhW8ip0bCS/z9vVgyXDNc=;
        b=lX0B0AAW/focwxaY56DLNw3mIWKurFXJO10+ijNi9HrpA/ItCR3iVZ1dlOlbn6YTQ2
         Erwoei0Q/fbBh5zOobb5rW4o//zozKh2LF2dwQOrTQeaeHsO09/pv6xlE28LziqRZRHx
         gdNMQ0GrmzxS7rO7rEQwliH0RwizCH/taZ00PmqlcYB/I7eg9+bedBbu84EXU6YofJ+J
         NcssFAqkEKYqGw0Ql3tXvmaAMtASgJ7NDrxw6CNUG9c5Rh/ApDi1qLU/sFGXlvjkP457
         DUSktqQfIKd5ymSlEbCCvK1Oek4wViaEJR77ZjpxzbOzW1Spd6P4zgYQNuPDyNqHK6x7
         gfbg==
X-Gm-Message-State: AOAM533uM6AEZSaVSQnJFk1xKcGv1GGQ8f8oUJAQNlhfmarJoN4yM+IW
        fpWVlkdehLWjGMgj9xac9gw0MjV9pobP/B9eRT0=
X-Google-Smtp-Source: ABdhPJxO9Fs0lN744pI3vERiDRD0xhvwSXC3poyrmXrPztNJ9LEnOYhMgqZheafU2uzfqtDyv71Wuvop9Lp6zl6YHlI=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a5b:886:: with SMTP id
 e6mr12574836ybq.473.1605059249452; Tue, 10 Nov 2020 17:47:29 -0800 (PST)
Date:   Tue, 10 Nov 2020 17:47:14 -0800
Message-Id: <20201111014716.260633-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] usb: fix a few cases of -Wfallthrough
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "fallthrough" pseudo-keyword was added as a portable way to denote
intentional fallthrough. Clang will still warn on cases where there is a
fallthrough to an immediate break. Add explicit breaks for those cases.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/usb/core/config.c    | 1 +
 drivers/usb/host/ehci-hcd.c  | 2 +-
 drivers/usb/host/ohci-hcd.c  | 2 +-
 drivers/usb/host/ohci-hub.c  | 1 +
 drivers/usb/host/xhci-ring.c | 2 ++
 5 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 562a730befda..b199eb65f378 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -1076,6 +1076,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 		case USB_PTM_CAP_TYPE:
 			dev->bos->ptm_cap =
 				(struct usb_ptm_cap_descriptor *)buffer;
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 3575b7201881..e358ae17d51e 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -867,7 +867,7 @@ static int ehci_urb_enqueue (
 		 */
 		if (urb->transfer_buffer_length > (16 * 1024))
 			return -EMSGSIZE;
-		/* FALLTHROUGH */
+		fallthrough;
 	/* case PIPE_BULK: */
 	default:
 		if (!qh_urb_transaction (ehci, urb, &qtd_list, mem_flags))
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 73e13e7c2b46..1f5e69314a17 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -171,7 +171,7 @@ static int ohci_urb_enqueue (
 
 			/* 1 TD for setup, 1 for ACK, plus ... */
 			size = 2;
-			/* FALLTHROUGH */
+			fallthrough;
 		// case PIPE_INTERRUPT:
 		// case PIPE_BULK:
 		default:
diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index 44504c1751e0..f474f2f9c1e4 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -692,6 +692,7 @@ int ohci_hub_control(
 		case C_HUB_OVER_CURRENT:
 			ohci_writel (ohci, RH_HS_OCIC,
 					&ohci->regs->roothub.status);
+			break;
 		case C_HUB_LOCAL_POWER:
 			break;
 		default:
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 167dae117f73..eac43a7b7f23 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2418,6 +2418,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 			xhci_warn_ratelimited(xhci,
 					      "WARN Successful completion on short TX for slot %u ep %u: needs XHCI_TRUST_TX_LENGTH quirk?\n",
 					      slot_id, ep_index);
+		break;
 	case COMP_SHORT_PACKET:
 		break;
 	/* Completion codes for endpoint stopped state */
@@ -2962,6 +2963,7 @@ static int prepare_ring(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
 		return -EINVAL;
 	case EP_STATE_HALTED:
 		xhci_dbg(xhci, "WARN halted endpoint, queueing URB anyway.\n");
+		break;
 	case EP_STATE_STOPPED:
 	case EP_STATE_RUNNING:
 		break;
-- 
2.29.2.222.g5d2a92d10f8-goog

