Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0876829EB5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgJ2MKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgJ2MKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:10:52 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF67AC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:10:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w25so2821271edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yiqvhhgdDe8NsVeFyLnM8Df3S98P8fO/ovFIcT17UzU=;
        b=asRd0my5w9PZfZVChD8jhR7pDuApgW6r4WfU7aIau9OhoPHXVvVu0O7fGbfz0pNVId
         3MNNIywJ7bzqcvf7OPMtWgMp6AgPiWH5AqoZd/swQUqafB4tDwyTx5oogVfbZXYzEn4G
         ZPdE55CgSeanbOxscd9sxiz/zunTbL5S0F1uVGu+/g+Uq6hfsWjsYk5pRRhe5Dpgyj80
         sXDXixsv7JYvZBkIgQyJoO9kYgXZf2Fa1H+rwL1gz1TVOuGt5v+A6adT4VYgUZykie8m
         MGfs0jwI1TcwIGroTYneNwm8fBsYqGspLbtzT4aT1OlpOvQKialxcMEAyhI+RGxDjsc7
         EYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yiqvhhgdDe8NsVeFyLnM8Df3S98P8fO/ovFIcT17UzU=;
        b=djXpxjuR1somZUKui4ttSQj/XaK7XutZOcMUFv0ntS8oxxqqslboujj5X8EkhfKZJp
         T/PfjmCZ+TZrh3xzwDUEDt8TYoe18jRya/7+N9DopFSKl6frulfvplog93GWO5LBv3ND
         BqgVEtTMyFUNZloQtU9nvYbA8p1Jq/xkZsULBGbIpbbDuajo+9HscfWrTh7F5ozmxvwd
         u6yZivNL+rQ3tJY0yWcFyJWXQ7aIGr8s+lkdXO9V3nQRMrepZDMwawvt1WWGR4BKSbtB
         jZOzRDwI9NnHTuhyGffJoPEJCwxvAq/ndBI3qRARCfMi/RGgslZYSb73HlOyuvnBuTXb
         NPhQ==
X-Gm-Message-State: AOAM530EHjS8z7p9c6pswA1x5nJmHCQSzsAD2YL2QMw3E297e0DNsBsD
        Ep5tQx8OdKk9Sn7vPxGH1e0i3nwnuhk=
X-Google-Smtp-Source: ABdhPJzJ6UrkwY9lbHgHmoBvSIK1sjn5n8alRKiKxlvcQzCRgT2ztJrN85+QoD3BdeTrx6qpa8Lgkw==
X-Received: by 2002:a50:fe98:: with SMTP id d24mr3563881edt.223.1603973450517;
        Thu, 29 Oct 2020 05:10:50 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id p20sm1364200ejd.78.2020.10.29.05.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 05:10:49 -0700 (PDT)
Date:   Thu, 29 Oct 2020 13:10:48 +0100
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v4 5/6] vt/vt: Add URXVT mouse reporting protocol
Message-ID: <18409b77d3f876b7e5789f2cd89f7741bb4b98c8.1603963593.git.tammo.block@gmail.com>
References: <cover.1603963593.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603963593.git.tammo.block@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The URXVT protocol easy, all data analog to the old X10.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/vt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c884539aee22..bf7913652fd7 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1866,6 +1866,9 @@ void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
 		len = sprintf(buf, "\033[<%d;%d;%d%c", butt,
 				mrx + 1, mry + 1, rel ? 'm' : 'M');
 		break;
+	case VC_PMOUSE_URXVT:
+		len = sprintf(buf, "\033[%d;%d;%dM", butt + 32, mrx + 1, mry + 1);
+		break;
 	default:
 		len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
 				(char)('!' + mrx), (char)('!' + mry));
-- 
2.28.0

