Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E982AF7C4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgKKSM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgKKSM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:12:56 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC9C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:12:56 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j205so4439919lfj.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VzE8BDaL/n6JBFIiUCtyweyNiqD2rbfzZl05aVLw9Z4=;
        b=BOODpSb5zU+KwM9sx1qPBXcrfWDmhXnHjrX9u+W8LwPEsG+sBo5JjILCLJcFDzhQJr
         zFLZXOEdd9kdGDLJhtaIOR6AkD0AYFwY9+1ig88IO2xWktU3mNm0KeSfOAfHBqwCv403
         0w4wW+5sXMT9itogqMe234o8z6ocruH8lPupM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VzE8BDaL/n6JBFIiUCtyweyNiqD2rbfzZl05aVLw9Z4=;
        b=epz/61/07/LnoD55Pgu6dQOuvsPinwD8F5p+HEpLDgLLAydK0ia2dsYct0c1hT04LG
         gatlSVq3ZUTAXw7dh0J9CHGLYS6uWPKBbHSsSjyjSXZucEk+uCR0mEheyAv5ihoOcWcJ
         KdFrTZMTvZuQhnQ/Yzo7AdMsPCrh1SQWyPexRY67LQNH/T6tRj1mC4guJviMX+eLtJKw
         M37542QsUccvfsf+YJyxNb/it5DOoGQls1l0bcUtMufnjz0go3whpRAK9A8fWBZJlHw5
         s935VFm53c8aG7xHYTNjg6jKh343fHzNxujxdzmnLVbX0oODeXx376xYGm6Hspe04EML
         vN4A==
X-Gm-Message-State: AOAM531wAYQms0uqtVABEJkoXVh3mtd8g2c1nMTWVRnGCsdy8fzzzzm3
        zfotIg5cgDgwEV9Vz7P510S2O8euXb6EiYY10bzjIvLyt8wgCA==
X-Google-Smtp-Source: ABdhPJwMy0RQwbcNeV3E/RqNsvvERd0DhLw5UIIHAS6OGVPC3Mj6ghAHXJryoYs2uwNsQa22a3ygQ1LjSmss7aT4PeQ=
X-Received: by 2002:a19:c8ca:: with SMTP id y193mr1722705lff.150.1605118373925;
 Wed, 11 Nov 2020 10:12:53 -0800 (PST)
MIME-Version: 1.0
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Wed, 11 Nov 2020 13:12:38 -0500
Message-ID: <CAO9zADxBz5q2FrdL4zxSU5Cs6kX7qrkrc__DT4eEaJ0aZKTVtg@mail.gmail.com>
Subject: 5.9.3: "md0:" is showing in dmesg/printk but with no other
 information is provided
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 5.9.3
Arch: x86_64

These are showing up in dmesg every so often and they are not
associated with any type of message/alert or user associated action.
What is causing this & why are there no details associated with this
message?

[Wed Nov  4 17:05:56 2020]  md0:
[Thu Nov  5 08:23:32 2020]  md0:
[Thu Nov  5 13:12:00 2020]  md0:
[Sat Nov  7 06:53:59 2020]  md0:
[Sat Nov  7 06:54:07 2020]  md0:
[Tue Nov 10 08:09:27 2020]  md0:
[Wed Nov 11 12:43:06 2020]  md0:

Regards,

Justin.
