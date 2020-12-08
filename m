Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60DB2D2375
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 07:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgLHGMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 01:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgLHGMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 01:12:23 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8198C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 22:11:42 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id x15so6450955pll.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 22:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UpVQF3Vudkbc3GHoWROwS054gUR7+NaA51Md2j04exk=;
        b=MO4q8Daiy7xSk0OWg8VXqYhYklCqqE1W9wZHqn4xUf/MmMlgyVCQJbCefKD3IlLPo5
         68BreaQqF3oOFwd0dXQ1W523QExDItYrWAaw++qVF1oNxHxlYFD2tf0Q4ZbevR+wkMWp
         tw/c4E5vYcT+MZvCpmFAtI4y3aZOLTLfOUj7LeuIQf0MaNXEIuKa29vMbtbBR7T/6kSE
         GOA3AoUSgYkGvwSiZWOjUOpgvSWDd+5z5G1WoGt6owN/G3rhgy982d0H7OwCjiJS/6f3
         bGiF1i0l5TkxUq4mniAKrcU0gUn2kGlQdAzcmxeaOat9ZKw/Khn5MPRF5syo4Jf3iBts
         kCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UpVQF3Vudkbc3GHoWROwS054gUR7+NaA51Md2j04exk=;
        b=aJH09zyd9/Q9PYDGVMwzI/F6r8ZKc2sHwh0lYrpv2B6q6k2UYPjzYgHnWnEaTPGM/4
         eTCkZuExujWNAUjOT5JB31SujkzrqmKpzUcDdhaUfcg16eCOsxlAsbj3On6jaX6aVSDa
         TqFmMFcENXyYNwvW8mk252ORff5NtYiYvMZcnr15A89jyK3k7/LWA03hbE7z5w6zg0r9
         qaLI6Q5Ml+7c0SlTgW9rjFWSK2r6DdCzxT4i0CRvg3s9uuvcm5nIlGw9NUw+LWh7qNZb
         IvZIYokM/iXFwT4XuXGs/4iclxe9B3gI1izKqq5RCLrxe/7Ts8KsEkABS9CpCkp/rgIq
         oqzg==
X-Gm-Message-State: AOAM531r683cBDkjDYIDhfG5KwHyIk0Q4zwhOgAddByTON3Y8FFAv77N
        H1GfHm9pmD0FgXEEg0bxsBokeQ==
X-Google-Smtp-Source: ABdhPJxQ7wCgvPqgz9ego4638i3fjxTVNJlcUZ2n0nqpNJKE4NIpX6odJWAB6a0FOaM14bjDRvanmA==
X-Received: by 2002:a17:902:a708:b029:da:ec42:a3d4 with SMTP id w8-20020a170902a708b02900daec42a3d4mr11356142plq.40.1607407902173;
        Mon, 07 Dec 2020 22:11:42 -0800 (PST)
Received: from endless.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id q35sm1725015pjh.38.2020.12.07.22.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 22:11:41 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     cascardo@holoscopio.com, don@syst.com.br, dvhart@infradead.org,
        andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Carlo Caione <carlo@endlessm.com>,
        Chris Chiu <chiu@endlessos.org>
Subject: [PATCH] x86/platform: classmate-laptop: add WiFi media button
Date:   Tue,  8 Dec 2020 14:11:11 +0800
Message-Id: <20201208061111.29073-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

The WiFi media button on the Quanta NL3 reports keycodes 0x8b and 0x9b
to the platform driver. Add the mapping to support these codes.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
Reviewed-by: Chris Chiu <chiu@endlessos.org>
---
 drivers/platform/x86/classmate-laptop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index af063f690846..3e03e8d3a07f 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -1023,6 +1023,8 @@ static int cmpc_keys_codes[] = {
 	KEY_CAMERA,
 	KEY_BACK,
 	KEY_FORWARD,
+	KEY_UNKNOWN,
+	KEY_WLAN, /* NL3: 0x8b (press), 0x9b (release) */
 	KEY_MAX
 };
 
-- 
2.20.1

