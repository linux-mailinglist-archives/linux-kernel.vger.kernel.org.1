Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF7E2D926C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 06:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgLNFHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 00:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgLNFHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 00:07:09 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C6FC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 21:06:28 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id a12so26946981lfl.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 21:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=gGCUpnhclp6Bj9KO4rfrwce9rrdnq0S18KGcq9CZlKA=;
        b=dSQmu7K9bDSJ1F9Gw1oxD9VbeexRkTE2E3iWBd1PKDt2GHezT15dyi52xGNfAqzkwV
         reG/MpSCqi2KmiPJLCeFE+ckuIpNqDlzG2VY+eP63406KoRrJjttBlrcxGx0KyNn5Qtq
         eLgD+JRQG1K4hhUhVt9bRvjYZ8ut/pU42bvByvLMlTzoVeNqa0ij2P/QCJq5UvhoP8EL
         A/fQVQbqAK2eK+7ZW3c7NKyD5IE5NCX+DQDbkvDyynCzf1+KjiB7wtQ/ngylN89fy7gd
         r93Y/6kMZeEuOkUzcsYw/dMmaL94ncWVHVt7sa3NJXyNVZdF53lTzXV9ZPUX3d/gulDl
         Jp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=gGCUpnhclp6Bj9KO4rfrwce9rrdnq0S18KGcq9CZlKA=;
        b=N3230gk8PWXfyN2P21I4ajmDyPSuCBvKtwF+bzuOA2RKnmdUabgSIizWgDko8H6Cch
         U3Tl9md22jLeHzz1PJxsowSetBYC155/ippyoGehxgtWgi5bAkiDktmfgYDt1+qUbwZi
         OnN3jAzq0KGGrqX6YtE7YnnqAC2ejl8RJTqpLj+I0a4Rwuj+7vkpGKc1t4XMwZqWvAt2
         CmIcMLrIM8A7CIlbxq7rfXO72NibZOBGFG7EgNBXWsKi6lk6X5rac8axX8x2xg5FLHeU
         XrKwWeP7qESHIc1yShEJXEBEWZWShCgjXuYveXVEJVY9OWIv8BR74eCwXcOCTnYy1yCY
         AgYA==
X-Gm-Message-State: AOAM532YW0Q2JfSpnzRrYL9I6dYGkoTinbNFawYTa08TcrPALlSamtvr
        9uCmmVXS2a3leMxJdytjsJ/5PXsxXEvFbA==
X-Google-Smtp-Source: ABdhPJx+IifI3ooyU1TMkJnttOvKA+bz6csSG5TM8A52heAIOS+9o/zgYRpxgmsY0qYbT0yu7ZhXdg==
X-Received: by 2002:a19:416:: with SMTP id 22mr9622129lfe.507.1607922386923;
        Sun, 13 Dec 2020 21:06:26 -0800 (PST)
Received: from [172.16.28.2] (s.parabel.ru. [80.89.204.140])
        by smtp.gmail.com with ESMTPSA id c24sm1927270lfh.135.2020.12.13.21.06.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Dec 2020 21:06:26 -0800 (PST)
From:   Pavel <biohumanoid.lists@gmail.com>
Subject: Bug in recent kernel timer implementation
To:     linux-kernel@vger.kernel.org
Message-ID: <baf1cf45-546f-2ce0-59be-7417747bc038@gmail.com>
Date:   Mon, 14 Dec 2020 12:06:24 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: ru
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Seems like kernel timer implementation is buggy since some kernel 
version (between 3.16.0 and 4.9.0).

Comments for add_timer in timer.c:

* The kernel will do a ->function(@timer) callback from the
  * timer interrupt at the ->expires point in the future. The
  * current time is 'jiffies'.

Linux x86, Linux x64. HZ=250.

init_timer(&my_timer);
my_timer.function = testjiffy_timer_function;
my_timer.expires = jiffies + 1;
add_timer(&my_timer);

So, according to comments in add_timer, testjiffy_timer_function should 
be called next timer tick, 4ms later.

If you will run this code in Linux 3.16.0 - it will call 
testjiffy_timer_function in the next timer tick (4ms later), as expected.

If you will run this code in Linux 4.9.0 - it will call 
testjiffy_timer_function in the on second timer tick (8ms later)...

If you will modify code for Linux > 4.15 (setup_timer/mod_timer) - you 
will get the same strange behaviour...

You can get code from here

https://stackoverflow.com/questions/16920238/reliability-of-linux-kernel-add-timer-at-resolution-of-one-jiffy

3.16.0

[52728.313029] Init testjiffy: 0 ; HZ: 250 ; 1/HZ (ms): 4
[52728.313720]  testjiffy_timer_function: runcount 1, jif=13110976, 
oldjif=13110975, delta=1
[52728.318743]  testjiffy_timer_function: runcount 2, jif=13110977, 
oldjif=13110976, delta=1
[52728.323304]  testjiffy_timer_function: runcount 3, jif=13110978, 
oldjif=13110977, delta=1
[52728.325824]  testjiffy_timer_function: runcount 4, jif=13110979, 
oldjif=13110978, delta=1
[52728.330811]  testjiffy_timer_function: runcount 5, jif=13110980, 
oldjif=13110979, delta=1
[52728.335802]  testjiffy_timer_function: runcount 6, jif=13110981, 
oldjif=13110980, delta=1
[52728.338305]  testjiffy_timer_function: runcount 7, jif=13110982, 
oldjif=13110981, delta=1
[52728.343298]  testjiffy_timer_function: runcount 8, jif=13110983, 
oldjif=13110982, delta=1
[52728.345806]  testjiffy_timer_function: runcount 9, jif=13110984, 
oldjif=13110983, delta=1
[52728.350885]  testjiffy_timer_function: runcount 10, jif=13110985, 
oldjif=13110984, delta=1
[52729.317263] Exit testjiffy

4.9.0

[52073.085341] Init testjiffy: 0 ; HZ: 250 ; 1/HZ (ms): 4
[52073.092322]  testjiffy_timer_function: runcount 1, jif=4307910976, 
oldjif=4307910974, delta=2
[52073.099818]  testjiffy_timer_function: runcount 2, jif=4307910978, 
oldjif=4307910976, delta=2
[52073.109830]  testjiffy_timer_function: runcount 3, jif=4307910980, 
oldjif=4307910978, delta=2
[52073.117362]  testjiffy_timer_function: runcount 4, jif=4307910982, 
oldjif=4307910980, delta=2
[52073.124845]  testjiffy_timer_function: runcount 5, jif=4307910984, 
oldjif=4307910982, delta=2
[52073.132315]  testjiffy_timer_function: runcount 6, jif=4307910986, 
oldjif=4307910984, delta=2
[52073.139816]  testjiffy_timer_function: runcount 7, jif=4307910988, 
oldjif=4307910986, delta=2
[52073.149824]  testjiffy_timer_function: runcount 8, jif=4307910990, 
oldjif=4307910988, delta=2
[52073.157303]  testjiffy_timer_function: runcount 9, jif=4307910992, 
oldjif=4307910990, delta=2
[52073.164824]  testjiffy_timer_function: runcount 10, jif=4307910994, 
oldjif=4307910992, delta=2
[52074.089574] Exit testjiffy


