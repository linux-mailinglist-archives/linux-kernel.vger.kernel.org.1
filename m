Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62671A7AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgDNM11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 08:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2501928AbgDNM1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:27:13 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45DC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:27:13 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id o127so13032385iof.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lZl+SzAixlt/zspP8CIXqhi3WqXdw0DhseejXVx44uY=;
        b=VOfdVdO0snAnBN6PceKWVDGj0o/mgGh/ur/Um8PrvA7IfdIXAgOxCId+c3VbdU5mV5
         PFRg/STwB6ik9vzkbJ1cfkSgux3Ytvw8HeqrbGldySqfVxRhLOyviptUgCrE6qB7s44A
         WI3zG5XJsIrZQkFxy2sWjMIXWvSBe9KF3i7D1FyEQwDGIFDhnDnYS1vi+ZMmnMeK6hpt
         55M+qVYhnht8fgNf/bd8pkPuOivNm70zrAxljHbubeT0+envN4hB0KhMoQr5oNnZW+tg
         3s/pTW9bP0CGd6IbHWc9Z0HJwiCDyG6HTQw2WCbtSc21Rl2MhGwbTmr7bIcT85soZpfz
         7okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lZl+SzAixlt/zspP8CIXqhi3WqXdw0DhseejXVx44uY=;
        b=SHUFzOaJshhZSwKBPttaJXiWhmUJ/c17m9MUqa5hXut3IeLsBvU3NUu5IYRLeltaEW
         AHsqU/TiFahbcYKhMJVG/k7Aowfj9LWQK0dj4fRuCjGHOL4fkI/tgHGNTplTljPBX/qf
         xbgFDIGQDKEH5j629K4ozP03kNS+AeV7FLxPdmteF+mZiaMme0sTFGVvcs6d/xjmXryv
         kq4SSd0RPv0plqa44TJHU06I5wj7XBphA9ysPkCQQ/ahF3dVLgDjYs/t5u516efE2cbx
         zrlo0W7q/dUuJ86+0HQ1PalCvcW6Xcjm/ma5mEQ+qznLFCL4kGf1V+eK8LZZToV/FNBj
         UIJQ==
X-Gm-Message-State: AGi0Pua9gY+bbm3YCTr6Mya/DeUDNwyNPHluN5HBxKbW9eva/xw5TWgY
        PGo95AGKorkZlLNcZFyltkmzwQ==
X-Google-Smtp-Source: APiQypLg83FQI9KhxvuPMipPhJMLS+L2BK8ZKU8Cd24vD3HTM/7oNStucxBWjFmryrVSK6IH9K5u6A==
X-Received: by 2002:a05:6602:1302:: with SMTP id h2mr21094447iov.186.1586867233023;
        Tue, 14 Apr 2020 05:27:13 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id s22sm1069084iow.40.2020.04.14.05.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 05:27:12 -0700 (PDT)
Subject: Re: [PATCH 1/4] remoteproc: Fix a bug in rproc_alloc()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>
References: <e459f807-4c61-257b-b7b5-dd767202c435@web.de>
From:   Alex Elder <elder@linaro.org>
Message-ID: <4b05d794-095b-7efe-c71c-42dca785ca49@linaro.org>
Date:   Tue, 14 Apr 2020 07:27:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e459f807-4c61-257b-b7b5-dd767202c435@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/20 3:24 AM, Markus Elfring wrote:
>> I'm not actually sure this case causes an observable problem, but
>> it's incorrect.  Fix this by initializing the notifyids field before
>> calling ida_simple_get() in rproc_alloc().
> 
> I suggest to improve the commit message.
> 
> * Can the information “field initialisation” be more helpful than “bug”
>   in the patch subject?

No objection, though I personally would have spelled it
differently :)

> * Will the tag “Fixes” become relevant?

This bug was present when this code was first added.
Fixes: b5ab5e24e960 ("remoteproc: maintain a generic child device for each rproc")

Mathiew, feel free to add that.

					-Alex


> Regards,
> Markus
> 

