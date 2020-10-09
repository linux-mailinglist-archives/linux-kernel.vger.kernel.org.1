Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1B0288AD2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbgJIO0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388707AbgJIO0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:26:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69852C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 07:26:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b193so6408511pga.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6M2CF3GiS41kG7WeY/KYwPLrWKVHdZNxChB43/DhTw=;
        b=Q2AcAH4iGqaV+vMhtejsQD+2MvhpXAemtmuAuzjuG4d6PD1fOIxvd6qOLFE91lKRtU
         diw4KEtf0Uak97CjQctN0s6KIaoXRiN3YiHV1/aWHgASuGqeXZ0JegG7QxyLR7bQo5dL
         8XuR34g3s8TkS3QyxgYyaGO8is0Hi15Az2Zifq8Y+LB2tL1M9qkdOhizmWPM81e51CxX
         8rKO9G48xPD4FL38wtEroiQJi0ryyaGweveqXmBoVviIBxRS8a2aUECiDKnA8nuzIsRC
         0Gp4PG19k12YKaLB2G08avMrtriQTK4EoUszGcI5wpQo0gBjdeZ/Hg2WATJ1cB+2IUii
         bVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6M2CF3GiS41kG7WeY/KYwPLrWKVHdZNxChB43/DhTw=;
        b=Sqp2zknBFpxPSz05XMH95RMRCmYnAiGToi6oM3FJH86zuyoaFOb+fj/TpPzx8BabcT
         NYI2lOxRxprEPgEMVeG1rwNabwVpjvkeUt+wksW2akCsvt/hkdkP2BR90qHiAh1c9qOG
         W/K7XlUofvxNQ4bfxa+kNlK/+noD4ENQbhf7OzWWVOyaFiTl56pxvutqaqdpCaEqiQAj
         pIhuHOe82kNpexeuUA2WVIZbN90Ao4nuNFt8uhC0Ydc2dZy0nFZXSYRK4UqhqNRwkBlC
         QrMNbs1dV3EPYlDF78WgHn2+6WX4xVSZYAWV74zs/uYCOBDj+fzi2fw8JJrwitUMILOl
         b3wg==
X-Gm-Message-State: AOAM533COIlGtU+jzpY9L1WVrT/AbHVSGbG68ayGEV5VNsiYyM3USw1z
        DPW4QPxGcyvjyUlzQI39ijEG0A4f+cSWdh+SHhLBHv4MLWjCtg==
X-Google-Smtp-Source: ABdhPJwzEq4ugskmZfXDnj4WYNxgqNEiRNpMSgeyqBO+zq/GW8VbwN2Q+woPjNdBzoUjw7BNKS171CRizOTPEbwPzAI=
X-Received: by 2002:a62:5e81:0:b029:152:2f99:d9e3 with SMTP id
 s123-20020a625e810000b02901522f99d9e3mr12045455pfb.7.1602253584972; Fri, 09
 Oct 2020 07:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201009133734.GE8133@xsang-OptiPlex-9020>
In-Reply-To: <20201009133734.GE8133@xsang-OptiPlex-9020>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Oct 2020 17:27:14 +0300
Message-ID: <CAHp75VdX_uxbrkX=XF11WDBcuXjpQYWjjOzVzJ8ffj46oGw_JA@mail.gmail.com>
Subject: Re: drivers/power/supply/mp2629_charger.c:522:9: warning: %d in
 format string (no. 1) requires 'int' but the argument type is 'unsigned int'.
To:     kernel test robot <lkp@intel.com>
Cc:     Saravanan Sekar <sravanhome@gmail.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 4:23 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   549738f15da0e5a00275977623be199fbbf7df50
> commit: 3bc6d790c39dfc4539c36525e6bcb617abbae467 power: supply: Add support for mps mp2629 battery charger
> date:   4 months ago
> :::::: branch date: 12 hours ago
> :::::: commit date: 4 months ago
> compiler: sh4-linux-gcc (GCC) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

...

> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  514          unsigned int rval;
> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  515          int ret;
> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  516
> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  517          ret = regmap_read(charger->regmap, MP2629_REG_IMPEDANCE_COMP, &rval);
> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  518          if (ret)
> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  519                  return ret;
> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  520
> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  521          rval = (rval >> 4) * 10;
> 3bc6d790c39dfc Saravanan Sekar 2020-05-26 @522          return sprintf(buf, "%d mohm\n", rval);
> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  523  }

Right, should be %u. Can LKP generate this type of patches?

-- 
With Best Regards,
Andy Shevchenko
