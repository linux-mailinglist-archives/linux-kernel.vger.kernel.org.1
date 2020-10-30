Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB32A0902
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgJ3PBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgJ3PBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:01:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20686C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:01:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 133so5526486pfx.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1XAy4aydwoIez7GB6eQoqSadcu1Phg3DY4MjWHP4W3Y=;
        b=sf0lxZAdxDbdA9TI4ETZIAdO2vwzG0jsDF1//CKqFEs6wR4ZjNNXCcxcMT6h9V/bIM
         7jJdcu23VoUgs7a/MLVeApE3kOVuNGKUJwLdnkjaol/RjyD7NJJFB/C3/0i7XEITDkZt
         loeRD26MjqaJPyOwMVYk6MHVaSxlms0dPpX80kLmIN28PBLq2YEbjWZeogURskssGADK
         qsTqQt85mr/0DTgJHq+t86DtHxrBd64F/7PUtwU+PsBmG0943k83S4Ecaf8i6E1EMFZf
         Xpxy+NXWpikt9LGUJQoPE93H2wPgTXlk92hwSSrOJFsHmeZi1tHLDH6mpMl9LN6gMkBy
         VHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1XAy4aydwoIez7GB6eQoqSadcu1Phg3DY4MjWHP4W3Y=;
        b=dxwFEsukuvqmPI6TqsA0ncwAbQZnqMUd6QQgzLX9JkFdENeMFkIdOZS9Rg1d+kVhqA
         YVkxeXjp43t6CvC2nFifr8PYzoAHqvRpQZ+nY+QDL51SEQ/gRMlJyiAytX5NIE7BBvop
         390R/7CN4NdAKM95hRutr/aI7I0Ad3GtoZsTPRM9GYFozCNDu7N7u1zUyjnbB3MBOZpp
         XqVRimFUnmRw+mnwH7auNDEABgzQAmyyFcB0aAMBMeg+u59DZb1+FvQnYm5/e2cXIPTe
         ZratOxdmyddeXUo7jt+FTGHW+lk3Tvq6v40MxPsD0z0vaJPQ5yd8GbDwj2QBoqZSmPle
         8vjA==
X-Gm-Message-State: AOAM532H+pOx5HGlW67SYAUGEGgkqGfpFIobZL4RB3IW//u5M+G0eqPV
        OJ1SyMiKJhvvQ6MsCQZU3AJxyQvQYNB+sC4zOs8=
X-Google-Smtp-Source: ABdhPJx0eV4RXSdewh69mce+KwCaxgDPNel6HEYuTkcpTLOY4Jp1Pl0+qV7b0O9VBIc3A+Cw1V+cag==
X-Received: by 2002:a65:50c9:: with SMTP id s9mr2577499pgp.20.1604070111614;
        Fri, 30 Oct 2020 08:01:51 -0700 (PDT)
Received: from localhost ([240e:472:3d00:779:b01a:f9a7:6a68:30ac])
        by smtp.gmail.com with ESMTPSA id m3sm3579833pjv.52.2020.10.30.08.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 08:01:51 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Fri, 30 Oct 2020 23:01:12 +0800
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BO..." 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] mfd: maxim: remove unnecessary CONFIG_PM_SLEEP
Message-ID: <20201030150112.2is4c6omlwqnd64x@Rk>
References: <20201029100647.233361-1-coiby.xu@gmail.com>
 <20201029183226.GA88922@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201029183226.GA88922@kozik-lap>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 07:32:26PM +0100, Krzysztof Kozlowski wrote:
>On Thu, Oct 29, 2020 at 06:06:39PM +0800, Coiby Xu wrote:
>> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
>
>I don't quite get what did you mean by "took good care". This should
>cause warnings of unused structure.  Comment applies to other patches as
>well.
>
Sorry I made a mistake.
>Also, the title prefix is: "mfd: max77686:"
>
Thank you for the reminding! I'll improve my script to avoid this issue
when extracting prefix from git log.

>Best regards,
>Krzysztof
>
>
>>
>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>> ---
>>  drivers/mfd/max77686.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
>> index 71faf503844b..8c701f8a9dd5 100644
>> --- a/drivers/mfd/max77686.c
>> +++ b/drivers/mfd/max77686.c
>> @@ -227,7 +227,6 @@ static int max77686_i2c_probe(struct i2c_client *i2c)
>>  	return 0;
>>  }
>>
>> -#ifdef CONFIG_PM_SLEEP
>>  static int max77686_suspend(struct device *dev)
>>  {
>>  	struct i2c_client *i2c = to_i2c_client(dev);
>> @@ -262,7 +261,6 @@ static int max77686_resume(struct device *dev)
>>
>>  	return 0;
>>  }
>> -#endif /* CONFIG_PM_SLEEP */
>>
>>  static SIMPLE_DEV_PM_OPS(max77686_pm, max77686_suspend, max77686_resume);
>>
>> --
>> 2.28.0
>>

--
Best regards,
Coiby
