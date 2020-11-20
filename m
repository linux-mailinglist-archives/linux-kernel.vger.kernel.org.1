Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F0D2BB1CD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgKTRwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbgKTRwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:52:25 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E7CC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:52:23 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t37so7828104pga.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=pVdeI1sYIriKSKU0FAfSE1onJx9VqHW2QxdMQfohHlE=;
        b=S6cwSJFWciVZJ/O4DHvzItNqZhYkCFL9lFZO7Qs64qtIAqATlt0VYH86pyz+tW3WBq
         CclLKbfZPizwx0HhcjbDfpWC97MMxpUQ8ixhUUKywAXQlX76kzf3RN8wFoTCCJrDv2vT
         lthKMxELdfxmMAoSU9+tLj90ajl3rZJyy8sXg4ikj6V3RljjwtP9SUoAZevsMGj1KPq9
         UnJKIPmI0pOXI5g/WHJ6BCtRartbfrzpGWziVVQQOBD8kR9buf87mqfbtmdqjkKbMrcM
         3qsw2pqxv8DrVC6Xo6ydCJF96zlD0OVww/Q81mL2RoEM/rRRSH/nNZtzl7ZROo2kMmOc
         d1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=pVdeI1sYIriKSKU0FAfSE1onJx9VqHW2QxdMQfohHlE=;
        b=gZobmp4wx075h92SpB4e61NAYhAoNOtwvh5ArciBHBaLxw3VfOv4WTt39V9W1n2ISD
         1ystpbLDrIFonjFr54nzYyTfJlmMh5n+twB69GG2noyKhfE6vBCq+J4IQFb7qr8G11Mi
         JU+HCvkpVgFd2ktbMTpwSlqzyIOPMnI8ymJAA/bZ9fwo+ZTTf4oTiAq07Tx362wnkw+g
         VcEXn5TZXdUMheeGK10QhZf1aFC5zeZVTPa29lPIzhVoroAesc6I6r+pV8PL+6W288SF
         2BeMju7Cag3Wx4MryVWft4e42zbHnVhCLVwF0raUUJmk7y1pzE2qDgRiqqp4oSNWN5/s
         noag==
X-Gm-Message-State: AOAM532FyVLGZXoQWjkdrHprZMmZs0jxQic/KnDRjcagiwtw76nggJRB
        kh8RxF7ohDU/yT0o08XgupKK7w==
X-Google-Smtp-Source: ABdhPJzScsu1nZ3ZInsLfW7bstHlr8/e/Q73vdfsiyNhdbmilFHXACO2L6p3BApzBa44g/4Bp+HceA==
X-Received: by 2002:a17:90a:fed:: with SMTP id 100mr12040112pjz.65.1605894743044;
        Fri, 20 Nov 2020 09:52:23 -0800 (PST)
Received: from debian ([171.49.186.209])
        by smtp.gmail.com with ESMTPSA id 138sm4131039pfy.88.2020.11.20.09.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 09:52:22 -0800 (PST)
Message-ID: <37c1365302a6c05e3d1fa6dd17d39e9eb71f932d.camel@rajagiritech.edu.in>
Subject: Re: [PATCH 5.9 00/14] 5.9.10-rc1 review
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, stable@vger.kernel.org
Date:   Fri, 20 Nov 2020 23:22:17 +0530
In-Reply-To: <20201120104541.168007611@linuxfoundation.org>
References: <20201120104541.168007611@linuxfoundation.org>
Content-Type: multipart/mixed; boundary="=-jhvfZqZ6WQlWS8Jd5dOF"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jhvfZqZ6WQlWS8Jd5dOF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-11-20 at 12:03 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.9.10 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied,
> please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2020 10:45:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	
> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.9.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
> stable-rc.git linux-5.9.y
> and the diffstat can be found below.
> 
hello,

Compiled and booted 5.9.10-rc1+. No issues with "dmesg -l err"
But "dmesg -l warn" shows something.

file dmesg-warn-nov-20-2020-portion.txt  is attached

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology - autonomous



--=-jhvfZqZ6WQlWS8Jd5dOF
Content-Disposition: attachment; filename="dmesg-warn-nov-20-2020-portion.txt"
Content-Type: text/plain; name="dmesg-warn-nov-20-2020-portion.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

WyAxMTM1Ljc1ODE2NV0gcGNpZXBvcnQgMDAwMDowMDoxYy41OiBQQ0llIEJ1cyBFcnJvcjogc2V2
ZXJpdHk9Q29ycmVjdGVkLCB0eXBlPURhdGEgTGluayBMYXllciwgKFRyYW5zbWl0dGVyIElEKQpb
IDExMzUuNzU4MTc0XSBwY2llcG9ydCAwMDAwOjAwOjFjLjU6ICAgZGV2aWNlIFs4MDg2OjlkMTVd
IGVycm9yIHN0YXR1cy9tYXNrPTAwMDAxMDAwLzAwMDAyMDAwClsgMTEzNS43NTgxODNdIHBjaWVw
b3J0IDAwMDA6MDA6MWMuNTogICAgWzEyXSBUaW1lb3V0ICAgICAgICAgICAgICAgCg==


--=-jhvfZqZ6WQlWS8Jd5dOF--

