Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2212832C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgJEJHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgJEJHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:07:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BD2C0613CE;
        Mon,  5 Oct 2020 02:07:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so5591383pgl.10;
        Mon, 05 Oct 2020 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUORg47spfL73f7H/PLu8NLMtjAqRWZqjYpdZQW2IeA=;
        b=mczHn7MVXcsomQTFrw5fjFQDY6Z2sHBj48BuZ+oqxp0x1dRrhtzk7jZ799ntIIiXxX
         lZJOgxdZiEewNVhmAThkQtkBri/M92ZndaceRxCWEF/3hBbUe21AvPxrFjS8zIjl5z8A
         TeStuo/AHh2/bx8Wyk8EDbFMH62S3C2xj2r5rFPDrrzcOqmNdXvonpBbdxYLtJpGoSej
         Pi58cFQwb2Qv5HT7FSgqsJdHGCA3M6PkZUFdKAyuEKmRS/1r61BaJ7WDBCpMTGGWsq9V
         Cf4/5Oc/VP6cNow8noQMnn81MZA4fzac7y0IkZws1K8fvkEmFrAlJTNz/xkzaJNWsY5q
         ohQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUORg47spfL73f7H/PLu8NLMtjAqRWZqjYpdZQW2IeA=;
        b=JAdKZ7VdCALXfBiDWZIRBCqbfwqiJttOyvVw8sWIc4sQ/EkO1EuTI3k+bB58kPbDmV
         5pXklEvQ25fvJ1NTv0oniTC4cd/HAxo+JTax993H8GY6ZL5PkjjoiL+v7cW55CZ/LGuB
         9J9XAyxBBBRLWAG5NyAXQUGiBsq+7pQWnagFsTZyz1AIVPYNCnubBFB9hO9nO7GMD21e
         GC9ToAWUwfYbtaiIk0Kr4/fP5Q7jnT7yQ4TEF5S4P57nQZXIzh85/xN+Z1L6tMCfQKCA
         Y1ZexHqo4WcRl77Yg0+4cV6XmZUsJYjYdPysw5cyvBQUgMIQLImYhOPf9cpIh1eDS1c1
         zoCQ==
X-Gm-Message-State: AOAM531TlAg5iL26cJOZr62NasEEhiSJkWFFUxcswsa2Nhh7sKGCHeIf
        2R+h8Ww79yAAemLlGwfiuc5kgDj7mn8kQAXDgm8=
X-Google-Smtp-Source: ABdhPJzhbg94S7Z/1w94KPVZXA60oHdU7QVEKuolCSxzPQuXMVhODL+N9B6n/+8Je+21Z9sl4PM+WEFOH36w974C6MY=
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr13296765pgj.74.1601888827197;
 Mon, 05 Oct 2020 02:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601621983.git.rahul.tanwar@linux.intel.com>
 <e8c462ffc826d06c108aac45f8476083097cfa55.1601621983.git.rahul.tanwar@linux.intel.com>
 <20201002181135.GI3956970@smile.fi.intel.com> <f224391a-2e51-ec37-7045-4a16f04b5384@linux.intel.com>
In-Reply-To: <f224391a-2e51-ec37-7045-4a16f04b5384@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Oct 2020 12:06:48 +0300
Message-ID: <CAHp75VcHk0qZ_pFAvZLC4+8=r7E=cqe3J+enB3UWD9X1KQQ4Ng@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Add hardware monitoring driver for Moortec MR75203
 PVT controller
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 11:53 AM Tanwar, Rahul
<rahul.tanwar@linux.intel.com> wrote:
> On 3/10/2020 2:11 am, Andy Shevchenko wrote:
> > On Fri, Oct 02, 2020 at 03:04:27PM +0800, Rahul Tanwar wrote:

...

> >> +            pvt_temp.config = temp_config;
> >> +
> >> +            pvt_info[index++] = &pvt_temp;
> >> +    }
> >> +
> >> +    if (pd_num) {
> >> +            ret = pvt_get_regmap(pdev, "pd", pvt);
> >> +            if (ret)
> >> +                    return ret;
> >> +    }
> >> +
> >> +    if (vm_num) {
> >> +            u32 num = vm_num;
> >> +
> >> +            ret = pvt_get_regmap(pdev, "vm", pvt);
> >> +            if (ret)
> >> +                    return ret;
> >> +
> >> +            pvt->vm_idx = devm_kcalloc(dev, vm_num, sizeof(*pvt->vm_idx),
> >> +                                       GFP_KERNEL);
> >> +            if (!pvt->vm_idx)
> >> +                    return -ENOMEM;
> >> +            for (i = 0; i < vm_num; i++)
> >> +                    pvt->vm_idx[i] = i;
> > What the point if you are replace them below in one case?
> >
> >> +            ret = device_property_read_u8_array(dev, "intel,vm-map",
> >> +                                                pvt->vm_idx, vm_num);
> >> +            if (!ret)
> > Misses {} and because of above
> >
> >       if (ret) {
> >               for () ...
> >       } else {
> >               for () ...
> >       }
> >
> >> +                    for (i = 0; i < vm_num; i++)
> >> +                            if (pvt->vm_idx[i] >= vm_num ||
> >> +                                pvt->vm_idx[i] == 0xff) {
> >> +                                    num = i;
> >> +                                    break;
> >> +                            }
> > Or looking in this, perhaps move the incremental for-loop here and start it
> > with num which is 0.
>
> Not able to understand what exactly you are suggesting here. Presently
> it is like below:
> 1. Init vm_idx array with incremental values.
> 2. Read array from device property.
> 3. If success, figure out the last valid value and assign to num.
>
> Can you please elaborate and explain more clearly? Thanks.

device_property_read_u8_array() effectively (partially) rewrites the
vm_idx array.
The code above is inefficient and not clear.
My understanding based on the above is that half of the code may be dropped.

So, clearer variant looks like this to me:

  ret = device_property_read_u8_array(dev, "intel,vm-map", pvt->vm_idx, vm_num);
  if (ret) {
    num = 0;
  } else {
    for (i = 0; i < vm_num; i++) {
      if (pvt->vm_idx[i] >= vm_num || pvt->vm_idx[i] == 0xff)
        break;
    }
    num = i;
  }
  for (i = num; i < vm_num; i++)
    pvt->vm_idx[i] = i;

And all these require a good comment to describe why you are doing the
trailing loop.

-- 
With Best Regards,
Andy Shevchenko
