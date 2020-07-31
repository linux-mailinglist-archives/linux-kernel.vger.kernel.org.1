Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FCD233E81
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 06:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgGaE4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 00:56:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35892 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgGaE4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 00:56:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id c15so11839958edj.3;
        Thu, 30 Jul 2020 21:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4H+oRSmTvEm6CIUgIK4P0aR3vjANz1UROQflSVQivnc=;
        b=b/m9SZFU0Lkek9YdHHL6wkC5R/nhiQftFO33jVk6TY2GsBZ1NCDNzFrPzX+D5iQ3/p
         PTBXHVzJnxCDL7hJxaN/wHiaiq2gNnTEXUbA0BAGxwhCh1yGqACWb3GNKTohUWL5ovg2
         xOSfDTJFhJsyJaYdaWXaCk47T4I1BXcEeie9AlPk/YlwRWQt99TvhD3gVEUtqoKEuRKs
         pHT6VdrDqlM3q88oong0Y/nRjDS5SIfq98zHurEN059oaAvZYwdUbXY98+f2Fp/wtoQC
         VObsmAfyhizTcSQh+AQk7/GHw2Zw8NEkJDCm8CX6LfgBeyB6a51ZouNfu+BX99+i8BYE
         gtPg==
X-Gm-Message-State: AOAM530nvv2LNDglg03SmTik0lA78z5wz8VlmF1bn+OCw7CXF3yS+K2n
        QSPyjt0keV/k1yHWCPUiTpU=
X-Google-Smtp-Source: ABdhPJyEGl1t8oZSMXGGJywcFvB6YfHnbZsZ2I+VAQnNpB4AzoQ2ukdWZucjy94em1xriCvhfy3x4A==
X-Received: by 2002:a05:6402:3110:: with SMTP id dc16mr2202194edb.218.1596171377036;
        Thu, 30 Jul 2020 21:56:17 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id c7sm8096414ejr.77.2020.07.30.21.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 21:56:16 -0700 (PDT)
Subject: Re: [PATCH] vgacon: Fix an out-of-bounds in
 vgacon_scrollback_update()
To:     Yang Yingliang <yangyingliang@huawei.com>, b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>
References: <20200713105730.550334-1-yangyingliang@huawei.com>
 <220220f1-48f7-46f6-952f-ab41fa57d6a1@kernel.org>
 <c3714d73-d5fe-c77a-e554-bb1ff4fd6980@huawei.com>
 <9aecd7ac-5060-6b8d-61f8-393431eb243f@kernel.org>
 <3df26fed-5ade-df26-6417-380401b9650b@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <42bd14e3-ae2f-0c14-5d42-e3e7aeb11c78@kernel.org>
Date:   Fri, 31 Jul 2020 06:56:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3df26fed-5ade-df26-6417-380401b9650b@huawei.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31. 07. 20, 5:23, Yang Yingliang wrote:
> void execute_one(void)
> {
> 		intptr_t res = 0;
> 	res = syz_open_dev(0xc, 4, 1);

open(/dev/tty1)

> 	if (res != -1)
> 		r[0] = res;
> *(uint16_t*)0x20000000 = 0xc;
> *(uint16_t*)0x20000002 = 0x373;
> *(uint16_t*)0x20000004 = 0x1442;
> 	syscall(__NR_ioctl, r[0], 0x5609ul, 0x20000000ul);

VT_RESIZE(12, 883)

> memcpy((void*)0x20003500, "\x7f\x45\x4c\x46\x00\x00\x00...
> 	syscall(__NR_write, r[0], 0x20003500ul, 0x381ul);

Write 381 bytes of some ELF to the tty.

OK, that's it. Thanks.

-- 
js
