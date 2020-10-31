Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5648D2A1828
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 15:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgJaOa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 10:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726161AbgJaOa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 10:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604154655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=+SYpvrQDrcTeFc0x19vDwjumMLcu3POqDKnp+UVjIms=;
        b=CY9ZlPDDNTRTNDDafre+y61i9vwBbn6EVZeICq5cK1WgGtyPkm014t+NXtBtiTObWpx+03
        MB+gXqmDPnBTWqMtoFYpNQ7yW6ZKg2/SgjorxSsDg2Nh7Bai9VAu+rVIGBU+1iczW23KG4
        dxQyuoLVtnkwphe7U7JRjaGZhtRAoQk=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-_NALeveiMNuQCNy7daN-Lw-1; Sat, 31 Oct 2020 10:30:52 -0400
X-MC-Unique: _NALeveiMNuQCNy7daN-Lw-1
Received: by mail-ot1-f70.google.com with SMTP id k26so3265578otb.4
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 07:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+SYpvrQDrcTeFc0x19vDwjumMLcu3POqDKnp+UVjIms=;
        b=GMxBZxl1RCEWDMvakzWN/NhCdq+PptfnQekWV7uSuXDvSlK7hp6rpSBEJU3axjIZ+8
         ayUngO6TgiiwirJRmQ62ri1aHi5XXkQ4MaVFvw2fK6aIKnzB7ehlN+HFxMAtOVre4NQ+
         cZA0QHc6lwmNp1ZqrPR7tpYfrzRFdJ8RtnzKhNJP7+2fgkDjwvaRVhbr9h82lqaBH7+Z
         YIT/EoK9ugUmGPRV9iCO/ElbUY6spzWL41gev9BvSGld6CP3xC0s8DOnL7nV5qunnLBh
         5FhdNMvQlaN12SZx+3D/xye21OfQWzjJ1goP51mPXb9sM4LUIjB3BDLC7zYA2Ix+FCIQ
         eddQ==
X-Gm-Message-State: AOAM530N0emLJ5/064aj6aPZCADdjprRc+BnNJ+CGN2dF+DoPmVKnJjR
        d3Wsjmia59wmwzOjFhPRfq3OqaXgV2+crHQ0CaRZgWIpH67Vix+HTOAXz16tW74vE0OZjCz8D7h
        pT7ZHqUBqK7RYI4rKwN8+Y/Mn
X-Received: by 2002:a9d:734f:: with SMTP id l15mr5916555otk.260.1604154652231;
        Sat, 31 Oct 2020 07:30:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyNwiU5traENULXxMhMa8p553xof5vI6tzuH7k3YI8IOQGwO3P+TB5/wMD5gKqIrPLJ9KnCw==
X-Received: by 2002:a9d:734f:: with SMTP id l15mr5916540otk.260.1604154652079;
        Sat, 31 Oct 2020 07:30:52 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h32sm2165668oth.2.2020.10.31.07.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 07:30:51 -0700 (PDT)
From:   trix@redhat.com
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] mfd: tps65010: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 07:30:47 -0700
Message-Id: <20201031143047.2140428-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/mfd/tps65010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 7e7dbee58ca9..4a21ea3fafae 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -134,7 +134,7 @@ static void dbg_chgconf(int por, char *buf, size_t len, u8 chgconfig)
 		case 2:		p = 75; break;
 		case 1:		p = 50; break;
 		default:	p = 25; break;
-		}; p; }),
+		} p; }),
 		(chgconfig & TPS_VBUS_CHARGING)
 			? ((chgconfig & TPS_VBUS_500MA) ? 500 : 100)
 			: 0,
-- 
2.18.1

