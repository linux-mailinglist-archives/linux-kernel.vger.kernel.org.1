Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FFD29C9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830951AbgJ0ULp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S372731AbgJ0ULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603829504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=lt6MI9lyzWRQsxhjflylYnJ4QKAMKvBFCYdtvU/Wi4k=;
        b=do7QZbNmd/OBssWjhwETHX/AF+oj17yAsnpi7R7S28kCNoVybd+1TEj5Kbb+rRUmV0rUv+
        56Kbx9vgwGqm5FxPoU4W9nA6gZNOtR/SCG0xbts5cAfA8fU9Oe3gnaAcP2+EywUV3nkjBO
        W3chViXo8FmHIc9ExGxTi+zvqgJutHg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-x4ihKK_NM-aEUSsSwvPmgQ-1; Tue, 27 Oct 2020 16:11:42 -0400
X-MC-Unique: x4ihKK_NM-aEUSsSwvPmgQ-1
Received: by mail-oo1-f69.google.com with SMTP id s134so1280136oos.20
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 13:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lt6MI9lyzWRQsxhjflylYnJ4QKAMKvBFCYdtvU/Wi4k=;
        b=KA0uTSHrPYxf5eNwDKPmWAHrOrW3h05C4wWnplDnvfzdpWxB724TSFclE7oJHcKyxZ
         vnN6Za0T8yE8b4ZwqFjAlv9Cb3NaYMNZrBOJwOE6rPnHiB961+x+y8hGimk2uwOEeFqn
         f/v82UzOdd4tL7m9kbXvKq60c92Sr87tXtzlNg0b18H0oP6EYRIpL/Kptmx4a1qkdNtZ
         hPGaY3ormGWKad/768ttcfoUrv9T7Ouk6eyr0WwUWKK47oZkAmMxEqSIlUCp3MU9IY5i
         8Km49BorKycAAhAhFsgfh42LbZF4w1DPVD+7yt+2u4lOqrgNAM3UAnqCv5x9xYi1Sl4u
         WL6w==
X-Gm-Message-State: AOAM531Jcetg0iq9DO0AzWgZhkwe8lH1H02yHRQcEA6Y9xFkysVQ2u+A
        BDGWVFnzoA8HWqkEz+vmv7MdUuceyPVZw7r3G7s/IAoUswi1EBniciLn4XWUV2QQgGjFZqRkRSy
        2LMYnzOwDhXQdd+M5YLKrNJNo
X-Received: by 2002:a9d:2f09:: with SMTP id h9mr2747417otb.186.1603829501206;
        Tue, 27 Oct 2020 13:11:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc0SFqKRZ753fViQfz8Ms1OZtjfHdVFd98OZflO1c8SHIGNz3TNx9l2WhvvKu/YMKZORnLDQ==
X-Received: by 2002:a9d:2f09:: with SMTP id h9mr2747408otb.186.1603829501002;
        Tue, 27 Oct 2020 13:11:41 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q139sm1940445oic.38.2020.10.27.13.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:11:40 -0700 (PDT)
From:   trix@redhat.com
To:     paul@crapouillou.net, jic23@kernel.org, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio/adc: ingenic: remove unneeded semicolon
Date:   Tue, 27 Oct 2020 13:11:28 -0700
Message-Id: <20201027201128.1597230-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/adc/ingenic-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 92b25083e23f..7886cdca5a5e 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -542,7 +542,7 @@ static int ingenic_adc_read_avail(struct iio_dev *iio_dev,
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
-	};
+	}
 }
 
 static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
-- 
2.18.1

