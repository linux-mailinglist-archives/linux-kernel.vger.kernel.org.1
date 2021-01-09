Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4675F2EFE1A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 06:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbhAIFve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 00:51:34 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:40579 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbhAIFve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 00:51:34 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id D5D9519C9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 00:50:47 -0500 (EST)
Received: from imap6 ([10.202.2.56])
  by compute2.internal (MEProxy); Sat, 09 Jan 2021 00:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm2; bh=fuj2hxn9MCY7SusyLczxNdhSHb7ZtnoN3g8oH8GUMa0=; b=I+ohpY4t
        JNQQvFz33d0Sjax6FhxfwO8SUfx0+oJzwKJVkZzcYV4q8NmjeIKfFnzXLlpk6JV7
        UKji7nscfiaj5KCoIXkwSl6F8HtXryOLVnQU5JaKTzmC8aG7316vyMWtMoVhSkRt
        426jHT9erFhxULDJI5v7kQmCzgphHn66IkKmIonZDIGALHQdQ3PRcW3IozSKW7HA
        cEeweTzGKfL6b/Rxra2HM8Jicpu1eaQPV3NUOvILwnYzKkgy84MREDgAubQcGrsp
        c0Vca+Pn6rBw0VaWuyjd6yUCy0JJLvYDVImGAh1Z7ftYOWJP/FFSjT8cSr47N8Xg
        bjHzXwpV1daksA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=fuj2hxn9MCY7SusyLczxNdhSHb7Zt
        noN3g8oH8GUMa0=; b=Tt5q0nbmQIetYRWNEP5KxWucz49U8ypoDVLF7QYNR3AjS
        NLbBn19zNg3n9xIj6T6VbtN2jm1WHe1yjl+6F3CeYcuDSl9JyAK7mM2Fj8yzckOX
        yig8E0H2o4GW/8z4BKkLzST73LqiJVTywh0rBTilDXWwC3fXFpMUxAXMscxfaav8
        sFWccGWPeGNtnL2/Q8+vMhCoZrZQmOEBx3V4B1dk7HX2ZKx7VxxhyAIU14uhkuq0
        N+n7t6G8krjiJQe3pa3k8Y/qsF7K5Rs6OW+xTdbIOX8j1um1Kn5y5F72aWAfYrFc
        5aiLJNwnqu584oTtZx8TzvRifhu957gJUx+NpXFJw==
X-ME-Sender: <xms:N0T5X4d7hrsRIxn_BKrG-OwRS-KivYwnKe87EC7FBEUWHHaqDXPGbg>
    <xme:N0T5X6P-p-V4CDjzHSFuDb6KrrseYC0YXplFnMZnzFyPs7DdzPt_fQsGmgVWfjDSe
    pHtPQg7rftcfggQznY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdegiedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erreejnecuhfhrohhmpedfvehhrhhishhtohhphhgvrhcuhghilhhlihgrmhcuufhnohif
    hhhilhhlfdcuoegthhhrihhssehkohguvgehgedrnhgvtheqnecuggftrfgrthhtvghrnh
    epvddvjeffkeeujeeiuedugeehfeduteeluedtgeevtdeuveettdeluedvheefueetnecu
    ffhomhgrihhnpehlkhhmlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegthhhrihhssehkohguvgehgedrnhgvth
X-ME-Proxy: <xmx:N0T5X5g18sZtx1UNt21YKChzwiMFvBsIQ7YvvLM2tGzNdiD2ksHoUw>
    <xmx:N0T5X9_NSs5bjAniNxPV0JOPiDnaKs2TY1Odkyc-OIQeHwDjic1THQ>
    <xmx:N0T5X0vGp3IiK1nOGHWCD5VuXrM2y24Th4heeoux6SxQA04ZwrefZw>
    <xmx:N0T5Xy4w4vIbfSYvZ13tK40Fg2GOxcNekNBydUsgnWDIjEa1SIYjFA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A4A3B1400A1; Sat,  9 Jan 2021 00:50:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.1-61-gb52c239-fm-20201210.001-gb52c2396
Mime-Version: 1.0
Message-Id: <e3367030-b822-4f17-9c6f-cd7e0e2f9933@www.fastmail.com>
Date:   Fri, 08 Jan 2021 21:50:26 -0800
From:   "Christopher William Snowhill" <chris@kode54.net>
To:     linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_False_positive_"do=5FIRQ:_#.55_No_irq_handler_for_vector"_?=
 =?UTF-8?Q?messages_on_AMD_ryzen_based_laptops?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to https://lkml.org/lkml/2019/2/19/516 from yes, 2019.

My MSI B450 Tomahawk is exhibiting this bug now that I've updated the firmware to the latest beta BIOS with AGESA 1.1.0.0 patch D.
