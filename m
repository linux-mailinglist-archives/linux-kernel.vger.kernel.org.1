Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA1B2B7141
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgKQWH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgKQWH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:07:59 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5725C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:07:58 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so140210wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=URvCGNr5k1+GzznmsJpB6SNe04WSGrxWUmVDQcvgcZ4=;
        b=I03DxdCD92qsINhuEikYZ0TIzqvVS7L/jHcBxIb+ciBI6o/XpoFgfYLo+YsbNS+16P
         P4RqgCb031+L8tTs9IR1wLVE3u5AST/aEAbtHj+iMtmlo1X4rYS/KdOebq4OprAEicUo
         Hpya8WtKC9srGXWOOXOwcVtHIQ8XPvACMYi3q8pzxiB7DOOo2qJ/LMe8t8cwOhlkrqhX
         HkUAUjH+DQqtDKyLANkCqJr8lNqBXPZsmBBolet3QG1dGzyfIvBEA/W5PmtYxMFN5+rA
         oxmm0kQxjx4bCnLzI4WwvofizGbr/vU97Fx1NDF9MxCeAVpso+Rkl3WE1SHtJUCZpil5
         3/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=URvCGNr5k1+GzznmsJpB6SNe04WSGrxWUmVDQcvgcZ4=;
        b=TyUSKZWr+oy8ejiPQ99691pg3wxreeA5m7yHg5uwdMTqp2nYgjSnIuEXbKly1xuInG
         oebr6FNH7J2Gd+fqGnCMYYUHYyqfv2A/zJ+3Edmy1GYK//wHhB9L2w44YcEA6aD0MP0o
         NLIRJ5lX9zAUShmnINM0FVhKubOusxhMs56+Oo5UubeWMUJ3lNJNu/8mzEVGqno99wqs
         oQfqTs4ctLgCr6x6JJAXdidrUa8A7efc5ujDTZNi2m93erUWkiL4vaLHH7O8Cuo6eS1m
         oXT1cMPLY/9pXjhnQj+Iot6B38azGG1/e7dryIj6odPWL4wdbzS+BZ6/QnNVKeoqXA7n
         nXLQ==
X-Gm-Message-State: AOAM533dKJxjZzkJZzSffFGWjP6l6qfbOcJGEGVTk3xiJZa2StBueoNZ
        v/mkJA+jioqjYEyHuqfkGR4=
X-Google-Smtp-Source: ABdhPJxUjPspH7cJSSAMqBmrepuOgh4/9AxibRwo13eCtSmnpO/CFhmYNovsBMRKF5dpXWnVbE/wVQ==
X-Received: by 2002:a1c:e3d4:: with SMTP id a203mr1177352wmh.177.1605650877448;
        Tue, 17 Nov 2020 14:07:57 -0800 (PST)
Received: from localhost.localdomain ([46.166.142.216])
        by smtp.gmail.com with ESMTPSA id h20sm133352wmb.29.2020.11.17.14.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 14:07:57 -0800 (PST)
From:   Armin Gholampoor <armingh379@gmail.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Armin Gholampoor <armingh379@gmail.com>
Subject: [PATCH] net: ipv4: fixed a brace coding style issue
Date:   Wed, 18 Nov 2020 01:37:44 -0500
Message-Id: <20201118063744.214744-1-armingh379@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed bracing style issue.

Signed-off-by: Armin Gholampoor <armingh379@gmail.com>
---
 net/ipv4/tcp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b2bc3d7fe..37bc91e4a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3170,8 +3170,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		else if (tp->repair_queue == TCP_RECV_QUEUE) {
 			WRITE_ONCE(tp->rcv_nxt, val);
 			WRITE_ONCE(tp->copied_seq, val);
-		}
-		else
+		} else
 			err = -EINVAL;
 		break;
 
-- 
2.29.2

