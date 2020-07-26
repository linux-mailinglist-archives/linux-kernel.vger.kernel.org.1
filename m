Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D1E22E2D3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 23:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgGZVyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgGZVyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 17:54:20 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75694C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 14:54:18 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t4so11478522iln.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qbO72KNQsN1uo9s1oqMFM1YRWkl2m1XWlF1kgUkKGp0=;
        b=JRvwIWUWd8yIzPjjt0w+lf4VYLIoogQhRYAh7jUaqhyAemeFjXtxb9Sug2rDYTQLUY
         TL4oMKF2rn3WDDk/W2jYyHx/DifRq4NdcnfV9tsaSR7RAzfJcGspNpdaEk+ZC/1ruv5m
         rdfNQECwXYpBl6cuS9BkTGmg08od0sm4t5YvX76TwhzVWXxBOR4OKyO93qXTKOdM7jbT
         +lfvqfmdpXkpRAgqepa3uoVHwSHexjb9Mqk1biFF1pSPsFmQOGh7CK/ZrdNbpUTVf9fq
         UJQjKc5wwmoapIT6Vq5A/odsVdyLQKnsZTCOcQzGsaiNRa2KNQ6XnwEc1kii6Lxkckln
         FvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qbO72KNQsN1uo9s1oqMFM1YRWkl2m1XWlF1kgUkKGp0=;
        b=LnX1UNoozc4qMjXlySAN/0PtjO6zzZddV+znNaQY+KPsiVXT/UwpyeTcnfHkL/CdHh
         O4JIw8G3Idyvj4selyHx77SrEbPC0hKwmmxZTnLdUO3NVhIaUAlttlX38Z/SbyoJcgz3
         1AmayKoqeuyaTVnzWgvyAtnQbZAppPkc0U3tjv15FU+kH/NETezQ/S/uPBZLPTc/R8OP
         d3Ej3lfzGzcPjYXVIGqBwT5C9Y2Mih9tqiLv/dNEr0JM3pfkiBeCYimaKYWsSi1qULqS
         3z3HtCFiLNFA2pgaCGosN+/YoblVtddUPJdFXHN3VwveHOeC+HPMhl1uGpkmzi8R0FpG
         91Xg==
X-Gm-Message-State: AOAM531JgR+XHxe8dmunaUb91teXcHPBVsfDk9Mb1bUskR8eByLbOlTy
        gI9l7kIBW+61TIJj2Jqi9KltAQ==
X-Google-Smtp-Source: ABdhPJzXPAxSdoJRP3ENuN+EA7N7oxkg3azTG1Uih+Vi8wnVNgMAOGnCXPHCMkrNl3Wwaq+8Le0fFw==
X-Received: by 2002:a92:c90c:: with SMTP id t12mr3036399ilp.222.1595800457780;
        Sun, 26 Jul 2020 14:54:17 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id u21sm1073907ili.34.2020.07.26.14.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 14:54:17 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH] RFC : mikroBUS driver for add-on boards
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, johan@kernel.org,
        elder@kernel.org, rajkovic@mikroe.com, robh@kernel.org,
        mchehab+huawei@kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>, davem@davemloft.net,
        zoran.stojsavljevic@gmail.com
References: <20200724120637.GA427284@vaishnav-VirtualBox>
 <15cab987-6eaa-9137-0f70-4735b3fea87f@linaro.org>
 <CALudOK6SrEKDdDv4CwPdZqH_KGHxwotbjgajo4dzf8FY22UVEA@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <9ccd5a70-713b-f620-7f95-8754181e569a@linaro.org>
Date:   Sun, 26 Jul 2020 16:54:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALudOK6SrEKDdDv4CwPdZqH_KGHxwotbjgajo4dzf8FY22UVEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/20 2:12 PM, Vaishnav M A wrote:
> I have gone through all the suggestions and be back with an
> updated version of the driver patch with the changes added.

Great!  Take your time.  (Seriously, take your time, because
I have to carve out time in my own schedule for reviewing!)

					-Alex
