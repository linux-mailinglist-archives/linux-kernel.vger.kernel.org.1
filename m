Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BE7292F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgJSUFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728200AbgJSUFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603137901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=mnoRDcLRpk47e6nhzTgs1K3yhuyBi+7gPd1VRJKtnrw=;
        b=CGzEAYnPSNTbr521XYiMy3YYeYXbQ/a4Ln9CtyPUPbgxIShj82Xv8LlQeDn9PaSGsIktu2
        qwNGE96SOLbjJSvw1uRgH4XjBj4oxuMhEMrXNUBspZaZuccp94e1ppSVz6paSKC+Wy56lp
        lBppqamogTy9v2AXTgYBIgTRGSmLVUo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-vfgUs3WdMJanb3t6sj4E0Q-1; Mon, 19 Oct 2020 16:04:59 -0400
X-MC-Unique: vfgUs3WdMJanb3t6sj4E0Q-1
Received: by mail-qk1-f200.google.com with SMTP id g184so583279qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mnoRDcLRpk47e6nhzTgs1K3yhuyBi+7gPd1VRJKtnrw=;
        b=M5/SAOp3/nPPHAFcGUETUgo1OjuA0Wnyi6mMOdTdTowBHfUkyKemgEYZj8xJEq5EtC
         qPTMAPla8l6H8oxcvGFNkQ2fOxw7FfP7Yb8TzbICZxQMjYCQRSHWcFGJ0rdRW3rETEKa
         NhnbOoAKRjzop0gXwIOJ6DP9S+hwBVuz3se6RZI1d1W3hOJb1jSwOpHPjGabttg8CzQb
         Q1EIu1GfjNqdAz4MW4NueQVHz1NbH+ql0vxMkFh72K3mSPKqlLlng8exY0z7zSXvTU+h
         yLXXmF1NspPfAmxbCymtCSpotqUGQNoV15rRouBe96Sw18/g/WZ03C+mH4fwgMyEIkCY
         qBsw==
X-Gm-Message-State: AOAM531IyLDLrHl8EbNOHilteXUr4ndbGuM6uBoDt6vy+GNFfjTKo5k5
        OWVGGNaJcOP/E9wn4p7V8xCKqonnezUtJsxITFCxMLwJoKOmQRYgmmeWVoO1ozEnAb7MawLkKyw
        NekHU6PeF3POfFr0dDlXVoATc
X-Received: by 2002:a0c:a166:: with SMTP id d93mr1542683qva.22.1603137899158;
        Mon, 19 Oct 2020 13:04:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsbpFpfbLblIlcs3o3CaAmJ42DgOJ5oXwzID77rU+/hVJK0TWsSYMpdjqWTgD/b7WK/kOHmg==
X-Received: by 2002:a0c:a166:: with SMTP id d93mr1542670qva.22.1603137898939;
        Mon, 19 Oct 2020 13:04:58 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 128sm454249qkm.76.2020.10.19.13.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:04:58 -0700 (PDT)
From:   trix@redhat.com
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] acpi: utils: remove unneeded break
Date:   Mon, 19 Oct 2020 13:04:53 -0700
Message-Id: <20201019200453.16864-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/acpi/utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 838b719ec7ce..d5411a166685 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -104,7 +104,6 @@ acpi_extract_package(union acpi_object *package,
 					      " [%c]\n",
 					      i, format_string[i]);
 				return AE_BAD_DATA;
-				break;
 			}
 			break;
 
@@ -129,7 +128,6 @@ acpi_extract_package(union acpi_object *package,
 					      " expecting [%c]\n",
 					      i, format_string[i]);
 				return AE_BAD_DATA;
-				break;
 			}
 			break;
 		case ACPI_TYPE_LOCAL_REFERENCE:
@@ -144,7 +142,6 @@ acpi_extract_package(union acpi_object *package,
 					      " expecting [%c]\n",
 					      i, format_string[i]);
 				return AE_BAD_DATA;
-				break;
 			}
 			break;
 
@@ -155,7 +152,6 @@ acpi_extract_package(union acpi_object *package,
 					  i));
 			/* TBD: handle nested packages... */
 			return AE_SUPPORT;
-			break;
 		}
 	}
 
-- 
2.18.1

