Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8EA290FDE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 08:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436965AbgJQGCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 02:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436904AbgJQGBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 02:01:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F0C05BD12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 20:35:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b23so2572916pgb.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 20:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QCDwsfNkvqPQpIDU4u2sxBUV+wI2fvaYjsjuhY5RuJc=;
        b=GMxYGdsmmYiibZtixe+aGFA6jkG/y38/+DJoIyZpEciLgohQn6z5cAlabOqCDhfzKk
         K0sMKIGOFuTvUCFfmYmWUGSt4mCeOtrXQ9tEof9Y+9eaSC5R44kJqxD6NS2oJqsLleSs
         vQ2ZhVzXOQuX9u74j3yzoh8Uoa9xg/EX6d5SKtb+LBjA6h2p15B88dEzhWtJFrLkcaZr
         p1kwOyFIRR0EsZKfmvINTOwiK3boq/TVplc/qCuLsoz9z3CvAs83K3Q7LI7CKEL8D1O3
         aYA/ja/Zej1HuL9vWHZNtFE5vdp2XaCCg6/UEifspLDsI7Ic17l1gXAa41WnfFh9DHnY
         f37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QCDwsfNkvqPQpIDU4u2sxBUV+wI2fvaYjsjuhY5RuJc=;
        b=Fq8751Gq8K9B+l6NgOGf0i4/BMlDvke8gKFIiOVIKFAYItgX/0aC6RjhpTQgmF3Cu3
         uM/c1szwrXn4NXRBO6rwxOrxFj1whPs75t2F5xegpqFLO1zp6U5XZKGmNAuRRgMZQ+xx
         r0R3mjglrX277Vt6DrML2B5dWkJl2Yh0zDj6ahkSFC8MqxFe8nMqZkYm+kD6/rZ0ubaT
         jJV2OSr6mzNcWtb/qdwm9EcuVaXX+XJsWHuwlgVFHoWvqFXVJ6Larn8f8bgH4ePLG8Ug
         +tOyrnMiXVu6CNMuRS1UzGVtrxWkIhC+yEt/vo8ykakuSpZHNcVldzZIn5ZFQJKrQHrG
         z1SQ==
X-Gm-Message-State: AOAM530S0dwQ6y0acrZd3HG++8ryA3Z75ZECUrk5NQTnX1fPbqiFfMVb
        S5zthJnPw6GVD+OHWex6Vowz3A==
X-Google-Smtp-Source: ABdhPJzhg8j37lQ1anTwUnr51Yoc7Hw5kVKAHEnp+m0vWm6Q+L5sYL8LC6bIVz4ArNu9hUosH9T/Xg==
X-Received: by 2002:a63:7841:: with SMTP id t62mr5605629pgc.183.1602905744957;
        Fri, 16 Oct 2020 20:35:44 -0700 (PDT)
Received: from debian ([122.164.16.34])
        by smtp.gmail.com with ESMTPSA id q7sm3958172pfj.38.2020.10.16.20.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 20:35:44 -0700 (PDT)
Message-ID: <4fb15a8ea92e6adcb68445ec065a910d09100ed3.camel@rajagiritech.edu.in>
Subject: Re: [PATCH 5.8 00/14] 5.8.16-rc1 review
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, pavel@denx.de, stable@vger.kernel.org
Date:   Sat, 17 Oct 2020 09:05:35 +0530
In-Reply-To: <20201016150021.GA1807231@kroah.com>
References: <20201016090437.153175229@linuxfoundation.org>
         <7138d7bce8f8da009119f0107eeb7c85f67057b9.camel@rajagiritech.edu.in>
         <20201016150021.GA1807231@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-16 at 17:00 +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 16, 2020 at 07:41:05PM +0530, Jeffrin Jose T wrote:
> > On Fri, 2020-10-16 at 11:07 +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.8.16
> > > release.
> > > There are 14 patches in this series, all will be posted as a
> > > response
> > > to this one.  If anyone has any issues with these being applied,
> > > please
> > > let me know.
> > > 
> > > Responses should be made by Sun, 18 Oct 2020 09:04:25 +0000.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	
> > > https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.16-rc1.gz
> > > or in the git tree and branch at:
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
> > > stable-rc.git linux-5.8.y
> > > and the diffstat can be found below.
> > > 
> > > thanks,
> 
> > [   10.718252] i8042: PNP: PS/2 appears to have AUX port disabled,
> > if
> > this is incorrect please boot with i8042.nopnp
> 
> Is this incorrect?
it seems to be incorrect for me, because the warning
disappeared when i passed i8042.nopnp to kernel.
-- 
software engineer
rajagiri school of engineering and technology

