Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD27288CC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389404AbgJIPbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389351AbgJIPbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:31:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57934C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 08:31:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c6so4616679plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ebuBhX2+OnZ2g8gjXhG5Whso/NiZdq5IVoUzSX1VC3g=;
        b=K4b3qCjIlGa7QpahTMy5KQ9mTu+mBvRcJqYQ6TXSswBe5TurjFg3V44zCtdzqMMXUF
         IC8JdkYcCTs+yTt1EimfFZonockgPCkelROoLvRXQwnENCtGGKwbr4RYZuC74mD3Ou+z
         zNzUJKp9fBWgft9muzkhlkL7csymtR0sWk7TaZSA2b3H9j8sjw1kYeyutzWc3f4GV+ni
         9v07unky7mVGC2g7Tt7Md3gOR1e7JofknxN8iZ5LeaaUnT5X8hn+8EcCUJwXh3wQSJ+l
         ZxhzHzoO+OPWcX+6xnQRCKJcjj7Ezb1hTwOEqLoQggzzsvvXsNl5cco3CUX589rS6l32
         x0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ebuBhX2+OnZ2g8gjXhG5Whso/NiZdq5IVoUzSX1VC3g=;
        b=TkHGraR9mzg9ek2km7BB2LsNZj7WxsA1chqTpsC7etoT9gpeJs4Ll4fD/0yQyOp093
         HDdwQMbonVt8SH6zoq2He7LIFMCsMS1bnSEk+INzSBrNqHCi6+JV4wDFLnJWghxVgzqQ
         +KuKtLpE2Cmn3sRzhd8u3pHguoxVtvHWJ+PxtiXdH+JIOf+vZA3uVutTjiQm0KLBXiLf
         Pluv8xR2MpTWmRX1dwXbTeKjJyiUfZg0A3XSeuRDXKZ+y5BkpFV3wWXVUxNeM0FpH1Xa
         SEXfU4Ggvt7NzbmCkg2WXaTwfAyowryl2ylqyRCN+O1URCSl21EOGWaHj48uac+6eJ2n
         g4vQ==
X-Gm-Message-State: AOAM530ZolE3JkxTHurVY0ofba7Y/FL/Te0LoJ8lCn1DctqMW/MA5p0u
        VZjKqXERbfruryGF+BFRwpCrdgdDrRlPkv8I
X-Google-Smtp-Source: ABdhPJykXqTArhzl2768Gp+TQuNId627QWe71O5CbJum81jKePVl0r0tgS26dJeL0FrwznFGlkoQeg==
X-Received: by 2002:a17:902:c3c2:b029:d3:df24:1584 with SMTP id j2-20020a170902c3c2b02900d3df241584mr13080680plj.33.1602257494522;
        Fri, 09 Oct 2020 08:31:34 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w10sm11485722pjy.13.2020.10.09.08.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 08:31:33 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: remove LIBATA PATA DRIVERS entry
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200924112252eucas1p2e372d1ce6d6f8cf8106572adeb200fee@eucas1p2.samsung.com>
 <1c6cdd00-93a2-55f7-9494-1c0058de384a@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d6a81ee-6d17-ab1e-b4d5-1e9e6a525a88@kernel.dk>
Date:   Fri, 9 Oct 2020 09:31:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1c6cdd00-93a2-55f7-9494-1c0058de384a@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/20 5:22 AM, Bartlomiej Zolnierkiewicz wrote:
> Even though there is not much happening for libata PATA drivers
> I don't have time to look after them anymore.
> 
> Since Jens is maintaining the whole libata anyway just remove
> "LIBATA PATA DRIVERS" entry.

Sorry to see that Bart, I'll queue this up for 5.10.

-- 
Jens Axboe

