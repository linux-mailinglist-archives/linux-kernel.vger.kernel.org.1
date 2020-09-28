Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667F527ABB0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgI1KT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1KT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:19:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9734C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:19:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so426972pgo.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=aqKuja4n+cNWBnmmn/RpGXVE0nrfXb2IK4hEeeWWG3Y=;
        b=u3OdICsH6T+Q2k9FhEsUWwguIfe5wIrZTSCmxRqj7qmFewDfKqeED4sIS9TmvdrLhA
         hzYnT0C6dTWsHXgKFhc3vTQ0IiJQZ3wam4yLxxtGSAxWq/+L8NURYogXmVwRsQceq4RQ
         Kwa7P+M4lx14ekLnBBZe7qM2hqyTIH52nEVDruqJXFjgtY/N00gIh7RCAbFGkH0jXFF+
         bMsPorGtgaQWoiIg5cbxG3PvHX6Xqaub3T8+GQoDcypfP8lVXnlK8hUELPW0F3eK2Vsr
         4l/vvxWL/REvFBVQk2caFYbMatO40wN7xt5qOZmikK+YXBxZRvcReQhpc7WOCKanhdV3
         Grag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=aqKuja4n+cNWBnmmn/RpGXVE0nrfXb2IK4hEeeWWG3Y=;
        b=gf1MLFoUjiTnKOMh+OFULJLHlreMG+e7V7u/aaSrdq+QGdMxgl1i730zJc3hJbrb/h
         IOkTsVBxiTEEXW6wudZHsGSQKNK8aRsxS+1Yd+jz9Op97oYeKQneauPh+rLGvWcngrlw
         I3cnOkS4dwz7lq87YBbIFPIW7dadNVLL6xj8k35iRpNVxFDVmJIkHKv7nWlu/KKNkw1u
         OMFA3G70fddsz9+8A3hxV/Hpmb6Vj6gL1wT0ibWtdtVAnN7QHoIQHlf5vyGFeDVbbv0H
         IBaSl8bzFwqYe47X7aOl5TQCYid/7DwAflPv7gieKwKqJewPg+zCvb+23Tx+064hs5qA
         l60A==
X-Gm-Message-State: AOAM532p/L7j/C+93m7Vp3EYR1u/ifM86KUVQ9bdNYGaJYaARhqbBzTR
        w2f4elIm+e3RqtSlTrFPfPAT2A==
X-Google-Smtp-Source: ABdhPJxQK0ydTcY4tRB0S+K0h+O/S+YYo0HjyzgsduohiEaw0Q2P+jTFVVoeH8SlVqH0OZIP+4bomQ==
X-Received: by 2002:a63:b44f:: with SMTP id n15mr637920pgu.282.1601288367243;
        Mon, 28 Sep 2020 03:19:27 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id w203sm1292653pff.0.2020.09.28.03.19.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 03:19:26 -0700 (PDT)
Message-ID: <0fcd9588bb87f47856316677e8bb495f14fcb597.camel@areca.com.tw>
Subject: [PATCH 0/4] scsi: arcmsr: Fix timer stop and support new adapter
 ARC-1886 series
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        Colin King <colin.king@canonical.com>
Date:   Mon, 28 Sep 2020 18:19:24 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series are against to mkp's 5.10/scsi-queue.

1. Remove unnecessary syntax.
2. Fix device hot-plug monitoring timer stop.
3. Add supporting ARC-1886 series Raid controllers.
4. Update driver version to v1.50.00.02-20200819.
---

