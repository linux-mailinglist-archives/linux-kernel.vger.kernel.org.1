Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9ED8292D41
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgJSR7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729556AbgJSR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603130363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=4H/4VlvZn6NucRVpFY4pzGUiWYTHTFz3lrsu4Py62T4=;
        b=fYHac78J/czzo1NFZ5D+eADBZcXD9cVndYRrLvy/ByESlSqjI1Xhujwc760DT7lA8T668h
        vlS6b8koM53yJHrkc7ilBcFyDxpXeb7/qjKjyaYhaetW0WCZ3Swll5rvq+d+fUig3yExSk
        vQH2k89IcU2orwIrHocfn7NdhzEN6Ss=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-i1_OVfsTN16AOJ66aB8IXQ-1; Mon, 19 Oct 2020 13:59:22 -0400
X-MC-Unique: i1_OVfsTN16AOJ66aB8IXQ-1
Received: by mail-qk1-f200.google.com with SMTP id z16so207149qkg.15
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4H/4VlvZn6NucRVpFY4pzGUiWYTHTFz3lrsu4Py62T4=;
        b=cyPI8aAA5G+Az8JZzoaQbqFaZ1p/r97QXX/FSE+D2eCRu7vrqhnZHEOPqsgl6eAkZW
         WgEHpJQrb8AUhQJMu7r8uHUSaLAdGphTM/Tg7DUAyMBEt6NmkVtKgPVcr7qfcwSlodA/
         PDjRbDo8lbr3XCpUP2eLmJYU+Jn3u4sfifnCkXkE/hLnkaKfKm/8WalE1n/Nl2gZb0pj
         1/fgjYjZOOxB5jIHBA+1y2r3pkUaXQpkc6RH9Ky8rI3zkohvUAF3HmV98jJr7ENTD+Jg
         jWNgQLsgN1HEgM9shaynuLSgZ7AdHMBwdpCqIN4ilkAT7vYl0X0uPuu24LNZ7XaxFhXY
         afhg==
X-Gm-Message-State: AOAM533jbLdG6gZAw/ELLVu/MZQ27vq9zGkDnYXSY2jUhGD0Udf7OZ31
        I7WSPx5+rFR1AA+Qvr8TFQkZmk225D1S84U/+dqet/7NdHkpXEqbHQlE65Fo8uVxDqpu6GIiYzE
        SgNox4eMKZROaoC17kvcOGwia
X-Received: by 2002:ac8:5816:: with SMTP id g22mr601403qtg.316.1603130362012;
        Mon, 19 Oct 2020 10:59:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaBqNmSBrMPJHuYqKierKOg1cy0Yax1D0cPaSGeCTCBhmZz3EoB/iutfA2SPaR+VRasCSlRQ==
X-Received: by 2002:ac8:5816:: with SMTP id g22mr601273qtg.316.1603130360444;
        Mon, 19 Oct 2020 10:59:20 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 9sm322063qkv.110.2020.10.19.10.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:59:19 -0700 (PDT)
From:   trix@redhat.com
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] tty: remove unneeded break
Date:   Mon, 19 Oct 2020 10:59:15 -0700
Message-Id: <20201019175915.3718-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/serial/imx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1731d9728865..09703079db7b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -320,7 +320,6 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 	switch (offset) {
 	case UCR1:
 		return sport->ucr1;
-		break;
 	case UCR2:
 		/*
 		 * UCR2_SRST is the only bit in the cached registers that might
@@ -331,16 +330,12 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 		if (!(sport->ucr2 & UCR2_SRST))
 			sport->ucr2 = readl(sport->port.membase + offset);
 		return sport->ucr2;
-		break;
 	case UCR3:
 		return sport->ucr3;
-		break;
 	case UCR4:
 		return sport->ucr4;
-		break;
 	case UFCR:
 		return sport->ufcr;
-		break;
 	default:
 		return readl(sport->port.membase + offset);
 	}
-- 
2.18.1

