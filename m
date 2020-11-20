Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAE82BB1A9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgKTRpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbgKTRph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:45:37 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC547C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:45:37 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so8576373pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cK5F4d0qMv8rWJ7QrP6ojZzILBcMD6l3/NGR5/zHn7g=;
        b=UoWK9MYBJE1TyLQONgYTnCd7l17gX/KW94xX+kqV0yhhkqIGWZED22bb31p6M/HzoB
         m3KzMIbSRhsrOjxf9AMkEnibPX5QopTL3MxAomIlFdlt6NsEoevViw0/R9Ve7gsCrLXi
         H530GAVVLgkE2zNZ747uILJcGZJcafKngVAdRiXhEOe+7QPN0aWNdX20RRo8b2bMJLxb
         a7N1m7KQRzCdltpo30l1k1OaFZbktDHY7UPzo/cHtTSXNe9gEjI2nvxltOIjza+hQra7
         /4l5HUyV5cXg4Zi2b2GarNYZ1+iyqU7LknXF0haNZcfqR6jum1dX+iEMgazdTR2lZzLu
         yhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cK5F4d0qMv8rWJ7QrP6ojZzILBcMD6l3/NGR5/zHn7g=;
        b=jxxZNfaBSvZujxYNpQZaXSdKJrTLKkVJzvH5ME7NOJ5aTVR8ZLfZ0TYidPmN8LSK9+
         35URWppdW/kYK2MeDiPQCQ5WTk1q+0HuSleEJcXwnwnuxEVNogwj7ltdVuoKGvhmrhVM
         EJeXoN6XUOWx9Qf+kse7jCd6aUWm3ANywy7M5ouDQg2BkppKS6oRcsSuZIALhMthAaJK
         3zN7Oxkg150rNdYSOFkrVjYcIEBU2mKvAS91FFyn0A5iOGr01YBYdnIr0z2EjvgfZQak
         ZBYsbE4H3wIXmCuUrXwx94Xhh5RHwx5u7Rn1rxiZAx3a3MwisOYLPfcMtfBGYiRgoN7i
         0cMQ==
X-Gm-Message-State: AOAM531HaVbbZ5ATOmlnczDcXuCQIAH8LQxNJVPeHE72Kg/cQ6Mt/z48
        9Ol4jrLikl0n7rHi2WHySHs=
X-Google-Smtp-Source: ABdhPJx8PUvY86TcYq/+HHml2VaNIkFZTQaPQERkBsGPR4Ej3MKLJfnorrrZU2T6/FRgokeYPQSQVA==
X-Received: by 2002:a63:2e88:: with SMTP id u130mr17705157pgu.229.1605894337197;
        Fri, 20 Nov 2020 09:45:37 -0800 (PST)
Received: from syed ([2401:4900:2e82:cfda:fc82:287b:3e19:db98])
        by smtp.gmail.com with ESMTPSA id 138sm4117650pfy.88.2020.11.20.09.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 09:45:36 -0800 (PST)
Date:   Fri, 20 Nov 2020 23:15:19 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] lib/test_bitmap.c: Modify for_each_set_clump test
Message-ID: <27dfda9e32e6f7d0ba9399209c70e5c3c73d0113.1605893642.git.syednwaris@gmail.com>
References: <cover.1605893641.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605893641.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the test where bitmap_set_value() is called. bitmap_set_value()
now takes an extra bitmap-width as second argument and the width of
value is now present as the fourth argument.

Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
 lib/test_bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 1c5791ff02cb..7fafe6a0bc08 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -656,8 +656,8 @@ static void __init prepare_test_data(unsigned int index)
 	unsigned long width = 0;
 
 	for (i = 0; i < clump_test_data[index].count; i++) {
-		bitmap_set_value(clump_test_data[index].data,
-			clump_bitmap_data[(clump_test_data[index].offset)++], width, 32);
+		bitmap_set_value(clump_test_data[index].data, 256,
+			clump_bitmap_data[(clump_test_data[index].offset)++], 32, width);
 		width += 32;
 	}
 }
-- 
2.29.0

