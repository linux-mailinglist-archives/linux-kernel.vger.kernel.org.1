Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78FB292EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgJSTqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728196AbgJSTqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603136797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Z3Uaguy4PFk7zRxrw5xvopojDJel6cr7qQmABwkgRi0=;
        b=GjCqXM1hoBfT2EiHe+YIFDt225dzvR6B7gx90xY82RhQpxmvs8i1jnb9a9pviCrqtXjpg4
        VeK+f1IMAiUV9AZsJ4SLx7bMdtItLiAgf/Qu53FmoG0kIz1da5oT8AioxJd1fblJa1y4Tt
        4X/zihdv8lZbIEyChs7Y5pHuaAkdBR4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-P-mHY863MZeHv6smRGU4_w-1; Mon, 19 Oct 2020 15:46:33 -0400
X-MC-Unique: P-mHY863MZeHv6smRGU4_w-1
Received: by mail-qt1-f197.google.com with SMTP id h31so740308qtd.14
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z3Uaguy4PFk7zRxrw5xvopojDJel6cr7qQmABwkgRi0=;
        b=pTFTciObdq5DIu0O7sHhTIA/ssc4b5B16SuBccOvGRDqs+6uGrAJ5yn6NQg0yuF+Z/
         2VbojfmDQpDBlf5s85h3tr5qbTcH2oY9zhAakBroWR8HOaeeK+1Ooq1GjPhnwpISoq7t
         ne1eGh1B4Bc2IzX5QIJFnvD+o5o1Ywdx7Wl2DQQogLMG8PdRXXGvWO5Sg5PV/jsZDUC6
         kkKbwh5COm1W6QGlUfxjC+3rP9KmabiDkfVvGUYbFKEdNUzGjMY2PAgSDSnisXCMNVe7
         RxDqpLIx23i/qhj/qhngev4ZT2lP9PWy65B9eVPbJ1WcvID8K+OndvXDgdfEP3k4f8i7
         Ed6Q==
X-Gm-Message-State: AOAM531+aj/RwpffuooDVevnzO3i+FEaY4UIT13hfn3286lvzl5iV56I
        yej+uug3A3LiQy7nEMH9/wiKvzr08GsRfkLEHvdkluXGHo42LMCpgOKttT2tBBgPZKOYeCw7UNG
        QxlDD0VNGFMoONkDiIC6RFGrR
X-Received: by 2002:ac8:688b:: with SMTP id m11mr1075087qtq.177.1603136793002;
        Mon, 19 Oct 2020 12:46:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPXjLjBdBx9FQbkQGR60NJWf1BsDk5g87MBk0Rv1aYtAC1pfI2thPSbrgRj4hNgFrRHpT4sg==
X-Received: by 2002:ac8:688b:: with SMTP id m11mr1075070qtq.177.1603136792808;
        Mon, 19 Oct 2020 12:46:32 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t140sm445830qke.100.2020.10.19.12.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:46:32 -0700 (PDT)
From:   trix@redhat.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] char: lp: remove unneeded break
Date:   Mon, 19 Oct 2020 12:46:28 -0700
Message-Id: <20201019194628.14731-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/char/lp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 0ec73917d8dd..862c2fd933c7 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -622,7 +622,6 @@ static int lp_do_ioctl(unsigned int minor, unsigned int cmd,
 			break;
 		case LPSETIRQ:
 			return -EINVAL;
-			break;
 		case LPGETIRQ:
 			if (copy_to_user(argp, &LP_IRQ(minor),
 					sizeof(int)))
-- 
2.18.1

